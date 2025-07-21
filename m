Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC92D9EDC
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102467; cv=none; b=tIg8qG2NI/Ib+KKiJl/sPSiSOdPKTlkVrIlS2bIPOpvqnlU+g/hpXNq1j5fSIO9IQ4qi4l23RghhpFZZvDARt1ICXcwSLyQPl91sYshavupj26yORvkib7Yi0NVxG6x28Teia/AZWGDMZYXlt2Nu7ECYEGgMmbKIYV7L7yIv9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102467; c=relaxed/simple;
	bh=XeTbgg1YCZhnU/IzLKbCe1re6NeCWvfz3HX4Zc0ZwHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7uFU6B9bvlEnf/TYo07vehOC06sxhwXct5e4RrI+xX2EWkS3ZakQoOfkjJ7OhSktUgX1bIJ9RH9GicF0vZvU3wddEHDu5viHEKCfa6mjXOcTVPgRmX+Z6QODVuzYLo4BdvMi9kHK+f51AMbmQniu6clsuVWRqK+zQggUJ6A+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/B8HVdC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/B8HVdC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45619d70c72so40370165e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102463; x=1753707263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6klp9EUNzNQb89anQF9S8nNJOTrH6bgf7Ht0lN5b5Y=;
        b=m/B8HVdC0+4joTam1vDdiFjJl35FuvCQMJRcnE1feiwITw0QpGrlhCqmhpoAoXHbYS
         /9Jo9XrKnKnDYexjqZtYIFvoO6nN4ppDiVY2LLnMVIMfijK53nWG+3kR//UTHtHyNUux
         CKb1AqYuJsxjMl3jXWEbGGl9vK87Cch+nEE5x8J1odDtP0Q2UerIq6Ph6mV5Rry0LWjv
         vpadAFLi/TVN6rnVj5QgOXvyk41/Grj9WoiEiiOb+98SdmSLnHtDHVSHBtD0z3Xqw4Mu
         ovikxSrPhIfgtwaj742F33ZLWR1BTRFSn68WtWGQonL8w7lO6LG3dVfCugKIHrP3TU34
         MwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102463; x=1753707263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6klp9EUNzNQb89anQF9S8nNJOTrH6bgf7Ht0lN5b5Y=;
        b=eUxk46Fh4m1hBYZMuUmj8O9IBblAABd2e62TJk3Ek/YmzogX+jxnjOMgs2Y83OYm8R
         suOL0RsaEZxVqBjTEDIz+yMAaRdr+rS8jzkFQHwJ8sxcx1HyixHsUML756tBV5Ao+wt3
         lVco2h15/+Fjdk5mgrnH0CKyeEQzK2GRYWKHluiW4wrd/QP1DFT6ijrMHled1uQG/2tK
         6B5psLOoYchQ+YUu3b4bfkA5jdnZsTgqVa/SSda7mgL1++ObNF2hLZAns66+TT2xx8Wi
         D7XfvuoIYbGYKYqigky0PNji/0T+JW+6+/isBha3GrDA+O1n3YQToOF7yVils7V1IpJi
         VbFw==
X-Forwarded-Encrypted: i=1; AJvYcCUGN1HVkWCMQ4h6bRiK1TMicIfO9AYVYMTyrP3NSPZhC/s6aGySD3PGdsTx/nYK3H7QOiRPxIYH6bUXpzzsJ024@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmee9KsEoyuQTqptud/eoyAJz9utLUXJbWUGMyRtHmIBGhyw/
	SGc3jFO0zL5jlO1zsO84b2Pxw1tZEFWkGprnLNY6n0JwO/l90Ct29OyDVwpPcHCYJzA=
X-Gm-Gg: ASbGncvhW/dlIa5oXkZvEElCJx8ZTpeThBPDVJiIOUOMH2ngBgq5vHIQdIhH+WKA/t2
	9JD10kR2vCUSQf51a+K/SpvDm5zdM0YX0YKOebkzURl0LTnPfPdeTgxVQ43FlQWFphINnKS6nAY
	GxZS79lZwbed4izdFdCkVJO35TCBbxope1zZyLjr/edl3H/Rnjj+AKsrzWvOQBriwpHXKTOLpLN
	B4Kv+ffQWmP+C88O9e26g284cyQjNSNYrZMZ4n4LgEiGekfYsMJxOfzwspuxyV42Za9au9LNoHW
	+fy/8PzPeC8OZDzgxNMJHA3mmmCO3ZKcsjZmyD2sGYY/67kAagRqEdHGHNqkMjF+OlxozGbkVFU
	Hx6MMsuv4Ell4Ia9addOvGoyfa3PK7XzeeD30TN0gog==
X-Google-Smtp-Source: AGHT+IEKUzmDLNm/S47AjUbVT0TSPyNRSLNS8NrJTl5hmJt7B7yIO3fgiAjEVvKH+pX/3t1gyQ5bcA==
X-Received: by 2002:a05:600c:256:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-4563a5416ddmr95607725e9.10.1753102462803;
        Mon, 21 Jul 2025 05:54:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:41 +0100
Subject: [PATCH v4 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-10-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
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

