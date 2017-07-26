From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/40] perf script python: Generate hooks with additional argument
Date: Wed, 26 Jul 2017 11:17:25 -0300
Message-ID: <20170726141730.30750-36-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arun Kalyanasundaram <arunkaly@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Seongjae Park <sj38.park@gmail.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arun Kalyanasundaram <arunkaly@google.com>

Modify the signature of tracepoint specific and trace_unhandled hooks to
add the perf_sample dict as a new argument.
Create a python helper function to print a dictionary.

Signed-off-by: Arun Kalyanasundaram <arunkaly@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Seongjae Park <sj38.park@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170721220422.63962-6-arunkaly@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 938b39f6ad31..c7187f067d31 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1367,6 +1367,12 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 
 			fprintf(ofp, "%s", f->name);
 		}
+		if (not_first++)
+			fprintf(ofp, ", ");
+		if (++count % 5 == 0)
+			fprintf(ofp, "\n\t\t");
+		fprintf(ofp, "perf_sample_dict");
+
 		fprintf(ofp, "):\n");
 
 		fprintf(ofp, "\t\tprint_header(event_name, common_cpu, "
@@ -1436,6 +1442,9 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 
 		fprintf(ofp, ")\n\n");
 
+		fprintf(ofp, "\t\tprint 'Sample: {'+"
+			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'\n\n");
+
 		fprintf(ofp, "\t\tfor node in common_callchain:");
 		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
 		fprintf(ofp, "\n\t\t\t\tprint \"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name'])");
@@ -1446,15 +1455,20 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	}
 
 	fprintf(ofp, "def trace_unhandled(event_name, context, "
-		"event_fields_dict):\n");
+		"event_fields_dict, perf_sample_dict):\n");
 
-	fprintf(ofp, "\t\tprint ' '.join(['%%s=%%s'%%(k,str(v))"
-		"for k,v in sorted(event_fields_dict.items())])\n\n");
+	fprintf(ofp, "\t\tprint get_dict_as_string(event_fields_dict)\n");
+	fprintf(ofp, "\t\tprint 'Sample: {'+"
+		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'\n\n");
 
 	fprintf(ofp, "def print_header("
 		"event_name, cpu, secs, nsecs, pid, comm):\n"
 		"\tprint \"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
-		"(event_name, cpu, secs, nsecs, pid, comm),\n");
+		"(event_name, cpu, secs, nsecs, pid, comm),\n\n");
+
+	fprintf(ofp, "def get_dict_as_string(a_dict, delimiter=' '):\n"
+		"\treturn delimiter.join"
+		"(['%%s=%%s'%%(k,str(v))for k,v in sorted(a_dict.items())])\n");
 
 	fclose(ofp);
 
-- 
2.9.4
