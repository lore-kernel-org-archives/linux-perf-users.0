Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527458;
	b=shptonDt6pc5h2kVAaM+Yx5EbP2VUh6Ft5qTA/ges8TS7J32cPvq1JG8XCjflRSLGjri
	 0pVyxcmlR3aXeK5raS6oT+Lr5RxcO8CK74BWd4XuMBEuNlLsD0zQtgPC/MCp/9o8Q3n7U
	 fR0XkcOfLlAHfsWLW3AfUjaeLFYDIlY5bG/F+VjJ8G4jg5Mjnt0LRIY4y5RvkD/+t1UjQ
	 OOMlh9fg8KyVqi95nQ/pNUkITB8+PV662IUfa08IiOQQqzGR8D44cJh3Nfn1rLd3i8vBv
	 oP6HYQHXCUDBQKKd33HsTS8FXGy4BOMnHztiezXh9Ogjh0QfVqyRv9j2ojXQpvYSfrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LvepHSVm0SGzHPl7b9HwW8l9L6MPRh+0kyrUQ1IwKVw=;
	b=fbBr5g7ObTVgbACVtjY++izaxVRrXHrKSq//WbyzowzK306n0hwsMB098nDAeGzJN9Gg
	 Uyb2cKRUeuzd2jENUc48vu9dV5VRWKcrVgXusq2UmZtPwOiKtvGNC0MeGDc9t2fFDbcxT
	 /Fe84WYAinI14qRzO6lW8SEPorkbnMO7ZY84YsdyF385njwf2N2C5SlMfJ0w/KMY76zTa
	 RgCDz8YjqXf2VTSqwNrHMgtzEPr+1b3xGKgKoBQuAI084iie2qU4ozzpL7AMpZ7giwpaj
	 uJG19a53LHjTdpz+vbj5dz+g2K+xhBVWJPebY58LCV5LssiB4wzXeTsGu+m6j9MX8RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc3JcbXr;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939A606A893
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8939A606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc3JcbXr
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37071c0f42aso612658eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794527457; x=1795132257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvepHSVm0SGzHPl7b9HwW8l9L6MPRh+0kyrUQ1IwKVw=;
        b=bc3JcbXrCtsd/CYNg3OyEyTObw7+Lw4KvXjAmBkqZqZKWXOLlqjwK2cN69iqji+YBX
         LPAiMcMc7sdpprYXx3nk01ukkrxV6s4HBa8O8BSKFgUdT3UDL6DKvDR15GYTlWwuCeTu
         QwBBS/lrzGZicmkUOi983llt6L0LeJQsx5cuApqFTnrdRfZEtLLeCCoBnIn7hXnP2x6Q
         eeYE3kzLJWHMTMpR+RnW0asDzka2GV/tr2wQ2YS5r6yE3hsO23m2gRvUi1UgHKRnPYHe
         lblOp4YBIr0ycDNOXMRKpqCAx80ia5YbsRa3NGEidLgJvek7CQwtxI5Gif7i97fE6xyh
         bp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794527457; x=1795132257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LvepHSVm0SGzHPl7b9HwW8l9L6MPRh+0kyrUQ1IwKVw=;
        b=OoDFIdD6nu1EbrvbeHApaMIL6SEzHl2YpD7sb9MMjhyvqrHd+hOUwhok8ImKfJw+ih
         uXrg6ea3Xy76ethOa8BypsUwJ0LIhtt3Gj5hhr9PzEEW3EJydbH+OxGr/Uy0fgrcP5u6
         p41Yx+UVOrPzVpXiee2BOvev5wKNdNM5gRzAgqLcJx6I39ZauBpUeiq1wrx1tTOgPIHj
         VWlWffDc4++fcbeUSt5eOkxHQC8WZhcYOgNwt8SfZEB81i5m+p1+pf9k2JehloTv/FCN
         Xece7EkXHsBDrIDsmQae/a4L7POf8m5wNWGAw7EcQu7HAxQFDNz+DPOshZCfZpajyTjd
         Er+Q==
