Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2F4685
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 22:46:14 PST
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FB20E7
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2023 22:46:13 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee665546870055-d78de;
	Wed, 15 Nov 2023 14:42:58 +0800 (CST)
X-RM-TRANSID:2ee665546870055-d78de
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8655468705d7-6b236;
	Wed, 15 Nov 2023 14:42:58 +0800 (CST)
X-RM-TRANSID:2ee8655468705d7-6b236
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: suzuki.poulose@arm.com
Cc: mike.leach@linaro.org,
	james.clark@arm.com,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] perf/tests:coresight:remove unused variables
Date: Tue, 14 Nov 2023 22:42:55 -0800
Message-Id: <20231115064255.11057-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

These variables are never referenced in the code, just remove them.

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c   | 1 -
 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c       | 1 -
 .../shell/coresight/unroll_loop_thread/unroll_loop_thread.c      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
index a7e169d1bf64..5f886cd09e6b 100644
--- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
+++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
@@ -42,7 +42,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
 int main(int argc, char **argv)
 {
 	unsigned long i, len, size, thr;
-	pthread_t threads[256];
 	struct args args[256];
 	long long v;
 
diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
index c0158fac7d0b..e05a559253ca 100644
--- a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
+++ b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
@@ -57,7 +57,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
 int main(int argc, char **argv)
 {
 	unsigned int i, len, thr;
-	pthread_t threads[256];
 	struct args args[256];
 
 	if (argc < 3) {
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
index 8f6d384208ed..0fc7bf1a25af 100644
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
@@ -51,7 +51,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
 int main(int argc, char **argv)
 {
 	unsigned int i, thr;
-	pthread_t threads[256];
 	struct args args[256];
 
 	if (argc < 2) {
-- 
2.17.1



