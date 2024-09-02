Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE3376E0;
	Mon,  2 Sep 2024 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241586; cv=none; b=TZTntpuWWuXHeCljT/QBm/QrN1vVT4Pd2Q5efFD7u4p+cowP672nDcbxdPJBTyO3X0lJIe5athN8h1medhwCdSAuvQnldSvKVuRD45TSLULu7UV6BuIs3GQoYp0WwBrIBtCo6UCzK1gaSCjM/IHs3ZWC+6ma4vKRrgxlvwkADTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241586; c=relaxed/simple;
	bh=SZsKD9uCuchZVWAml/dCRK+oDW3QBVeOZ/uiMQe13NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkH94fTNqbhSOWdhe3av6xnjeeTF6jgcGmboqgc6dqbcPsqW88ME6VTg5LU2VUyjGTNyIwDpglswvKvq54SQfFvgspLCftDOFJAvLCBrxkUQdZSEyHcr9NXalUvSCX1TsWK35d4chS+kAMygMdhisdgLlNXjoyXyzmZwrVzlDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaUJ+SZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaUJ+SZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5857EC4CECC;
	Mon,  2 Sep 2024 01:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725241586;
	bh=SZsKD9uCuchZVWAml/dCRK+oDW3QBVeOZ/uiMQe13NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaUJ+SZPPT+iM4j6LjpFJNxBTfbFkXvsm9KfWgDN9kZTgqNBjKYfSbLQrwMAHLD9x
	 BSCKHlpBiDIBup9cdTDi7Kd+Git8JNv2w9UoFhhSJOde5qYG8HsXQKMhIP/AV58KuZ
	 xFVT7lQumzf525U1BOXI6ujBd6+r+tuICTBy1dKPW8aoDyp/61abGyIjcuO4WN30GO
	 tpSg0tlCam1MqfVQWJR7HnuMPJWy/5IdX6uHrjtKNq5C5SpM/YIQ3uwxi9Uz9Gf2e9
	 zpOvD9pYW01u1aL5m5xjIW9sbw9vflJJIJa1URCEexYmV52AimHVedv21v5tF1Iwcc
	 3NlstVAoMZK+Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 4/4] perf tools: Do not set exclude_guest for precise_ip
Date: Sun,  1 Sep 2024 18:46:21 -0700
Message-ID: <20240902014621.2002343-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902014621.2002343-1-namhyung@kernel.org>
References: <20240902014621.2002343-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems perf sets the exclude_guest bit because of Intel PEBS
implementation which uses a virtual address.  IIUC now kernel disables
PEBS when it goes to the guest mode regardless of this bit so we don't
need to set it explicitly.  At least for the other archs/vendors.

I found the commit 1342798cc13e set the exclude_guest for precise_ip
in the tool and the commit 20b279ddb38c added kernel side enforcement
which was reverted by commit a706d965dcfd later.

Actually it doesn't set the exclude_guest for the default event
(cycles:P) already.

  $ grep -m1 vendor /proc/cpuinfo
  vendor_id	: GenuineIntel

  $ perf record -e cycles:P true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]

  $ perf evlist -v | tr ',' '\n' | grep -e exclude -e precise
   precise_ip: 3

But having lower 'p' modifier set the bit for some reason.

  $ perf record -e cycles:pp true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]

  $ perf evlist -v | tr ',' '\n' | grep -e exclude -e precise
   precise_ip: 2
   exclude_guest: 1

Actually AMD IBS suffers from this because it doesn't support excludes
and having this bit effectively disables new features in the current
implementation (due to the missing feature check).

  $ grep -m1 vendor /proc/cpuinfo
  vendor_id	: AuthenticAMD

  $ perf record -W -e cycles:p -vv true 2>&1 | grep switching
  switching off PERF_FORMAT_LOST support
  switching off weight struct support
  switching off bpf_event
  switching off ksymbol
  switching off cloexec flag
  switching off mmap2
  switching off exclude_guest, exclude_host

By not setting exclude_guest, we can fix this inconsistency and the
troubles.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/parse-events.c | 12 ++++--------
 tools/perf/util/parse-events.c  |  4 ----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9179bf3084c3..900107a171ee 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -898,8 +898,7 @@ static int test__group1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		/* use of precise requires exclude_guest */
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
@@ -1016,9 +1015,8 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 				TEST_ASSERT_VAL("wrong exclude_kernel",
 						!evsel->core.attr.exclude_kernel);
 				TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-				/* use of precise requires exclude_guest */
 				TEST_ASSERT_VAL("wrong exclude guest",
-						evsel->core.attr.exclude_guest);
+						!evsel->core.attr.exclude_guest);
 				TEST_ASSERT_VAL("wrong exclude host",
 						!evsel->core.attr.exclude_host);
 				TEST_ASSERT_VAL("wrong precise_ip",
@@ -1103,8 +1101,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		/* use of precise requires exclude_guest */
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1122,8 +1119,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		/* use of precise requires exclude_guest */
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ab73b3d45f04..4fa46ef7213c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1732,10 +1732,6 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 		int exclude = eu | ek | eh;
 		int exclude_GH = group ? evsel->exclude_GH : 0;
 
-		if (mod.precise) {
-			/* use of precise requires exclude_guest */
-			eG = 1;
-		}
 		if (mod.user) {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
-- 
2.46.0.469.g59c65b2a67-goog

