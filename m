Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C550495CC
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973436; cv=none; b=Ja7jxRu34NnxxuFiKCd0rteOv87OQWXgXvVZVPRo1G3RnC041E+CZeOEdM888q8bADTahWeiJQyrNLTJqwyEyr8f8tX5LhmO/kKtyNHc8qkm8WX956w7BY7+K7b9fLaxD3clWO26YsJKhigxaCMCBTTdy/jAY/h2eWuPRhBeWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973436; c=relaxed/simple;
	bh=5L2DYXidB2IYVFV4DZXgB4EjS97aKYvzN/iBKkjkXTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ukk/TQMwcegF8WnwNSU1O4XPUgOwTnZjsgS9pLQf49MSc0e6NMnrB2xoNX5vIpV6iupqT7v6Xp0BrIaUZJWYkUt6ImhWVtRf9slvFKbiITMin+bwo698IEqY2IWWPeO80h21tjyh+WyJ30/P5eoacK0/PyTQcQGxmx80TVhe5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQ8rqxru; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQ8rqxru"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-620308b3684so31306607b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973434; x=1715578234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hw7gAn6Wd3oAVD+YE/WUAeQxWrrg2wv9Z+z5ZaH+aE=;
        b=BQ8rqxruBgZ0bdS52mNUzVYUbw2ZIrshYkBPxTngmK5cGe3OnM11BaL2xSGiLyggN+
         MNCe0GjD91louKyMTb/XeeYk55VKdg8YZIvzyZovMex+H27I1ZLkw0ldbrAT3r0twJIy
         aEQy85RIMmyGAYyemyeZsyl8J9TKhcXXIc6RNQwW8q2yAEIdAz7p5YMvzhQuUVC/FH4Q
         ZbF/KSx+hRLCZlV4xdCSLxqWiehX7Yx5npdOmQnB6suuVTcC7u+ru8etZFLainngPKBA
         oeUrRj54fCvMAUZLLRmIBKaBBkRGwg9T7XFzKppRp2qWZlSj72FHhxp3+hhlIOo3fv6/
         WEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973434; x=1715578234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Hw7gAn6Wd3oAVD+YE/WUAeQxWrrg2wv9Z+z5ZaH+aE=;
        b=PhKQL278myTP598hjwY88j+0JoZcpUnTIp6X5xkf+E1HRRTh9vmfDze2RZC9ZpCWxH
         Zp1LSiSDzDUrSggsK4qTf/q4y45aF7pGQaibfhFVZ2iEV5m3yLJMcjsijjCisFs9zcgn
         DkzEC62RhIBUMK3vpysGkIAaOkOwF/5sS9HQvuOYMuMi5teOnOTTIxD2CCaDiaMqKdXQ
         wgIXBve2cZvX0DknviUpsDeJi+ev0hypT3Vk9KvslV8wJhtUD6Ji7L0EtDwNaaLlBgR4
         oakJ95tMM2q4Pl3TPkyUTC5oZ3gHOso6FmqcUYDmL4kjr731mnYaQqpsO9y46l1tE3PC
         RB1g==
X-Forwarded-Encrypted: i=1; AJvYcCVG3WUy7+hS+FsiE/HDnGbiB2XIPna6xtywNOn58qOYa2om7T23+F3Mb/3Pb3ibgly8Xo0mwpfxKIr5ORRozkTRZuDbjg3n3gX/R2Z5bb4FVQ==
X-Gm-Message-State: AOJu0YyvXHrHKA+rDUnZDr/FHJuOC/0PSC1Zm+Pk6op8GPzghD3kqSQT
	5xaBkJha/7tDX44LemT3smwpxTDOP7R1psMqkZQo9rX48wsU+70VQ474iIyVYlZ/vCAMmGlr7Ef
	BDAgTUA==
X-Google-Smtp-Source: AGHT+IH2HqF82nqOEnJyPD/ejJBuLW3+c6Yp64UuhVP8g+KkSxVucC/eMfP9pgeVPKn3c99sMMJxAfjMaQrP
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:524a:0:b0:61d:4701:5e65 with SMTP id
 g71-20020a81524a000000b0061d47015e65mr2390812ywb.2.1714973434586; Sun, 05 May
 2024 22:30:34 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:29 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-5-mizhang@google.com>
Subject: [PATCH v2 04/54] x86/msr: Define PerfCntrGlobalStatusSet register
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Define PerfCntrGlobalStatusSet (MSR 0xc0000303) as it is required by
passthrough PMU to set the overflow bits of PerfCntrGlobalStatus
(MSR 0xc0000300).

When using passthrough PMU, it is necessary to restore the guest state
of the overflow bits. Since PerfCntrGlobalStatus is read-only, this is
done by writing to PerfCntrGlobalStatusSet instead.

The register is available on AMD processors where the PerfMonV2 feature
bit of CPUID leaf 0x80000022 EAX is set.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 05956bd8bacf..ed9e3e8a57d6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -675,6 +675,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

