Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D03BADB7
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570764; cv=none; b=r92pAUa/d84XHJ3OfbbQKHL0IplN4vDxVjN4H7Dr8OU23M6pxWE901FyKHz5LbSvFfgriH4Cq4xQS/cSb/Fh8GDdBqdlzC7QEplqRiYtP9FqL9JEKzyoxpqtIjG8yqmS/AwTqumFWDDfUs0SUpXA/27cA/Lp77zwIMigsePDxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570764; c=relaxed/simple;
	bh=isldx1JrIRTNGR69+4X19ew2mTc/25vMDf+Cpuh9U4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7iFIaNWECFOHVCW0fbpjySJodQuYmuR9QEqA43smsclq6DlZk9GZOB4XplpUcjrcydSbrkwzrDzoREIPdgCsP9Ec46HulT8vdoilZP2HqL0pEK9/aczHO3xJYwUXo+2a5Sp6+QQRUOVdr/JDkpmyzWPgKnvgMjwzqqsjOvEdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+FKOI06; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+FKOI06"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488971db0fdso39371655e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570761; x=1776175561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUsEosGHbHSKoT3nv7zDi6wwgNQYAMlH9EtHkBeF/j8=;
        b=P+FKOI06GQrs+N7HykssbnH7/TC0pyPJ66PoMBAhOleQzhSwjSPmoBWn6OWUrE7Cxl
         /W/VtSMP9Bj1kU2qG8gbGzAGywfdMFWC8l8LEBzjHJD3RvZfwo3JEhOs7l3B79UeudQY
         DhJ5c0JSobsZwLiMRX4GSBrh2c0mehWPlA5+Qj02htKVBAOHqPOSl0Si4yKVPPSLRaUM
         1ocf1Wvt8TYqrhCgUA6NszJqfMFgjHcJg7GlecqrzXDDHU/uoQYOP7xdFxeQf17+BwM3
         S+bwmyAex7qGVvnp9r2SPhOG1viClfS1K++IKsJVG2j44ETEf0zrg6dTc91cJNcKL35T
         WaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570761; x=1776175561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUsEosGHbHSKoT3nv7zDi6wwgNQYAMlH9EtHkBeF/j8=;
        b=eyeVDaNtNISdd9IIglK7WC7aTE8ZiL+xu52tjCE3NmovS9PXb85GoV9+fhrZaNMXW1
         3lnsrsmbLA55+GHtBS+nj0llqH+0T6N9Oyxq03Kp7sV/Tr1N4H/C34P/VEu+IqlmLDBK
         rt/k9097/zdldIQOBEWM11FJac7txMnBwntagGRgFqV0rnztx7+2+y4iVq4n+jFQEjtW
         HbQVqnk7y+6I9w7vOXBEuKqmdc7XLslIl9XFux2zfzQWYmem4bB1MwM+TU/bGNhl/Bjh
         n0OAS1xip+PeaqGW2uNzVR9IY56EmXhX58X6YTVaUappd2zj3JT7CwRl7/OECautOMjY
         KaPA==
X-Forwarded-Encrypted: i=1; AJvYcCXe74n+0hr9nDZogPWcOqYEqNfA7Cr95SE0cJ7kAhAjypDppZrnwLTBf2sKTHB1ADHTn5+2czD6RZHCbc9Y3w+I@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhf2RsJWiDoDRR+ZFgBHOPo6AHdNOiN3ccAwR8E7nMFmxjDiOH
	06B6D0jIa0caRGFWTWwoo7C+0TUq3qELRe8zDY/PZcEEf4JcvffgD84Fc+aT4oAgMiY=
X-Gm-Gg: AeBDiev2OodfFa3uPIWq1n8ar7PghPq4U9xr7KQZ10aLrwVmju3zqtGn3ixdH04E+tM
	7cfcxAyqo+VYl2HTeeC1keAGinw4jzPIlwjAZmm4Z84LOT1HkezQCKjA1VLjA3fprStXn9IdGHg
	8bL91lUVR6eCDD2LmMubipCIHyebj8MDCAm4JnavIOgQP5yDpmZleJhb4+TN9sURnfydm5mlnuZ
	iy2CAPP56BBbX5SqlarH2B4sXMPdTx7k3axsDlZPhaKw2up4vzI44fcOlxgZ3O5CRNAgmdUmgQw
	9/5vKNUvNzZH7/itAWPHrQYvNVbTlhkBRAGIvENlLtf5zvUp2SksClHXEKvFJqiM5z4htAZTmy7
	j5qocu7T97lR0g6G+LZei/DfbgtfJj8Qe5sBsfxZbTv73pdU1vX0kfkK8yzXVPTprSEIhyI7Vg+
	YQ0uJZWo8uFHjUasBzboDVeNKAjfE0YTEwsizyvevUCmo=
X-Received: by 2002:a05:600c:5292:b0:488:966f:70a7 with SMTP id 5b1f17b1804b1-488996b02f2mr260622725e9.2.1775570760907;
        Tue, 07 Apr 2026 07:06:00 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:06:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 07 Apr 2026 15:05:20 +0100
Subject: [PATCH v2 6/6] perf arm_spe: Print remaining IMPDEF event numbers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-james-spe-impdef-decode-v2-6-55d3ef997c48@linaro.org>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Any IMPDEF events not printed out from a known core's IMPDEF list or for
a completely unknown core will still not be shown to the user. Fix this
by printing the remaining bits as comma separated raw numbers, e.g.
"IMPDEF:1,2,3,4".

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b74f887a48f2..c65b22a2179c 100644
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
+		int i;
+
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " IMPDEF:");
+		for_each_set_bit(i, &payload, 64) {
+			const char *sep = payload & (payload - 1) ? "," : "";
+
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, "%d%s", i,
+					       sep);
+			payload &= ~BIT_ULL(i);
+		}
+	}
+
 	return err;
 }
 

-- 
2.34.1

