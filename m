Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC5A3DC4B8
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866750; cv=none; b=jqhSGHoMes9nR4es8H0vlZ6jHg9/fHQRdidzuqoUjk2fY9BmdDpD9szStZ6147wnAYZ5fkpdv7k5dcPHAgmAi3S5qNOg0zx1qsCVIM9retValWkdyDPq8XshfbfEi/NdHTjEYJKdg6zmfMIKWvID+JvVHcQiPTAQ5N8bQsrsb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866750; c=relaxed/simple;
	bh=/7TyOYbdEe9k68HYyv7dCCFzh+d6Q52A6z+ebAC5RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+7WH2ZN7oUnpHiejGjIqRwX8Fcng5U/f/Tf8BNbg327pHLp/yxDJMvoanXscoK6oaE28XUaKM4XvSOxRqcGFqYxhUs5WNkxyU5Cn8fN5OXOcqyapQ2kQLFj+/2gcO0PPpGCVHkiiv12VYQ/TfeqjvzBR2UhaSL0uFo3//WAPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l87vSOwC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l87vSOwC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so501483eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866748; x=1779471548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=l87vSOwChOnynPHwAZ0//AVIc+e66cee+/h72nnOxkkaw9YUEE+bDuBuUXGtvyRZQK
         amguNpHg+AjdS50rVTCl66SoO1Ho7v8Ez/WgVm8Id9ZG+da31mtecBjk96eCV2k0vVlm
         QuMWLsIED+f5ICot5ZpFjmaK7wUZ2K3zufGWpa7w22HMrY/Jed0k/4ErOBrGbfi83bYV
         XAUx0zutQ2Mln7SYSlo4GxnSZ70ptiGpXvZO0KKNqKWeKsq0gcTlbMrpQYFVeITBq/Nc
         sFDHIlOq0URaS2U3Snah/eI/KOQjp4WR4cZvGkwsGP9cps9g+vLDAp764jC1gWakSd4x
         AY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866748; x=1779471548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=Sew4K7nQnQ+lLqS5X9BFSVICUwrQSh8k5/NLJGHBAxbnpkJk/GfJu8BYUDxFCDsi6/
         n6m+2tL02zurDIUT3fkS1XRSUTH1/mFNlEI3vmTdWdPY0cWzB43MuotbRbWZYtpegWe4
         Z2f6q4YtNWCwmWOy0eqyTRgtrlgwx9u/llqS6+iXWAi6Xy1CruegJ3Vn5FDBaIBK6jCx
         Ouoxx0Be5QkmjgyTu0x8toCUny3QU1AZ9gdY9rRCs4dpA6zmWBc8Z6JNNaR73Fh8+dOe
         VpFO9GXQDt1rQnxvqsOBctoISua8/ZK+RY/PMzA7fMyj1g/6h0BIkVGOCsSt5p3Tn4bo
         R3TA==
X-Forwarded-Encrypted: i=1; AFNElJ//QYjgP5UxklC3eFp3kFRrdcpMjHydLaWbTT/m9YGLYiPfDAWjVmeGRNgbi8g4NIHsW8PBMMpl/QKmVAfF09Lv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwn/StNFemx5dn0/xpxTtlbYF+cU6mq8pY84AEUnBI0de7puFo
	gnsQG+oDeGne/v/6Fjf6oWrE6GPtmdUa5bRrj1yZn1zaCUxjIThKONqVKYq2nFLh4Oxw983rgjf
	2dRAWGt3b0A==
X-Received: from dlbvv13.prod.google.com ([2002:a05:7022:5f0d:b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b11:b0:12a:6ab7:3f73
 with SMTP id a92af1059eb24-1350463608fmr2307586c88.0.1778866747426; Fri, 15
 May 2026 10:39:07 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:40 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-4-irogers@google.com>
Subject: [PATCH v4 03/14] perf build: Decouple pmu-events from prepare
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

