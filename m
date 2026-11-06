Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939429;
	b=0VAWqCiKntw69y2Z2I1jmKobx1HbLMeEd2lXUUbQ8M2cmXibeQ93GOKRzpuCMeGTOm6/
	 mNKpdNDTJ0aYI5Ju3ERCVKyy7JHlHzLRrvw6JiPLjZAwOfQMQVA4T07Nli75CZk88GHmL
	 Jk3R9FaLyWC8ykLUI+fBHgWx14gcelSngef+VSMpkAJwdCwjSXkgIn56zO6ZFYer7L4I0
	 DThTBeG+6e0HuTXe/Zz11lgt9DP1BwSSTe88JaYGw/rps46o/eG38C0+F7wDelP2oaghw
	 2FgEOwgED3Q+KnAZLmYCGF7Hc8LU6DeK86u0DFUCJVDUHEUGtZfDPh9kmROEZW1nWUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7G6ubWNxEJnm/5usRwRUK4RV0GJVedj8s47HCFOXdQA=;
	b=JI+o/JGK00FqfISqGve0kYJpVk778Vn1BMF9tNQo2z8NITCI7IRU+3VOvD+Wqk3DDxva
	 4rVoCziwxNcag748fPYq1IH2spd8AUSH38obraXf9uN9utgnszmrBzoro5hl6DFOw8K46
	 eQ03aEgJ2VbIxiJlmcc0AMrrqgK1mc+uoPilZ5U7wMw2Gn1sB58fOXsCrE9/HOhWSqWPe
	 C4jqp3OjsusFZF3djgabL1gtr9N50LMyqXTKxMdJos2kfHTfxCuJQu9o0HGDuWx/pwNku
	 1tcVhOxEzrg2gP46Fa+QmDQIMgvgoxQI8I01wmMtNJGTuP7X+VyI5wzR0X3D7tRBWew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LxBReIVM;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F49606A332
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F49606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LxBReIVM
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67bfdab8f20so116977d50.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939428; x=1794544228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7G6ubWNxEJnm/5usRwRUK4RV0GJVedj8s47HCFOXdQA=;
        b=LxBReIVMNpmlU/klkL+H0PKfZ/be2sJv4OxjMB6EfEEZjCNETRMsb28aLoX1Ve4FIQ
         DgYlQStQ0k6zWe/2wWO4rpWIq85UcsMJ+Smo2KG41zbeN3pewgdqs4dOXBKkjAVwuTlx
         cxrBUZDXT5EA3FnOi8SmU6vLED1numPmREWy5Hwr0l8rfegQWdkrZ7fHWf0c5VEPucT5
         s/yWWUdMKGkPlvFx66eKxnZIXcaUTKIgYlipbKlrOmhWRbvxWlcODf7nG/MHBPYgfC9T
         s4rq5SHvp5YonkkUh3N2sFOcj8QklxYIlJnLhMQj/0eAmkqZRo4TOaB1iyK6b3kStICn
         8B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939428; x=1794544228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7G6ubWNxEJnm/5usRwRUK4RV0GJVedj8s47HCFOXdQA=;
        b=dCpeFCb9x9w42nhHjfE68avrugDzwGshMxZwYVVPF59PHHf+Pm+ECCAM/CRkC2xdIx
         wJK/pIYeLeFolOhK/et+zqwCNEYNmNl/EE8yTCP9ANLTrgYFUnjsvS0Y1GITvgmEdVUN
         8MTK/9L6Hm4099i53VEQwNT5xbqLYC5sFk12x0Tz458i/7LQcCeM9RN/+gMmjIwQeZ+W
         dvpkQAZfiqKxO2/U60cwRUPPJHQ848cxD/89rz6D7Tqu53ZHQ1Z6nMorAfrWgT8IiaTI
         pMbZpSCTW9KWMOBFQUVNra+iJXnC3CruXSkIng+M6n7xPMsSIVtEMWRuf91f5druT4rG
         vXBg==
X-Forwarded-Encrypted: i=1; AL+hErFSKKlA+3RDHwTJQhQlwirs1IhN5nx58rjYoBfr53ziUMYDgoObiq/+m29yb4hrUKNkrNPq1XJQR7FHjCT0ibio@vger.kernel.org
X-Gm-Message-State: APuU4Z9bARwhh5Badt+KUypo9Fl46+7wRBo0vbN0bAq3RBpVt+4xIZTp
	0v/wsL3Ysx6V2EG6gspa4BygqbajCpjpv4+pEVIdeMGh8AhFKs8Pk506
