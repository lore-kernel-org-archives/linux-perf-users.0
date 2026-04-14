Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860B3E63BF
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170907; cv=none; b=idqhm5rsQeZ4HMXQyAd0KQ0uLrE/Fa/bQUMDmoxiaGiOhHlkc6Lk6MsdyR6wNlu3XitOuW02ESGQoh3dgdyqFwgW4z/rFRZYMKnnJgMQ+x6L4V4ZHZ6GnonhQAGTc0vtbRCAW+ULkhZDvm1sDS/JjF0Rquxj8ydsvWxxkHKYzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170907; c=relaxed/simple;
	bh=/AzkEovsO9hXmRshBeGK0xV8fVdHRetAqtsdomf8VKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucpzlj6Do5J6neJJs7heUxd5M+EovjGnWQ/zHM8Ihl/rDwyO4veGt5pMOigiXS+XseEwLc7wDwvpeZXT7M4Nrn79JhFwlp9MTJAr7HgyCrzYqJnORrQPSoYxth1U/BA0JHiGcFnPYY65gkki5/NP1BRWGctFluKPqQoH3UwmblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cx4cpvDa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx4cpvDa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so36488505e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170903; x=1776775703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmMwrtSIePz754V0sje5TuC0YnmOAM3jxAH9WYpMnUs=;
        b=cx4cpvDa+IotMPzgMwXiJVfSUroM9VdO2nloWNGlt7uEas882LTaeWvLL8Gd9nBB9i
         HTDV6CnHyoXatNwDljc224MI8ZW0T+xmbK3RlttoiOUkWeUzxbplFyWnbdOVNUddkXWV
         vGzwakTLtH29jt90Kz0hYoL3FeeQld/arklfi+d61z+Wq5/rZVN5FYHAMLV2T4OrGqjR
         2jt/yA/qV495TO7mRWKDyAd6zkEB5N70cGGez011zZKTzfOwCz/pY45oNmScmTiGm7vl
         24iEmN0STHs0+VE4HQ26ljYBh0GDuy4wjlJ2hZ1nSNX/XrdVcefqy26WM4aFMHqSK0JN
         7JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170903; x=1776775703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmMwrtSIePz754V0sje5TuC0YnmOAM3jxAH9WYpMnUs=;
        b=m3pehHnmEnCq6tJfZ3mBnGzHmMiB/tJNexdq8Fj3Q2WRHytR3hL4SlFWTQEtu82ZLa
         usVt7lfchNkUkzAwfJ5hec6zj1nA15sSjkj+BGF2V/Y6tME3wBa2Mn2j+I5gFeV83V2B
         8iVM2y2UMQNdgtDxvvDXCtBEWXy1naCD4sp6LhUfMefB24jj1oeGaHw0xZdCjBbwp96w
         EdLi/Ve7i5OYqbPV1dUBLwhqO0tXbw5fYC6q7tHhuc8Wn16VpoN94v8aHly7unbOMf+u
         3ZTEYalJag3FP3m5od6Pdz3kFU0wIC2evGsEB6/StCRfchtr7IMSbULNDC2UWVYY9VB9
         516w==
X-Forwarded-Encrypted: i=1; AFNElJ/Jtph3IIrXt7GS5bgoLnXa0x/PDgWjtLihGsoJi2H/PTYOcvC4kR9XKjcWXgretpWxYWxvIFC830l6RLTqkA/c@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80qona0YVRxjTaXYPhUchm3pnGfirOaLKW2apTDPvYUO8IxyG
	cGcZgxtYU1sOn7duL8t1ghAhHVQKg8N93Z/E3AVI3GxW8soKnyBGcZGyXvjw4aVTaYI=
X-Gm-Gg: AeBDietADLOE7Xl5B6Ia37W2NMhunhZ4eL3OVzAuNI3SXUdxqP8IcCZiqTODLCXKhxd
	r5145qpbOwhEAJCMkkDaCGObI7sT5OtI11NBzEf76QGzktefc+NOcR+NwFHN98slhbR5P0teKuR
	QPc/1q586K9dlZWSjDZ9rr6vNLLIqLLNBxyl3myCmwQmO2IwzkrOJy9fxBXqEAFkfY2vVzfTnBy
	+K/5WIHdudsy4kpd+MeWJPn2m4DdyQle4XYOnKovYsOe1pr6M1OZ74by9/9CWjuGmn54uGBA3hp
	StThrB1pwsbP8xpkKZjTrP1p4pIX+aIiEdziKSXuC+2eLATHVLZfQxmcAzS1aT3etj+P9rhRR4f
	HLcYsv/aVggccgeXPvj1Igmumcpq+vkje1rnBymCa50YJHZvRN1gR1yCa85qmV7rt0KMsIK5LRl
	Fs6l2VQdqJ+2VL0rDuqlqV6pHQkWEmZUwGvmGS5Rpguw==
X-Received: by 2002:a05:600c:a406:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488d6781cf5mr185361955e9.0.1776170903346;
        Tue, 14 Apr 2026 05:48:23 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 13:48:04 +0100
Subject: [PATCH v4 6/6] perf arm_spe: Print remaining IMPDEF event numbers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v4-6-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

Any IMPDEF events not printed out from a known core's IMPDEF list or for
a completely unknown core will still not be shown to the user. Fix this
by printing the remaining bits as comma separated raw numbers, e.g.
"IMPDEF:1,2,3,4".

Suggested-by: Al Grant <al.grant@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b74f887a48f2a13b1be165947b4e3293f9987bd4..600677318f84c06970e4e618280c39cc83ac5b1e 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <stdarg.h>
 #include <linux/kernel.h>
@@ -365,6 +366,23 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 						   payload);
 	}
 
+	/*
+	 * Print remaining IMPDEF bits that weren't printed above as raw
+	 * "IMPDEF:1,2,3,4" etc.
+	 */
+	if (payload) {
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " IMPDEF:");
+		for (int i = 0; i < 64; i++) {
+			const char *sep = payload & (payload - 1) ? "," : "";
+
+			if (payload & BIT_ULL(i)) {
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, "%d%s", i,
+						sep);
+				payload &= ~BIT_ULL(i);
+			}
+		}
+	}
+
 	return err;
 }
 

-- 
2.34.1

