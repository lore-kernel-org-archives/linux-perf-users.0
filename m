Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCB43D4E4
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016054; cv=none; b=qyFLNbkPWHBGGn9NiWslj5+6rWYA3b7Zj3j+02fommDR5uMLtIWITggOHdv6T5ToYCne0iO7ZgkvQfK5L0VTy0PNu6xCZfvVViDoNE2QPaFbumXKJhz8Gse/lxvBAa1Ha5eDQnOomAtJ8LpODMgnombs4qnKu0sQdZScz+LvIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016054; c=relaxed/simple;
	bh=6om1sNi+g28w6gz9Rvlzv8I2HBpgV5uEGqJP16w3z5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsNvWRFR4rq00IZ2oNKAg0OWM/XGIGfXf0hbaAPdHvgS2lxqpWx2Wd49b7WCr8X6AZLDPcSpkrrcb3zxBMmx46h5dRtEPOQ+yXs8dsRozcENmpXEHxj3HmWrEu3jgmovCb7wFqq3qgRxBLrfw4W3aTzLtwuvauoh7UJ2dK8lF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORsR2oGq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORsR2oGq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be03d47bso48595505e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016051; x=1781620851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf9ynHBKvgH06k0u+j7iXyYQLRwSGMTUy1wnSW+2ToM=;
        b=ORsR2oGqhC2iKtONkp/Q2Za1I/Bf9J30GDoToWBtZAUgcUzBRDdKwusQ/ZrySwTMh/
         f6s2wmdamPxTyBa5WmkMefLJ1+8HCthQTXtoQJ/wNRqSYg/HDPZ3ctppFP2xRZv+8d1m
         p40CKm7JqAjXYLMUpaElXPepdPNIowI+F41zsaRf8Uvbb87LTBulS2rSFImL+IVGpQG4
         bf0rK3Wr9riDyHsKjhb2xlxpMk/Oxn0gYxyCD4pUSPTfdFoA6tiMxW4LSM5LSphfUt12
         00591kQkfnzGQoGneq016wndmlSBp4Tc44y54ihGU4bgMmRrb3GSmcw4QK9CkPCD09or
         a51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016051; x=1781620851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gf9ynHBKvgH06k0u+j7iXyYQLRwSGMTUy1wnSW+2ToM=;
        b=XsW82gu/BZpBKTgKFnrMEAubhRTWGTwD4I/R88zYA/4xzmcLTOKGYyhQPeMe72Q9Vr
         7gZVQ/5vPC+2Er+5xcDOsByNv1HkQzdzrhtRH5k1s0Lq1xgH68/0fDUzx1LrnNjcANBU
         Z1WdO7H2sPckXu7ol9EP6/YokWu66JRtfTDl0jcWZq4zNrA/PvH4CvcirjF0c3XTPx5M
         ih6Us4E6d2rjKLpKnEvlikXUbwwpU/+xkiF4PoLlWITFtUSU7wlJYR//Si7nd6W2ycAP
         nnsLCPYVD2dfBw9yfk+2ZdUOiKBaO1w976pHLVqrC0++qWOeY5vnIfzr9N9SAdxVG5lV
         oE1A==
X-Forwarded-Encrypted: i=1; AFNElJ/VkMqSdAZn2YQ4e3tYhI2gpsi0SnRjLJUCnjPa8PxqN79c14axO7m4/yrcwPezFbYs8kEv/201qaS2iWhwaGPd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EDF9DZ3+ngHt58QaG7v2EHMv5ooWAN5px5oVjm9kypVIMQs6
	I5tqb9YuQgDS1aBKi4gWSGl4omokTCwpGiBchJwzhMkYK2S2/7JvTxPxzeIe1DJOtfk=
X-Gm-Gg: Acq92OHfhuePLQcwjeUADDM2G+T/Tn9jmD0U+FMes2B0l1hUIQVxiaomboW2Z6MESkK
	zTj6JKmFspxh5IqfwWw6mmMJaq2lRQ4fCW2H6aUd/fX/HqV0ALjA1NBAfYmejGxnSOflOed4kqK
	kKDdV7H+k2CEp5ZlurlZyKS+RsF+s+VqRdtbyQ8v6HtqraZggggrkvbArIRJkom1q6mlb1cky4W
	fLzDt3Vd2LhQSDWgZce/dD5Z2t1GoQtR5v2t172B3qX3o1b5TgFYiqyDNgvIhciiZ5dfb9a2y6p
	Keez2JpjIFufHpIU9wcr7Qdfh0kJRay9pPNmXeDDrX5aC4ZMSSLPav3FrQBXKeqe0CSgcpAXDoo
	JeSZLgYib+OWzVwgaz09DodVkpJsFVqXJt5UcB4TATTE9YwLHjrU8MsAoeNplp9RriSJxEWOWiE
	CQmTUhB8R6SlNd3ROPt0pSdYKxLh0Ien+YMs/UoQ3TiQK1r8ZDmtIQmQ==
X-Received: by 2002:a05:600c:354a:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-490c2607c39mr343398935e9.31.1781016050068;
        Tue, 09 Jun 2026 07:40:50 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:24 +0100
Subject: [PATCH v5 19/19] perf test cs-etm: Move existing tests to
 coresight folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-19-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

There is a subfolder for Coresight tests so might as well keep them all
in here.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 MAINTAINERS                                                         | 1 -
 tools/perf/tests/shell/{ => coresight}/test_arm_coresight.sh        | 0
 tools/perf/tests/shell/{ => coresight}/test_arm_coresight_disasm.sh | 2 +-
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7efb893edcbb..ff8935b459ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2749,7 +2749,6 @@ F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
 F:	tools/perf/arch/arm/util/pmu.c
-F:	tools/perf/tests/shell/*coresight*
 F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/coresight/test_arm_coresight.sh
similarity index 100%
rename from tools/perf/tests/shell/test_arm_coresight.sh
rename to tools/perf/tests/shell/coresight/test_arm_coresight.sh
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
similarity index 96%
rename from tools/perf/tests/shell/test_arm_coresight_disasm.sh
rename to tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
index f2fb1aa92252..ccb90dda2475 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -24,7 +24,7 @@ perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
 perfdata=${perfdata_dir}/perf.data
 file=$(mktemp /tmp/temporary_file.XXXXX)
 # Relative path works whether it's installed or running from repo
-script_path=$(dirname "$0")/../../scripts/python/arm-cs-trace-disasm.py
+script_path=$(dirname "$0")/../../../scripts/python/arm-cs-trace-disasm.py
 
 cleanup_files()
 {

-- 
2.34.1

