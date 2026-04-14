Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F663E63B8
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170899; cv=none; b=gSc38Mo07wfba3FJp0e5PLFvl7rlsrRmMoMtFOC09K4rLxkCi2JqlzpgXPmf34Ow3mW2B5HTvxUe22AB+wfcfM4WHauSr6nPIfM/LrayYWpkcWo77/b0VOmi8WCwUEYmkCCs0qlICwVF3lPc9qxqckZnavROWVx0AyJpNBApf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170899; c=relaxed/simple;
	bh=farxSNQwiB9LUcKDN/v7yz6rJcSDtgflT0mq1LBa0SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQ6s6bODqwEnGy8OMPDYiGfhh/2XO20L6X524C9925twPJheTdvPN5+P0MyiD/VI/4pP+WAdpdCR5nqStrCGIeTtBVqHLVD17dZ5Bhnpjd6T/v1181/FcPWrDV8t5a2KhIZpjtmGjBWmQVafjce7IDOfcIfVYDzBEnB5S+rMyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EczixZ0p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EczixZ0p"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a041eae5so41065665e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170895; x=1776775695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg1AN3CPIjuOdDVSv7pgWZI8ZtX7HtgIH7qnU4E7Mis=;
        b=EczixZ0plC/oJZFRFPQkojxb9JE9bPG19rzTchMjVVXkOG6ucT0XgvGRnKoAAYxvi/
         QeBq+TNm8o8zQRsX8y7vUbv84Xw77sYyiiLyrNfoU/9wHFlQrOCLjfW9zEjokmXafjXT
         3VT2Bx1sOE6yovDfhXD+T54rVEXZ90jYSBNgiKOkIsn2+DnpO2Hisld13GwKi80v+aSS
         AP76zE1zIqYWW7yxVe7soZ9d/7HeL6L09EEbUUTTj1O1pXUoc2RiQZcFyzSH1pq1Jsrn
         U/5mjfO1s0ZoyJ7o2sI8QuKK06gjys5rCszUI7Ia9qEdhct9bAZ0T/hTRBJ5S3JmL/+6
         3jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170895; x=1776775695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eg1AN3CPIjuOdDVSv7pgWZI8ZtX7HtgIH7qnU4E7Mis=;
        b=fij3yQCTvVZjwWjy0JZEYJV06rVWwMEnf3yuHGb3F0wI7h4UhUx9JTv0Lo63gHfDf1
         dEnF3La10TD5gVLUmX63U80z+RyKlBffRetI1lNkc561cWySEgL3rKu7rQI/j20hJX5I
         BU9cUcOckaemGp2tSRk4P73BedSqLLqAAi5lJKFlZ+mVzW1WJOdmZ+6D2ryc1faJO7i+
         qqH6+6T/s5zB/GpI1Qye3+FkOZrCWgrCVdVM+WKMSqm2V6uxxTeH/xNcTmkoK8tWsKb/
         AG3G2VLV0rZlkTN1nDSX9V9HJbhVXujUddLEoMk1qFuHvGFd3QLM8xASG4E4CUMeYLGM
         kYgw==
X-Forwarded-Encrypted: i=1; AFNElJ/whWge5HW8Ng6YyICmaRHnaHu5eR9F/zoogDPMB1xDnIa7nLNsxtADpYU7w38j+FkuVT/NqjtZ++Bdj/Ugq8nQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcziwXqFgmMGs3oQE6mf2MYon1ciXrowzxiTSvw+0cl/PvoMYI
	8vVjeM2VFXg5YQQ6ZdfnxOiPtBUyxQRzADKjyOcay32FGJiHMOZDtsHU0bKuLbPlh2c=
X-Gm-Gg: AeBDievuLPd+8HQRsNiNmJy0LxkGMvJW+hRtcHDKIUj6jne0tM2a/pNJrsEPZyk4vxP
	HQaNYaumWQ5+UuVwxlGt+K7aYNWgib8wWYI+FL2A4qzf/MlKA4FTWRXuhKY6ghYPDMHwoOkfGIF
	HFGSz1WxpJzk1xYfayXKD3WSE02/dJqmGm7f3Otbhqm07vf7FUZ9ElJ9KuJsUD1pHgaGMkBfQxk
	UTgEiFC/8korXZ+3da6qiCm7MpS3CoKLPqPqx51UqrBtRZTLnfu4eZOlpNGxDZdTZ/s5iWb4O4a
	fFQjtOOIA/BN+iD4Bnpkr5LsxOVpg2qrZmoLSvQgUWksgRC0kvlSwMTVabXbSos8zfUi6lH1kpu
	LxpPncnSranCSJlRv/I45h66uXCzgXaVe3NPh/56zn0kuLW2KbjaHKmxszEt5UGoVENFBJicBY2
	4/zqGI5+OHrbjr/wEwVDH1+t3tsQTK2zKc9RfOlp11iAXh3BQSwqHJ
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488d67ce664mr229692535e9.7.1776170895003;
        Tue, 14 Apr 2026 05:48:15 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 13:48:00 +0100
Subject: [PATCH v4 2/6] perf arm_spe: Handle missing CPU IDs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v4-2-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

Don't call strtol() with a null pointer to avoid undefined behavior.

I'm not sure of the exact scenario for missing CPU IDs but I don't think
it happens in practice. SPE decoding can continue without them with
reduced functionality, but print an error message anyway.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 39046033e1433cff82ef0668074867aba4a462a4..037c7aa150c1efeda6e8e956a5b1db733e6ea74a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -982,16 +982,23 @@ static int arm_spe__get_midr(struct arm_spe *spe, int cpu, u64 *midr)
 
 		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
 		cpuid = perf_env__cpuid(perf_session__env(spe->session));
+		if (!cpuid)
+			goto err;
+
 		*midr = strtol(cpuid, NULL, 16);
 		return 0;
 	}
 
 	metadata = arm_spe__get_metadata_by_cpu(spe, cpu);
 	if (!metadata)
-		return -EINVAL;
+		goto err;
 
 	*midr = metadata[ARM_SPE_CPU_MIDR];
 	return 0;
+
+err:
+	pr_warning_once("Failed to get MIDR for CPU %d\n", cpu);
+	return -EINVAL;
 }
 
 static void arm_spe__synth_ds(struct arm_spe_queue *speq,

-- 
2.34.1

