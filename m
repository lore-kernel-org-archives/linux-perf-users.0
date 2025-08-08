Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D156275B05
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652238; cv=none; b=m8DwB/HUXxevqN2ORgsOFZrvP3RKbqHZbHxo60VdPhmhWhpqPLyKnH0O/kJChYgOxwRNpY7CUeVCx4yn2UCQVsNYvEkz8FgGEJhk8LOi6RHAfHOyVSTX00lpb9/yqBCvdYi9VPUB+dKuRnHkP9v8nCiREu7P5IBbxZS0WKgqQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652238; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKXCDcGDZtb6pEVYuXBXQqHwdMj3AE8sNhe7MaOWi2pu5ltXzlyzVIX53OU1Yhfst3e8u+Q5uC7HU6RMuak3OO5qMIyJ1zwxsVsL7C9A9+uxGE2BWWjXWbaiaUAD3s8WrtrTKHBYOAS5bzU3I/u82O2SBPOToHTFz2+I2p0gKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RaH50ZvG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaH50ZvG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so13373605e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652235; x=1755257035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=RaH50ZvGPhQ8bMszL2JExGwns8Ohq4uLiS7Fwao37U496oSk0c/4gs2SAbUq/TY86c
         ux459xL4OGPmGMoDDCArqmhbE+SHf+5SS5RYAgoiY319JSiHokUYptKbbwn+zEhx+zXO
         84et9TN4ZeRQA5G9xecY/5qPI2Al1ojBoK6nGGmlV1wwor87U7oLKNFo7xKpVWcbr9SQ
         RdZ21JDLFeQYw/jxDx815vU4FWNO0kMhFG1lY1uPkyrZJWpgzWhuUyWVLAWrBnCULUro
         f7PskndpE27012BDb29GDh0Xn39gqPJoFjp4tJCnzKtiHJ4cj6sOtRVUIYRotOqInBSn
         3r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652235; x=1755257035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=EgRGArxDrazvbHRIe5N/iWovTF7t7Klwf8wckbzHWhDPgcbvdwwz3S/knGvKH5GC3/
         gtdZ5mkyBWMzE402c6tT83QHehNctgU11nCcZHMGkSU4/9nFFttfKXZkNmwgfWpSQWMg
         znrfKLrzpHwFB9h/vymFDHb6K7qKUTYjPhlTWTbxggwbq7l3Wb69lRh5TxnI0AvHPJqZ
         KwCYM0VGbqFBTzgpmRbKT5RbQtC9b8N9EmLoGi+MTzHPPcr5gTeIxbTer/CvNvqo9PQ3
         L5UHJ8ut+mEU+KDW88Kph3NH7cC76+lbuatUz3aeXAIQRn3CE4NpcGSMmZF8n3MjLNxK
         kUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLMpKOnN0nIllMOHE8PWBJTwmOxvbTwNArS1b11p7/lFEIDmESuKmY4sFhqMTKrchWP7CLw6GmQ6s+lifI6NJB@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQL8bhNeSC3XJBZVVQlMfGIUDlGf7cTW5NIxOCyN2GTyqrXnG
	XXQtekuCt8yO3dpsg64y42DcuKrVHp6EsHiLt0Eo2vsHJQIEV2hmr4gW3b/8Df311kg=
X-Gm-Gg: ASbGncvJInxNJDCpuvTKVI1WYEo6CumvTMtlLhGzroIJNvZFT72Cc9t8Ho5u04+IaCe
	7hErz8eLbQkLlrZrWtF8ACZgXAHurbKGPXH2sX2kOf1i+tIV4kr5DNT4l4Txr8G8E2Ner6Qk0B3
	VqSSQZQiV8IMGf7QhmwdDjqwseZT6i0vP1nHyIuXyRmcMgn6YO9B9Wn8LiqEF5RKbnN0vk4dnma
	trIUvF4Dmks1Bpiqfjkgtd4rStmS1PkD3l+uehWAgvyScwGjneaUwn4X2dkKEOHcY5jX5sDped9
	L6a8hsMYkftJCYaOap9SRizV/f4hzZheuytzBOBLNxFLFW+PEfKgdi8Ne8XCFhUFDovP8qINXPA
	oeEsrnq7otNyn/LAw7ekU6tu8F0F5lL0=
X-Google-Smtp-Source: AGHT+IHOQ18gbVsDEVyKCfZAIEJklPYVqKw1aZ8vUXtA3WE+OW7IGcXWNxJyWSMYhUVtrh63ytt5Fg==
X-Received: by 2002:a05:600c:198c:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-459f4fc3a9emr26503515e9.31.1754652235388;
        Fri, 08 Aug 2025 04:23:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:55 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:05 +0100
Subject: [PATCH v6 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-8-6daf498578c8@linaro.org>
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

