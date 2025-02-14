Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DB2676D2;
	Fri, 14 Feb 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543446; cv=none; b=Bv5Z3ndpK1oNqjM5TERPz57V5diuIRWNB5fpayBpH5c2EvxSNIyrbp91q1V/ignzMa+dp2eNlmyXmJwsIq7CeII+cTqn9jldivnHddOjyKTaSBBYHK3/9EbePRz8Ki+v7qT568vlmLz4lj2xSrHnYNILk9ATfaefnUSeExv0Kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543446; c=relaxed/simple;
	bh=6YoEPxJ23tlB05Hr5lEn9IwiUxu3JyxaBoeQXV7L+7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJyVzkQvMw7fwxMsAfcIK4R5k3PKO9EkbmC6/QQCDT7XEa8EV/NnHQObTbyez/9iERAecMEM4eCiKFlMN481H4DT77z6C7wWrTZOTOS5X76U6yqyztAprUkzKUlei9LG4/QVf/PuRBZQc7TwAwvu3BD2Al7nEB6zk3GrwhUj+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkcO/qP9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkcO/qP9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d39a5627so31071435ad.1;
        Fri, 14 Feb 2025 06:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543445; x=1740148245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN+eZpJ9eIG68InE3GWCQVcY+xomBgCqyQkRTUGWCeg=;
        b=OkcO/qP9qoHfLhrhBQKtbhv+Yx4nzG6x+yROTCeAAx2MzxxQlczj3D29VL4RPVV8zI
         lLcK/2yc+NKtlbB1pihQvd99pigVj+jZQ4JJ+kYBQa2twFYN1e3AlHbmj1VuHW1mnyyS
         QcvPFWjwnyzIbZa0iwNJTaaQ98FjOBMOcrJH7oNvN80ggqxFsDRe4e7EJ5U84J09V5yM
         nKX9fnlCGnpMzqRsuXd6mrBcR2qU+Df1O2ui3GN0s463Z3Z4Gz/+nBd+S/vq5laukg6/
         lgKQdUC1sZ5x1xjURqLsR/h9s7EsYLGZmh9V+k3N8UpuwNSze2lk15UMd80YgS5eORDV
         wdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543445; x=1740148245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN+eZpJ9eIG68InE3GWCQVcY+xomBgCqyQkRTUGWCeg=;
        b=MaoBCJtxq7l7ejc2DJpZRAAiDUe0Egh56rTSbR/k4sYYf0R0NTl3/5+pZYR6v35v/+
         qGJnq5JypJNls3lcJ/kgKFhPg7Xei2i/8KrB9RH1uT/UqXIZxs/L5TBGTTqw5CpjTDBm
         6K+joUcoRWEfV+eBgiAleiaT6c41XXoJv83zrnynMt5MZbQcRyZarNPFflem5tJDTAnZ
         A3aN5FCrEJ0KmWmx8QO+Vug002QMmYAfNh5G+mwKO/ff7K2aF4NIZ7s47fycOZcBNVUl
         krsYBmgd7kklx/8PSpIQpArzj7GHmlhk5IIiZaxnxEdrDtmqkbNVFTVeN+5F0gjm6zOl
         xr4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbUplUuUdhAZpmuE6C51n2ejXWmWwylV+LZp5ifdTOhBxXOdQqbiADobrmhyBnMcQaT5orfxOnNuen@vger.kernel.org, AJvYcCX9RnMLgRM41SybTubKwTEHshuJQiCgT/wD/7BYOgn0AXKXtIH1iq9iQhybUoI2AwUhR4CfTlTwJ0lGYLZJ@vger.kernel.org, AJvYcCXFgeCpFlC9C0KDc/mavM5xv7jguo7C6+c6BG1ViX7xs+2OJrURav5FfEj84PArQQE+ffN8IOzukDPJHXelvosgCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbEP5kc8PGt/QP/+RC/nGPXkB6edzKCine1nXsyEtsOJ46/qp
	h/yqFurhRMnO4RXMU230Nq5rRVPMHLxMsbJOa3umyTHsX89c0FDb
X-Gm-Gg: ASbGncunOqLad/AlQiJyWIvMZTNOiu+LWrOgae0qDA2PL5r9/XPKfFs1KO3wJNmg++g
	BExnahOfAMkmUVraXWahcKHjiuMr3kVtJIcaByy6/cEAU5qwB20vshlnOPWEVYtNk1+ivgXla3M
	rMwUinG/wrs7hr24u5aSyG7CHuFcsFj5mLTY8mTdaqXqFsfD7gIg38SeA95bdIzNs8eicOY3+2/
	MK55Y7jGG0p+qLzE2/W/xXvJl0vxSYcLcfz0kJ7MRIqOSGIc35RHJg1MtqsYwzj4jNOl0Ku8WKw
	+6m6AV+fRMJ/93DIUg==
X-Google-Smtp-Source: AGHT+IFRr54NQGh/IgFm9UJ+j+G6mFUuuYOyOtSYg0bwbWseWMm/5RMmaT7XUoR1sxFLmmR2C3cCYA==
X-Received: by 2002:a17:903:2350:b0:216:410d:4c53 with SMTP id d9443c01a7336-220bdfed345mr189976225ad.41.1739543444569;
        Fri, 14 Feb 2025 06:30:44 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:44 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:31 +0800
Subject: [PATCH v4 05/11] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-5-ffca0e45147e@gmail.com>
References: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
In-Reply-To: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=6YoEPxJ23tlB05Hr5lEn9IwiUxu3JyxaBoeQXV7L+7o=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1OARxgd3D8G0gBs1fVW5W1xQkJOrG7rToycf
 qFi8+KQB+yJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TgAAKCRABygi3psUI
 JA8zD/oCREdDsqvpz+u5NdKYTBBxaf5oGFqwWIjo8D6W1NxIjU38x5hUAaqm0rDKPyPI5EI4Iog
 SMLIRHb9efzNadiYddp/P+y/5m2Eag7+F30WnxRpPNrdpBYix/vyMzCoxl+RzMY5B8l+eYC+HLy
 h7k+Vjkn0Pw9OMZ3qUF57pWV4iBgvQecShwPNjQ7AAhC8fiQqQjMHJec6+fCllGR8BlgOQvCQd9
 KM0v4GCIyFnvSZG4gUNKqvkBc9DReuHvE9qKtu0PQhMnoGlKag9AAHxSE98ZbDoHRnyENW6Ww+Q
 R5/nM/o7WN3KVqrh4sNKN0E7NtA8gNx0K+AhPveEnxrZleME+zKfLFzvYQLEY3xwHIWPiMJQGgZ
 4goZ08rZ5zlGU0NLTK+db653yIrp/zht+pqJuYMJPcrQszCWACEkwfLRgZspy7W4zXcWKkfYOsT
 w+QsznZUU90mHFQU1QRe6g0YHVtm4RaOPVWOQvzgEIYQCllqntlCRjqGU1ZcgWFAT0KbQivc2mn
 z3zbP/OQPBnzL+nQG/ygneSGzh1uy2iA0pFfX0c945SzIEQ+0LEr12/aSSW9wDUbZmjYf+0ZjPZ
 mMGbCgWSxJufQoQ29w8cnpjHeo5HdY1gBuux2zZDzgXozqtV4pO9+yTHbqjWXXL2bNcw2fomT9X
 a1Ip3ibTj9oijog==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 73ba9861a15ff931b5e388b6d809dedb140e2292..b601d585d204f9e59ad7f5216679b97852a46a04 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -608,7 +608,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -625,6 +624,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -634,6 +634,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -643,6 +644,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -652,6 +654,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.48.1

