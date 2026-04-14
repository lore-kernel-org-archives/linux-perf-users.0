Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C183D8107
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164802; cv=none; b=NKD9TkPN3kReaMSlegMWE5yqr2sck7XOVhQ8WrAKonSZO5MBjMToTXWUleLyMCZy2CdjEBRaZqL7ClZKMYoOqRShYpmazgil4sHpqDO0+12PuzMZs0E+MJB4nOGu3IoKcdPQQHQIxo4ldHAiFw5qoATs6tEFOxDa6qH2ASSaaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164802; c=relaxed/simple;
	bh=/AzkEovsO9hXmRshBeGK0xV8fVdHRetAqtsdomf8VKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNH8tAp4o8NXTXVjeOLS7zS5PkD2cugF1OtviC8z+9kv7kHTEsdICAeC9iITjoNmJs6olBjvG5Mtw9PcekNxBMSllsOk7GQctcc/gV30nMRwJKuXrIWloTLFdJ/YSlZbqY3mnE97OzJXejmQylxUYPVTdRjtpafYgof5sZt8/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ce3rrReA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ce3rrReA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488d2079582so49235005e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164797; x=1776769597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmMwrtSIePz754V0sje5TuC0YnmOAM3jxAH9WYpMnUs=;
        b=Ce3rrReAf3xD/w1isok+d9t4CsxlVd0YXxhpLwbK1/Y7S2n3xC3fATzEyK9rPL1Wwu
         cL8aWoB0iBt3kKP8rUaaVe4jl4se1ajLeF/oN8WwLOVPRmhz/wNGaVEXLrhlC+GdW9PH
         /4QkhhC3tTaWDExR7bFHD2UlsScHGdQ/fXJbNgO/QBFpr/8bMvdBYcO8olY3UXabcRAU
         AKKdlmj3CcWVMFVdeKAf7i86Cj9JDoBYNawY/eCyF3WoMeBYMXdd3H9AiFp+7Dn4ugog
         U5f5FAcOMnBerqtN+xjgpFWfRz7acwM71wbu7dFbJL1HMhXTJyNXWrlMbab9+BKt+LH9
         9Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164797; x=1776769597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmMwrtSIePz754V0sje5TuC0YnmOAM3jxAH9WYpMnUs=;
        b=npuaz2Q3HXgpskOQOBPwzSTejrYOQ3AhMc77A71KLNw/SUSIfuVoz28A1Deb1kABIU
         CajbaVEVmVcBb2zYSB0+WYpYp9MMBfaUhHriJOeFuDZTOJ8/PiAz2CPceSr8+PfVq8qi
         JLXJr0HR2nTyUmTwPTNPKMRNvBFgUec3iO5gtAhrKIldF25DdobD5Csp6RvBaS4btTSs
         TXl8ibHU9FykmT70HIlh5BTAHxI3ZMXZjIeiYcinDQEzTesuZM4nKj9A+9B5FXSxrXvk
         MsQB0bk1kC632ePoDeta103jwwPZmIxQXYqWqxQl9HMde/7kmK/pjmlcEatVNWepxjfT
         er3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/UClgf31wWVpV72mbkdoJdL5aygpGGaqKQ19feU2lVMWpTx1S0Tpp0O5cBmqn36lJ8S9HcENblYPvF/hJF+ztd@vger.kernel.org
X-Gm-Message-State: AOJu0YztW16aBt7AF3KvGuuu7J2H/X3sGdIzoyapYVHlncujjkMrBqML
	fhjOUAUG+0kJrTFcmYAUc8AwpfVS+I9DDeCRkvSxr1qHw4cSYjkmmTuRce1mB4aFn+Lp6bvldke
	SjnGrfMo=
X-Gm-Gg: AeBDieuPNdr1QCfU97n2X39GWmD6+FO2sFhc8qpDhY+SEaOJJldKsKW0kZ0Mw0TA3kX
	bxwORmq33FMhpQTbGWwi0PmIjeL792/khEP1TGbO4lQFVhM6ETGa2r2nU9lPatT5dNHrhbF5P9V
	b68EUPw6JDHKwYK4Ez48ld81lbqGH7CqpHlqStqneCE3N8dtbP1qH9uhtnoyzVK4pR551EX9h87
	bg9d0iWtp9J9D3gjbxvdIdhHwd3f6ippOOo0frngR6EBzV4R/iakyCfkWJP6payzBkfXATLQsiy
	oNpU1oexLBf9DD3+rMPLaKpohZNiqiOFFOGZBAWc2zQYze3TFWc9Jw1exrVh47V9bTKD5qBBETN
	/7zUfsxKvT7cws0GEQygTmgw9wxtSbfukn9zE/kQBKoJz7WnU+/88fHHxT7DjH9DKyP0ZBi4CX/
	v+p7SYxG2DNCjwQr6Gb552bDnUJVXL9+k5D59LvMAMeg==
X-Received: by 2002:a05:600c:3b24:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488d6872ed0mr236056315e9.25.1776164797092;
        Tue, 14 Apr 2026 04:06:37 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm183254655e9.4.2026.04.14.04.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:06:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 12:04:52 +0100
Subject: [PATCH v3 6/6] perf arm_spe: Print remaining IMPDEF event numbers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v3-6-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
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

