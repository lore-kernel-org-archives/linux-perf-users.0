Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D20277032
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652241; cv=none; b=tM7HVXaowYdiMkpNecB8I/zemZIJdmfthHQVrgMf1hvQTZqVm3IZ5L1MYq+pozaW2AVIlbZ3Vshp7WcRKHAdkASuXpj1Fcw7Af9TzxXA/h4ayGsBkmJeuLQz/HWkeQfEGByOljjHqGOyfKa+vPCu2DO0AO65djkiF1QvGcrkhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652241; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7izez6rPwNBYtkSPrK5y6oF58x6W3irnfeqHd3me3AJQugoI/A/pGOQVwRckVzK7zaz7UWQnFX8D5QKXx2cieGuG/JyoSHkKJk+ICwyNzzu/1GxrxpKtc8VVH35P6KaGIylBLJWhvEkc7QupmQiFS+LDq0isoai2ywkIZPUSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBtHhOof; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBtHhOof"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b77b8750acso1269809f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652238; x=1755257038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=JBtHhOofcVjoTYV6PD3M0k9FrHm+wDXRzf2YLVUKHCz72i8QHvy3x2brGh94EoosHX
         1MAAYLVmUMm4lGJQPuB/4rE8av8lhqLr6v9F6jmUfrCSixjoQl3nHw+YuC6HCr9S52HR
         pwHWh1zXw3CV0B1t2xjyNsMzZRsROUmbta0V2tkxrOHG1P8uhJ7ux7R5jnT9gFNuiSdG
         93wIlJnYgmlcaOHSbmm+KpjJWwRNxA3+2i4PYG/vG9hyZLzAokZH9IV8IfeHWlXm7hva
         a+Ug5R/uB+GaThtRxDk12Gtjpkpg+HXWAsSqpXGOa2ptWPzSoLFSplh/6ZqoQfSf6497
         nhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652238; x=1755257038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=Do8vWOrC6NYu6OjYQ2gW595R3i9kfAuTmPyRU3TLp72ivz7iec5gib7pUEMpzbzsUB
         CGxLed1v63dH08QrmBTo8hoZEOgl/0NNsJ/kzHsRkAaRA3I78PsVYXcfqiA9gaOb1vg8
         7s6ZNnSd08BvckTTxezv4Vkwh2xE/RzxTgud/hfnwI+FWL3MV7PPx/jShnTEhVKPlg04
         UVYfH7mq/ywFweLeEn3+dC9fCWtP9KtoFrt5vWv0035AxtinM83WTaMU/YtGgKTNoVwc
         gynM/rdSXwlKnYEcgClXdl+vosrUl33dkOm953+kXEtkREagiP9dEPVW5wlSwaGoAGMR
         AWYA==
X-Forwarded-Encrypted: i=1; AJvYcCWz4kbeZ6oCVBGkmbHwZD1RB3SXbSL7D1MNPU5VhKbwGdV7u9B/P/HX1qsfMKGA9Ir/NGtm43l0oB2DP/Fz6K76@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJyP1KT7dfy9b8Mh+HjoOpEGxeWvmXF1seZ+SKnfKR0hZRYvC
	Ny0vxxDrkLKQVShGXrYmN2/hgCeKRLVhWxsr6Osa6hsafGwqo9ye6XL2uI+Z2DgbwrI=
X-Gm-Gg: ASbGncvk6wKDPmHLFiUElvoCVzNUKkTMY3eRsW1y2gzlLYe3FVhJlPTwCHeYQHo/wkh
	jweumb/WtiqUnj9DQsI1OxM1an8VKDU9nXRr7B63jyfxnXb4shh5y8svU/7ECnEuc9bIkekrVQi
	6bWVolIQDvHVFKxyogreJZTGfHLhqyvAw2UXihCZAUVIDGZnBUGtKCHZbC4nL7HKw5hNZE8dE5z
	kRuM5kh9qGkd6sYsHgToMDu5IXG/QAO7G5y9QMp4IsZVtzUCqoNql/vTFs/w8kQffFLBuIhaUBr
	m4p64d5rqVOs+GlrjhxAjUA5EDAkZZjd0CW8H9FNDJh4wX8kN+zKB67Z5+oANQVvP3UCWWwJoog
	qFiRuhxEUlsj/URovvOJTB9l01VnV5qE=
X-Google-Smtp-Source: AGHT+IGoaBQKmBj6KMNMQL0VdWvV/9kYUe2OiKjmu5rnVVRKChL318TYjODlxCnVcHM6lZ386h3kaQ==
X-Received: by 2002:a05:6000:4383:b0:3b6:d0d:79c1 with SMTP id ffacd0b85a97d-3b8f97c49afmr6128407f8f.10.1754652238270;
        Fri, 08 Aug 2025 04:23:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:57 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:07 +0100
Subject: [PATCH v6 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-10-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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

To pickup config4 changes.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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

