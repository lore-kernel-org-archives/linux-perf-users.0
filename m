Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D7191;
	Fri, 24 Nov 2023 00:39:18 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee165606133b13-1a3e1;
	Fri, 24 Nov 2023 16:39:15 +0800 (CST)
X-RM-TRANSID:2ee165606133b13-1a3e1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8656061300df-0d1c1;
	Fri, 24 Nov 2023 16:39:15 +0800 (CST)
X-RM-TRANSID:2ee8656061300df-0d1c1
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
Date: Fri, 24 Nov 2023 16:39:10 +0800
Message-Id: <20231124083910.10169-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return NULL if dynamic allocation failed.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/builtin-help.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index b2a368ae2..e89734dbb 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -196,6 +196,9 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p = &((*p)->next);
 	*p = zalloc(sizeof(**p) + len + 1);
+	if(!*p)
+		return NULL;
+
 	strcpy((*p)->name, name);
 }
 
@@ -211,6 +214,8 @@ static void do_add_man_viewer_info(const char *name,
 				   const char *value)
 {
 	struct man_viewer_info_list *new = zalloc(sizeof(*new) + len + 1);
+	if(!new)
+		return NULL;
 
 	strncpy(new->name, name, len);
 	new->info = strdup(value);
-- 
2.33.0



