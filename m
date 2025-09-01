Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5333473F
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730526; cv=none; b=u1xjC+YzPASVvEF2+zh8Cab7tCD4NyHjXRYFiB9nrp75eJojNUUxyMwQ8/8OuYRFw3JLMZnmEfClGF8z2YLslByEV5bCQznEhx39Sl0NY3h9Bl5dJIlr0j9XuDo/O3+tEhx4Bji1KRFclAP2Wih/Oz2X/HMDhfZ0CK6wsNhsPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730526; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0lPrXVj5bmo9bfTwcj4d8oFTqoPqPjvRb0nNY0VMaovs3zEHhLsb/wYyTsoJa5x/aYtntcDXSttDGl0WFYAuHsqcXn9S7uruOYsHaIvRY6sCEt6SD1sizu4tT3utWRJDV7Smak2D/rtVymtr3pteAZVbUUOGsT7NGWNgakN1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQqmXfcM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQqmXfcM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso8475935e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730523; x=1757335323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=qQqmXfcMxUNaX1Otr4NfZ1ITH3q8jsS0Z1PkbYY2wroS/Nc7HlmT67nrUX9O3uBqls
         ikmXz+QZUtibNm7YTeAu9m6qMpUcXEfN2vFCl/StynxK3nSWETLElHDHoS7gOldtkysn
         E81Ta2DoCPUfd05HC8JgJFt74/PYnHFePiE8FzWaW12g66LofHX6n01ZOqe+x7aUGXwT
         Q4LZ9L7olhyQPOnrs5lPoVA4DxuPjBP0uEOKEqWj+BV8z1JwjufJKPcE6qGMJs5dmocQ
         boRN/BJvbfIbK0NU0W5aUE9uFilbkAuCNQKly9MRJ/jIg6wxDsE9OqSEZLkRCpzJWK97
         vs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730523; x=1757335323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=NiDS+cgAdkx5DA+OMlFede+JUAThIJRcsPA3lSDH+e2K3ybsE2YoEVOyl2dFqSQoO3
         jsrAc5g5hJnfM705PK6JQZOIjuw7ihNNFIJyaOHZFWeShmPDq/nJwDXgr+DkYfzV3oHE
         5RJD2esaHJ/fjh/1+QLAOpADQlgTwX1je5qTFzHmF0lltZMIGbnJKReQYLgS4Ut0nNXt
         LonWebV0nIU4IeVh0e0R8b9PbfFLoqqdv9qA6LG6123GmKuNMc8H8sG3ZKcqwjBljozI
         3YDQQoF/zM+RUcJhQr7ClLuBSMy8m6lRYTtQdu7QMZmqmeChVGg/1XPiOOD2l/j0dJfU
         ksqA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+YfrOasIUMfvyAtvMIvVE2MCrCUWkBVwp/fUX99FHkK6eC+/mwTirFJwJ4YbCWqt4CPegvN415DqreeAvmlB@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUHFJVpFXDCGbnmcrD0tLZDFqrVijxLyncIw5hd01G8bIa33I
	rrUdDLmf+egibNYQPc72vO4mawhUol5itk0nNJFSSbAz398AdVPcb3SVO+DxBXORz3M=
X-Gm-Gg: ASbGncvFIfShoO7Rxm9/asQP3em61J2VpMLPXQeF8i5FQo0PDRGal7xnMBn4Cfnb2qE
	AIu8ik5JbAm6Zg+oHURIF8X43Yrajafvml3+9j3HnSm3oYRjs6thiKv/esBqomvZvABFWb2ilWq
	xB9j+6n90x/w0kzSNxCIrR/3PcXe4e9EPrLiDYvHZmMiQHg5VoKtMBz86kRiRuO/+fGVmWYgvW6
	1v2jk/BW5aPxHLHO6DZnaBrRMATuDuFVP0qRYlDJ+1xFNZxrFwIUdsBJ/fZtduv4GcgbLvJx8CZ
	pzql+GrkuZLzbKi3ypZ4hr9jd1EWjmcv9wCwCfUwA4We9tbCNe4HwyRpRoxVdenUFKzzeZ5mVNl
	ep2RDmOaj45iO34iWLx5dbzeE6E2XD2c=
X-Google-Smtp-Source: AGHT+IEQj3GrkfSjpxyNOrXOZvvlmQ+TSw4g8/XmWwPgGUWH337/Zp0pT39A7m8T0jFPe3YqQi07Lg==
X-Received: by 2002:a05:600c:46c6:b0:45b:84b1:b409 with SMTP id 5b1f17b1804b1-45b855ad0b0mr80544675e9.30.1756730522690;
        Mon, 01 Sep 2025 05:42:02 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:42:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:39 +0100
Subject: [PATCH v8 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-10-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
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

