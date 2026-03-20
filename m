Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5E38A70C
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005202; cv=none; b=KbfK5qqcO+J/nfemTizxcMNy3XR/zOtIrelJ6BQetTT//dRyvATxMhIX2Ju6/ox1x0U3XOFwUVmjb3KBVAANLLdk1UV6856eWBO5J8ijXDSp2sYCp0M/uGFf1kPYWvF4dJBvrZxKK+rduke3hjMbCVzyk81Kd6n5Z+C9e9FRMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005202; c=relaxed/simple;
	bh=R8aKTR0/fvv7+TrWNcd/MTVJlvaGNvgjPlXYdfiu6l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UWsfS9wKj5I9rKdxdLeOj8Su+ibGqwuS5YSJR5aqbicWfMQ7RkudXUQo9zFJW2FIOK+CvxQDV/fBy8bhtz2E+eFasoL+YiPOVYp/cWCaPkUnnwjuf+YPceHs19PHdiHhGSqJCR4MFgpx65zPlVByHcRtByejD07w1cuEamSZS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chQ2O7K9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chQ2O7K9"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486b9675d36so13805565e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774005200; x=1774610000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCFvpB1C+Z22hUF7G+KbuAK0lM0pODyKzdU2aGF6QM0=;
        b=chQ2O7K9U4qY9hdw3AUVq83U75QlLgzsJjs51+JYJ8u+YaccXvGtrtK6aZWpgY3R5C
         tsjeXrzfC6irFpy77zh6MioRDQSyxkmDgL3JooV7qlU6PNE2qdIJaS+Ef3Sw1/EzL2Sg
         GSEYdJ4X26mcmqV97FUEYqG7GezPMBQ/gcMLL4SU0GFAqD/0Tk3ehLcgrukZn8RYxqhU
         70EE2jO/ngOaAQdQ2h3mY5husibzBhvj46oPWNb5/izwdYxg92UC1pppgATvvTFDGq28
         wuI8yjHrrZOuscXftILlrfddrKnO7FB4wFcRgCGEvcoHepb82U3OtMXD288u2pIRRXIt
         zrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005200; x=1774610000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCFvpB1C+Z22hUF7G+KbuAK0lM0pODyKzdU2aGF6QM0=;
        b=FMxNwqRkhbq8k7tEeJ2UZs0zNhtPAVF93IT612o5J3QaK/0afEIQdKiMXfTzKvexNt
         aRMc1HLz4WKhDSzy0l2SrzEozDfUHBcjqBhjvebusPekqsZ6lKEXwVBkV5vFwZpRSqlB
         R1AZqZx6EsTp+0NdKkiYflIDuV8xyvtoMy7IfEt8wIV7DMSOInztDEPEpG/m48jYtFus
         kboFuMmhZ120P28o2J9bVwJG3ubWg/hJx17caLAQk/S2FpeJGCUTVvARL/Mvd8U1lrj4
         /KKEXUMKIolS4S6limksvOrj2Fz1VNEoFYDc0XOQxoEBq1jOi9cCptnqtIboYY2DHlbN
         c0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWI1fAWwji2ub6R1lv2y3QpTkySuxc4jgvqIRD8KXij36llaAOz+K3Jq1LRee5UP57EXrGj9eKypPxjG10uFwAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FVIAQXYUtGTmJEEqYMxCYqUo+jPVjRU8c0jjwKsR2MGWR+EN
	DaAf0+e4ydcir5Gasx3r7/FRZakzNUDyZutAUUZ9Up59NbgOPdfHg2V/
X-Gm-Gg: ATEYQzwXgZ5ovXB4AxnCLZJ2at6iZGRXrVDLWjzb2vo3zFA97/ly4MCnJ7HvDIMQorK
	AGj8XwuUzRdsUSNU+N/rTsMxsZVeCih0dDy1XMvAM7YbEVaoq/s/i1xwWxkp/jUvn6R5CpKhksX
	t16K1YOfze/hDuw+EbplwbkjgzCwj04s+e1JWuhpnU1LkjIUBIaA4MeTubCUHND+y6/CMF+m8a8
	+xtYj+5bCjG/SXGSjWjELgU2HldViOlHgyLt2u+yjukm9PvB7HN27y2ep0K+OHymCrJyd6guRrj
	ZkQ5Nd3IxHidrlYsJbZvsB+SutzXxvKlSmDWKrQ5Awy0AjZ55NGrsMSvGvz5PHCsrEMygzhnzXL
	43QLt9UVUmJ+UIrqpAXHN7jYKaUPaFrUdqsM1SbKkXfPBcWJm2RioehQFAlOLRyjKJd8durSGVF
	SblH6i2+3SzyZM4AhBJrxY8gwF/F3H83zM4n3iKp6X2+h7v72Gpo0W
X-Received: by 2002:a05:600c:8b6e:b0:485:3949:e5c6 with SMTP id 5b1f17b1804b1-486febb56a2mr38210925e9.3.1774005199739;
        Fri, 20 Mar 2026 04:13:19 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm5573954f8f.2.2026.03.20.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:13:19 -0700 (PDT)
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
Date: Fri, 20 Mar 2026 12:13:18 +0100
Message-ID: <20260320111318.280636-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
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

