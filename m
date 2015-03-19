From: Roland Grunberg <rgrunber@redhat.com>
Subject: [PATCH] perf annotate: Set the input file name after parsing options.
Date: Thu, 19 Mar 2015 13:26:09 -0400
Message-ID: <1426785969-26345-1-git-send-email-rgrunber@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Roland Grunberg <rgrunber@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Sergio Durigan Junior <sergiodj@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The input file name should be set after parse_options has been called if
the '-i' option is to have any effect.

Signed-off-by: Roland Grunberg <rgrunber@redhat.com>
---

Not registered to the referenced lists so feel free to CC.

The input file option for perf-annotate seems to be broken and will always
default to 'perf.data'. The perf_data_file path field is being set before
parse_options has initialized input_name.

Current Behaviour :
$ perf record -o datafile uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.007 MB datafile (~322 samples) ]
$ file datafile
datafile: data
$ perf annotate --stdio -i datafile
failed to open perf.data: No such file or directory  (try 'perf record' first)

Expected Behaviour :
The 'perf-annotate' call should run against the specified input file.

 tools/perf/builtin-annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 747f861..78489bc 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,7 +283,6 @@ int cmd_annotate(int argc, const char **argv, const char *prefix __maybe_unused)
 		},
 	};
 	struct perf_data_file file = {
-		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 	};
 	const struct option options[] = {
@@ -333,6 +332,8 @@ int cmd_annotate(int argc, const char **argv, const char *prefix __maybe_unused)
 
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
 
+	file.path = input_name;
+
 	if (annotate.use_stdio)
 		use_browser = 0;
 	else if (annotate.use_tui)
-- 
2.1.0
