Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBE347BA9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776474; cv=none; b=m2BMfsD452hR9ypIBkvt2t4Vuz/DCJ11KIg9QyphRrGv2MwdnZo/ScvTzF3crrTl1QuepfULAFyNbX838BaBiIProvsZ/2u/GrHf2HxeczdmSaQppUqjcld3KAcNkE5aNDmrYJ52X+AVa1+UYXGZ6kK/ZGqa4EmcnqqHkFgpg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776474; c=relaxed/simple;
	bh=/7TyOYbdEe9k68HYyv7dCCFzh+d6Q52A6z+ebAC5RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LCO3LrrTWNcnsxIgI5sdwzS07kwEZCSLzRHbfbRjwIycO94GPpLdUx5rrSqyX3UXopGVukYs8of1LTZeN05VFhOfUV3qSx+7XvONdC+V9GxPTY6uFeBavDq2aDvvjDBU6/A/vR6/I+ExHEHmo1IdSQFBi3/QS3ettd7YmvYRa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4eHCZqE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4eHCZqE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso8576764eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776472; x=1779381272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=H4eHCZqEHwLg9qmfJFurOiHENcCAjLtVIrRFHLmDlGTI1QsucXVKbU0L/WUCOuwUvo
         fXtEacMPMFF4wUIHHV7jGGaMob/RT/+PpNm48qrQAK/TFzEj8SMdURy8D4CLNIKFcWk8
         k8TdN0w5Rj8vHbDIAIiCzzw2EXlbtQTdHhP/sJ7YbX/MbyIA77ji1MnChE9QykN68FFD
         psIxAcR2YqrNYK+mP3uryiW7pT+Gz72hVb71CwgTDsB/gWyYMp8ldMD4X7e95osCWIuj
         VGjkTKroayYwUeFQ2sSPYJL2sQkUNV8PepEZn51e5TazyfCjDBFXtXWqYuUt+h7aUvTr
         rqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776472; x=1779381272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=iBBWr+w/m4n59ERgnO+T+ZaoVz+Ch/vO6/23lVcfYmu4UqfUEwUqpQjsE7+AAc9DEQ
         tjyOD2Ml67lIw9GDngw/ZNgyfYdXKqZO8Jdcf1IJ8j6mC+FcLiKlwmRk1ypyHqfflEH/
         6OdC2cxLKnMeWOrmUIzpMajedItpAdX6vUQAdyrZ7r1u4V52SujgQIqCJWJdA8v52eWg
         zhzfjEukJrT191nQW1I5/mefjtDIEU2VAAZVQFcPYbti58LvEhRc4BzwLbswlbfhzh90
         znoYYXIQTDWZLYiLsKi//7+oahwdxQc+LzB8JAId7FmIqvS9LLR48M3yd7BW+B7eIFPB
         /AQA==
X-Forwarded-Encrypted: i=1; AFNElJ8b5L9tNyuLKiCa7eDKvTISSaTJShI9pXn/ugNMbljAobHOtGdVeqgeO2vnIb0ASG97u/Nfg36SNmAjSNpoCKth@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmDTXQi4kwvUqmQcsDRf8vbN4DHNunXnC/ZpDJ3NCDDecK2mC
	nwTMu7DYhXotf7jU48vpThtCrC1gPmMOpdepMTw7no6THcBiGJN1FlVSTGESCo4If86qJ+cBU73
	HLVHWyDhlaw==
X-Received: from dybgn2.prod.google.com ([2002:a05:7301:2502:b0:2f9:af7:5043])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:290f:b0:2ed:23cd:babf
 with SMTP id 5a478bee46e88-303981873d8mr110905eec.12.1778776471796; Thu, 14
 May 2026 09:34:31 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:57 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-6-irogers@google.com>
Subject: [PATCH v3 05/17] perf build: Decouple pmu-events from prepare
 umbrella target
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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

