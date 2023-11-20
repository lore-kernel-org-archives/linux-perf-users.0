Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03A699C;
	Mon, 20 Nov 2023 03:24:04 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3655b41d0dc5-fb5b4;
	Mon, 20 Nov 2023 19:24:00 +0800 (CST)
X-RM-TRANSID:2ee3655b41d0dc5-fb5b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea655b41cc005-bb4a3;
	Mon, 20 Nov 2023 19:23:59 +0800 (CST)
X-RM-TRANSID:2eea655b41cc005-bb4a3
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
Subject: [PATCH] perf script perl: Fail check on dynamic allocation
Date: Mon, 20 Nov 2023 19:23:56 +0800
Message-Id: <20231120112356.8652-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return ENOMEM when dynamic allocation failed.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/util/scripting-engines/trace-event-perl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 603091317..b072ac5d3 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -490,6 +490,9 @@ static int perl_start_script(const char *script, int argc, const char **argv,
 	scripting_context->session = session;
 
 	command_line = malloc((argc + 2) * sizeof(const char *));
+	if (!command_line)
+		return -ENOMEM;
+
 	command_line[0] = "";
 	command_line[1] = script;
 	for (i = 2; i < argc + 2; i++)
-- 
2.33.0



