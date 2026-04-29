Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67434410D16
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484190; cv=none; b=HA4Ui1LcRZi007hGRLdfTzAVEYPq+ILburGGzlqAp8tUHD6srNeusnBQkWdrBIy2jhdqs1wranzsd+5cOznCDhAqAn7OmP8S8HnOiK6xGLTi3GAt2zspFHM4RqYjocSDg9j9oQsPiGTmPurByUipsxiqId1/4gaBMPQsIcQFuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484190; c=relaxed/simple;
	bh=JF9ZFidUicRlAcCbQncK8HqM7MrMRoNs5Wpf957QLtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiGVZbti9eXcCN9LqAvJ5ci0id5s9xglDw441/2Vw0FYmYj3P65/qPvdEAayiK1njej1uAtzB7vAEwIxDKMooklEWxQUPVobYt2PKplngYcoXtH+436qTKxbYRzvs7UXF+mv2IJqITD6VUZ6JpedXAmuWVKsv7cfcXslL61J+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=G3alGpCX; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="G3alGpCX"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d832f2f44cso80413eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777484188; x=1778088988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBZR1vQ+XW/8g2ZcPEJAJuQiQZIb8i4vtQDaXQ6Bcbc=;
        b=G3alGpCXTC4PYalTq+Fo21uZ32CZU6PDTXzxy+cxXIV47EQXWOYkEeYmddSgNZZssX
         vvIZ4zkZbD1UZIyO8ftgsw1TRUh5HkblRC774ldggAPRnHVRoDkOpkFEi1xkAirXApYj
         D/ywPM+ShQVrgkv6QYRFPTsImlU7NQnY4ACcyc1K/U8N+EtkQdG+BerUgaBLhFakxx7S
         VozUuSPoume7CCZf44QERNONC2Hcaw5XtDDajiXnBZTQbrgVnGvbB5CcsK7hD80n8zK2
         OgTxEjgAF4ZS3HDRkX0ohZmWkmt+KRvW1j7DKKdRKcQpco/HIwPcbIre56N+tJ41Sv7J
         VISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484188; x=1778088988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBZR1vQ+XW/8g2ZcPEJAJuQiQZIb8i4vtQDaXQ6Bcbc=;
        b=W0jQC2WuplKbLQ2gOq4Kjglc1SH0wDIrijjYnGO7+sOlCHjeiP2zKCzpENKksIvQ/Z
         kOZzv4iLyYit06DDVhsa2gRXNrJIgoyUZ6nFkyMMX6u9aT1w0TzpziT1hWUvvCFf3VDe
         5MnxWagr7uKrhHk6BXlTFloP9NMUrhimjuN9DtFKkPmH8dWbIdNCw6EzyC/Rd+srn3O4
         OPysB+sMGysoWNvunJarYmd/Ns18r6QZjojau2O6uoMefqwZTTg7SlzO8XEyGwAJmijx
         VcvcgdCtLX3vin4gtAS9ydh1Hp3P1k7aOA//CjltJfpPmegFjfL11QKsUAOfPKA1IOT2
         u0nw==
X-Gm-Message-State: AOJu0YzWojm3c5gnnP5/BykTZqcsPM0KumlQWskn4mvm+muukPvh5iq2
	kPYlVVwIY2UcDmoG/gwg1EZhhIJD1WAHLUBq6fCF/HWQkS0N1F+SGDnVQs3zx/Xq/Gs=
X-Gm-Gg: AeBDiev7/GW5vT5s+IjAOgsxBOhoyP5OT2aYvDOYLZPQdIfL/N3oZvz8ulk9oEI3wdW
	tqY1Z567/fqhWwK69/lR5WqnoBNPBOngwgyCp/OwtMEeSCSJvDpPfZbX42qprgO+e+U3ReYCTLc
	DAW4x/Pm1FgCmkJeV61YqNTWHCU/8roWiyPiquZecldfkRrIQvFC/a+IrjCFoWPhI/i4pYKdW6N
	BAHTt9QitmJiDCtgJFaLLh/jCWU7LVcMCp/USA12tqLhS13dBR7KG+LkTGBJKqW167XXKnkZecV
	kpYrWVTYAtIvxDC55KLb5jUcD3lrbtbeh/SJqCVPte5tb9KzPM+/e+ZRFUyRaThRB3Rj5uY9AAZ
	dk9kIzKRitWgRjWCTkBDg3GwWkZV8VZ9j/zCllZ2iIvYg92KpnY0OQCuyiKhiDLkbJSRbzaolvG
	pcHynk8p4+lEs+owcIZjTJMI5Mw6mxQKReGbrG
