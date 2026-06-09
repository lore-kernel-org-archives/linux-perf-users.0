Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B97438FFE
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016050; cv=none; b=uWv6/lJGZbH41Nc9Qd1K8mlqIILfMmdVWtYxIXuhnpp/Z8LCsRNxa2FVYk+6uhzjqY8Ix15ecImW6hUq9iJlnNBwzOTaItwnz9jHBUcAL4XTflgAKaElQ2/x7es8/H+ofPCwc5qxol4O+dJSnMF9r+gsYlmSa4bKYkaMAR/3ze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016050; c=relaxed/simple;
	bh=wObRJmm3gTlf7wqz3XGbcKcAk4UU+DK+eJvukw9px/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyYA70epnxEYom4BEYbws94wqj7EQu74aqYGPjIKlOmxL9V80NSqFoJa9+/hR2OeSlRGi//1CFWk39NdiYaiSX4VMNIPPrjOqwSHkixdoZV9J6z/NsMiwOMTuHONYtAO4JhtIWA4tQKjzbQWgNE1zIvd/Qpt8p9rgMgzUKTBSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F04zP6Oq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F04zP6Oq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so49452935e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016047; x=1781620847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdUeDLTBd8NbSbxSGmF6PVOlpVLflZ1t9lCb20G1ZuE=;
        b=F04zP6OqT2e5wpfuCvsodg+W7RQc73XZPImtr5g9uCrGpBRNvhq7r7ajRrkr6aQLt8
         oyMsLCZLPcK3SbnYwsvj6gYXT/YaHmv2H91tGr/Lcry+5/lleAW0W4sSz8jUUHrkRl5g
         OIfxIRn14UV162xelR9odKtWj3vnFkA9Qnu5ZaLLghtJT0/SdHAMxbYFq/jTn5wqP9pf
         EbQgPTlzEUEqJSR0sNhjuWT7AgEiTIHPSE1YQmrKDSeOWivS+GJaIP01Auok2qHiMHvb
         2WnknxQOAlH4+tA2Pwr/IvYNFPsADuzXWiMyxiq+qWpArSvbeRivH+2QmEoNnYjSpoxv
         c5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016047; x=1781620847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VdUeDLTBd8NbSbxSGmF6PVOlpVLflZ1t9lCb20G1ZuE=;
        b=oJfp310LehcizaBuek9IjxlWNZ3yef3uaQWdsb3I7WAPr+A5If0g49m2PYsyUJiB1p
         Lv1U3V8xoEKfmsKcxlEJMAzsl87tyBxEtXpIS2OsuuTTC3xRlQqBrY+3YTHWFs29UTGJ
         Sz6GhBEZSNdR3pVaJzJt2hmOItBnTCyIQ3/RXS2uvQXUWTFjOAJuXHLkHVk2xVBWUBEe
         amf8zwagOxSstTxQGXqo9wm6XkjhhKDD8NwHOEO5FYX78Ian+DSIL5AobBHrXXpXhufW
         7o2fkZRG5YgnyQ6p1JgikgSCIgeKmjA0BVSJP4vN5RA8F16+BP2oW9/qdqyZ6h/sQeaD
         b5lg==
X-Forwarded-Encrypted: i=1; AFNElJ/NsDrC31Cn95eyCTYdBDJtHThEHtZb80xse3sxaSLxIdSgP36smwTLJ17z6B+/rI2JkEYtDANebZElwVhH7BW/@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0JoXV7kYRROC2A/Em0VNjDWfrg+vTIQS5mmcjMDMh+pqt8X8
	mqUYggjqODkIzykqpHf6zHyIirqdoECQOlC64NIEFW5LIMfbtLbK5bmujlK1JNmX+xk=
X-Gm-Gg: Acq92OH51ItQQjEX+a49NLgxzTEO7MFuoiAhWU5Z8+0vaUlf6ZwNGoV4T8T0gKn2KDU
	b1/B2OLuPRhkzS0y6RXL3WGA+oa/XkZIgfBSG9cBrO17lA0InGaJbBvdUHQQ/NCI4h4XgZTjzNU
	PpXCJO1Nlv7MSzQ9F3X3Isbie+8JupPFyEFoj0ruOnhzivrKsJ9BtEBaF+wA6ARoh5rMIJsZHXW
	lCe+tKL/NTO79oqZDhEy6D+VYJxNiavu8BLIkXcjBiaeAIhgpQjlQhaiVf7FRBqsJzrpZ9Vumfl
	knMf+g1CDaUuMocgCect8yXb5Rdv1blkwCnvzB4VdX2VJ9/QP5rUhyY+yLLNw5MMXoyf0SjAl4D
	Rkb9puRq7jaGm47dY7fEygKuAcGb1Dlmt44X5upQUCC/LGN2gnGNXJ1jiFFrXgUYKAwLIkLQHYs
	Sqax5ODjUX/DFrXdcdM+ABOiae45QHzq7OZLHRrNZq7m8=
X-Received: by 2002:a05:600c:529b:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490c2625f9bmr306873925e9.31.1781016047377;
        Tue, 09 Jun 2026 07:40:47 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:22 +0100
Subject: [PATCH v5 17/19] perf test cs-etm: Add all branch instructions to
 test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-17-d53a7d096a19@linaro.org>
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

If we reduce the number of samples searched to speed up the test, then
there will be less chance of hitting one of these branches. Extend the
regex to cover all branches so the test will always pass.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight_disasm.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index 87797d239f76..f78dfb6bf73e 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -38,8 +38,7 @@ cleanup_files()
 trap cleanup_files EXIT TERM INT
 
 # Ranges start and end on branches, so check for some likely branch instructions
-sep="\s\|\s"
-branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
+branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al))?|br|blr|ret|cbz|cbnz|tbz|tbnz|svc|eret)([[:space:]]|$)'
 
 ## Test kernel ##
 if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
@@ -47,7 +46,7 @@ if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} -s python:${script_path} -- \
 		-d --stop-sample=30 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
-	grep -q -e ${branch_search} ${file}
+	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
 	# Root and kcore are required for correct kernel decode due to runtime code patching
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

