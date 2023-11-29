Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C958A1999;
	Wed, 29 Nov 2023 01:42:06 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee565670766cd0-3c572;
	Wed, 29 Nov 2023 17:42:04 +0800 (CST)
X-RM-TRANSID:2ee565670766cd0-3c572
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76567076b191-69aba;
	Wed, 29 Nov 2023 17:42:04 +0800 (CST)
X-RM-TRANSID:2ee76567076b191-69aba
From: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Li Dong <lidong@vivo.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] perf help:Fail check on dynamic allocation
Date: Wed, 29 Nov 2023 17:42:02 +0800
Message-Id: <20231129094202.11500-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return error  if dynamic allocation failed.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/builtin-help.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index b2a368ae2..ca05cc795 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -196,6 +196,11 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p = &((*p)->next);
 	*p = zalloc(sizeof(**p) + len + 1);
+	if(!*p) {
+		pr_err("Failed to zalloc man viewer list\n");
+		return ;
+	}
+
 	strcpy((*p)->name, name);
 }
 
@@ -211,6 +216,10 @@ static void do_add_man_viewer_info(const char *name,
 				   const char *value)
 {
 	struct man_viewer_info_list *new = zalloc(sizeof(*new) + len + 1);
+	if(!new) {
+		pr_err("Failed to zalloc man viewer info list\n");
+		return ;
+	}
 
 	strncpy(new->name, name, len);
 	new->info = strdup(value);
-- 
2.33.0



