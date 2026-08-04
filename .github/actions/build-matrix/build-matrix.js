
const distributions = [
	"buster",
	"bookworm",
	"trixie",
];

const base_suffixes = {
	"buster":   "buster",
	"bookworm": "slim-bookworm",
	"trixie":   "slim-trixie",
};

const _push_matrix_item = (matrix, version, distribution, ...tags) => {
	const base_suffix = base_suffixes[ distribution ];
	const base         = `${version}-${base_suffix}`;

	tags.unshift (base);

	matrix[ base ] ??= [];
	matrix[ base ].push (...tags);
};

const build_matrix = (versions_map) => {
	const matrix = {};

	// Default tag for each version is a distribution it was introduced with - ie oldest distribution
	for (const default_distribution of distributions) {
		const version_list = versions_map[ default_distribution ];

		if (! version_list) continue;

		while (version_list.length > 0) {
			const current_version = version_list.shift ();

			_push_matrix_item (matrix, current_version, default_distribution, current_version);

			for (const non_default_distribution of distributions) {
				const non_default_list = versions_map[ non_default_distribution ];

				if (! non_default_list) continue;
				if (non_default_list.length === 0) continue;
				if (non_default_list[0] !== current_version) continue;

				non_default_list.shift ();

				_push_matrix_item (matrix, current_version, non_default_distribution);
			}
		}
	}

	return Object.entries (matrix).map (([ base, tags ]) => ({
		base,
		tags: tags.join (","),
	}));
};

module.exports = {
	build_matrix,
};
