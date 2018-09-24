From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/27] tools lib subcmd: Support overwriting the pager
Date: Mon, 24 Sep 2018 12:02:18 -0300
Message-ID: <20180924150242.14235-4-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an interface to the auto pager code that allows callers to overwrite
the pager.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180918123214.26728-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/pager.c | 11 ++++++++++-
 tools/lib/subcmd/pager.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
index 9997a8805a82..e3d47b59b14d 100644
--- a/tools/lib/subcmd/pager.c
+++ b/tools/lib/subcmd/pager.c
@@ -23,6 +23,13 @@ void pager_init(const char *pager_env)
 	subcmd_config.pager_env = pager_env;
 }
 
+static const char *forced_pager;
+
+void force_pager(const char *pager)
+{
+	forced_pager = pager;
+}
+
 static void pager_preexec(void)
 {
 	/*
@@ -66,7 +73,9 @@ void setup_pager(void)
 	const char *pager = getenv(subcmd_config.pager_env);
 	struct winsize sz;
 
-	if (!isatty(1))
+	if (forced_pager)
+		pager = forced_pager;
+	if (!isatty(1) && !forced_pager)
 		return;
 	if (ioctl(1, TIOCGWINSZ, &sz) == 0)
 		pager_columns = sz.ws_col;
diff --git a/tools/lib/subcmd/pager.h b/tools/lib/subcmd/pager.h
index f1a53cf29880..a818964693ab 100644
--- a/tools/lib/subcmd/pager.h
+++ b/tools/lib/subcmd/pager.h
@@ -7,5 +7,6 @@ extern void pager_init(const char *pager_env);
 extern void setup_pager(void);
 extern int pager_in_use(void);
 extern int pager_get_columns(void);
+extern void force_pager(const char *);
 
 #endif /* __SUBCMD_PAGER_H */
-- 
2.14.4
