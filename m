Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3A2066E2
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736485069; cv=none; b=k698+4pQgJaT+dPWZROcUhCwf04LXHbGRQ+4+TdfyUiVBdG/RB9XqGmVTCJKc8MOF/zYcvOtsPZzWWeFEc8GOdAVGr4WPUr1WrQeAR2SrxQY/cobr6MUiRN5lLFqC7q3zXhIIfiTovq5AkO8kjNdWc9sXZKiRbaXzSA5EE+LDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736485069; c=relaxed/simple;
	bh=YOepETVfHonn8uZir4r4eusKZejQHN7ESN5brod9p/Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bjxJxoJE0flS8VnwL2Eu1Wf/HNxQNdjCu4EekzooCgAzR0Ie+5W+3iFJcgbMKewMDBj5/7+mWLpy4vEHjYc1ruvuH3bC2tpfz5mT8JWu7AHL68zpPRa2q7OLBp7KNfseHyMw58Z887dn6/5fNHFvDdEF5i0UuQybp1CtM0uHcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqgXv7rn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqgXv7rn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a1bc0c876so3725590276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 20:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736485066; x=1737089866; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s63/Y/oKa0if/THcgPq3FL+TPGZ7JCSoXdoBNLnmIzc=;
        b=IqgXv7rnTM3vwmyrrROTkt44G2kWE09ChsunNayA+h9btdxPRMfurJ43wckIZ0OMow
         t7HtScyXUHPrmhTbhmzens47M5AvlWOq1FR6LL9tgeV0hn8cYTrVasReAlkjZTiZxNbv
         jeK1UPQpYVX4FS/m5QM/+VY7ChLR5YemUBKZcueLAOR/0B6UBY1T4lGfIWme28z329vI
         KpzSM7eLg5sQAaz/WCQ6KQjJXEFYtFuXcTS/iN/k/i/Ddo9sCOcpR5D+Ex5EihqBEqze
         Eu+A4lGF8XYWCNSLBYQk/eE5g20rYAMMZ/PR9QpJIJls66WcMHuzyk5/+jnF8tWxBkHD
         ztdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736485066; x=1737089866;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s63/Y/oKa0if/THcgPq3FL+TPGZ7JCSoXdoBNLnmIzc=;
        b=EkXRim50DfAswrNw7DFyHzzNw4e9sSdxCeZrG6OewACYRC0vKHHR4LiNFOThGGUrwt
         dfreLuiB1l1VMO/UFsx0B2lhvjnbNw0EbX2es/xaEmVmjNETVUBmfA8PTIsu3+W1TEYX
         Y2e9UIVf0EF7eTiqJT1+/e+yjpxaawO6TGYj0cOaEawvwwsTx62lN/tm1m2fI8uVsI8l
         qycKLQcppCMROy6bPqJfRW3QuohNS9syXkbb0D9Hn46LKPg+9RRHe1qd3MmV52eXufix
         vgqScU6VJx32IlbOfeoyhTlkiG5Oax9qiUZrZQgJdF3mFpCZzQO7cIwfc/jMkB5XnMUn
         qQPg==
X-Forwarded-Encrypted: i=1; AJvYcCXYer+8JVPmQ5SrcODvgIM/8GYCkbY4b/Zi4Yz5EMMBS3iIiKd3/VJ/uxUDuQZeB2daVs9XFEaoIY392EX+paAy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvz2p2bVGthPG9hpsi2VepJh5ajIR4au7MS7leIrA0rGOOd09i
	TjtexOPFmRNJS65FV4aT3oc75HwwhH+wUnG7cg+5/p7kyS/K4BozGfbNk2UufOdw13+7AIn0RK6
	Gc7MK+Q==
X-Google-Smtp-Source: AGHT+IFPeRWpfLYB+la4IH4hxWInhVIyCyFBDphutveXRxwdCHDaA0mZAuPZTPXzO9htsEjo+ugr93nIBaEE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a5b:10a:0:b0:e4a:dea9:fe07 with SMTP id
 3f1490d57ef6-e54eff2ce3cmr20589276.4.1736485066457; Thu, 09 Jan 2025 20:57:46
 -0800 (PST)
Date: Thu,  9 Jan 2025 20:57:34 -0800
In-Reply-To: <20250110045736.598281-1-irogers@google.com>
Message-Id: <20250110045736.598281-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110045736.598281-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 3/5] perf test: Fix parallel/sequential option documentation
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
Make parallel testing the default"). Update the sequential
documentation to reflect it isn't the default except for "exclusive"
tests.

Fixes: 94d1a913bdc4 ("perf test: Make parallel testing the default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index efcdec528a8f..2e40869b64de 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -33,13 +33,9 @@ OPTIONS
 
 -S::
 --sequential::
-	Run tests one after the other, this is the default mode.
-
--p:: 
---parallel::
-	Run tests in parallel, speeds up the whole process but is not safe with
-	the current infrastructure, where some tests that compete for some resources,
-	for instance, 'perf probe' tests that add/remove probes or clean all probes, etc.
+	Run all tests one after the other. By default "exclusive"
+	tests are run sequentially, but other tests are run in
+	parallel to speed execution.
 
 -F::
 --dont-fork::
-- 
2.47.1.613.gc27f4b7a9f-goog

