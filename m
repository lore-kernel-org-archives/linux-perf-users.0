From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/17] perf script: Allow +- operator for type specific fields option
Date: Wed, 20 Feb 2019 22:25:46 -0300
Message-ID: <20190221012549.4069-15-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add support to add/remove fields for specific event types in -F option.
It's now possible to use '+-' after event type, like:

  # cat > test.c
  #include <stdio.h>

  int main(void)
  {
     printf("Hello world\n");
     while(1) {}
  }
  ^D
  # gcc -g -o test test.c
  # perf probe -x test 'test.c:5'
  # perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
  ...

  # perf script -Ftrace:+period,-cpu
            test  3859 396291.117343:      10275 cpu/cpu-cycles,period=10000/:      7f..
            test  3859 396291.118234:      11041 cpu/cpu-cycles,period=10000/:  ffffff..
            test  3859 396291.118234:          1              probe_test:main:
            test  3859 396291.118248:       8668 cpu/cpu-cycles,period=10000/:  ffffff..
            test  3859 396291.118263:      10139 cpu/cpu-cycles,period=10000/:  ffffff..

Committer testing:

Couldn't make the test above work, but tested it with:

  # perf probe -x hello main
  Added new event:
    probe_hello:main     (on main in /home/acme/c/hello)

  You can now use it in all perf tools, such as:

	  perf record -e probe_hello:main -aR sleep 1

  # perf record -e probe_hello:main ./hello
  hello, world
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.025 MB perf.data (1 samples) ]
  # perf script
           hello 21454 [002] 254116.874005: probe_hello:main: (401126)
  #
  # perf script -Ftrace:+period,-cpu
           hello 21454 254116.874005:          1 probe_hello:main: (401126)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 6 ++++++
 tools/perf/builtin-script.c              | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9e4def08d569..2e19fd7ffe35 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -159,6 +159,12 @@ OPTIONS
 	the override, and the result of the above is that only S/W and H/W
 	events are displayed with the given fields.
 
+	It's possible tp add/remove fields only for specific event type:
+
+		-Fsw:-cpu,-period
+
+	removes cpu and period from software events.
+
 	For the 'wildcard' option if a user selected field is invalid for an
 	event type, a message is displayed to the user that the option is
 	ignored for that type. For example:
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8d5fe092525c..373ea151dc60 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2560,6 +2560,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			pr_warning("Overriding previous field request for %s events.\n",
 				   event_type(type));
 
+		/* Don't override defaults for +- */
+		if (strchr(tok, '+') || strchr(tok, '-'))
+			goto parse;
+
 		output[type].fields = 0;
 		output[type].user_set = true;
 		output[type].wildcard_set = false;
@@ -2644,6 +2648,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
+			if (change == REMOVE)
+				output[type].fields &= ~all_output_options[i].field;
+			else
+				output[type].fields |= all_output_options[i].field;
 			output[type].user_set = true;
 			output[type].wildcard_set = true;
 		}
-- 
2.19.1
