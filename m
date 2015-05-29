From: Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 1/4] perf tools: Add 'perf-config' command
Date: Fri, 29 May 2015 14:42:45 +0900
Message-ID: <1432878168-11278-1-git-send-email-treeze.taeung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36797 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbE2FnG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 29 May 2015 01:43:06 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>

The perf configuration file contains many variables which can make
the perf command's action more effective.
But looking through state of configuration is difficult and there's no =
knowing
what kind of other variables except variables in perfconfig.example exi=
st.
So This patch adds 'perf-config' command with '--list' option and a doc=
ument for it.

    perf config [options]

    display current perf config variables.
    # perf config
    or
    # perf config -l | --list

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/perf/Build                            |   1 +
 tools/perf/Documentation/perf-config.txt    | 375 ++++++++++++++++++++=
++++++++
 tools/perf/Documentation/perfconfig.example |  70 +++++-
 tools/perf/builtin-config.c                 |  75 ++++++
 tools/perf/builtin.h                        |   1 +
 tools/perf/command-list.txt                 |   1 +
 tools/perf/perf.c                           |   1 +
 7 files changed, 512 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-config.txt
 create mode 100644 tools/perf/builtin-config.c

diff --git a/tools/perf/Build b/tools/perf/Build
index b77370e..3c1f437 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -1,5 +1,6 @@
 perf-y +=3D builtin-bench.o
 perf-y +=3D builtin-annotate.o
