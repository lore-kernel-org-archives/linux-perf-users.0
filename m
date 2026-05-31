Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED41317145
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209494; cv=none; b=jX42OCdsBvt5xaTfR4jf7+6l5sYcz7IpnkzUmu3lwinq6zvU34vFrOvpPsNDeYLiPEZLfMTijZOlQMK2MEcWanckEdDyuDxyT2UUGtrO3F4cymHDptEIlK7oaOJwUKTM8IVQXIZEaKJMKWdJ8zn4U+fsFg4X7d3ohuKQZfrdUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209494; c=relaxed/simple;
	bh=S4QkXOVGAqkdJXVukJkj9dC/Tvf3VZ/72OSYa7CMAfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iif1lwxu6Wyu5eqLs2FyHhgzeYsp6U8d+ACfwu3r8b7z7f8iFUsh0eTFfknuSvN+60rNt1iwapoJRZIHJHCMPHcPnQEynN+WxqYGpnOdTiFie8ocoMrD+lO17HbdfJfRIqXCNeteNsFOus6zZXnMSOePAXtt6qMHo6b0IMRhZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihcFBzX7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihcFBzX7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137731eae44so12668531c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209487; x=1780814287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lF2xOrHkC9g74zwSi2HvrXz7ysKPnxyt3AoJ0r2d1t0=;
        b=ihcFBzX7YbyAZ0kycnVMJxj8jUqdiRfchD1cJdd5KmR1GSmD8Fc8rHxTfBibigVEVB
         Ep5NF4bxWt6NYEjIe/0s8G2X1W07YMamx6OBEH2xdTKLDxBnF4A/Sz2cbiHEMYMB16it
         An9LSdNaM1Im3MhpyBEoyERiJtytmqgvlu4RYwtQjVIKYToGDp725zPDP96aQNdTIjsG
         H+eTlFKmqOMYe/EaI1W9XN2CQjKea17jNOwdNks8UcG7/RgsoVp0RQr34/4EQ2+2skSt
         Mwcd4csFDfv1Zg/+ER6ezAqUz0Cr+qV1T6timS7n2MAhKqj+VtwoEigWdfLSImPhJlN/
         Qy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209487; x=1780814287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lF2xOrHkC9g74zwSi2HvrXz7ysKPnxyt3AoJ0r2d1t0=;
        b=I4/4vmRx+kv9ke9L+xjQE6G7d21ob6V4X3SU01O/K0WA2Sg0tfjOKamDB8bWK/KNSV
         IbsGd105dKeJgMt8pLwp0Hv77hPjUdcKyCTj2U9UPhmVP+jIRqowNYRZ9HH9IlrMGWiN
         Oau4NiY2Nouge4Mt4F7vT1UyNX9KTNXG+e84cQA3IGQQ1RVE0Cg6pNZY712qw0pR7PoN
         2NNVbWVdyK5iIFEB+3DYV2vViZ77PJiB7aX52xYTtRDNBbx0MbrQP9nA5eRi5UwKURR2
         xL+ollViaigXRH6DMTUby0Kam0xZcesTDgYsB6TvPuksf67IcXPposNtyzDnCFahUXc/
         mn4w==
X-Forwarded-Encrypted: i=1; AFNElJ/dWCmao4qlrNU/TXs9e7RGL1vsFpUy0B8rWXtM43scgMM4xovZeD+/SkntuPvFaPoH+O2IuWi1o14KKIcQBlRD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4DnY6HCLm3tfJvZScVriNqu4RypPvI898UAXd8qkaUUGY3gn
	BIrc5P7ZSf+JbaWIkoWPEJhYZs1sDRgudAn1aYEnmBqr1dVKm4rUZX+ZzbC/fM9wfstU2qc4dGs
	DnmdrIlhF1w==
X-Received: from dlnn5.prod.google.com ([2002:a05:7022:6185:b0:135:7678:498b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f20c:b0:12d:b205:c737
 with SMTP id a92af1059eb24-137d4240ee7mr2481661c88.17.1780209486919; Sat, 30
 May 2026 23:38:06 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:31 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-10-irogers@google.com>
Subject: [PATCH v3 09/14] perf test: Fix subtest status alignment for
 multi-digit indexes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running perf test, the status column (: Ok) became misaligned when
subtest indexes reached 2 or 3 digits (e.g. 9.100 vs 9.9 vs 10.1). This
occurred because the subtest description field width (subw) was statically
fixed to width - 2, assuming all subtest index prefixes were exactly 7
characters wide.

Dynamically calculate subw based on the exact character length of the test
suite and subtest index prefix. This ensures the status column is perfectly
aligned vertically across all test outputs regardless of subtest index digit
count.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index bd356249c70b..42dc7f6f00ae 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -373,10 +373,12 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			     int result, int width, int running)
 {
 	if (test_suite__num_test_cases(t) > 1) {
-		int subw = width > 2 ? width - 2 : width;
+		char prefix[32];
+		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
+				   curr_suite + 1, curr_test_case + 1);
+		int subw = len >= 4 ? width + 4 - len : width;
 
-		pr_info("%3d.%1d: %-*s:", curr_suite + 1, curr_test_case + 1, subw,
-			test_description(t, curr_test_case));
+		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
 	} else
 		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

