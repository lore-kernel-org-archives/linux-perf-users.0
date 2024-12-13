Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988B1E0DAC;
	Fri, 13 Dec 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113190; cv=none; b=BguaoZgaP1xQV9vW830CkSBzsWSyJQVxczdmV8AYyGJJhI02cfIJoJeQeylYgeqhtiHx2WO/f3kzs6TChArKkvUqGGlhJMaX1lBpR3w4juqij1qoR1yr9RXFynIp9R7qId933Kb36JsCZtkOtPCJpvDO6H6avzMHOEQZ4IAi90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113190; c=relaxed/simple;
	bh=IMKq4YKtkwXTsJhEt54jJRZjbleDFBUmsrXlpelQ94I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WtwgxcotzVB6Bqk9SmkTfYtSi+ib15N+j0gKYm3ThEF+x5DZKapdUmXcPtgsxSucGGCNimPHbTE/n3yV3jwiCtb2HNBvnerQgqs+ifAZ9y4O0ZwBiQk6H2AHImspNeSbvqcBGJRy3MnxzZp+Nceaar7/eHV/XU06SwvDcZ/8Xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHM2nVs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHM2nVs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EC7C4CED0;
	Fri, 13 Dec 2024 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734113190;
	bh=IMKq4YKtkwXTsJhEt54jJRZjbleDFBUmsrXlpelQ94I=;
	h=Date:From:To:Cc:Subject:From;
	b=AHM2nVs8cViHbk0c2uovOfVDlbZtTWMspNv296IoZ32QrdeQMuPuqMIfb4kI/KBOv
	 FeXIILSYdInu7+k/e3RKuyZwJK6emtA3rubYxWN3bNxEt2xudfxlR46HPwtDne4mh+
	 dHPzI528LoTjZgfYurGCIaiGnbk82dGUuDYOKK2i0RlgV/1FALIAUYM59y7G6yyZDn
	 GA/H2s5Jw5ybAgatisaRptKui69Id2AmjM4yqeT9YIq3kPdox6fnfLTlnvVRHeGAqG
	 mfXqDSaKGANPW5e258UN37C2hZpGruduA7rkTZcYMaq3L7XOq50HtcSYk+/mkirYjw
	 5d+1pp0RmLUKQ==
Date: Fri, 13 Dec 2024 15:06:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 next] perf tests switch-tracking: Set this test to run
 exclusively
Message-ID: <Z1x3o0YoeZS2kQzr@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This test was failing when run with the default 'perf test' mode, which
is to run multiple regression tests in parallel.

Since it checks system_wide mode, set it to run in exclusive mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/switch-tracking.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5cab17a1942e67d7..88a03bcbecb2b11f 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -583,4 +583,11 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	goto out;
 }
 
-DEFINE_SUITE("Track with sched_switch", switch_tracking);
+struct test_case tests__switch_tracking[] = {
+        TEST_CASE_EXCLUSIVE("Track with sched_switch", switch_tracking),
+        {       .name = NULL, }
+};
+struct test_suite suite__switch_tracking = {
+        .desc = "Track with sched_switch",
+        .test_cases = tests__switch_tracking,
+};
-- 
2.47.0