X-Gm-Gg: AYBFou3CgtEXUk8EDMoXIIG+RWG5olVyNMGtF4YI0aBOcgyw99yt271ToY/RKhv8JG0
	NSneSxhCKTfBh5wqdgB5dI14ZV1ruFSCYO0BztBNtkBENc7oChGrZdq3hUwq6NoA0PoJuyF4mA9
	3TMbJYS7S53o1Lz/KPZ3HmIJeNl5DCCgSMRloOq5GCAQ2yLyBd+RnXtl2x/Aljg33eMK4AWsBZl
	4lCRhlFRfJ8jYLWZmDeDf58fY4oog2Se0F8n9Cetx9UV5GuVSWT6E1vM8zyN3VHjGG1E62fndq8
	c6pYRroyYsjVbpaK5vXN6iCQHJFpHtsefkyHN4uatpv7DqhDUC2rmDbCNthxaszJEKDEgJqItAt
	jRM7PnmtD0FBcQyflkCpSN/HLuNSm6viLtkdQ5fZcetT7/EZohhznpXMN7kZqIdGnJ3/cSPegQQ
	k459nnr/ok7radCAxQXDIUfG3U/bNHEKQVMXbFOhdRiedJoYHJrxCUXz1J+RMO/lYNhCJiyRZBN
	3/foNB9fktoNyQL1XqIsQsV02zNSUWww2k3SqNP/t9D4JIP2Gsd471JZzL2xSACE5TA8Q2m5TQg
	t+TzvJMyLYcr87Iwk8zPbs+zsQrl5fAY7zcRSBsIe1FChCDIq6xe2h43mKm3LlD+/bSBUtZSkyo
	tLpFeCQiF8A==
X-Received: by 2002:a53:d9ca:0:b0:679:f885:cc16 with SMTP id 956f58d0204a3-67c14442d1emr555370d50.83.1793939427978;
        Thu, 05 Nov 2026 20:30:27 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c135de73csm1164634d50.18.2026.11.05.20.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:27 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:21 -0500
Subject: [PATCH v7 02/14] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
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
Message-Id: <20261105-alpha-profileme-v7-2-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=55HbKGU8JmFCdaXO+TdbP25wCaTvQMNhrLfu9ImNY30=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht+JfOuxdt/+L2WP56SUS2kkXjR7yvL9xPXbNutPN
 TUtb3pzuuMjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCusZNjZJj6+V2twO
 yji+6ZPzkWfCYpT9LRM8NpxcvrIS2B1ikZTVMYGe789OB9ZLDPJ7IqcGO4UvHZiV+fX/4cULmi7
 K1qTFXaWhYA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
logging options call takes a flag in bit 0 where 0 means "count all
processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
0.

Table E-18 of the Alpha Architecture Reference Manual gives bit 0 the
opposite sense, but the PALcode in the ES40 and ES47 firmware agrees
with the above: it sets I_CTL[SPCE], which enables counting for all
processes, unless bit 0 is set. Linux never sets the PME bit in the
PCB, so if 0 meant "selected processes only", nothing would be counted.

Add a name for that argument and pass it instead. No functional change.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/wrperfmon.h | 2 ++
 arch/alpha/kernel/perf_event.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/wrperfmon.h
index c97b82a1f7db..1fa9bc813263 100644
--- a/arch/alpha/include/asm/wrperfmon.h
+++ b/arch/alpha/include/asm/wrperfmon.h
@@ -23,6 +23,8 @@
 #define PERFMON_CMD_I_STAT 8
 #define PERFMON_CMD_PMPC 9
 
+/* PERFMON_CMD_LOGGING_OPTIONS arguments */
+#define PERFMON_CMD_LOGGING_ALL 0
 
 /* EV5/EV56/PCA56 Counters */
 #define EV5_PCTR_0 (1UL<<0)
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index f77abeeb25b8..bb0692e93748 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -734,7 +734,7 @@ static void alpha_pmu_enable(struct pmu *pmu)
 		maybe_change_configuration(cpuc);
 
 		/* Start counting the desired events. */
-		wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, EV67_PCTR_MODE_AGGREGATE);
+		wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, PERFMON_CMD_LOGGING_ALL);
 		wrperfmon(PERFMON_CMD_DESIRED_EVENTS, cpuc->config);
 		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 	}

-- 
2.55.0

