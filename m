From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/30] perf tools report: Add custom scripts to script menu
Date: Mon, 11 Mar 2019 23:02:04 -0300
Message-ID: <20190312020204.22092-31-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a way to define custom scripts through ~/.perfconfig, which are then
added to the scripts menu. The scripts get the same arguments as 'perf
script', in particular -i, --cpu, --tid.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-10-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  8 ++++++++
 tools/perf/ui/browsers/scripts.c         | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 2d0fb7613134..95054a8176a2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -590,6 +590,14 @@ samples.*::
 		Define how many ns worth of time to show
 		around samples in perf report sample context browser.
 
+scripts.*::
+
+	Any option defines a script that is added to the scripts menu
+	in the interactive perf browser and whose output is displayed.
+	The name of the option is the name, the value is a script command line.
+	The script gets the same options passed as a full perf script,
+	in particular -i perfdata file, --cpu, --tid
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 96e5cd3b0eee..27cf3ab88d13 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -6,6 +6,7 @@
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../libslang.h"
+#include "config.h"
 
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
@@ -53,6 +54,24 @@ static int add_script_option(const char *name, const char *opt,
 	return 0;
 }
 
+static int scripts_config(const char *var, const char *value, void *data)
+{
+	struct script_config *c = data;
+
+	if (!strstarts(var, "scripts."))
+		return -1;
+	if (c->index >= SCRIPT_MAX_NO)
+		return -1;
+	c->names[c->index] = strdup(var + 7);
+	if (!c->names[c->index])
+		return -1;
+	if (asprintf(&c->paths[c->index], "%s %s", value,
+		     c->extra_format) < 0)
+		return -1;
+	c->index++;
+	return 0;
+}
+
 /*
  * When success, will copy the full path of the selected script
  * into  the buffer pointed by script_name, and return 0.
@@ -87,6 +106,7 @@ static int list_scripts(char *script_name, bool *custom,
 			  &scriptc);
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
+	perf_config(scripts_config, &scriptc);
 	custom_perf = scriptc.index;
 	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
 	i = scriptc.index;
-- 
2.20.1
