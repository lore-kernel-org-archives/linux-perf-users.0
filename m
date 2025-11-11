Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD02358D33
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861115; cv=none; b=HOqkPOk8TL56XUi/Z4cr9GKg4CZhQQQ6JDr4crJxMQFOMfdCr/xAkJrgSwrR/7taOi//EQ4xdSUSnU0D6oJhtS4bDpgtWdtr3a5d+jVnPqVHEEkYtL2KkLEjnunBqEwVfUY1DPBL4dL2bfM+qk+xPKTolY38HVJNVqJ0b9Qze3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861115; c=relaxed/simple;
	bh=x95u+IAe5V5q3kdJyo2Q7B3yE503oFrO1P0dSeyIme8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaEp9+C62IkkUbbBKLIPp6S12fFgXPoxNJFC0wmzntDpRHHd+7SNRp3xs0VXjIKTf9d33jIASTmgg8IzKXv4/kNhTTcQyWCP+2QN7/LZ09mGczW/cg6b4RzUtME1R9q4UdsdwJWD/V2DvNTyAmw4OrOThU60qyO4H+hD4G2Vlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZkwRqYON; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkwRqYON"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47773cd29a4so16209855e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861110; x=1763465910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfuWM/BYuIKRAqpYoUgwQd7cyFQJ3HADoloFiEPlZDo=;
        b=ZkwRqYONLunVmEc9PIqNrVtCbI/1N5gLB7N9TnqRc/9xnoA31Ejn6steSAtkZfzfOm
         Y9ZH+Ca8t5IlBWW+ATJwBv+VJ5Nmgl2HmP9cDIWrIdkkOp2df/K7bMinIxZyprq26UWw
         4sGVB4y6gvLDXoFXpjHU4/MuvTZsNSCVysrYoagHQBZ1rlEIkJtNZ5qGPSfrcyNvBUp/
         7bczIxUMf+YE3SJ+MVotPoRprFI8VAU5X5cvtmMsLW0k/fz6lU7l2kMYp49JwC/w1WCX
         m6EX+/Il7RiGc6JysB7e9wrJpmnN+Rs/K2NWEf9ZYex8qOeI90C+6UPTOWiEzjgO8dz3
         Wu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861110; x=1763465910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hfuWM/BYuIKRAqpYoUgwQd7cyFQJ3HADoloFiEPlZDo=;
        b=eJl41xV3AxWkNqDco69CA57BH8dlCALYhB9x1KxZbMe0Dl32WdycIkKpzwJYumEo5+
         i1K0afKNKqIaAuMMkLfX/oyhrNk6eTEXaSvh0vhaOMC8xNcmMkMH7NvDuRWuMEeaVKPp
         z8w39WYFWTts3aWMEXcM77S/fLsrHZEE49zTvBJCZe2N5nKOyMM/RAzE52/dT9tNURoc
         09v7hRX8TXIBl9360+ugUpd1DxbUmzcxnyeJejG0RnJ9h6LHL0Eq+9+xnXqDLODQElF8
         TNTJm2NzCAQ9/P9nZFUH56yWEoIKJQJdGBkF0aHrIDk3T/GiC3aTNTJr1KMdRy95zejP
         /2ag==
X-Forwarded-Encrypted: i=1; AJvYcCVarhALbqUdC5gvFtD/aBunKnt6j9NSycBYos+aJuiffomAKSasoqQ6v2LUOVUL3JG5p5xt2aC0TpuqVjumwt5l@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRYM/xJn76O7nYE+o75thA18HZa9BVshTp2ctsY4K0bxwyhTO
	nSMvPM2+GWYMvDi4ZSramSaV0FfmJjYykEagcw2lMdVUFAc0VoIwIyQ0eZtLALNp4yQ=
X-Gm-Gg: ASbGncuC1Pp28ToTDHq+QRbT84eNTWYfpy0T+NOz794caRBANeAyswreHO+L/flYjRj
	bHcHlaLi5ZmdI0WCdsfOzwDmxAKqdyEwJCRgoCjvISc6wvkN3vT4cK7GmR/ra9kLUVktmq6fjn0
	VNQCrgxJQOwfN6KVPXvaOlp/Ij5ztuz2ipSs+LrJ6IM9C5rhqUr/PS2H+kNJNU9YLdzGU962tgk
	aDluAbTDhtf1wA9pDzYyt24PwzlzD9WxDJA07Ajvd76VoLWjzbaisljSiV44FhFGFaP3MmU7MMV
	uW2rLbYYs/qImj7GCsrPuo96uDbEsxQsRkW++gN28kqM4Bk/3xD9XX2Ygmp5fEcyIJyd/+HXqxA
	eEQI+FK/8fLYsNf1PYR+ZHnAaycOwgVqS8s3TpZ5wBZzJekVoO4h448Cjs4EMJApqtF1cpZMunY
	x3B4jrSD2ZtvPa6D6w38WerlNgxQPSxJs=
X-Google-Smtp-Source: AGHT+IGYPR7rqVbdbF+k3EWMkcQQ1XUolXYoeKsYoPvyE020LtvRy4kS5z2d7QV4g2hQ3KZfV9KU5w==
X-Received: by 2002:a05:600c:1c15:b0:477:7c44:c0c3 with SMTP id 5b1f17b1804b1-4777c44c1e2mr78464655e9.40.1762861110374;
        Tue, 11 Nov 2025 03:38:30 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:30 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Nov 2025 11:37:55 +0000
Subject: [PATCH v10 1/5] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-james-perf-feat_spe_eft-v10-1-1e1b5bf2cd05@linaro.org>
References: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
In-Reply-To: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1

