Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7783590C0
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861119; cv=none; b=N+5TOTHO0DVHRKy9jzYSEvQc9EOq6TyzBI2D3BjyY9z+5v6fv/UQJ2r4iAmbeThSpDWwp3jajuEQbsf7ZNSmyBqZ+ki3KBnhIEIljT8MlG8zptazfWvf5i8uXwtQdUg/82rzbiBok7JUnXw/xSDbkmos127C4it6FWJ6Ii7Eu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861119; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3QE9m2UQTDFNP0mrncsyxR7+nrZIaFLAFagjynUDtyg+Mxwf2bujpoKZ9snDvtu0xmsqTM/DYX72mclWsrwZgSz/+MmCNvathrf0BNSWUUOD4hsiBApX68iS+KWEessTHnEJNWvSxz7wJPJXH+eFKvgziqXrUw6fW65as+4xCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDehWl/b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDehWl/b"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775895d69cso21297285e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861113; x=1763465913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=vDehWl/be0EvJq+Cp0eB1lTOJLz767+Fv4g5FD2lEo74N9c+Zs5J9LeU2Tam0+/3t1
         h3pM9bX0q8OffUmbFGVIohlru3qgrN1th+Ph9AezTjXqg1/phZu+2aciX5fYZc1cW700
         FTEGgRttwZc9gSY9lZDuEeR4y15jWQNb7uPT1uMVcCgezJIV6M7KaRBDnUye+xkMDwds
         e5Yco7m2yAPi2Edo4Gm4KRDGJzwk9VVclCPKWnZfSY/66r4fHib3xKcQn11W6Nwr6gqq
         xzD1gT2vszWqzsaAe7f/phJC5P6lr6QZ/0rnxMlbEzEuFnIh8bOZ83v76ZDYMBYnOdmL
         XOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861113; x=1763465913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=GVkUPPvQqqiZMuPyyvKnkln6klAknvQ9TVO7OzIvWm4F8ks9nzdA+0639SM5HfCVCS
         l1YxBI48zFZZRXMjfeGSCF97NiGPob1c5q5N0BJwMw9iYle0DTYAGz3J5DFx7RhECURk
         XEDqMj4GpsyYtiByp77V6Bg5Gz77UGS/fC6WTI0Fr1u8IoZz25g8J0778bZFNywwZSha
         qzcMtikARCqPbrGFR8aJNSsbbQAqNdQOYBM+2v7Ul6UJzSXR+biiPcxl54YlkQv/wqKO
         0UCti55rAbmDnxdx7vK5OM4As0RgpjX0ZvpgB0xWUwEldbPyKEVxyfv11qBuH9/RVSe6
         PmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3TShXhcrLLRGWGC4pUWQ60BEkZcMJl27wFXMpPvDna68yVkVJ4yr7BFizpovPjW5KmmquIVvpIOnmmskE6gED@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9W64YG0x1lDcu7TiRJVAkFfeobqTATq0Vz6hplyWFtDCaJ33
	JJY8cR5wX5UwqkT2YoP3zaBh8kFDjyY94xiwyJOZwQTbjFx4TZGfyInbfNMIRtD6b2I=
X-Gm-Gg: ASbGncu3mUR2w2d2+MfGgHvLhyRYuDLgX7giio+Ptm+5/uWwu82/kOt9iFN9hzS6Pe4
	Jf3E4FDlWyOD3W1cqBh+cibu/X4q62KejOUT8zcxoCEz23p37RBGya8U38duNe93jRooE9kFZ3f
	54p5CCnm6It6EwwbtCpk1GECBVnCnS2apq5ljry/s2GCi2qPzNpaCpXIuBta9kvCjGtjRbzCgeV
	u5i58TyQth6wG0vEJz0b9mcugfXlhM86P/O1KPfzAjvv6vNB2H1kg4xtda5i5wqlqHaqgaX6d6U
	9GrQZ+zz5y0aKoi+q4z9VwToQWsd9m+CPN21+gb3x1irhaRhiqlaTzH80nLHSZsfRqZFSB7/eiX
	SgpQC12V119xCc9Mbt/7Fy6S6DVJo47VDE6OyKRzWyed10hbmgXb7uyVv2fDqaazddgWpXl+nwH
	OaqqVBkXTiZ829DX02ypfU
X-Google-Smtp-Source: AGHT+IHHKYLRfVgN/W/e843ki5ckqj4gtDXuwTA8cbEV+6RFtEvcngH3q04dA3ZvJO4NaiMzNyBD6Q==
X-Received: by 2002:a05:600c:1c14:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-4777323ed28mr117807465e9.11.1762861113334;
        Tue, 11 Nov 2025 03:38:33 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Nov 2025 11:37:57 +0000
Subject: [PATCH v10 3/5] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-james-perf-feat_spe_eft-v10-3-1e1b5bf2cd05@linaro.org>
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

