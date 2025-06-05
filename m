Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99F24BBFD
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120618; cv=none; b=WMxWUB6jrOIsZAAo8Clwca8eMnqmK4gXmZg96QecNvHwMWBhxp6XQEsTbl1agr/feTrujk4z1y7RDs1LGT3iU/ojGlYgS0M6ze9tRCttE/HFcoH+/jFlAlZyd24irulZu/Eiph3GS+gIoV20X6Ky56Lpj/2KyRp/kXS7T429ABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120618; c=relaxed/simple;
	bh=XeTbgg1YCZhnU/IzLKbCe1re6NeCWvfz3HX4Zc0ZwHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+5ql0uAm9McWzbsNB8pbxADfRnIiWSt6q5ncnTI1xoblGYqWf1nRmNvQBVx1NZrzkjtzgODbkkwF6u3s1iKZ4WQYbr/a3ef2GBE39hsAdG3qr26b3J39viNY8sTCN1YfjHSmLa/gJtdNheoKWmp9VmbIHYj5ImGsHF9X44vi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mt+YqD2W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mt+YqD2W"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so654318f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120613; x=1749725413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6klp9EUNzNQb89anQF9S8nNJOTrH6bgf7Ht0lN5b5Y=;
        b=mt+YqD2W7wG3zPxuBuxmlZBTOSl4xgWdqw5Kx/7rWDH+AnU9+HyyMPNUGpUl5ei7Gc
         cHKEGuHJAAapWEdI38+s4wcA/84ZaneXxsepP11WYgHv1VSv0BofutwSAlQfZdYvPI35
         0GSLa9FJcbOrB1y01OaPruMYSlgul5SrQSmjdcwfC5wVPrpJLm3Nu/JIbq/pzIUQa9Y/
         712djwtbUi7OcYS/+NWM9vOWTCk+pFZP3BBhP0hZrHGxurpHBLFX+JZZEXzfWw6ZfeqR
         BYWi8UT1c5aeatFPgfwtLkfTVVJQw0f/JStBeRK9xa19RavK/H0MZWsp14e03g1n5tCY
         gPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120613; x=1749725413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6klp9EUNzNQb89anQF9S8nNJOTrH6bgf7Ht0lN5b5Y=;
        b=PaaGB4vUAKtCuTuItr77DITuCZbxHKTBKeSW4cMAHp8ONiCi+cxK8T/lB0dBP7H71G
         fYoDgR79gyP03jwNQHNUHb2Kd9PRYIIX8k2Yc7hGbCmkEGAvB4YGWIIW6fjv8WPKnfWF
         TqQ252b4F9L/ONA+bytJ91C55asPRfm2943E1A4gVW1sdcyQrkSyNAq5Ij9Bnmt6yUxk
         EqhHUpd684xtJMsDbobFjcxiiNkls3uBvj5ttrCmO0mUp+Y0LpqdnTTjkndArIY4S09G
         RD/qf5pxplEobvzK9QxkqunzyKmKLQ2aI24ZX9zbFwcR12WCatsWtn9Bd1fJ7Psh21s+
         9UsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp8NIOxoEhEIxfL1LqbYf1ykoTJd93mGbOnG91jFGdECIfFg5hZZ8b7ZsziD6gGtrdDo6lNOgIKodwSK8SdvjK@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKFtqNdMM6kpx6+hyPUPNJCK1ZRahoKJa8eDxaojUA1XbSTRA
	LL0EByXxZY92QldCgAYuwV0M+NaK5g0xmDm/WDTGZdJ/nHTmQ8v1p0Mpg1p/e7yHryg=
X-Gm-Gg: ASbGnctQe5icHk+bnvA1+gA036KKAEL9ABQhrQfeJcyN9gVlONnlCgQw2iH5b/IYy/b
	ySVx2x2M3XYVPMXGCwR8CNUAm7madpHVO5gfEdDW+uzbWaA7VNsN2nG+TxDGECqJW8bvbgHY9R3
	eI5Tjnjd1m/3xUG7IAWFPdCMmiu9psiVxbYC22mLIjHk6w5qdmyYt4wvBVbpsTg1TlfMgslzzEY
	rKYoRtyesJ/nDkrOJBuOokKsPrOZhYz0TXrE5Rr8kP0Xos0u0Zu3NCsyddU/ab5mIPvfezrz6Tj
	hqy+xfq6UdZjCRkFFYgeCyjE7Q5YUKsZvBrqoWRbMTyfwPwpyWSxmD4az7qteTnIS0HnETU=
X-Google-Smtp-Source: AGHT+IH02Sm8uYqylsDIHsGX3ZEWWx30EqeNhSMG+4n8yfcZZZ5mpZsxJSCawBIvfoWGFHbxRM6qAw==
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr2309297f8f.32.1749120613386;
        Thu, 05 Jun 2025 03:50:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20629965e9.23.2025.06.05.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:50:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Jun 2025 11:49:06 +0100
Subject: [PATCH v3 08/10] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-james-perf-feat_spe_eft-v3-8-71b0c9f98093@linaro.org>
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

To pickup config4 changes.

Tested-by: Leo Yan <leo.yan@arm.com>
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

