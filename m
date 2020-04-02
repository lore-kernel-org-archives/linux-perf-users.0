From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: [PATCH] perf script report: fix segfault when using DWARF mode
Date: Thu,  2 Apr 2020 14:54:16 +0200
Message-ID: <20200402125417.422232-1-agerstmayr@redhat.com>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Andreas Gerstmayr <agerstmayr@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

When running perf script report with a Python script and a callgraph in
DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
function.

Added a check for this condition (same check as in builtin-script.c:595).

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
index 8c1b27cd8b99..2c372cf5495e 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -694,6 +694,9 @@ static int regs_map(struct regs_dump *regs, uint64_t =
mask, char *bf, int size)
=20
 	bf[0] =3D 0;
=20
+	if (!regs || !regs->regs)
+		return 0;
+
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val =3D regs->regs[i++];
=20
--=20
2.25.1
