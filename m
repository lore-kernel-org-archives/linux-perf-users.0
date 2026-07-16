Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF630274D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185400; cv=none; b=p5w+/7z5dhH6V3JEMCSl4hL+4I4zUv2ZLPbZHYhbKjdNawaXcK7E3IZLbCyTueLLFA5Y0cTEith04L9mLaP/+j/KhmP/jRzxmkvtZsvAtWicEVoZgi+MYUrlpOs2GAz88CwKSDippFP1EyJ2QbKq5A2Vi96lMTyYA1sNSOhrs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185400; c=relaxed/simple;
	bh=d5JB2fN4cHgH+ISFRjlPKGGrO51fpH0LIbT4lwQYVcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bzZQe0ErW/NNfmsggmBUVIV4MUpkX0yiagaT1IkznjCF//06pDDJAIxPM0fkj/ry5vG3cbfqrHVneL2TU2n1EUs3ftWrTV3xZoqkz30rnfTz38z5WZHLMkUj2MmaBzcaNBGw7UrU0EtmXXXKo7bv6UVB1Z8/F8skcWetLRqvuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFTkXET/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFTkXET/"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so9232598a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185398; x=1784790198; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnCDelU6k7UkVlqKMeKUfoU14mnGppN9P1rHffhr4aQ=;
        b=jFTkXET/fRO5QdtmhFln8VurjsfW64hoBOek+tsX8qIQ07rgaxEyJFz83KIqY9D7cJ
         fXDs2QAKB1pjJIM3EZDkSxykJvFr1Lm9QWUp2a1fj1Z3jg1b2wF+x1tQY0c7QNhJoR6F
         iC7t+yXijjPRzVmtJdLNzilNqEvViewyb7S92Iw+7eYtHavmV/qw2Hfbv+vgtAPWNTqk
         EZTyIsWvtTvpuDwFeA5NEaokWBEk2G/xcawoXAPtZz4js3XEU50l6b/UvKTpF8pKJXS8
         dnfqThXPRu+w/ouoRE1geNIUmktQKju/bkczE5gAkoXkHXeu5q9N0XugLwtESe2YDZTt
         U/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185398; x=1784790198;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnCDelU6k7UkVlqKMeKUfoU14mnGppN9P1rHffhr4aQ=;
        b=XvwQJdjtQ5akvOBvkPDRWWdx2UWHUeeh4K12F5fBSK5QdlLCAyr7v3IxaLk1Z7VuUI
         LByvLuDajYjQlk9rkZVJtcnjRCBMFlxGPMn7Gka6WU8+M0q2v3kVGSxrnrMHpDVsyPki
         SWsd5XJz9J+w0023wxloH7kDlzim2hZijgnvUMYEXdyJBrDbeSieH2nHq+GBh/foc50j
         uW98LelGkzRzrNPM6haZNdY1A8EskEpwnPwKlRrul9icHAj2VmZ5c9k7nYXUgbOZ+6tN
         hlkqsicYjPmLr71FglImZzgYvR4DIl+nUCnhEBfFhOCwHMJTtyxCkWr4Ws2Qz1KHuFhC
         kbSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOz0JwOWGSkMFLS8Ulh67RD87cte6f56sni91bk7wXRjpmuJTnlBo0Ad8uoFM062q1augwQKRCpmQVTN0jU7tj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fP0paHTs0U4JCycYeY6zsQlZeGBVwKE4++esImgbwsret+eC
	NW0d1eYX0lJ0RpuMeoI4A1F35lzA36HaWbKvOGlTrSr4xwLjDKKGNQWQFWsjWBwdm5a51jpFaEC
	0g+M6NmS9dg==
X-Received: from dychz19.prod.google.com ([2002:a05:7301:8613:b0:30f:2b52:8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c46:b0:37f:bfd6:8b40
 with SMTP id 98e67ed59e1d1-38e1add8ad5mr8801189a91.5.1784185398199; Thu, 16
 Jul 2026 00:03:18 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:52 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-4-irogers@google.com>
Subject: [PATCH v4 03/14] perf stat: Extend STD output linter to test basic
 New API checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

This patch extends the standard console (STD) output linter script
tools/perf/tests/shell/stat+std_output.sh to run the basic no-argument
check a second time using the --new print flag:

  perf_cmd="--new -o ${stat_output}"
  check_no_args "STD (New API)" "$perf_cmd"

This ensures that standard console outputs produced by the decoupled
printing callbacks are formally validated by the test suite.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..233e0a50eb33 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -118,5 +118,9 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API basic checks
+perf_cmd="--new -o ${stat_output}"
+check_no_args "STD (New API)" "$perf_cmd"
+
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

