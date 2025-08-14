Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8D2F530B
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163571; cv=none; b=DtHFbuUKvRbq/qYgrxHSIBJHa6MZzZQomfQcCml6fOApj4c7/q4jzOaTWl3Eo5X8ps/yhaNVas/pZD6Q8AhVNZse3Kddi9LpB7KACfmKUe2boa+SQ7AHGyR8cb39hBAiPQEuYBToTYbK5KmYn84PuB54ptZHmuwY/Ra6LDgvugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163571; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m92R5sQnz4nTF9RG9du83HjOnt8vzraDL9LOL1MvO21eJ0Gi5EX3v5B/8i/+ESxzllzW8D0l/BK3XzPEmb6TN3F4PJaNeOyWd/zPvtSzlBnbRwoXKPn3Y+pT9IOXN1ToHoCuPytnBnTIePZA3VgTblE/5DOHZm8aTIjKI0bNMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZx4yWid; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZx4yWid"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so4655865e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163568; x=1755768368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=vZx4yWidLDoaeNiJDRNy5ZUp/YxpLKFArIBE+g7IRIuFFt4POqkE+zq67r8HdiaQyG
         u/89EthjxuD9iIs0D4fnKivkfLSThP7BMWSJerQG8+e6eR6f/Sv9jLttTSrwpC/rd4Bv
         o2P207ammyRTSn1Q5reoMGFZuJE8VuL4W9w2cCxPKbvdayE5lbT9f/nNMoK4pB5x2J2B
         d/WXWqHMzJ1s6rByHA2GxE9lsBD085p30QFLkvv5dpSHZNh3e7KKuopT/EJcOwAhhbjE
         rdy2zR7aAsROvf46NPrgqB+rbf91qOH3V8e5CHARzhvZ9Y3/KGmWH5/2sXiBSRaNShQ2
         /bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163568; x=1755768368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=uNufW4tAFssRe7tPILieddbSyUHM9rQtOTLNdhljvZT3emPAyjOVwQOIiNecb+Yjv+
         lTsTRk456ymCG0m/EdTIfyosVsDHeT0N+945GtW7p9QnFKqt27ArgQO7CVAvtGIgHWAJ
         T774JlKhQ84oVzMbNKhreMFQouhyQUJ7WBMIywUNLWopi4upTW/jjeJ3Wwa153dF7w5w
         75w7RXOE86koA+eSN7d+Z88zX+JyG+V7aKNjtFTFV/B/gjPU92BvuPe1tWUHzY7hOWzM
         Yqo7ql7FwKKBKaerdzeYElysIOpH7UBJGqXZQtR1L3YOp74lbLpoUCHBf1jKlfbEF9Bt
         c/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiIwZpQ02cp6wK14T3rasJfzr15KSks1BNPvTSQIhcH9wLk1SpRMwJGmDmUPj2FkhKNWFCIXqMLm/enS0XF490@vger.kernel.org
X-Gm-Message-State: AOJu0YynH6DKE19e+aBvamboiE83TmpDOpMjrTLLfHVanYa3tJSmgy/w
	qmJM7zjtSzAC1p5+PBExd7QelBb2yidwMgN79WwvmOjsip8nxb5WtXnUWgtJ85YrREc=
X-Gm-Gg: ASbGncuisOEoVgicRVIpxRZyjXlujt6dBhj7LexmQtPKc3isWVjD5IzQ7prHXWLab5t
	6/gH4YUJyXBqPO6/eZ6+otAE2dtU0RmaDD8uo2pUa6LuZ7dws9ZfrvmBXd9AJckXVBeHOcA6G3S
	EkqVJVSbFsbuWxigUf1hU1UpolHfy5TQdFnQuHBsCMt2+av2bb5grPRKZakjDuZ4hqtn6iEIzYn
	MW+PXujIUTBmMGBS12RnJabxA+bjXFZFhliRBY3ocYFAQG01LqqrjWdW1FoCTB+EnjlQ7jRXimE
	clfLFZGhJi8CoPZhBHvLInz+NNgHK/91kXAM/XCq+Wa3ZC7TrrLKFgRAwrihlnbb3Yn0Zhzt6e6
	Yy7uDquESWeSVpjdNKRLYuPccdEuSDLE=
X-Google-Smtp-Source: AGHT+IEfiNAJpBqr1EBOXZKivbX12m1SjqEMe6qLmXAWuSO2UYgUUw0TISQjYJI+9nhScFZ8SMs3Cg==
X-Received: by 2002:a05:600c:1d04:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45a1b79573cmr16522705e9.6.1755163568201;
        Thu, 14 Aug 2025 02:26:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:30 +0100
Subject: [PATCH v7 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-8-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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

