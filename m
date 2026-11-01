Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561293;
	b=jwwP+hEyKOTFP7qUGakzTMJqr5uRkZUJLEU7Bw9FINIXyj5OqdF+zdEK5+1OvTwsQFeM
	 xkMd/SzJDk+GH1+qkrtZntMmEXO1BOe+iwLk8Zjsq8ubmlfg1SDeoZqJDMZrc5Gm+cdbf
	 +14gMkKaL53O05NkRVTYW9ErbKCheAww4ZcUdYDifD2zm87rDaIanaKJAYIf0/GRPGpeQ
	 BWcmaDFiaC4RcaOzGLr6F7JqSceBWCZkOFmLq7skMV6Q5S9liDVuTzwSen/AiTztB1Uuc
	 W1VwrXvgK/NfP0szOfdwOWlBe6UbqXPKvR92LgXGzR3N8QnlAkMDyEih714ppIuWfiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vUuHLakRNbr4esv7p2rM0pJWyo4Q85EyExt4ND+SVOs=;
	b=YqncTAoG695Kn88XoopQaC8D7rhNzTJWVLJlZJDCqAs+lI7HI0qGu6uVuN4rixwYXmHJ
	 5Ww990Tfj2lTloqjzlavntMRNmeDte1IIUCqSKRAiEQVGX2NgvigL82ys16iG9dywqTeq
	 P857wz5VBKFwRApuXASppYd1QaCCtkyYxJoEOYB1gEFRITj6EXVRygu6DQW/ltqrpbjYR
	 miM48XIA93Qnfqwp/bI2AkZ/Id4JSneaWxZsOBx9TeU9apbtBFuEHcpcQRl+GHEoP7VbY
	 g1CfvBH61QWhF5C+5zS4dMec80tE/y6BAr5YYsyXLbvsRm+A7eNlZ3SdLFP/HDoD+ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHi1lMaP;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47760A2600
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E47760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHi1lMaP
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b10d24345dso19338957b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Nov 2026 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561292; x=1794166092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUuHLakRNbr4esv7p2rM0pJWyo4Q85EyExt4ND+SVOs=;
        b=PHi1lMaP6DJ14nweKwQZ98dt4zasR7P6wJF54ko8g8l3/7uVQVvN6I5eMHmut5PMyt
         ta4Dskz5PNsyOR80K76EX/8MGEftwgybPOpMSqj2tJxUwdOfvU/Gt1uisFMJn9OrJAGE
         B2M4/4Ej+3NcFO4q1Eexvbm7HFEyMQJYKs1MEA26Y0KF7a+ZzMzZxu+nhmomCxXBp4zA
         YVm/fl+mq8FxuBrf8hsB0EZXvm2Zc4NkJqm21aqMB/96nS8fwitcTrZ1IpOQ8igHCB6+
         PrxEJioUmvcfrjJOThbu/H7WdZZSADS9Pl1qc+wP/O0tnje+bz21U6XdKLHoL62FH66G
         IM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561292; x=1794166092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUuHLakRNbr4esv7p2rM0pJWyo4Q85EyExt4ND+SVOs=;
        b=LRlujzNkhjO52UbdagReIC0PBabm/6/Sq6k5x6IBDdaQFApqQNa01mWmyXlQ+r7X2r
         YnTUNqckJ3Qz7YG5tSctevQp1x7zA1L1FcnKtOVnjx9M6VM1u8eFmbbDpTuoLv+u6W91
         p4DOm5qkoJqbAJMx6j7YBPNyfHmdYcFvtAr0jd9n3QwkW0aEKbfKeRlZLBUTt7xzcA5J
         26jEj60H7JKbgwpQMGpSZqozoBFTvUSzYPzcTBquICXe+0ihDBAOwsf78GZM54Yy73HD
         bwwQfk1JL7VFo4C5hnSVDZwpp4hHX3PiaeFIp382LywMQDP6/8B+9vCLd0j6pJdc/wo6
         jBew==
X-Forwarded-Encrypted: i=1; AKwUvBxrBPGTPIJjAzrX2+jgquXDAL/aOAI+yzWrjnnspfQmIq1DT0Qc8dgk9pueKDmXgB3MEJUPmpqpx0PkzO0brm+I@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sm5BymVGItsTWu8MeunAddd0H7CLtcU6CpY0ZcpPN/AR7XEYa
	hwbS6RiBCOGm7yo41ASqVO7hauqdCpeD2X7Pa8O5KJY5WHKAsRYwgpY1
