
const core = require ("@actions/core");

const { build_matrix } = require ("./build-matrix.js");

try {
	const matrix = build_matrix ({
        "buster":   JSON.parse ( core.getInput ("buster")),
        "bookworm": JSON.parse ( core.getInput ("bookworm")),
		"trixie":   JSON.parse ( core.getInput ("trixie")),
	});

    core.setOutput ("matrix", JSON.stringify ({ include: matrix }));
} catch (error) {
    core.setFailed (error.message);
}
