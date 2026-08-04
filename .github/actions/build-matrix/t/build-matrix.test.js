
const { build_matrix } = require ("../build-matrix.js");

// Synthetic stable-release-style version numbers (5 -> T) so a broken test
// can never be mistaken for a real Perl version. Ascending, oldest first,
// matching the perl-versions action output contract.
const fixture = () => ({
	buster:   [ "T.8", "T.10", "T.12",                ],
	bookworm: [                "T.12", "T.14", "T.16" ],
	trixie:   [                        "T.14", "T.16" ],
});

// Ensure same order of got and expected matrix arrays
const sort_matrix_array = (matrix) => [ ...matrix ].sort (
	(a, b) => a.base.localeCompare (b.base)
);

// Columns, in order: T-base tag, T tag, latest tag, latest-base tag.
const tags = (...values) => ({tags: values.filter(Boolean).join (",")});

describe ("build_matrix", () => {
	it ("computes the matrix", () => {
		const matrix = build_matrix (fixture ());

		expect (sort_matrix_array (matrix)).toEqual (sort_matrix_array ([
			{ base: "T.8-buster",         ...tags ("T.8-buster",         "T.8",  ) },
			{ base: "T.10-buster",        ...tags ("T.10-buster",        "T.10", ) },
			{ base: "T.12-buster",        ...tags ("T.12-buster",        "T.12", ) },
			{ base: "T.12-slim-bookworm", ...tags ("T.12-slim-bookworm",         ) },
			{ base: "T.14-slim-bookworm", ...tags ("T.14-slim-bookworm", "T.14"  ) },
			{ base: "T.14-slim-trixie",   ...tags ("T.14-slim-trixie",           ) },
			{ base: "T.16-slim-bookworm", ...tags ("T.16-slim-bookworm", "T.16", ) },
			{ base: "T.16-slim-trixie",   ...tags ("T.16-slim-trixie",           ) },
		]));
	});
});
