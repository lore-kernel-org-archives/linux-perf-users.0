Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754A39657D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164785; cv=none; b=SqEKjkcQCSl56gikOqEdFrywy9W9nOy459qeiuZwdOVdIaeaPsvWl067qtA5nSbEwcvOcGbKvdLaqzupqO6nUml3xiPF1TA7h/byCqlLEeNc7n479RqbrjybfjA3YyD/fN5JdN6ieOdDtvEEb1rqVHHhU/OG0pYTxz6w6XkU5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164785; c=relaxed/simple;
	bh=c7qPGq5j/uORdeirWTlNi4LwnrslrbyzEVlVFo++RKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lazgad00553WQDaOADj394j4+/xRgv97+BMyUi1XLSPMPfCgEV39eN1usWy2tQWwUxRpRCRZcBU7xkebCIYJgOkKakG2h+qodqMRTz8Z8yssQv4a9wWz8incS3Rr7A0P1L3j4VHZmQdQb+zTt/hFS2IYUrJ7P/Qv1mb5XK0F1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvaxyHrH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvaxyHrH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso50913545e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164782; x=1776769582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0m6CTk6wTQa2I/4VyueCvjJEv4p9jFA0baTHakVwpc=;
        b=uvaxyHrHThMZoYmckEq57fT+VznSvXbnT5U/N6N2NObcn+pp7dZYnZC+DBC/HxpX/c
         Pbc7SJJv65kkGrk2cIH12Akue4pcOCNlazYP2q+6QbQmKc9/qCdY3/iwegpx1FVJqPmg
         9JPbJLLEIVtumi2gUUvsPiEDgZsC381Ak6/JnFMaIkNJjAOoWbYv+WOynvQrW6qyel1j
         cYwzU6mYu1dv8DchOxSkPByyCuwDPCwhrYjiiUhQgi2e7dGysEFrFaq4Fo/iZWHjsgVV
         grOlpc9009WPeUxQvd2xpVOAMyM8uoGbLrQa4dasLCwL3+gX3F4EgtNFyyPdV5cejzgG
         9m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164782; x=1776769582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0m6CTk6wTQa2I/4VyueCvjJEv4p9jFA0baTHakVwpc=;
        b=dK0PpCLGjno6Fi6LODkfoN3t3G/Ozp+RmchM2qtkzi9dNCsJ/6Q4+wdihOxjugEP/T
         Nd9pHbtbL7rYEzD8DA7Ty+6jy6r6Y0naW5c35DJmQSgvf8Fpc6pdCu1zlwSsFqvltmhT
         FKmC78RgLDeqECgJUPDzVQe0NSHkGJWQd5Z4ztBrjOq1/dIvKKyIm/nE4nCSdOnwWumX
         yXQyb6WMjmQaEiuD7p3yyE9TIkeGbbnMqyCZyxW2NH5MJveHZCV6yTb7tNBJ4cYdHzAw
         +Gyq3l1NrxIZbcd44+4iyxea8/vqSt3XQ78Qh6ZBZfkKm7Gkd/PNQzWNAz7bMCfvUlGN
         4adg==
X-Forwarded-Encrypted: i=1; AFNElJ/SD+lCbMUpVyCczQEmq7oJoK+LfKoXvzdLK/1n5I1YN7onJdKl6wfzT0QKxFYFJn/wRVpKzcwS1S9Kr3bMPd7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaYuJY8cK/aeT+ntcVt7q12nnUQWAqqUgSarOHGyKIB3LsUHA
	CdJB0EuU3WTd2KvVE2LKhRe8tY5ieR4y/SIu4Zha1pnBtSx5QdrHDMlMKRzajUCxSZs=
X-Gm-Gg: AeBDieunHbyZsGmw2pSPxBTL0AinDVvyC03N8xxtR10NEKtY5czjr05XKv2Gmmcjqc2
	0g+7OcYaR9Pg+yZfSWs49bzXtm6tLiYUsA6R1s0mkvG2DS2YZ2BrVcXBrpveuIZ9XveZhbXJC/y
	guR/E4xIR+CqU4qYsvM5+aCc4l2rPuceWcFf5Sbc2WGCEL264qciEU4fRItG5XHXSuVpAoigBiu
	5cKZx9cE5jOgVckZMhcKi//dopBu+U9Cst+2ya1Og/34mtbF4M3ZS1dAwsP8y7FTUPzQBb1fMIz
	CqRpX7yGBNHHv59vwIGmd8Vi/0rDZZBKRvBs7WlZwjnemIGMhGwsnUetofJwVMs/x60OxNaxnHx
	MeQu51COjDUAVU5sMP4BpGVGoRz94c+3qWXX1F8/FzWe+nCcmgsjM6cV3Fp3EVqQvudjUj+iisM
	Nc48ehwdnDdEPpIa0o9GCcIIL17SUW/nxOAdQnnYZMPw==
X-Received: by 2002:a05:600c:8207:b0:488:a4d6:69ad with SMTP id 5b1f17b1804b1-488d688dd1bmr229092875e9.27.1776164782252;
        Tue, 14 Apr 2026 04:06:22 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm183254655e9.4.2026.04.14.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:06:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 12:04:48 +0100
Subject: [PATCH v3 2/6] perf arm_spe: Handle missing CPU IDs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v3-2-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
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
index 39046033e1433cff82ef0668074867aba4a462a4..f9188fdb8e786fccff94cd8a92f367d90efc5cfe 100644
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
+	pr_err("Failed to get MIDR for CPU %d\n", cpu);
+	return -EINVAL;
 }
 
 static void arm_spe__synth_ds(struct arm_spe_queue *speq,

-- 
2.34.1