+perf-y +=3D builtin-config.o
 perf-y +=3D builtin-diff.o
 perf-y +=3D builtin-evlist.o
 perf-y +=3D builtin-help.o
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Docu=
mentation/perf-config.txt
new file mode 100644
index 0000000..afda861
--- /dev/null
+++ b/tools/perf/Documentation/perf-config.txt
@@ -0,0 +1,375 @@
+perf-config(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+perf-config - Get and set variables in a configuration file.
+
+SYNOPSIS
+--------
+[verse]
+'perf config' -l | --list
+
+DESCRIPTION
+-----------
+You can manage variables in a configuration file with this command.
+
+OPTIONS
+-------
+
+-l::
+--list::
+	Show current config variables with key and value into each sections.
+
+CONFIGURATION FILE
+------------------
+
+The Perf configuration file contains many variables which can make
+the perf command's action more effective.
+The '$HOME/.perfconfig' file is used to store a per-user configuration=
=2E
+The file '$(sysconfdir)/perfconfig' can be used to
+store a system-wide default configuration.
+
+The variables are divided into sections. In each section, the variable=
s
+can are composed of a key and value.
+
+Syntax
+~~~~~~
+
+The file consists of sections and names. A section begins with
+the name of the section in square brackets and continues until the nex=
t
+section begins. Each variable have to belong to some section, which me=
ans
+there must be a section header before the first setting of a variable,=
 as below:
+Each variable are in the form 'name =3D value'.
+
+	[section]
+		name1 =3D value1
+		name2 =3D value2
+
+Section names are case sensitive and can contain any characters except
+newline (doublequote `"` and backslash have to be escaped as `\"` and =
`\\`,
+respectively).  Section headers can't span multiple
+lines.  Variables may belong directly to a section.
+
+Example
+~~~~~~~
+
+Given a $HOME/.perfconfig like this:
+
+#
+# This is the config file, and
+# a '#' and ';' character indicates a comment
+#
+
+[colors]
+	# Color variables
+	top =3D red, default
+	medium =3D green, default
+	normal =3D lightgray, default
+	selected =3D white, lightgray
+	code =3D blue, default
+	addr =3D magenta, default
+	root =3D white, blue
+
+[tui]
+	# Defaults if linked with libslang
+	report =3D on
+	annotate =3D on
+	top =3D on
+
+[buildid]
+	# Default, disable using /dev/null
+	dir =3D ~/.debug
+
+[annotate]
+	# Defaults
+	hide_src_code =3D false
+	use_offset =3D true
+	jump_arrows =3D true
+	show_nr_jumps =3D false
+
+[help]
+	# Format can be man, info, web or html
+	format =3D man
+	autocorrect =3D 0
+
+[ui]
+	show-headers=3D true
+
+[call-graph]
+	# fp (framepointer), dwarf
+	record-mode =3D fp
+	print-type =3D graph
+	order =3D caller
+	sort-key =3D function
+
+Variables
+~~~~~~~~~
+
+colors.*::
+	Color variables can customize colors of the output which is printed o=
ut
+	from =E2=80=98report=E2=80=99, =E2=80=98top=E2=80=99, =E2=80=99annota=
te=E2=80=99 on tui.
+	Color variables are composed of foreground and background
+	and should have two values for them. If you want to keep as colors
+	of your terminal, you should use =E2=80=98default=E2=80=99 for the co=
lor value.
+	The color names that can be used are:
+	red, green, default, black, blue, white, magenta, lightgray
+
+	colors.top::
+		=E2=80=98top=E2=80=99 means a overhead percentage which is more than=
 5%.
+		And values of this variable specify colors of percentage.
+		Basic key values are foreground-color =E2=80=99red=E2=80=99 and
+		background-color =E2=80=99default=E2=80=99.
+	colors.medium::
+		=E2=80=98medium=E2=80=99 means a overhead percentage which has more =
than 0.5%.
+		Default values are =E2=80=99green=E2=80=99 and =E2=80=99default=E2=80=
=99.
+	colors.normal::
+		=E2=80=98normal=E2=80=99 means the rest of overhead percentages
+		except =E2=80=98top=E2=80=99, =E2=80=98medium=E2=80=99, =E2=80=98sel=
ected=E2=80=99.
+		Default values are =E2=80=99lightgray=E2=80=99 and =E2=80=99default=E2=
=80=99.
+	colors.selected::
+		This selects the colors for the current entry in a list of entries
+		from sub-commands (top,report,annotate).
+		Default values are =E2=80=99white=E2=80=99 and =E2=80=99lightgray=E2=
=80=99.
+	colors.code::
+		Colors for arrows and lines in jumps on  assembly code listings
+		such as =E2=80=98jns=E2=80=99,=E2=80=99jmp=E2=80=99,=E2=80=99jane=E2=
=80=99,etc. Default values are =E2=80=98blue=E2=80=99, =E2=80=98default=
=E2=80=99.
+	colors.addr::
+		This selects colors for addresses from =E2=80=99annotate=E2=80=99.
+		Default values are =E2=80=98magenta=E2=80=99, =E2=80=98default=E2=80=
=99.
+	colors.root::
+		Colors for headers in the output of a sub-command =E2=80=98top=E2=80=
=99.
+		Default values are =E2=80=98white=E2=80=99, =E2=80=98blue=E2=80=99.
+
+tui.*::
+	A boolean value that controls launching TUI browser for each subcomma=
nd.
+	By default, TUI is enabled if perf detects the required library durin=
g build
+	and this config option can control it.  Available subcommands are 'to=
p',
+	'report' and 'annotate'.
+
+gtk.*::
+	A boolean value that controls launching GTK+2 GUI browser for
+	each subcommand.  By default, TUI is enabled if perf detects the
+	required library during build and this config option can control it.
+	Available subcommands are 'top', 'report' and 'annotate'.
+
+buildid.*::
+	buildid.dir::
+		Each executable or shared library built with each program is assigne=
d
+		a unique identification as build-id. The option means a path where
+		build-id information can be saved.
+		The default is $HOME/.debug
+
+annotate.*::
+	There=E2=80=99re options which work with a =E2=80=99annotate=E2=80=99=
 sub-command.
+	This options is in control of addresses, jump function, source code
+	in lines of assembly code from a specific program.
+
+	annotate.hide_src_code::
+		If a program which is analyzed has source code of itself,
+		this option let =E2=80=98annotate=E2=80=99 print a list of assembly =
code with the source code.
+		For example, let=E2=80=99s see a part of a program. There=E2=80=99re=
 four lines.
+		If this option is =E2=80=98false=E2=80=99, they can be printed
+		without source code from a program as below.
+
+		=E2=94=82        push   %rbp
+		=E2=94=82        mov    %rsp,%rbp
+		=E2=94=82        sub    $0x10,%rsp
+		=E2=94=82        mov    (%rdi),%rdx
+
+		But if this option is =E2=80=98true=E2=80=99, source code of the par=
t
+		can be also printed as below.
+
+		=E2=94=82      struct rb_node *rb_next(const struct rb_node *node)
+		=E2=94=82      {
+		=E2=94=82        push   %rbp
+		=E2=94=82        mov    %rsp,%rbp
+		=E2=94=82        sub    $0x10,%rsp
+		=E2=94=82              struct rb_node *parent;
+		=E2=94=82
+		=E2=94=82              if (RB_EMPTY_NODE(node))
+		=E2=94=82        mov    (%rdi),%rdx
+		=E2=94=82              return n;
+
+        annotate.use_offset::
+		Basing on a first address of a loaded function, offset can be used.
+		Instead of using original addresses of assembly code,
+		addresses subtracted from a base address can be printed.
+		Let=E2=80=99s illustrate a example.
+		If a base address is 0XFFFFFFFF81624d50 as below,
+
+		ffffffff81624d50 <load0>
+
+		a address on assembly code has a specific absolute address as below
+
+		ffffffff816250b8:=E2=94=82  mov    0x8(%r14),%rdi
+
+		but if use_offset is =E2=80=99true=E2=80=99, a address subtracted fr=
om a base address is printed.
+		The default is true.
+
+		             368:=E2=94=82  mov    0x8(%r14),%rdi
+
+	annotate.jump_arrows::
+		There=E2=80=99re jump instruction among assembly code.
+		Depending on a boolean value of jump_arrows,
+		arrows can be printed or not which represent
+		where do the instruction jump into as below.
+
+		=E2=94=82     =E2=94=8C=E2=94=80=E2=94=80jmp    1333
+		=E2=94=82     =E2=94=82  xchg   %ax,%ax
+		=E2=94=821330:=E2=94=82  mov    %r15,%r10
+		=E2=94=821333:=E2=94=94=E2=94=80=E2=86=92cmp    %r15,%r14
+
+		If jump_arrow is =E2=80=98false=E2=80=99, the arrows isn=E2=80=99t p=
rinted as below.
+
+		=E2=94=82      =E2=86=93 jmp    1333
+		=E2=94=82        xchg   %ax,%ax
+		=E2=94=821330:   mov    %r15,%r10
+		=E2=94=821333:   cmp    %r15,%r14
+
+        annotate.show_nr_jumps::
+		Let=E2=80=99s see a part of assembly code.
+
+		=E2=94=821382:   movb   $0x1,-0x270(%rbp)
+
+		If use this, the number of branches branching to that address can be=
 printed as below.
+
+		=E2=94=821 1382:   movb   $0x1,-0x270(%rbp)
+
+help.*::
+	help.format:: =3D man
+		A format of manual page can be =E2=80=98man=E2=80=99, =E2=80=98info=E2=
=80=99, =E2=80=98web=E2=80=99 or =E2=80=98html=E2=80=99.
+		=E2=80=99man=E2=80=99 is default.
+	help.autocorrect:: =3D 0
+		Automatically correct and execute mistyped commands after
+		waiting for the given number of deciseconds (0.1 sec).
+		Let's see a example. If a mistyped sub-command is executed like 'per=
f mistyped-command'
+		and this option is 0, the output is as below.
+
+		perf: 'mistyped-command' is not a perf-command. See 'perf --help=E2=80=
=99.
+
+		Or if this option is more than 1, the output can be such as.
+
+		WARNING: You called a perf program named 'mistyped-command', which d=
oes not exist.
+		Continuing under the assumption that you meant 'with-kcore'
+		in 0.1 seconds automatically...
+		Usage: perf-with-kcore <perf sub-command> <perf.data directory> [<su=
b-command options> [ -- <workload>]]
+		<perf sub-command> can be record, script, report or inject
+		    or: perf-with-kcore fix_buildid_cache_permissions
+
+hist.*::
+	hist.percentage::
+		This option control a way to calcurate overhead of filtered entries =
-
+		that means the value of this option is effective only if there's a
+		filter (by comm, dso or symbol name).  Suppose a following example:
+
+		       Overhead  Symbols
+		       ........  .......
+		        33.33%     foo
+		        33.33%     bar
+		        33.33%     baz
+
+	       This is an original overhead and we'll filter out the first 'f=
oo'
+	       entry.  The value of 'relative' would increase the overhead of=
 'bar'
+	       and 'baz' to 50.00% for each, while 'absolute' would show thei=
r
+	       current overhead (33.33%).
+
+ui.*::
+	ui.show-headers::
+		There=E2=80=99re columns as header =E2=80=98Overhead=E2=80=99, =E2=80=
=98Children=E2=80=99, =E2=80=98Shared Object=E2=80=99, =E2=80=98Symbol=E2=
=80=99, =E2=80=99self=E2=80=99.
+		If this option is false, they are hiden.
+
+call-graph.*::
+	When sub-commands =E2=80=98top=E2=80=99 and =E2=80=98report=E2=80=99 =
work with -g/=E2=80=94-children
+	there=E2=80=99re options in control of call-graph.
+
+	call-graph.record-mode::
+		The record-mode can be =E2=80=98fp=E2=80=99 (frame pointer) and =E2=80=
=98dwarf=E2=80=99.
+		The value of 'dwarf' is effective only if perf detect needed library
+		(libunwind or a recent version of libdw).  Also it doesn't *require*
+		the dump-size option since it can use the default value of 8192 if
+		missing.
+
+	call-graph.dump-size::
+		The size of stack to dump in order to do post-unwinding.  Default is=
 8192 (byte).
+		When using dwarf into record-mode this option should have a value.
+
+	call-graph.print-type::
+		The print-types can be graph (graph absolute), fractal (graph relati=
ve), flat.
+		This option controls a way to show overhead for each callchain entry=
=2E
+		Suppose a following example.
+
+		Overhead  Symbols
+		........  .......
+		  40.00%  foo
+		      |
+		      --- foo
+		      |
+		      |--50.00%-- bar
+		      |           main
+		      |
+		      --50.00%-- baz
+		                 main
+
+		This output is a default format which is 'fractal'.  The 'foo' came
+		from 'bar' and 'baz' exactly half and half so 'fractal' shows 50.00%
+		for each (meaning that it assumes 100% total overhead of 'foo').
+
+		The 'graph' uses absolute overhead value of 'foo' as total so each o=
f
+		'bar' and 'baz' callchain will have 20.00% of overhead.
+
+	call-graph.order::
+		This option controls print order of callchains.  The default is
+		'callee' which means callee is printed at top and then followed by i=
ts
+		caller and so on.  The 'caller' prints it in reverse order.
+
+	call-graph.sort-key::
+		The callchains are merged if they contain same information.
+		The sort-key option determines a way to compare the callchains.
+		A value of 'sort-key' can be 'function' or 'address=E2=80=99.
+		The default is =E2=80=98function=E2=80=99.
+
+	call-graph.threshold::
+		When there're many callchains it'd print tons of lines.  So perf omi=
ts
+		small callchains under a certain overhead (threshold) and this optio=
n
+		control the threashold.  Default is 0.5 (%).
+
+	call-graph.print-limit::
+		This is another way to control the number of callchains printed for =
a
+		single entry.  Default is 0 which means no limitation.
+
+report.*::
+	report.percent-limit::
+		This one is mostly same as call-graph.threshold but works for
+		histogram entries.  Entries have overhead lower than this percentage
+		will not be printed.  Default is 0.
+		If percent-limit is 70, the output which has percentages of
+		each overhead above 70% can be printed.
+
+	report.queue-size::
+		option to setup the maximum allocation size for session's
+		ordered events queue, if not set there's no default limit.
+
+	report.children::
+		The children means that functions called from another function.
+		If the option is true, accumulate callchain of children and show tot=
al overhead.
+		Please refer to the perf-report manual.
+
+top.*::
+	top.children::
+		This option means same as report.children.
+		So it is true, the output of =E2=80=98top=E2=80=99 is rearranged by =
each overhead into children group.
+
+man.*::
+	man.viewer::
+		This option can assign a manual tool with which a subcommand 'help' =
work.
+		it can used as 'man', 'woman', 'konqueror'. Default value is 'man'.
+
+pager.*::
+	pager.<subcommand>::
+		When a subcommand work as stdio instead of TUI, use pager with it.
+		Default value is 'true'.
+
+SEE ALSO
+--------
+linkperf:perf[1], linkperf:perf-report[1]
diff --git a/tools/perf/Documentation/perfconfig.example b/tools/perf/D=
ocumentation/perfconfig.example
index 767ea24..be820b7 100644
--- a/tools/perf/Documentation/perfconfig.example
+++ b/tools/perf/Documentation/perfconfig.example
@@ -1,29 +1,75 @@
 [colors]
-
-	# These were the old defaults
-	top =3D red, lightgray
-	medium =3D green, lightgray
-	normal =3D black, lightgray
-	selected =3D lightgray, magenta
-	code =3D blue, lightgray
-	addr =3D magenta, lightgray
+	# There are types of colors which are red,
+	# green, default, black, blue,
+	# white, magenta, lightgray
+	# The default is like below
+	top =3D red, default
+	medium =3D green, default
+	normal =3D lightgray, default
+	selected =3D white, lightgray
+	code =3D blue, default
+	addr =3D magenta, default
+	root =3D white, blue
=20
 [tui]
-
 	# Defaults if linked with libslang
 	report =3D on
 	annotate =3D on
 	top =3D on
=20
 [buildid]
-
 	# Default, disable using /dev/null
-	dir =3D /root/.debug
+	dir =3D ~/.debug
=20
 [annotate]
-
 	# Defaults
 	hide_src_code =3D false
 	use_offset =3D true
 	jump_arrows =3D true
 	show_nr_jumps =3D false
+
+[gtk]
+	report =3D off
+	annotate =3D off
+	#top =3D off
+
+[pager]
+	# That a 'cmd' is true mean to use "pager or less"
+	cmd =3D true
+	report =3D false
+	diff =3D true
+
+[help]
+	# Format can be man, info, web or html
+	format =3D man
+	autocorrect =3D 0
+
+[hist]
+	# a value of 'percentage' can be 'relative' or 'absolute'
+	percentage =3D absolute
+
+[ui]
+	show-headers=3D true
+
+[call-graph]
+	# fp (framepointer), dwarf
+	record-mode =3D fp
+
+	# graph (graph absolute), flat, fractal (graph relative)
+	print-type =3D fractal
+
+	# caller, callee
+	order =3D caller
+
+	# function, address
+	sort-key =3D function
+
+[report]
+	percent-limit =3D 1
+	children =3D false
+
+[top]
+	children =3D true
+
+[man]
+	viewer =3D man
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
new file mode 100644
index 0000000..e7784ed
--- /dev/null
+++ b/tools/perf/builtin-config.c
@@ -0,0 +1,75 @@
+/*
+ * builtin-config.c
+ *
+ * Copyright (C) 2015, Taeung Song <treeze.taeung@gmail.com>
+ *
+ */
+#include "builtin.h"
+
+#include "perf.h"
+
+#include "util/cache.h"
+#include "util/parse-options.h"
+#include "util/util.h"
+#include "util/debug.h"
+
+static int actions;
+
+static const char * const config_usage[] =3D {
+	"perf config [options]",
+	NULL
+};
+
+#define ACTION_LIST (1<<0)
+
+static const struct option config_options[] =3D {
+	OPT_GROUP("Action"),
+	OPT_BIT('l', "list", &actions, "show current config variables", ACTIO=
N_LIST),
+	OPT_END()
+};
+
+static int show_config(const char *key, const char *value,
+		       void *cb __maybe_unused)
+{
+	if (value)
+		printf("%s=3D%s\n", key, value);
+	else
+		printf("%s\n", key);
+
+	return 0;
+}
+
+int cmd_config(int argc, const char **argv, const char *prefix __maybe=
_unused)
+{
+	int ret =3D 0;
+	int origin_argc =3D argc - 1;
+	bool has_option;
+
+	argc =3D parse_options(argc, argv, config_options, config_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (origin_argc > argc)
+		has_option =3D true;
+	else
+		has_option =3D false;
+
+	switch (actions) {
+	case ACTION_LIST:
+		if (argc =3D=3D 0)
+			ret =3D perf_config(show_config, NULL);
+		else
+			goto out_err;
+		goto out;
+	default:
+		if (!has_option && argc =3D=3D 0) {
+			ret =3D perf_config(show_config, NULL);
+			goto out;
+		} else
+			goto out_err;
+	}
+
+out_err:
+	pr_warning("Error: Unknown argument.\n");
+	usage_with_options(config_usage, config_options);
+out:
+	return ret;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 3688ad2..3f871b5 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -17,6 +17,7 @@ extern int cmd_annotate(int argc, const char **argv, =
const char *prefix);
 extern int cmd_bench(int argc, const char **argv, const char *prefix);
 extern int cmd_buildid_cache(int argc, const char **argv, const char *=
prefix);
 extern int cmd_buildid_list(int argc, const char **argv, const char *p=
refix);
+extern int cmd_config(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_evlist(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_help(int argc, const char **argv, const char *prefix);
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 00fcaf8..acc3ea7 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -9,6 +9,7 @@ perf-buildid-cache		mainporcelain common
 perf-buildid-list		mainporcelain common
 perf-data			mainporcelain common
 perf-diff			mainporcelain common
+perf-config			mainporcelain common
 perf-evlist			mainporcelain common
 perf-inject			mainporcelain common
 perf-kmem			mainporcelain common
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index b857fcb..604fa4a 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -37,6 +37,7 @@ struct cmd_struct {
 static struct cmd_struct commands[] =3D {
 	{ "buildid-cache", cmd_buildid_cache, 0 },
 	{ "buildid-list", cmd_buildid_list, 0 },
+	{ "config",	cmd_config,	0 },
 	{ "diff",	cmd_diff,	0 },
 	{ "evlist",	cmd_evlist,	0 },
 	{ "help",	cmd_help,	0 },
--=20
1.9.1
