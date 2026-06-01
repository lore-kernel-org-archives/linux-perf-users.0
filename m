Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4C9463
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272388; cv=none; b=BX5dzU0gVavDIkLjdyuUQ4F/d1LHGPEsONN+XZeRMYHgfaAgrEwGUnCb8grmsO4ORxJFj9fvPQJmndMcPCsobg7kiKFgBWECR5BSTkiSoB260vvPk67N1/SINrsPAxOEAZy+P0dvLQaJ5SXPgVji6FVa/W+4w8Msi/iW+wogDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272388; c=relaxed/simple;
	bh=v+uQb482xCIMi9HmoWUGu58IjoDszSuB2IlHYCHiaSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q4tuSE3U7wBPIvw7uxDttcc+LTWi7/cJK2p0R7YUJ6VHecoVECr7LVuMoc802kMsbowq3Rsog28aWpfGYK5MXIC7Ar2MwmY+XdyJyyqH1U6rJQWeaDAjXCxMCY3ijcIwVN51jA3uYNY1mYAR0Yv+hNVYnvi/SqyZffBAvcKU6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIYdgjpl; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIYdgjpl"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f23c55b2so2317177eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272377; x=1780877177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oWF0bxxyu3W0maVW6LzGoakYua7rlvwmHaeizM/uC8=;
        b=ZIYdgjplBhXy/lL7fP4LuV78HDU1GUGEGQpiOHwTrPbgs22UFnWyL1ii9X0GAwkeyN
         G1UpeQMJoLVaisOxmIh+CyLi9XpnYuv/UtmoqSSbnlA1JOTZXswWXYqeSCmgkD9Tm6gp
         G0mIHd78VbEjgAaopNYpuFYMUQKw4nM2wrjVA6Oa1Jxad21kDWQGNdyhVH0JiV+LjFf1
         zvjdqUQ1BcygWdozVp1KQu+RL6FRjG9HggmSA0eMLz8Gpn98M8aujLqIqvM9/JHOru/7
         QfAIrjSKnhautdi2d7AHl7WuD1agKNeNdjej6x80WuWJGK3BF93FyYzVgLsAed52Uelq
         yE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272377; x=1780877177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oWF0bxxyu3W0maVW6LzGoakYua7rlvwmHaeizM/uC8=;
        b=XLyOwT4LGoXXpAr3N8jOiT2j7KUzGwOhnbEd/h+Xu7RBKeWGhsqclUb9iBB4Ur5rU6
         2CCm2KJWQtn6OSZ7j1WX1ZVa6FdRO93fH9nMxcV6/eFVQdbkOtBQ5wnBSo2G1N9tLP+e
         1ZGF3kdYUKOESAyQuJHRohQC7rjOgiVei1ZspDontyZssRs7AM9lpMeTiU4kg4fVlx9z
         +M+bGR/rVdCwWZB2nSSW8pXzU2QPOSZuTI7XWFrm1FVRjZiec17BKSmoKaoOOS+zjSf1
         NWx4LClxzIcxv6UR5N0yAhdzFPIKSAQaoX7R1Rt7dn1lpgT00V7od7ygStZpeWLmeveB
         +5og==
X-Forwarded-Encrypted: i=1; AFNElJ8VOXP1KxT2Yc6uOHQQUYgMp+Xd/DOAg1f8DcdTnKec5GFeP50VkQcUIB8HUfaUcvORUGgy6b/rMCLG8mJOd7Dh@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCqMwHxGOPa19l/tiy4U7xwyLq/a6gFldI0/xKm9T60Le6KBo
	o9FX7w5lnRlZV0oYrUhbKF56izQ9w5VeK+oIAy/MW1i2H382XUIlIppemFMMUp++p5IFLaxAzUU
	K9wL2zKAr7Q==
X-Received: from dlai21.prod.google.com ([2002:a05:701b:2715:b0:135:b432:37dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6ba6:b0:136:6883:c4bc
 with SMTP id a92af1059eb24-137d3bf701emr3176568c88.9.1780272376558; Sun, 31
 May 2026 17:06:16 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:43 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-11-irogers@google.com>
Subject: [PATCH 10/15] perf test: Fix subtest status alignment for multi-digit indexes
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
index 336d24105c9f..4c0caa8d0b27 100644
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

