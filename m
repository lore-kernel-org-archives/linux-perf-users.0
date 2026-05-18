Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5783793BF
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119218; cv=none; b=hnT9fhabUCOWl47yzj3bNdFmfbaqnarF+LDO8RBYUEXLLwslW8EEOurxqvkyV6Zp42JQQ8X1O8AHl5aNKdykqiyMwBI96nACPql9/QhLsRgKr6Mj8jMI3KnD1ckEotzooW9j8dpdqXNwp67rdiCqE4EMqeTZnGIKlO3OmHM9OYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119218; c=relaxed/simple;
	bh=/7TyOYbdEe9k68HYyv7dCCFzh+d6Q52A6z+ebAC5RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kMUixTdAxpJrYNI6Muja9TzM81haC79Kl7yVMubwnYLMzNMmFctVxJjIdLlYFE9nA/zMJTiX/kZquiDcDNOEpG7Lgx9zFKNX4FZ5lFz74Z/yDKaIHC8GHYCmvYtPaOgQets5CSCjZAxnzXL4qxTsAwj9oBBmZRqWw1AJ0COgl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSfBD0UC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSfBD0UC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f5943ca81aso8294652eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119211; x=1779724011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=jSfBD0UCxTvVy838eBJRpMz5JBxwPTh3WYMOi80oLfrSm3UaMDk+xc9seB7HqCRtHE
         O59gIBADssMAUZSkGpQ31GUHAG+HKocKRK79B9pJtt8rdzdRCCHdUBF3Z9paONclV0Yn
         DK11Z4pNUJnBIp28AJN3hTKR3qcb0FL0Ae372ac9OOuC0RAFlsous7eTjYTlhXYPxGXV
         IGMNd96f6AqRyFSAmRxLYy6YM6iAS0kAdpUpdImEG7r70JaUTMRYkCQhtW3wzsPYnbFM
         /VUfjKrw8f3wZDJYWenX35gicOUjwZLKPnaq0p+/dUI8J3lf3VMYZ8oYfklBONuTQgNp
         wGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119211; x=1779724011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=eaE70zKdD+0Hd+09+8gFIAdpchTN5OUmHiP4pKMTOYNLEIUChdNLoGs2LFcE7YtN46
         kLGIaShh89iXLRkRTtiaasmXtyVKpjfm0Zu71+recNsBHN3LJ1ksI72dIq+sfJeTPP76
         Odbnjrz2XHfZhLmOJDbYmvGyHVG64Uxw995FRY/88fvpzWkwPNFEaHC8lSqsykePkXuv
         UT5Ta3iUxH1mtAtvLzSgKR0SaQsraIA7nL5R5+BaHH/kBoVAP6wMFT3AirheW6t5ywYR
         o8EzXcwkmVy6UOO7Ou5M/iRRJ5TO2RxFdOCeIu3PxyDeZhbU05upCmvBQCvJTXDTK7v2
         GcTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DUURk60a6ksbgwEYD0FSnhJr3SMrgBDgdCDQy2S76omUY7SOkxoIJMQB+sqsnmrczkCBrpK0XrckL59cGJfYS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rTW+BRjnKHLF28ExJ1l2bMRNHVOrYzF5Amis1/Zn/DmI1sam
	9utTInFW/qIYX1PnE0XapJTzwD78WbOcHDRUU5sGJngZ/D9itqI0gAtSVVY100aeRNP0oOPwizl
	dGeE1xOldfQ==
X-Received: from dybsr9.prod.google.com ([2002:a05:7301:7189:b0:2f9:af7:504f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6006:b0:2ed:7e1:975
 with SMTP id 5a478bee46e88-3039812a638mr7231205eec.1.1779119211152; Mon, 18
 May 2026 08:46:51 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:27 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-4-irogers@google.com>
Subject: [PATCH v7 03/14] perf build: Decouple pmu-events from prepare
 umbrella target
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently, the $(LIBPMU_EVENTS_IN) sub-make depends on the massive
"prepare" umbrella target. Because "prepare" depends on external
libraries (libapi, libperf, etc.) as well as dozens of generated
headers, make completely serializes the launch of the pmu-events
sub-make behind some of those unrelated prerequisites.

Since pmu-events is a large compilation unit, unblock its startup by
binding it directly to only $(LIBPERF) instead of prepare. This allows
background python generation scripts to overlap simultaneously with
the rest of the build.

Testing a parallel build (make -j28 clean all) shows improvements:
  Before:
    real    0m27.642s
    user    2m32.356s
    sys     0m26.683s

  After:
    real    0m22.254s
    user    2m32.810s
    sys     0m24.646s

This reclaims over 5 full seconds of build latency (~19.5% overall
reduction) by elevating average CPU concurrency from ~5.5 active cores
up to ~8 active cores.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c81797ceec42..c66af4c825fd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -550,7 +550,7 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(LIBPMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
-- 
2.54.0.563.g4f69b47b94-goog

