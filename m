Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD31EA90;
	Tue, 19 Nov 2024 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001034; cv=none; b=LfRSVG/v4lLwq5vu0tN+A9Gy4/bUQoN+EtgUWYo1Sh4y+rH9a/h5ERRbwh8bhdXCDhGaxvLxYB7YIPcsFg+MGLP6Bk/PucQmcpUvrjrph/M6iuOaa63/cGHHLJZrhiPBZbSGw5rZ+uXZ3cnzKEEvkBB7bjn0CeeuA7Pw9Rm5084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001034; c=relaxed/simple;
	bh=EU0LUFP03XC5ouuGJCIsMtl166bvMESi5p7jaeZrhno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZinTSFRTdLTm80uVGbg2UA7n6k2A0Nl3YGASrWQL4Eb7zJGzHnnMkEgGR0f8U2gYSPD4EPXFj+qg4yRzZTTX9I4X1+o5aMdlvhSR+CL0hhnaUmkWDsvNsymjQkzof545ozTPZYDDiLmI+FfxZfa2XEON9MD+Rowti+o9/ZMaxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673c3d0222c-17a54;
	Tue, 19 Nov 2024 15:23:47 +0800 (CST)
X-RM-TRANSID:2ee3673c3d0222c-17a54
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6673c3cf4ea7-1dd41;
	Tue, 19 Nov 2024 15:23:47 +0800 (CST)
X-RM-TRANSID:2ee6673c3cf4ea7-1dd41
From: guanjing <guanjing@cmss.chinamobile.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	mpetlan@redhat.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v1] perf tests: Fix unsigned comparison with less than zero
Date: Sun, 17 Nov 2024 16:04:46 +0800
Message-Id: <20241117080446.182201-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from the call to readlink() is not unsigned.
However, the return value is being assigned to an size_t
variable 'len', so making 'len' an ssize_t.

Eliminate the following coccicheck warning:

tools/perf/tests/tests-scripts.c:181:5-8: WARNING:
Unsigned expression compared with zero: len < 0

Fixes: 964461ee370f ("perf tests: Run time generate shell test suites")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/perf/tests/tests-scripts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index cf3ae0c1d871..1d5759d08141 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -174,7 +174,7 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	char filename[PATH_MAX], link[128];
 	struct test_suite *test_suite, **result_tmp;
 	struct test_case *tests;
-	size_t len;
+	ssize_t len;
 	char *exclusive;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
-- 
2.33.0



