Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7EC2F83C0
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163575; cv=none; b=tJAbj3pAl2llDtYKql3eOEiMDw+a29/ubqy784Ej4WqOIuP2Q/lL0cWPRz/Vmq6uhulfpa0qiISqRPqD64Heewe7pMpqntl+HnEhgO9Oeq0y6WVWxacHh5EPrrBq1bdApwVVT8HqZUU3YxqLCwzVTcPAFxghTVXCj38vvebt0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163575; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBvfS0vMeVxQ9ZY5ZLNILHrudlErfHkYMgQtmklnSSiFWwkWM6qhuUJ4pLrTQdgREwuUGrD8Gy6b8FpCY599kZvpN2oQXS39uT3FBxSQgcpbzVWzgdM5gyVRr9itb0DqBqQq3Dz45ct8f7AbxIuZIt9mhlTqa+N8c7DjpaQIW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/laRN4f; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/laRN4f"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso3760885e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163571; x=1755768371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=p/laRN4flPe2/P1CowT86YgfTWKRwrcfXfn//tIJLMZ+YmZK+B0jRpyKDZw38m+wW8
         ydCeeK2gkUgAjVHEM4cIUR2kL6W3Soi/dSBZPnpMT4aCAutvLbRZMG36u9APU4tqUG6/
         7fPmdPp58FQSpF9P3tPiLe8u1vZT1E+SDCCrl4iGvxBGl/r12Qfqi5DmpUSss7G8Mx30
         vpIz1U+4+IjXJbmUBWGih5ISiVPxzUOXyUfAWtQHoi2E238TJYENgXByNSgMI7/XNrt1
         NH3XUGOweofx1kC4mk3gjayod4rKeRf4/kUwumiJAPcv1xNijXF82noWUxdXz1ke2wkk
         hoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163571; x=1755768371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=VIOMZuhv5nSl54AHACbRcXIC1T590P8olNcIVGYAuCEf8HeasJ/CxL/BLpYrVlWw9N
         VtNwL02OHjq6x6qJqyoJ62o92tuasXqbJDop9eXM7q3XaRcugzVN5kgQTdu8echhe1th
         8CERjE2h0f2bLTRr/OiGXg0feUfGcdS4xl3t3/ou+WiR5u3aIpLA/b/QuKLEOiSdE8HD
         6AZ1QP6JoBcRgih+fHUgbqhS9JiJtkjM2cgV/j9x1q5zdmMM1GrynnugF+FaKECKNB7G
         Ht3jDCxPkrWHr1rifEfaDr8fa/FllogaFQH57SIaWMMsgiI81kJlaquM1f8HEPPZCDJ1
         Gz5A==
X-Forwarded-Encrypted: i=1; AJvYcCVAHhAqG4Nd5Cu6+G2VIGe/pQdQJBc0xwW0/RfMjwJ7l3RoWFZZNz0DZqjpOXxXwxV+4q4EkGDglUPRtCI5nCaA@vger.kernel.org
X-Gm-Message-State: AOJu0YxKq564n2KnXTllKS+/gxJFEJoYgRJZp1VkNZZmSqYU3p0VNhfu
	T2IvN9ZdiXX5m5o7gqauMN9Az6RfOUVGwniDWei4AoPsVCbQnwRp752bnKOwRZUbY6Y=
X-Gm-Gg: ASbGncs2f443AjQ1dQB8rqEv9ZXTA1ct2zqBih6Ha8vwicTJ644DmRLUZ1wLV5jsEm1
	Hv60eEdQRsZtmk2yF7mO9pWUz1kN/D00Ggj2JcxK0zIXs6TzPgiKmkhFz/qtaFcehnimaXzc8jb
	hPTjUk29Ttdx8ESKPtgEUKBm5bCBxRO9wxQU40ZjXrPah1gie2oj05gwO6V5ivnsY9Jo48Q8iuo
	ToDvaIEaa28GbTqJe1OmvnJvbRQWprKKmdDj25FtlmwRHXbz2x34rx26NZ+jTaD4qP2vAkPUECE
	p6xdyD1/3CJCWrCy5F0fbql/PQvsGSU1jsGKJQQ9ugjNth6yi/1KA5qtPoiPArkiWMBcgLOK266
	AtM1sHmNSROWghIsidOeN9jbLCNEV2Oc=
X-Google-Smtp-Source: AGHT+IHtct+umesyv5x7r2OiRVf/2g4YUX/d+UTbwfLkfG/5sEvYEqn1B72mWCeZftKk8wn55AxWng==
X-Received: by 2002:a05:600c:3543:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-45a1b628566mr17809305e9.13.1755163570902;
        Thu, 14 Aug 2025 02:26:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:32 +0100
Subject: [PATCH v7 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-10-6a743f7fa259@linaro.org>
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

