Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B449423158
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410462; cv=none; b=OmGXsPjIyOYuqtZ9MnHkq85advg6yTgclvde0Erc51hKt85TNFXL+vCMBQyiVozqW4xRjLj36KVzyJ1dHj6WcEyCzoBQKQYYBBon9OR+VWReCx/BmpeLiu2W/ZU38AQGDzB4RUN/usgFJoYHBQowwObgJchstUOTZ0GtEbwOvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410462; c=relaxed/simple;
	bh=UqUTcZlsYRMZ7HrUOPVdOIyjHND7lnBLRlj9pGTngF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOIKdi1SX/xCl3NCAxsohOuOsHvQnLAFPRX8GwBt8zmiPcbUkdeo4MSo0E5nENU7UpPcMz8DXVYnEBjW7/lE7hUK05kolexMOp89W9lIIUbtS0abN9fZbGhIB2CTP4u28XVyBV4DPq0bB3cCxyfA0047OAmzYF2D+UKVIEArm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWTTARr0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWTTARr0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b3e03939so4508355e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410459; x=1781015259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCyit+MYNey9T5qQgf6spNYkow7XxVLTYJAiVVbCmNE=;
        b=TWTTARr0hyfXJFttBluqwf4CfuBhqj559ARL/D/LHTuf1PKJfmtL58sJaQ7/Pegpep
         gNbovz6Yjxzs50/PtGa+CbBUv9CElKnN1w0EKGVXwusA6GM5mSYy8LNZvNYFKI57VB+H
         MXYs8ox+a0MbPfS2skPwSDfNNrhSbNC3MsJ8tmyeWY17Wu9Fx0HwmO6DynVmeBHyd3fL
         rkcdowRJMjY3D4IF3oT97b1Isdadkjew7kjWhyJUEJO6q6bZcss+D3puSyoi6G2+LZjN
         2B7scg/EGPdhkOAUCCTST6yyDLjCYfgHNulzAV0GsQRDSmBqxbA9qhDq3AEx+JOIybnx
         thHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410459; x=1781015259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eCyit+MYNey9T5qQgf6spNYkow7XxVLTYJAiVVbCmNE=;
        b=oKOL8/Qivr3oCyzc+5NgkukU+yxiN7nD8YxF7sbOi7vAZv4DM6kEC+k4w4M9fG/qrL
         X6/lzGw6snMZBBIP5IVNZUrZl0qF5utuFGbMCWt4yob9UGHWEOrOsT1jHn6nfNyQXsdZ
         U5jY6ZVFBIoH52CoQJpiW5X64N9pCZDRtw4aCP0B9/h5bleZ2VK6XmyYQbPzXRyhKRSd
         d1faxH5tZg7taot+rCqyzAY0435gTdmoWPLizbvavKUeQdEFCSPK0hSE/JcyCPdZrSqc
         t6qVoSZnXExkKDtIGHh936/6dsFH+K21NzlJer5ftObox6IIq3lSEyR6EFvaQvEp5n2b
         /KDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Y96OPoaDT9eqpaFCOkZJqOMEtsil+APocTsyvxNefM1L4zWY95EWg2XkKxlDSBSoTiHmsOI8e5QuZedkcXl0G@vger.kernel.org
X-Gm-Message-State: AOJu0YwuI+6CV22pnzaL65rSbe/x6GdEC3Xc3RP481rszQ+Qs02+nVBf
	vX2PZKh90ALo8sQDWXarpOvUh4rpuBlQMWqlNBx0eSNRkT0tTyULUjZDekF6b1hUgPc=
X-Gm-Gg: Acq92OFPeXD+7DGbYWpjp/ILGrMTOMVjXNFZ9pk6l71YWvmR2LFzOx8LjKdpZJ4M97V
	MKI401Gagd10C6gRD1hD8NIu+TW2TjbtnKBqBCLu5+quIEZ4QiecTG3p5NTGKrOL58PX52pxV5H
	wrVpXXWpcFWw2b2oW1r8KGha7uR64ILZOL13kBKTwsdWCF5CTgY6Q9WpqGBG6TAzcIUdOZKEa/u
	936B4aueUPZUt5iaCIWMkv38x605b5p0cAg/RQ2EA6ZexM5MoygTdTDRbgxrqrLSQgGeV4Tcaky
	dDmBkNf5BWBQyPNAdk4M0zMiE7VVkvizOPRiu+zJfyyPc2b8HW84suG5aUb1A/XNUF55p1Ul9pi
	LLOcqoaGuYlY7BGXKMalkU484HuQmlA0vefw9R3BHsfLlCd6djZDd2+ocPioyDqGMSdMpsaomcV
	l5XngZ1Qkl/3D1Rv+ab7s6QRThKt22yxTtxRPRqC/xjw8=
X-Received: by 2002:a05:600d:6447:10b0:490:5000:917 with SMTP id 5b1f17b1804b1-490b0e373acmr50037565e9.1.1780410458901;
        Tue, 02 Jun 2026 07:27:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:27:00 +0100
Subject: [PATCH v2 18/18] perf test cs-etm: Move existing tests to
 coresight folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-18-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
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
index 2a400fd38a36..b196aab709f8 100755
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