X-Forwarded-Encrypted: i=1; AL+hErGUU+dTRSo4AmIpPHBL3H79+SmAYlWWGkpcb/QDbgDRmI53S7Hwu6JA1ln7C27ncxp28Z6Jv4TGFZjLmd8+nkgi@vger.kernel.org
X-Gm-Message-State: APuU4Z8+qhZQVRiiAzNI4FTa8cf5PQW/LUQONVfeZ5NJj21rkRcddq2u
	TRmxlOO37cY0fi4TTgTVf4RAGVPW8iQ9coAA9B3d7l+AR7vdBV2YIP59
X-Gm-Gg: AYBFou3988+6D1V0BYlO0hWqHg3fB00gWaYou+2oN/NK6iYntApQPJNcr5m8GI+DeHU
	xRb/+Lz5kOcCby9M9PwZ5/IW0doUNGCtdANcdJz96F9iz+n5o8BF1ZOfyIPPFXyfUvYcsl40Uua
	YUcJhKMAVIy+rkkeP3xJrUNwu10TBvvPEcKYJqiEmlxh63xPspxmF74IUMbaR1OO5/XZc7PFRFj
	jVeL+nTp2bT+z0AtnASUgf9zJpi9vpNkFLtjL+0nQsCvP9FDiPgqoMHWRgimOsPJCKKALGvuOrl
	kwMqWUJNmFYlrb3K/CXuvK2KHa1e1TGDYw+xH8XeFJ0q5GCWrIEGyCB4Yu3jEDkceFc6OpIMaor
	Dmbv5EPMZpsrUC5rrcnCZFH+rgdz+ZaPauw+2y//pO6hIAmwYKckzmD6nEfF5rlTyQhW4pJcmWi
	/X4nd8J9BRwvFM5BpJ6kvQh4E25OCnhHpHObkrL1fOIYMFOQaOSF2sj4ufJwO7lG7fAyNM96ISA
	obGwSrFF7wiAt9CRrNPlrdm6h+z8p1QaBD+Xkrig1Lr2EN0K4XdKbr9lK9j9XgYhROnOP0Sex6v
	zyMqKc7KPLVrJe7i
X-Received: by 2002:a05:7301:f87:b0:36a:1e0a:accb with SMTP id 5a478bee46e88-379687a6ec3mr638180eec.35.1794527457444;
        Thu, 12 Nov 2026 15:50:57 -0800 (PST)
Received: from evangelion-g ([2a09:bac5:40e4:11cd::1c6:8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm3842976eec.8.2026.11.12.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:50:57 -0800 (PST)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH 2/2] perf/x86/amd/ibs: Fix missing CPU hotplug cleanup and unchecked init return
Date: Fri, 13 Nov 2026 05:20:03 +0530
Message-ID: <20261112235003.18608-3-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112235003.18608-1-ayush37735@gmail.com>
References: <20261112235003.18608-1-ayush37735@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of cpuhp_setup_state() and remove the hotplug state
if perf_event_ibs_init() fails. Unregister syscore operations and reset
ibs_caps on initialization failure.

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 66e67e27224f..2518cc7a24a6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -2129,6 +2129,7 @@ static int x86_pmu_amd_ibs_dying_cpu(unsigned int cpu)
 static __init int amd_ibs_init(void)
 {
 	u32 caps;
+	int ret;
 
 	caps = __get_ibs_caps();
 	if (!caps)
@@ -2156,12 +2157,27 @@ static __init int amd_ibs_init(void)
 	 * x86_pmu_amd_ibs_starting_cpu will be called from core on
 	 * all online cpus.
 	 */
-	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
-			  "perf/x86/amd/ibs:starting",
-			  x86_pmu_amd_ibs_starting_cpu,
-			  x86_pmu_amd_ibs_dying_cpu);
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
+				"perf/x86/amd/ibs:starting",
+				x86_pmu_amd_ibs_starting_cpu,
+				x86_pmu_amd_ibs_dying_cpu);
+	if (ret)
+		goto err_pm;
+
+	ret = perf_event_ibs_init();
+	if (ret) {
+		cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING);
+		goto err_pm;
+	}
 
-	return perf_event_ibs_init();
+	return 0;
+
+err_pm:
+#ifdef CONFIG_PM
+	unregister_syscore(&perf_ibs_syscore);
+#endif
+	ibs_caps = 0;
+	return ret;
 }
 
 /* Since we need the pci subsystem to init ibs we can't do this earlier: */
-- 
2.53.0