X-Gm-Gg: AYBFou3KoHDZJopoBJmdwFK3zzaQV+ABxOFNnOOe7q0jlhlDMxGOHxv0VJbdH0TvVxf
	7aRu3weoXdYtFq5GlgGopNzbUml92PDE55NTBz7i4vv4EiS/lVE76bYZ76D//jW+wh+3gesmQXI
	xLudhtZmTXOQxrvahzG1ln8SHKuFJskhNy0QrTzXaYsICnX+sw1UoT+zNp91dSbOsic1r+dvwW0
	jLYb3SBl6Gs+QMNAwY1HoLhTm4Kx5GWjnXMJjfDpK1YAW5gwe45KigLRTmCDglFlA+aD6k1xpNU
	QTsT1sJI9BICLZ3mNBuAyb+m9YlXYAQtVEbHAYqyyPgg4T41MxNAynp9E+Q5IaHgeiiz1bF/k8t
	8sN3INciacWovgMSfR8C7hRxG8IW8G1mWQFIpMPyeXw7WD9GlC/4D/Snt0G2JMeNXM+aaJUchxg
	di1CaH4xgiiydBhX/AufZL7XciHJXI2mSj58aBYFAu66LtW1ckaACKHPcodcXnkB0wEm2jygprp
	2jxBgH5w/ryfAqbEIhNe8wNt+tdYfbsX6jzBx/5NRTUU4FabK5Dm3oX4KFd9jJzFcPl9loJYejd
	7WdlyCvI9SNzMdqLgxMLyXnDuR1RYx9zHAHGbB3GTI6BkBfOl0xk4EE1u/R6lBi2HUh7PLiGG5E
	kS0N75afmC1kdyWBdr70jnEPCEb5uGUM=
X-Received: by 2002:a05:690c:30a:b0:8b1:6e61:513 with SMTP id 00721157ae682-8b2b64382d1mr80228967b3.0.1793561292194;
        Sun, 01 Nov 2026 11:28:12 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b6d3ba5bsm40482837b3.0.2026.11.01.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:28:11 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 01 Nov 2026 14:28:06 -0500
Subject: [PATCH v3 3/7] alpha/perf: clear PERF_HES_UPTODATE when an event
 starts counting
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-alpha-profileme-v3-3-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
In-Reply-To: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=bEa6cnf/NHGbPsC7PL/IhVePDwjtE880lWDMA14mV8w=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeTzpqzXxf5wfjifN3lZpDysVDXp81fLXlTXn3qW/Mu
 QJ1RfMPdnxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1s94y/OHe7lSsdj
 a1/LZQ24ddVcs/PP+xQ0tZ4YcRG0fe0sDlh8IY/qeIprfEJzSZ2fu9q597Z5uzuG7om/a8v1rFI
 rMMnvx8xwYA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
then programs and enables the counter, but nothing clears the flag until
the first alpha_pmu_start(). In that window alpha_pmu_stop() with
PERF_EF_UPDATE skips the count update, because the flag claims the count
is current. Since the next reload rewrites the counter, everything
counted since the event was added is lost.

perf_adjust_freq_unthr_events() does this on the first tick
after an event in frequency mode is scheduled in, which is the default
for perf record, and it then sees no count to adjust the period with.

Clear the flag where the event starts counting. alpha_pmu_add() cannot
do it, since the event is not programmed until the PMU is enabled, and
stopping it before then must not read the counter.

Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 70840c05d39b..ecec78c355cd 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -456,8 +456,11 @@ static void maybe_change_configuration(struct cpu_hw_events *cpuc)
 			cpuc->current_idx[j] = idx;
 		}
 
-		if (!(hwc->state & PERF_HES_STOPPED))
+		if (!(hwc->state & PERF_HES_STOPPED)) {
+			/* The counter is live, so hwc->prev_count will go stale. */
+			hwc->state &= ~PERF_HES_UPTODATE;
 			cpuc->idx_mask |= (1<<cpuc->current_idx[j]);
+		}
 	}
 	cpuc->config = cpuc->event[0]->hw.config_base;
 }

-- 
2.55.0

