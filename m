Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AF466B58
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481866; cv=none; b=WTpkNkORwCkouX6esJZF3Pmb9SVkdysJVFNp0OVptOFiN0si1LM9i0IP+zQTPsC2frxsD28d3pQAphWLkPcU0USSMoSGXy+E6iMEwV9WJzoKeZvEGyIkpQ6gkqM3cY2c3XbwJKMOP4hiOOzBd7rKfFZ2ZJ8TOjCtTTxY1v/S0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481866; c=relaxed/simple;
	bh=UqUTcZlsYRMZ7HrUOPVdOIyjHND7lnBLRlj9pGTngF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bydcKJRwqIikpFdtaxtH4Ie9VYCFdTaDnNsbp8ETsOGUOV2bjGf/hNASgpABuhUfuFIQ9A/ltYg75404x++aY2gUtFMWUL/aeNoSJHgyiWGbtyPwgE/K9NJi0FxoncfyQG3z/zmQDvHZaYMBg5Kkb+e975P64TQMaQv1vA+D+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0Wlt+RP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0Wlt+RP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490afc47455so12581925e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481862; x=1781086662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCyit+MYNey9T5qQgf6spNYkow7XxVLTYJAiVVbCmNE=;
        b=i0Wlt+RPcv44qhtF5udBvR8aHl6ithT7E5Mny7TyZAELaBbygssmh0taH+i/OYHja6
         q/KpjtdsIRuXHERpimbuHLGQxE3ZP/c52GjM1UZZi5yeJOgTicoVh/pPHkH6mK80h4IV
         e3suAomkmYzwkNzmUaEqgX2j2GLLjs0BuGAf97ibu6s6JeN+H7I1q8uHLB/v3q6FqdjZ
         J9B9RSq+fgps6rzJ5gpXLdTdXbbJ0dsd1h026TuvyIdOVqqPQ3GiRwiE7Vwmv9vGnFek
         adBK8bKbPOE4dwePGotL7I7fmFYJIrMAIJ0FTftxGaCNfDwdzhJAviuJAq8ILYF++Sfq
         zFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481862; x=1781086662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eCyit+MYNey9T5qQgf6spNYkow7XxVLTYJAiVVbCmNE=;
        b=qp8kD/19kJ5uX4eyLiYsFshawnLjnM+tkZaHmbOclKwhQ87VBTuvE7UNFGnj+PgbZt
         wNcirwm1OhkxFwzCq27zvt8TnBI6hXveCEEydzL+Ryw1XVv/58v1LvmQI4ak/IoH+qi7
         zWWqE3kAoLYef2FJPrnoy6hjzS2X6avEM0Gkrn48N/UdrFzbPkNH0BKpsJpnMIgSf3HH
         Khh+TZqgQzVXUQZIBhQnwN1IikhcOhSAgxFqANXVt6SUM7BOrdDMO9RBVCWm+o+ODpay
         /oQEJVgb0XmmEJ1UG6aEsARuhe5fzoKq/izIqvr0iso+NoZSic5IPepDenOGKI6XpI/S
         Qqvg==
X-Forwarded-Encrypted: i=1; AFNElJ94o5Cqzc2fvYEpj9Nh0c3RreyIA8aIST0FwJG42SSCEbWV/XRyeeohdiPwoCIFNHif0MGSjMRXmtB6GAt+/oUW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ifZJcCNbF1yvP7nM8612W0vPavp7tGIH00SycufS6UKeQaqX
	o88U95Am10YdVs7lxkpO+CbG15tjLbIwdUfLqNoY2jKIkreRrZ86n8qET8oulneyoBQ=
X-Gm-Gg: Acq92OFAuuTiueRPSLIWucE2zs2R3cofzNbsYfS18T+/QGTf33To+rwCBDQ9HXz68bv
	DTrKVVcVcteh5X8GJh9NTjII0znKObZIUqfG2J29Fc1E+QncAtJQTgwx8MScu454H/P5TjhMZJi
	41HA4LpWHzlcbd3Os/q3YUU+Ov73sTDjz4XI2x0OZeMloo3ER7OOtcsDVE35EVcPDGoDOo2cch4
	sQFP1jN62MSkxoOGQ1Nn70qgDLZ1khqa4+EUqbccNdUXWkMX/QHrDyNSmid6NvPL5WsKgQ5YWTX
	z2/Cz9Qr+B2skqQN83vcp8u58BbP9FsriC6fJfSIbM8i7kjLj5H0cFxTInIiSk3qmxqbU8Z5Ty+
	Nx+1+8f4tcYDMLkD+ec2fbL3XBFWnNkZHWMSesm8+bDLpYkEziE2O/2JHnihaA0q+1vE7767O/I
	uKd+mptWjIZZ6Cl1gg1xFZP+J/hA8LICvMtH0JyyO/wX4=
X-Received: by 2002:a05:600c:1c1e:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-490b5ed1318mr45363175e9.21.1780481862441;
        Wed, 03 Jun 2026 03:17:42 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:23 +0100
Subject: [PATCH v3 19/19] perf test cs-etm: Move existing tests to
 coresight folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-19-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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

