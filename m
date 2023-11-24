Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6820D68;
	Fri, 24 Nov 2023 01:27:03 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee865606c655ca-855ca;
	Fri, 24 Nov 2023 17:27:01 +0800 (CST)
X-RM-TRANSID:2ee865606c655ca-855ca
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee165606c63cde-0afff;
	Fri, 24 Nov 2023 17:27:01 +0800 (CST)
X-RM-TRANSID:2ee165606c63cde-0afff
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
Subject: [PATCH] perf lock: Fix a memory leak on an error path
Date: Fri, 24 Nov 2023 17:26:57 +0800
Message-Id: <20231124092657.10392-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if a strdup-ed string is NULL,the allocated memory needs freeing.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/builtin-lock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b141f2134..086041bcb 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2228,8 +2228,10 @@ static int __cmd_record(int argc, const char **argv)
 		else
 			ev_name = strdup(contention_tracepoints[j].name);
 
-		if (!ev_name)
+		if (!ev_name) {
+			free(rec_argv);
 			return -ENOMEM;
+		}
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = ev_name;
-- 
2.33.0