X-Received: by 2002:a05:7300:1908:b0:2e6:ff79:e344 with SMTP id 5a478bee46e88-2ed09fbb95bmr3969265eec.9.1777484188387;
        Wed, 29 Apr 2026 10:36:28 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:eadf:43ff:5bad:d931])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c09c6e3sm2899087eec.25.2026.04.29.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:36:27 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/2] perf/x86: Avoid double accounting of PMU NMI latencies
Date: Wed, 29 Apr 2026 10:36:10 -0700
Message-ID: <303ba711a576cc016d349a132548237601d8b7b8.1777483573.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777483573.git.calvin@wbinvd.org>
References: <cover.1777483573.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because NMIs always poll all handlers, calling perf_sample_event_took()
unconditionally in perf_ibs_nmi_handler() and perf_event_nmi_handler()
causes two latency numbers to be fed into the exponentially weighted
moving average for each NMI on AMD machines, one of which is much
smaller than the other:

    <...>-70985   [029] d.Z1. 13311.704313: nmi_handler: perf_event_nmi_handler() delta_ns: 6732 handled: 1
    <...>-70985   [029] d.Z1. 13311.704317: nmi_handler: nmi_cpu_backtrace_handler() delta_ns: 1673 handled: 0
    <...>-70985   [029] d.Z1. 13311.704319: nmi_handler: perf_ibs_nmi_handler() delta_ns: 2064 handled: 0

This can bias the average unrealistically low, in this case because the
latency of perf_ibs_handle_irq() doing nothing is averaged with the
latency of amd_pmu_v2_handle_irq() doing real work:

    # bpftrace -e 'kprobe:perf_sample_event_took {\
    printf("%s: cpu=%02d sample_len_ns=%d\n", strftime("%S.%f", nsecs), cpu(), arg0); }'
    Attached 1 probe
    02.836860: cpu=17 sample_len_ns=7775
    02.836871: cpu=17 sample_len_ns=1492  // avg=4634
    03.042803: cpu=20 sample_len_ns=4298
    03.042810: cpu=20 sample_len_ns=1152  // avg=2725
    03.204410: cpu=27 sample_len_ns=6973
    03.204420: cpu=27 sample_len_ns=1302  // avg=4137
    03.622364: cpu=00 sample_len_ns=5270
    03.622371: cpu=00 sample_len_ns=992   // avg=3131

Avoid the problem by only accounting the latency of the handler which
actually handled the NMI.

Fixes: c2872d381f1a ("perf/x86/ibs: Add IBS interrupt to the dynamic throttle")
Reviewed-by: Andi Kleen <ak@kernel.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
Changes in v2:
* No changes except tags: added Andi's Reviewed-by.

 arch/x86/events/amd/ibs.c | 6 +++---
 arch/x86/events/core.c    | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e0bd5051db2a..b451a1b2c9ad 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1599,10 +1599,10 @@ perf_ibs_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	handled += perf_ibs_handle_irq(&perf_ibs_fetch, regs);
 	handled += perf_ibs_handle_irq(&perf_ibs_op, regs);
 
-	if (handled)
+	if (handled) {
 		inc_irq_stat(apic_perf_irqs);
-
-	perf_sample_event_took(sched_clock() - stamp);
+		perf_sample_event_took(sched_clock() - stamp);
+	}
 
 	return handled;
 }
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..d1c7612e2e5b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1814,7 +1814,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
-	perf_sample_event_took(finish_clock - start_clock);
+	if (ret)
+		perf_sample_event_took(finish_clock - start_clock);
 
 	return ret;
 }
-- 
2.47.3

