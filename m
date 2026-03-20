Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3377372692
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005787; cv=none; b=dH+tsxOMcXx0I3ZaN/PvmEEvQ5cI+IMKYzSAKxKrF972lZSfzmBZGyW/Q9MUZ7HPC11XNrH30rP62N1rXYPmcXWvPzlrtfAaTyEnXPpkIM/0O0auRJR9IN+lnT13CAkRDJ/iTURcK0QFvwHg5AKZyZVrYp6OqsSvp04m0SkPkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005787; c=relaxed/simple;
	bh=R8aKTR0/fvv7+TrWNcd/MTVJlvaGNvgjPlXYdfiu6l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqnVuzdb2EgFYSQBjVrmTsFwXYMCilWBigC0DX4OJDQKIfuRuA2fD8Z3laHuSN5EZu8WQ3MbkzBDi9tXSMQl5KbHVme6Xni8ejm+4lHk3AkCyRvArMWdpIprnVHQGP0UtMC+qY0LYMh8D9SohNKoUWaKxqGGngsAisMdbaWx0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/6moCLs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/6moCLs"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so1641111f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774005784; x=1774610584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCFvpB1C+Z22hUF7G+KbuAK0lM0pODyKzdU2aGF6QM0=;
        b=G/6moCLslSUUg1c6VUdjb3dgb0W4rAZ0ya7aPXQp8PAt03JA4TBeATU6zzlz6ijbeY
         qOQjFFCEvfVsqmwDDCmrjZmvkn7RmI6zBWytpWuG56bYp7xaiJ6CXW2P4cZV2CryOLcm
         VgcpNsILWWre6rpvY/vpGm1Y02bJywIVHwpBxP7AG4rduFy7CDGvI/NDdDyfaSbOpeGI
         N+Y7ieMNlcwekx8LtqcGIekkHtLDW4BsAWZkPul3u9dUDHRjFOMWHuu1KBIJx+ywiD6B
         RJxTo2+pIpcP0Yk4C35J/7G+vD7zpuvhm5yAP3BrCDXXpf5FWBtxQl4fqr/xYECciPS2
         AsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005784; x=1774610584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCFvpB1C+Z22hUF7G+KbuAK0lM0pODyKzdU2aGF6QM0=;
        b=SVpisCtDSCvEhDAoZaOjJvVA+lyx9aOgxl8rv+lnnY+kzCcftUjltGgo4lYKIeRoer
         FmDQLpQrVqIc1GrSOQo5IT+OkaQBQn10SArHO/ECSbiaIFlozmWfqS6HVAvCvYMspZp1
         ILeWEoB1DxHIFGRYA+lz4kkJvwjmXUb81jqpR4jvhesu3leu7Ua0r9MbK1ZiAJxY5QWC
         Q7zvZi6Upxk2adHtukuAu+s9YEt/M4BAhUlWTlTQqiC+sDm8dJaKCvg39byt4xU3ta9l
         l2nMtGF3/Ykz7EqMZJ2ybiBnASRH5V8HXRgy7/qezaTMTSmqebs1qQF844YRGYGKMyPk
         f9DA==
X-Forwarded-Encrypted: i=1; AJvYcCUt0EkBVIUb7FRs5EAGcbeYsAKy2RQWe7UUZvr/d9MpwDf0EFRhSQ2aLgyC+JnSQ7BwLtCFMpTwt49JXSIFT8Xd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SSVvZaKcQoTzyoTki/4hddIiG5YDQ9VMxjge1k4To0ZIOA8A
	EWDp0jE94aEdyk3gUcqQjaJDA8kpLwTU8zNoeLO/skaWM3dLUK4BpOMz
X-Gm-Gg: ATEYQzwx/oFTtwjoUsyl+XEyGnU5vnWUE0ahEnQo4ayps37z1m5x42Rm5Xx66dRbfj0
	yu98h4dwwIeJIfSoNdJrY62FRsGym5bytmKJ/Wc8yTIc2Nai35GKzKbu1EdRy84NqzLFc4LnZ1N
	aKZWSP1q1WMmXqU9k2U/sjZBTPBb7kI1esCq3VmqFjxcnvBEC77MV/ufXfPa8LKkyev6Vnkf0p9
	ChRqWGcA74vUf32StnUXvYf5m9Dcr09OYdctzg8RIGwoFjakEQy+ZIp5BJVmr2ICb0QZciNor14
	SEGE90nmiSlz2p5a4Qao8NelU55wRH5c5Ityskgd9TuGvMaaZPm0i1AtQMPPv/VxCTqb0WZ+I6f
	tyEnTqrX1TuU7hAiQY5XHkEi/4EsPKHO57PepnuUY2Mg6ko25aQAFdEM47VectSCIs6E+wpNlDk
	XtCJGvReTfGlMrOoAFwlJor+TGDmQBsOU2SNjuk5g1xE2+XbYEosr2
X-Received: by 2002:adf:9d86:0:b0:439:ccd7:cdcc with SMTP id ffacd0b85a97d-43b577233a0mr9466907f8f.18.1774005784101;
        Fri, 20 Mar 2026 04:23:04 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6471a297sm5567283f8f.37.2026.03.20.04.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:23:03 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	hpa@zytor.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] perf/x86/intel/p4: Fix unused variable warning in p4_pmu_init()
Date: Fri, 20 Mar 2026 12:23:02 +0100
Message-ID: <20260320112302.281549-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319152210.210854-1-aldocontelk@gmail.com>
References: <20260319152210.210854-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Build the kernel with make W=1 generates the following warning:

  arch/x86/events/intel/p4.c: In function ‘p4_pmu_init’:
  arch/x86/events/intel/p4.c:1370:27: error: variable ‘high’ set but not used [-Werror=unused-but-set-variable]
   1370 |         unsigned int low, high;
        |                           ^~~~

This happens because, although both variables are declared and
initialized by rdmsr, only `low` is used in the subsequent if statement.

This patch uses the rdmsrq() macro instead of the rdmsr() macro.
The rdmsrq() macro avoids the use of high and low variables
because it reads the msr value in a single u64 variable.
Also, replace (1 << 7) with the proper macro.

Running `make W=1` again resolves the error.
I was unable to test the patch because
i do not have the hardware.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v2: 
 - Use of rdmsrq() instead of rdmsr() to read the full 64-bit MSR
   in one single read avoiding the use of high and low.
 - Replace (1 << 7) with the MSR_IA32_MISC_ENABLE_EMON
 - Remove pr_cont() with MSR printout added in the previous patch

v1: https://lore.kernel.org/all/20260319152210.210854-1-aldocontelk@gmail.com/
 arch/x86/events/intel/p4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index e5fd7367e45d..02bfdb77158b 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1367,14 +1367,14 @@ static __initconst const struct x86_pmu p4_pmu = {
 
 __init int p4_pmu_init(void)
 {
-	unsigned int low, high;
+	unsigned int misc;
 	int i, reg;
 
 	/* If we get stripped -- indexing fails */
 	BUILD_BUG_ON(ARCH_P4_MAX_CCCR > INTEL_PMC_MAX_GENERIC);
 
-	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
-	if (!(low & (1 << 7))) {
+	rdmsrq(MSR_IA32_MISC_ENABLE, misc);
+	if (!(misc & MSR_IA32_MISC_ENABLE_EMON)) {
 		pr_cont("unsupported Netburst CPU model %d ",
 			boot_cpu_data.x86_model);
 		return -ENODEV;
-- 
2.53.0

