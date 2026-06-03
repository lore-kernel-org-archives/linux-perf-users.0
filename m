Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B545BD6C
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481864; cv=none; b=mkoiaG2+3mV9K8GA/Gux0+sav0iFjABa+Gw8qtcXB+bEL0CrTGdmol5LRXyd6v3g0jrjh7lQ3nsaOw7tL7/fvdDWEVVApY9Uz+iKs0gX6tS9vPrYRD6tAMmml2/b9pMVieFhVZd3eULx8tOBGaFx4olqXyP2VyUaLGwdvRTwlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481864; c=relaxed/simple;
	bh=kiF2OTFMHPFSfKgoJlJ6LUHEtfynLX2Gc37z45ui+yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+4JrldLFCgKd2Omu9OI5YhDpfw21PfQrphfihqSTPVLFI9RCaewz91D/i2sE+tIfdc12AlApNUCcQVIzi12Uy67tL14CoDzJTwp95IOCP35aWQ/ZX8cbgGh6MFH7z9VOilTCxPoRs9XlrzA0lhjzFgfUDV5SKPAu2jKMP2Z/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQTVNg7z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQTVNg7z"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so114315535e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481860; x=1781086660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlDlLwXjKsadrJWN67gG6GxzbQU2KCIjPSaxtLGJjnQ=;
        b=vQTVNg7zStkvZtjOEzfnPUZbwL4C0rRgvMgi05qRx18yWEItjWOvVZdTqukQfZpgxc
         K19U0Juqq8GZVBTajnkoFI6VWoTL5kealx5w80UzjG8c5t+pyJEbJZ5m/ijhuSWOc0/s
         vidD+ViK4kZyhAuHeH+lzYmvGpGxzSkRgFKuO8tHEnnFCZ4K+wQFwbClXBFg/yiMPKhA
         V3lEvoLoo3gBG8QyTsQkd8LEObYCbvjmVDB2Aa9Z1uMDoHlievme8veeKMpgwj/t22th
         S9nxDecgQ5oY7JOpxFUP9nHcvHJ3Y8/mZbOJNJKDHHA0JrmjZuURn29aL7FVbmUc0oTv
         mG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481860; x=1781086660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlDlLwXjKsadrJWN67gG6GxzbQU2KCIjPSaxtLGJjnQ=;
        b=L961AeMJgUYP0aztJ+U8bLtNRutnQ+0Ws7SIULPuTeFcuSmY+FmcAUW9wwKgvKOQ0L
         o+1Ck6BOGUMYrTQKyT4Gs904OrXPTaVu8He8plsDryOgWDgooW7PipAyoKHepa7s+7ai
         HvYkwFQGn6Qecc7zJ1kFk/XcOjkynwqKJa9bg9pPUBdho0jdTzw13wUiHyaDuDxgcJbv
         HMUDKVK9CDCvMKzCcqPK3yEBFA/8YgKI7AToLT7yC5uqDwa9z7RXL8BNPbpwzF08b1dK
         aC0gLdRcfjAS4HluAG0V+NXRiYgK9/ck9XCXAVM96MYmIpAn4+Z0z5Q26R6PlsuaC2it
         DRsw==
X-Forwarded-Encrypted: i=1; AFNElJ+gjnAZ+Th/PK44YctBXUrf7oTqSNb5JoeEhQaEq9DJk3E7VwO60QmJHm2yJNKIEOFpOPr/x3U35WpLoHlBreGU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn99g6ZeqplrUcZ9ZgukbDwl9/sLPc+ldH93Xcy2IpQP9NThm/
	Oce3Wel7PNAYl4Wy+URa+Q2IGuMDKdBMr4/KL9ISEq/TAmmx1BTRcUOinGko7u8brIc=
X-Gm-Gg: Acq92OFqiCFJTcQa9c6oI9H9h3a03AxcF9JG2+0UKBgThPH6eGId1rXiu8aqwo62rTG
	aSoq32fSWwzwscgwRmYo3ArCWkcIBOD0lrq3t+inigI8gbV8dXWFNxaY+nmKIkDzkYz80yawuZB
	B9ne+5f0fEqBipgvhcRgKMLOJWlsmWyT3MZAcxxjiefwFh7Og+JlqmsQ+bL/4BA3TixYkgPZ7jt
	SalTE3F8ljXgus3T1F26O+iU39be4s74sC1VTlekzcq7jJ2imtLiY6LjIDIdTv3xevtA0TrWYXw
	2Ivr1Ez7v6mxjn24f7p4UpUAiB9Z84W/w/USnp1dS4AwAicEbp5+Dhyb+9z91epK9jjSq4fKQkj
	LIFc4djos6HTQ88eWTq0yU9UJ/S/3viLqrwrELQ9jt0XFWxfnl0u60UrXzghKWNXjB1OyolQyeK
	xjX9WFXpuawnBSlk0ip/KIqiu8ilJL0uYbfAIbcJNE7CU=
X-Received: by 2002:a05:600c:1c13:b0:490:b642:ce29 with SMTP id 5b1f17b1804b1-490b642cea1mr43638275e9.8.1780481860386;
        Wed, 03 Jun 2026 03:17:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:21 +0100
Subject: [PATCH v3 17/19] perf test cs-etm: Add all branch instructions to
 test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-17-c392945d9ed5@linaro.org>
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

If we reduce the number of samples searched to speed up the test, then
there will be less chance of hitting one of these branches. Extend the
regex to cover all branches so the test will always pass.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight_disasm.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index 8b5c60a09012..5ee87eb7973e 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -38,8 +38,7 @@ cleanup_files()
 trap cleanup_files EXIT TERM INT
 
 # Ranges start and end on branches, so check for some likely branch instructions
-sep="\s\|\s"
-branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
+branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al))?|br|blr|ret|cbz|cbnz|tbz|tbnz|svc|eret)([[:space:]]|$)'
 
 ## Test kernel ##
 if [ -e /proc/kcore ]; then
@@ -47,7 +46,7 @@ if [ -e /proc/kcore ]; then
 	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} -s python:${script_path} -- \
 		-d --stop-sample=30 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
-	grep -q -e ${branch_search} ${file}
+	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
 	# kcore is required for correct kernel decode due to runtime code patching
@@ -59,7 +58,7 @@ echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
 perf script -i ${perfdata} -s python:${script_path} -- \
 	-d --stop-sample=30 2> /dev/null > ${file}
-grep -q -e ${branch_search} ${file}
+grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
 
 glb_err=0

-- 
2.34.1

