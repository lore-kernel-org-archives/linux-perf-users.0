From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/63] perf config: Show the configuration when no arguments are provided
Date: Tue, 18 Dec 2018 19:07:08 -0300
Message-ID: <20181218220733.15839-39-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

More convenient thah having to recall what letter is about
showing/listing/dumping the configuration, i.e. no arguments means
-l/--list:

  # perf config
  llvm.dump-obj=true
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  # perf config -l
  llvm.dump-obj=true
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  # perf config -h

   Usage: perf config [<file-option>] [options] [section.name[=value] ...]

      -l, --list            show current config variables
          --system          use system config file
          --user            use user config file

  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-z2n63avz6tliqb5gmu4l1dti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 514f70f95b57..d76f831f94c7 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -196,6 +196,7 @@ int cmd_config(int argc, const char **argv)
 			pr_err("Error: takes no arguments\n");
 			parse_options_usage(config_usage, config_options, "l", 1);
 		} else {
+do_action_list:
 			if (show_config(set) < 0) {
 				pr_err("Nothing configured, "
 				       "please check your %s \n", config_filename);
@@ -204,10 +205,8 @@ int cmd_config(int argc, const char **argv)
 		}
 		break;
 	default:
-		if (!argc) {
-			usage_with_options(config_usage, config_options);
-			break;
-		}
+		if (!argc)
+			goto do_action_list;
 
 		for (i = 0; argv[i]; i++) {
 			char *var, *value;
-- 
2.19.2
