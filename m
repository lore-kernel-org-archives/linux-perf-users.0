Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74E2FD7A5
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333447; cv=none; b=dY33YLYXFbuu06YCFNcPuRpfn8OEFBvRhsbJoOI5HT00F7D2EtWsmgtaKxTB0uu8m5GMjmshzIlXSkIvVeey31Uxwjcjut9dpHTUG0slp6FsiQIb60hOqPmV8WWjUsvs2g9DQuqMqzN9sh1hq82PK4+6npdIo1lngNSktQuhxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333447; c=relaxed/simple;
	bh=IJd6xGKn2wTKzeTG7OBOehcaLPe7DHLOeBtwLK/5d64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbrkWmQA5ln4f48ZBX5JkAiCD3DAoyH1Q1eDPtsE4+dgdyIC+HIf0M2PNKV1kGDSlzrJKoHSjkSvJK0enMl5EiVtpCTppf/bgYvW6FFF5EoiO8NoEQOOeJyS5MAf0z2xqs7Y5BV7/9EPRcjpuHDuToELqnzH6PY+NXLVVwINDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJ92GMLF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJ92GMLF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d19699240dso3188482f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333443; x=1757938243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkedwrzQI0rdKjNe52sGXdchQDXaBvZiPmkIP1sVIaA=;
        b=rJ92GMLFE57Dp7KrQt6tsUDYQCdfGNqB18dEodOCQzFRdRJi+uiXMAtn6Qx9VF3lr3
         y6r5T9alrQacArDlrmWRgJaQ+4IHqlpykeaW9YCVGNL91EdHiIl1iPQybMmwxOSxlBrx
         zIdG2kEM5quN/J7ju5193JOXb5/8M58bSPXqUcqO0qJI1+UZyMODtDdND/vYgvBTzrmj
         lBY+XbN5mmM8YWG26aL3/ItZmnXNwUpH7XL/IOBYPqg2WHdfj8LsVwKg/raHfpg5t9pN
         cqJgq3XzWTYoZV2AXOjw4NWk1YR30NJk7MCe6r7lBt5nF0RKwLiNvWsdiexgInIb2dQj
         SyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333443; x=1757938243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkedwrzQI0rdKjNe52sGXdchQDXaBvZiPmkIP1sVIaA=;
        b=GBL0to+SM/s1CRMCqQ1wjdKJqORAX8Go3dt+WV32Y8MZQoh0yNGFksYbCXaeXxzCQk
         /K9Qt8l3FLJodKCEgD01iGdOSK4Wb8AA5UptUTwvRfQEcKBXm3MS/+Q/rYPNtDGH/XOM
         CSowkMxsN/sF/WtWBjTBcFP2/QXO4nCtWm8pJ6s2cq6YIRnWSiVXbx/4Owk1gxXit8LV
         QF0iCYD81CbG8f5iJSVdMweTfM7REimesPke18C7vI+NaPSorOqCXVsODTAaZEp6SH69
         ojX1QDmFRtYCh6G/kp065yeLMOsJ8dW5cC/29w+58/QGjl/z23/T9Bf8O68Z7IALLn6f
         pHKw==
X-Forwarded-Encrypted: i=1; AJvYcCVcqM/Xk/pAZB9Yjx9k0gF9Ry3ku6KRwedO8Q9Dp+1zeUGW6Ihu8ofQJJpRUIRFlw6J7wkVKS0R570QSkW8zdt8@vger.kernel.org
X-Gm-Message-State: AOJu0YzzG3bs3zZ3fB/jlTrdbpMsnaVQW7Si2v1Ppi6/nqWGTyhHiNVK
	qz9xjKG9AfliZo8erJZgCfnc3GiC0+eRI9M3JP5gjlEXuosfCBC5KvkcT/rS6xiUjdo=
X-Gm-Gg: ASbGncueT2HhBr3Xm6fnFJ5WOheNB7lR6cuYUZqGO31iePo4S+i7zPI8/j16EF1AXBa
	2whuHNznK1MCQSV2myhNEeCEzgXrCQrNT1n2kfiywgfZN7cEjRvTLeXRh5fWM1tuWOAsWhh60VC
	83gkEGxHO00oKlb1O2TB619Q/4KDVv0/VxFfV9Gb9aG/5pea9absZa8vteZIa7xA5fcOuTGNSD0
	XMmXZaxQYlFLzm/3shLn+0JQ0OPkZY4mC2ybbygJ9qAtErCua08z7/AOhv5F1E3S9bl9CZfOb/E
	2fuL4BnHFbj1kCyr98GtAkrTrskcX//9v0YpBhDhJ/3vqWjujbUnVfvPuq0efdAnY6Y/LKuTWZw
	MDahGBlKACgmiRfWkdlel1jzLPo/SKCSlU58IPvdwiw==
X-Google-Smtp-Source: AGHT+IGak0uuuS5pIGUifYYsbhCa22YIqe9IhScFSAOd21dRmiIc9QfW//Nsn1rfDOPnEaB1ex4tYg==
X-Received: by 2002:a05:6000:2385:b0:3e1:a74f:f847 with SMTP id ffacd0b85a97d-3e627a7c83cmr6685253f8f.6.1757333443258;
        Mon, 08 Sep 2025 05:10:43 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:20 +0100
Subject: [PATCH 3/4] perf arm-spe: Display --itrace period warnings for all
 sample types
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-3-7ccd805af461@linaro.org>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Currently we only display the warning when the instructions group is
requested. Instructions are on by default, and the period applies to all
sample types anyway so always check the options and show the warning.

Reword the messages to be more explicit about which flags the warnings
apply to.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 4c81518a033a..228ed52e653d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1742,14 +1742,6 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	}
 
 	if (spe->synth_opts.instructions) {
-		if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
-			pr_warning("Only instruction-based sampling period is currently supported by Arm SPE.\n");
-			goto synth_instructions_out;
-		}
-		if (spe->synth_opts.period > 1)
-			pr_warning("Arm SPE has a hardware-based sample period.\n"
-				   "Additional instruction events will be discarded by --itrace\n");
-
 		spe->sample_instructions = true;
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 
@@ -1759,7 +1751,6 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->instructions_id = id;
 		arm_spe_set_event_name(evlist, id, "instructions");
 	}
-synth_instructions_out:
 
 	return 0;
 }
@@ -1877,6 +1868,15 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		spe->synth_opts.period = 1;
 	}
 
+	if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
+		ui__error("You must only use i (instructions) --itrace period with Arm SPE. e.g --itrace=i1i\n");
+		err = -EINVAL;
+		goto err_free_queues;
+	}
+	if (spe->synth_opts.period > 1)
+		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
+			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
+
 	err = arm_spe_synth_events(spe, session);
 	if (err)
 		goto err_free_queues;

-- 
2.34.1

