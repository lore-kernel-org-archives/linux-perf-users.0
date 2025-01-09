Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DB1B0403
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448058; cv=none; b=O3rubWUDLyz3SF34O+dXzY+quuwjybau/HUMjwdeY4pt8YAXupqg4mdTTpcAFGNUZNLqxNoc2lFbCSgRTXurIW60AE6WkkNxFUJt1qs7Dss+tuRfOiZJh2U0dRv2wM2fiHay1GpCWAOchYgRDfldFQ0MgTH/tiZO2QJEq9tIAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448058; c=relaxed/simple;
	bh=03zxN2UsxLOpbQk3XmD+PZeej4CtfK4bugESkK4+E9I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZwGMfa2fyb0VVF30M1kdUz9xIG4jlmQZ8qsk1VwuwEvO1MmOtwbT+XXdgfSB0MVD2KqphE1FLacNck6oPS83oDBxjBoqkKri2L1yyfy+LatMUOlkf0cQbZtNkmrfKolaoPKRktzykWdACPQ4zKJGNS0o0i8Gm3Pk6hvePXIkKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7jBtivB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7jBtivB"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e54d9b54500so2767989276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448056; x=1737052856; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FgaDCd82RhWxCDiAHRf7hDKnWcYPhRmEM5CI1fivqE=;
        b=T7jBtivBAwPo5/8MPRogPPuLKYenekjKGAUw+DN/xm3OcLqFG4RB66zs0DzvVIzJl+
         6BjRW5rktVO/zQiyIBQ64xhwufZIQcL5lnTTGadVkXtLH/uV5P0dlrW6f7RUtbRHM/84
         z5SH28a8kC+6TnvylUdT0VPoMirh0/mLy95sXzjpbSOf9CCUd4hg2XCtZye/JtKxwcSX
         5uCXbNsx9XXFNiradzNKtZUhT4zpbmiA+M6tui6gzcoFWl4do13K5LAydqb84tpf7ZQe
         8+0XzuowMndFtAOKacS/BhCh8GtgFCBASJa/t/6s8fwb9+ranuZFXht98oiPbxOf7U46
         /hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448056; x=1737052856;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FgaDCd82RhWxCDiAHRf7hDKnWcYPhRmEM5CI1fivqE=;
        b=eGKxSJo2Gm7jakhHHk80yTyTuhsY3y4Vq2X2G5K69mkBiy0wIgUz6Uqvie8/myFS19
         vmNGk8R9YGpyRIdhyeITq7bppVBCdNcR8Zp9uj+EXfuPcNxhGfRD7EBYIXvVBk96B8qK
         aBtMKQsoV9MiOul2g/IfRQ95KCmuYMR0vOAzCQmB8Rjb+VZkQ2Xw4YXStXKeq179NgOZ
         Thlg1vODa+OVfSOoTnJR+YLD/BHrt4asEukZtLWnyo3DtFr4DWwRTlQICb6cWDMUptxC
         RCR6DxnzusbusB20mXKfdZu+mAdtuVW48QKa3oqBnj0b4To3UpzjXInVP0HSWD/sLk8y
         M0zg==
X-Forwarded-Encrypted: i=1; AJvYcCWMVwmn/jRre5RImB86/FBsiTbNTuwJWKHuN9CvcPZIfvXCX0l1G533PrrwdSehWPYC9tzzIA3UNHzm0vhjAVAz@vger.kernel.org
X-Gm-Message-State: AOJu0YwiT3nqyDaJKAlsYSQ445KIG9vfCD2jkLP5DWDAInyWLGCPhT5C
	XfMZO2TZdBkM0XywuXltOvSVesA9pdSTeQX3sWr2+WB3Cpg0YC9qbjxDJmxjam6ktR2nIO5Cvs4
	yyO7vug==
X-Google-Smtp-Source: AGHT+IGrlo28ICZjlYnHKHud5Lhbw52hO5bMA6E6bVy8S25WjrRcSMy9qsfxFUgBQHqIGe7Ixi3ejTvYspZN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:aaf4:0:b0:e48:4046:6bc5 with SMTP id
 3f1490d57ef6-e54ee23ec0fmr15959276.8.1736448056155; Thu, 09 Jan 2025 10:40:56
 -0800 (PST)
Date: Thu,  9 Jan 2025 10:40:44 -0800
In-Reply-To: <20250109184046.193736-1-irogers@google.com>
Message-Id: <20250109184046.193736-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109184046.193736-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 3/5] perf test: Remove parallel option documentation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The parallel option was removed in commit 94d1a913bdc4 ("perf test:
Make parallel testing the default").

Fixes: 94d1a913bdc4 ("perf test: Make parallel testing the default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index efcdec528a8f..8f8a3c367570 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -35,12 +35,6 @@ OPTIONS
 --sequential::
 	Run tests one after the other, this is the default mode.
 
--p:: 
---parallel::
-	Run tests in parallel, speeds up the whole process but is not safe with
-	the current infrastructure, where some tests that compete for some resources,
-	for instance, 'perf probe' tests that add/remove probes or clean all probes, etc.
-
 -F::
 --dont-fork::
 	Do not fork child for each test, run all tests within single process, this
-- 
2.47.1.613.gc27f4b7a9f-goog

