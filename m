From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/43] perf tools: Use ui__error() for reporting --fields errors
Date: Tue, 23 Jan 2018 10:12:12 -0300
Message-ID: <20180123131251.28197-5-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can get it working for TUI, where using just pr_err() would
end up making the message emitted to stderr to be erased by the TUI exit
routine restoring the terminal to its previous state.

Now we can see that trying to use a tracepoint field as one of the
--field entries isn't working:

  # perf top --stdio --no-children -e syscalls:sys_enter_write --fields pid,sym,count
  Error:
  Unknown --fields key: `count'
   Usage: perf top [<options>]

        --fields <key[,keys...]>
                          output field(s): overhead, period, sample plus all of sort keys
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-usy9hhy7umdd4bbblkn63t8w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 211e7f326b9f..2da4d0456a03 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2887,10 +2887,10 @@ static int setup_output_list(struct perf_hpp_list *list, char *str)
 			tok; tok = strtok_r(NULL, ", ", &tmp)) {
 		ret = output_field_add(list, tok);
 		if (ret == -EINVAL) {
-			pr_err("Invalid --fields key: `%s'", tok);
+			ui__error("Invalid --fields key: `%s'", tok);
 			break;
 		} else if (ret == -ESRCH) {
-			pr_err("Unknown --fields key: `%s'", tok);
+			ui__error("Unknown --fields key: `%s'", tok);
 			break;
 		}
 	}
-- 
2.14.3
