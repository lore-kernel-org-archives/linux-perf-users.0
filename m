From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/31] tools lib traceevent: Convert remaining %p[fF] users to %p[sS]
Date: Fri, 20 Sep 2019 11:25:36 -0300
Message-ID: <20190920142542.12047-26-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org, linux-trace-devel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

There are no in-kernel %p[fF] users left. Convert the traceevent tool,
too, to align with the kernel.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lore.kernel.org/lkml/20190918133419.7969-2-sakari.ailus@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-func_apis.txt  | 10 +++++-----
 tools/lib/traceevent/event-parse.c             | 18 ++++++++++++++----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt b/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
index 38bfea30a5f6..f6aca0df2151 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
@@ -59,12 +59,12 @@ parser context.
 
 The _tep_register_function()_ function registers a function name mapped to an
 address and (optional) module. This mapping is used in case the function tracer
-or events have "%pF" or "%pS" parameter in its format string. It is common to
-pass in the kallsyms function names with their corresponding addresses with this
+or events have "%pS" parameter in its format string. It is common to pass in
+the kallsyms function names with their corresponding addresses with this
 function. The _tep_ argument is the trace event parser context. The _name_ is
-the name of the function, the string is copied internally. The _addr_ is
-the start address of the function. The _mod_ is the kernel module
-the function may be in (NULL for none).
+the name of the function, the string is copied internally. The _addr_ is the
+start address of the function. The _mod_ is the kernel module the function may
+be in (NULL for none).
 
 The _tep_register_print_string()_ function  registers a string by the address
 it was stored in the kernel. Some strings internal to the kernel with static
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index bb22238debfe..6f842af4550b 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4367,10 +4367,20 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 					switch (*ptr) {
 					case 's':
 					case 'S':
-					case 'f':
-					case 'F':
 					case 'x':
 						break;
+					case 'f':
+					case 'F':
+						/*
+						 * Pre-5.5 kernels use %pf and
+						 * %pF for printing symbols
+						 * while kernels since 5.5 use
+						 * %pfw for fwnodes. So check
+						 * %p[fF] isn't followed by 'w'.
+						 */
+						if (ptr[1] != 'w')
+							break;
+						/* fall through */
 					default:
 						/*
 						 * Older kernels do not process
@@ -4487,12 +4497,12 @@ get_bprint_format(void *data, int size __maybe_unused,
 
 	printk = find_printk(tep, addr);
 	if (!printk) {
-		if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
+		if (asprintf(&format, "%%ps: (NO FORMAT FOUND at %llx)\n", addr) < 0)
 			return NULL;
 		return format;
 	}
 
-	if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
+	if (asprintf(&format, "%s: %s", "%ps", printk->printk) < 0)
 		return NULL;
 
 	return format;
-- 
2.21.0
