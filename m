Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D73314DE
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730524; cv=none; b=CznqHABc8ma7S85gAl8p2qa2A5OCdQ85aV8lljMARMNvWUXWq1BzY2K2HRz6p1zJ7P6SWwMsWRIq27oySInkz+3wqB05h05uiuR7m2krRf+t+iaaTyc9Q5vPrhHvHZrW62XtL4KQLZBQ+6PztHPRyojCoCjGwCw18fof0t477KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730524; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtQNf9O3vbIKlnDQCqmR03qhl7ZQITLCgET1KIBSIx/cDMLwi0WxN/ZpFD75XrvMFB2HRIjKePYRzoFTrMR8TMxX/DIhp7cuRRQ1qrZkKIV/3aqYhAVwkiaQnEvjnhxWDYDC2FwZJpH9z/1M8eJBMkNX70B+OPJ9ljS8KPwaA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hohsdAT8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hohsdAT8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so6206175e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730520; x=1757335320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=hohsdAT88bofCDMmitFNT/Kz+f8rgI/d/lT7I1OUgzfb20Z4ilH2/dj/AODXjxVX68
         k/S7JrtFSM0oYX2FBn7sGq+IKPfv8XhG6H7OCr8OXhojKf6Iv2phk+pTZ3JxPSpqakMm
         bxzV/sg0m+IqLTjFGGd3PD4QBlZykfd5fgv+uJl0QFb0Fxwe8xH5rshyPeZLVhVUWZqd
         AO/L+6LIivmq5syeDBuvcoRH3o5z0v2XEVi0OxccMPB1Jjsh/5H2b6wZrZ3kvAw0PQ51
         dfIsKo7i/pOlCLesRukCpZwBCtA11DqlKNqWNAhTvvYjpE1mWMBsiBMixi/7X8TyX6qP
         TZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730520; x=1757335320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=TxTYmmP0r3Owx3y3cR2ubGtECP4hbRqb0qx1LPv7omES3XQObKeQXf4Wosi4jc8f/O
         Yd9BurlbN6GEDQrQkACt0brTzhdLoh1jL6D67cfkEk4KvZQC4rdpM3OSLtevxa+BCwRM
         bR78rUkdTJa26bAKW6Z9OXxm9OQkO2m3jv+gATX/oZHhoRojOefD1DTUenf2d1s+MVAU
         A+LE5tFF1ROV73rXD2AZh2U0+KLMd2wQgY49jo111qAuEHSsJsc4g7m9Lsl6jvz8lzFc
         Fr1RqgPaxM1MMqibN4cs8LPANBTcTRMPxc0XXmaJ3Jzkq5Aq/uCYX/Kd+BGmnUKZGfjH
         6HFg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Nxzup60m3Y5/c1Be5R3Ll5CM2ZMhhQkUcEaCt4BkzXCtp2R4dO1L6EYyEHdp67m2orjgBK8YlLKWuOKALatc@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPRV9JrynzVZUXay7Wsjj8z41SSrngqjmPoP8RBbMaC6IgIqe
	sp1pJRODEKtzGTN65FQmt1iXDoOraI0k9fqOJnrvjrHbbFmZ2+iDh1p/6HWfhySIubo=
X-Gm-Gg: ASbGncstP/zGWQ+lMeE/nYY6zETCgPFaRws6s4gRDdCCNSPreePXSbDqrZk3t2LdVVh
	9a/Xald/AZvbOOVlnzQNKZEcUZGMx1Izcv033jnTnYJNDYmix12kMgiUkDpf1XTULllM4/C9BYu
	avsNt2iXimT6UbfwekNyL+WQRNlgsWj0Ezd5uikUhTrTMeqpHSi9XDDS/pNoRdDzGYgeL+2CoHb
	TdFWYpax9eEk33rgq6cy6ox/OasYY/sjYftkRckGsADOE3DHuUFbgy2sQ9KwXkoAee8pRMG+vwT
	Cx76FCFK5oSzPDJrinDFvLj10nBG2CARW5vWEdE+ZcDOG2jhmMY/I73Nxyz24IAHknzhb0arimt
	a6ZJeZdk4LNfm5M3v1yfOfx+Mms2Im6aIGYbY9uKuAQ==
X-Google-Smtp-Source: AGHT+IFPTd5JV8rlNw+el2iMeq4VwQ39O/JeQnoM1FnI5OWoImn9QUGVjCoJJX8IN0HGzcTQOolA/Q==
X-Received: by 2002:a05:600c:4f89:b0:45b:8d2a:cce7 with SMTP id 5b1f17b1804b1-45b8e2ee782mr21104445e9.15.1756730519938;
        Mon, 01 Sep 2025 05:41:59 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:37 +0100
Subject: [PATCH v8 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-8-2e2738f24559@linaro.org>
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

