Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F24C91;
	Sun,  3 Nov 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730593455; cv=none; b=eIq6dtUWAEVoPL2FIAgii8t+SlTqMin0DS3xUofY+SiTz3Q0XcUUO5rFIurzbQ1lHRbKJyn+Orfg8BzdYgOW6sBImEvNS3PI52l7w4yfEIVClAW8lUY+I6T4OuT8lbBvAatyx9CMILjX/x0Nok/GNEO8/ikDgzSnxTVm7NvK2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730593455; c=relaxed/simple;
	bh=Q+oJA2uKm0R/MuuCEHnKdx8gl6GThPlEdlk05pIquKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcLDYwY+hkAv4xXQPi8hQCA9ofNhq3418fn7XKnpKtPSBKH5fgnceKR3dIOIfDAY8+fGYnlG0h+FtQUhcyFP9Rxalj8kbtVD5o/KSK2zDTlHRWWgvU/Xt/Z84VVlLYuheDEkpQax9Ma5Yk38inAvsRfEU4d0G18GNLDFq98erHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUfxs8aW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUfxs8aW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7E2C4CEC3;
	Sun,  3 Nov 2024 00:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730593455;
	bh=Q+oJA2uKm0R/MuuCEHnKdx8gl6GThPlEdlk05pIquKU=;
	h=From:To:Cc:Subject:Date:From;
	b=dUfxs8aW/4TyIFeGEuWbiRTFKumlp5LRP6LRQBe9lKR8kHapKIm3uln7WgXfM4wjG
	 0d4ENYzCDtvP67wnI+WTtCXpk8a/AWstJIvwgpXqbUuBMNz8o2KaVHoEdj7EWyr/kv
	 tS38N5QQ/OkyCJ+vaLx4rf+nVRC+fABjSlWO6GiOfbp5DSTky6oGkb/vng+UKbBbqU
	 KR47xY44aR3Cao6c+1CqMBydPHpc3mzfKL0h+HzYbG3Bh6KeDBJlobdred3MhX9YEz
	 8uIlYuS4DpWZ/CylEsBhjwLcd3RXK8hxqMkMDNMtRioV1hFUrXCXVUbZEDEMji0IJP
	 SCT9wLvdI23Mg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Fix LBR test by adding indirect calls
Date: Sat,  2 Nov 2024 17:24:14 -0700
Message-ID: <20241103002414.2281869-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've noticed sometimes perf record LBR tests failed on indirect call
test because it has empty branch stacks more than expected.

The test workload (thloop) spawns a thread and calls a loop function for
1 second both from the main thread and the new thread.  However neither
of them has indirect calls in the body so it ended up with empty branch
stacks.

  LBR any indirect call test
  [ perf record: Woken up 21 times to write data ]
  [ perf record: Captured and wrote 5.607 MB /tmp/__perf_test.perf.data.pujKd (7924 samples) ]
  LBR any indirect call test: 7924 samples
  LBR any indirect call test [Failed empty br stack ratio exceed 2%: 3%]

Refactor the test workload to call the test_loop() both directly and
indirectly.  Now expectation of indirect call is 50% but let's add some
margin for startup and finish routines.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_lbr.sh | 2 +-
 tools/perf/tests/workloads/thloop.c  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 8d750ee631f877fd..7a23b2095be8acba 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -121,7 +121,7 @@ lbr_test "-j any_ret" "any ret" 2
 lbr_test "-j ind_call" "any indirect call" 2
 lbr_test "-j ind_jmp" "any indirect jump" 100
 lbr_test "-j call" "direct calls" 2
-lbr_test "-j ind_call,u" "any indirect user call" 100
+lbr_test "-j ind_call,u" "any indirect user call" 52
 lbr_test "-a -b" "system wide any branch" 2
 lbr_test "-a -j any_call" "system wide any call" 2
 
diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index 457b29f91c3ee277..fa5547939882cf6c 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -18,14 +18,16 @@ static void sighandler(int sig __maybe_unused)
 
 noinline void test_loop(void)
 {
-	while (!done);
+	for (volatile int i = 0; i < 10000; i++)
+		continue;
 }
 
 static void *thfunc(void *arg)
 {
 	void (*loop_fn)(void) = arg;
 
-	loop_fn();
+	while (!done)
+		loop_fn();
 	return NULL;
 }
 
@@ -42,7 +44,8 @@ static int thloop(int argc, const char **argv)
 	alarm(sec);
 
 	pthread_create(&th, NULL, thfunc, test_loop);
-	test_loop();
+	while (!done)
+		test_loop();
 	pthread_join(th, NULL);
 
 	return 0;
-- 
2.47.0.163.g1226f6d8fa-goog

