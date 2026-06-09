Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DA43C05F
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015508; cv=none; b=WYM7M+tnSWnUllVA2EBiJ9bAqPVxSHXE3DrrR8s9AsUfGZaiDFShKs9tBGTvR1Lm0f+BbGbcTarPRi0UvFIpOIzvG1b4Pz27g5P1WQeK2KbfctRnvi/zkELI5RdLRY0VYt25nHWuASf4n57+8LQCusr7ixf4gsiSQOlFTfo8tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015508; c=relaxed/simple;
	bh=6om1sNi+g28w6gz9Rvlzv8I2HBpgV5uEGqJP16w3z5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhVMh9VHPKkOtfMO+ASNq0YZ4XXxl9fsknyCtPXfKJrmvRndR0Lhz9RJ96dCHF20MqK/m+cK/v4z2WwpGf3NfAC96ofsqMnvF26EBLj70d8ebURoa5OdQhy/YoZITleuPZCZzpcyWwgRpVIiJ+yeLT6uCoCjApWA5RBfEpJiX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPVsdbSl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPVsdbSl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso44466715e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015505; x=1781620305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf9ynHBKvgH06k0u+j7iXyYQLRwSGMTUy1wnSW+2ToM=;
        b=rPVsdbSlordoDzz4dJC0m/hS9iHu0YT1qIwqFNELm5et07sTg9ned4voIE+qWCwk35
         33Rkj59Hl7RX95gWU617Ot6zgAl6M+sIUCurWKDG3uZgtDvgBDs4wJ70mrzsEv/wkC8L
         tXUpXOwenRaNkUFoQClN8hC3krWACRlBAQMMg3K0yAMmA6EmL7waPMFlBxkC5fyEjst+
         YHLcGcMnvZs1/gZpAuw53qGUfrL+g3xpEufPsd3/kYzk21RuRmqFNztIwDSBggGjUX5H
         BpjouZRKtsvFYF15EG6Z5KwVV/vceT5DP+jqj+giWCFoAU/ThPcNBF5POZTW8PafV/9A
         vjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015505; x=1781620305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gf9ynHBKvgH06k0u+j7iXyYQLRwSGMTUy1wnSW+2ToM=;
        b=i/cJWRWFWUwlnI6o2XcoVEdGqNWkMj3lbVfdPs8W3R62ssSLkRpP7Ls4s+QM+lxa24
         1deaBK+MCFslwiJwjX4yv5OInWU9LYPltF4QTk7USBjqZRtLYw7cKd87yqXU/sy5Xtjz
         6tBZFM+auTAkXc/R8MaubLlvJrFw1znU73kUt3e+Y0l4yjrjiCMDkg9D0cIzTCSU0jXs
         wLTHMHylXQzkpJZX0+aNDcLG47atOfQe7E+uyl9MGQvDm9n3YRs5hLeA6Zw1qP9Bd4ud
         nYHvuv1E2JqtMNK3oF52m339nFmyJmrqOFAWObCx9QtoY7bjIBI2xRguR0vvPnksbKl0
         bLmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PwVsBWSYM8NjBTncyZmujYgJIqqXOtiA+Ru+gawEMNmJ0q0wNbRIbDm4r/BVb0+juTl7optc8M8HcZDVItAk4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NQYfNF4m12QGhXfveDd3XAaDDeLG3nRBXGlMUiW3Z6zolbJL
	npE8Bs33ahvurJ8cbkPAuY4zU8C2BUYeHSIcNCD5maKnrYHgnoMRMo4Gi8gm6hM1rSs=
X-Gm-Gg: Acq92OF+5pyCS/L3kECSqGO2SZAE/kDXhYuq2T2m7tokhy33Fd2iWXD9m/W/u5/59oo
	azkuhBKtNNUmQmqOCb/V6+vnoMaQyuafA7ChcVYFtNLmwrAC9n/3AL0Wxs8rpgggNkX6X4OXq+Z
	feL5VmKaNlguehix33SMHRZY3nXV/m8ySlfC8tfJyLClsVTCAnfoMhGvfyzbVLmrvGCBE+6CLny
	reAVEiQ1Q1ZHVbpns47OFDI1uNZm+o2FqIv8YTZxmX8kCkzyaZjk97wArmspOy/xbrd34ISaSoz
	SXOzX0JntjhhlCxjJaRCH5/wwVvq0T+zb/MZLxD0Q8BEiAKbgswqcs4A47ZT3GMJgsO53vzZsN2
	NOSr7bMey1hrjoA85l/w3bJVfuVmKZnNS9Wc53QWAmUXJLn9M0muo0A+rreqJIQJj6H9tAstVtl
	AcbOIhzlJmssnryDTv7SQvOzoVuNZElJy5VHVtlsBEnOE=
X-Received: by 2002:a05:600d:15a:20b0:490:b58f:4d65 with SMTP id 5b1f17b1804b1-490c2d1fbefmr199528435e9.15.1781015505479;
        Tue, 09 Jun 2026 07:31:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:12 +0100
Subject: [PATCH v4 19/19] perf test cs-etm: Move existing tests to
 coresight folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-19-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
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

