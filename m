From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/37] perf script: Allow extended console debug output
Date: Thu, 25 Oct 2018 08:10:07 -0300
Message-ID: <20181025111031.3440-14-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

The script tool isn't using a browser, yet use_browser wasn't set
explicitly to zero. This in turn lead to confusing output such as:

  ```
  $ perf script -vvv ...
  ...
  overlapping maps in /home/milian/foobar (disable tui for more info)
  ...
  ```

Explicitly set use_browser to 0 now, which gives us the extended
debug information now in perf script as expected.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20181021191424.16183-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4da5e32b9e03..bd468b90801b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
 		exit(-1);
 	}
 
-	if (!script_name)
+	if (!script_name) {
 		setup_pager();
+		use_browser = 0;
+	}
 
 	session = perf_session__new(&data, false, &script.tool);
 	if (session == NULL)
-- 
2.14.4
