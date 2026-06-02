Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C224218A9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410461; cv=none; b=jK+r1ML3qxPkYkMOJrgicNc5CH5POiRamaUY01qQ9HKCq8koUzpJ5k/9rbQI/XDmx8bfUt6HvvIlJaSJHpxokJJ0gD9NIfPo8Bw+3PBJ5/S5+wcBbF1KKplnOs/gy6rU3H/Qe3xy7699uhd1U1sY5R+q21lj0Uu85jbr4Fm9UsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410461; c=relaxed/simple;
	bh=8LSDPEyYFg9oEMScO6e3DlP1X0ZKaHJzrU3+/imMTps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2ddIKpx8Dr0GZaMqt78nQyolT6iGnClDseN57vUclGU08r7T0fLpAXYtkzvh0k6r87oIsrtslIZBLp4RJHNm8qulwjDpDA0mhr5uqllc34dU0Ruv6yU8YQkbPI5UDTs11ZQPfZBJGyctX3WKWEj81jr8JK+vtVCiLJigTNqTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NiDViISC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiDViISC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so104341105e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410458; x=1781015258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CFsmZwqnn6DMPD7vsYdcccNw39lngm7NfIBTUlMynk=;
        b=NiDViISC1seieV876LAYXrFV4TMVt7QMcKRLyV7i68SfIg14S7peg5WG3INzCzhfa7
         IJHtsM6+wjm82Lt6Tbw9t/JV2K+ohhNTpel2OiSX9KIan8dl9adqOPRAXI7qgguUNiK0
         PlD5RmVnInEjSOInaNNq3H80wJc2C7xlxCLJajdS4pmRnmGZxcX+jaV2Us3X7lk1Yv1b
         YQWk2ZutnFRAq/YIPzssz3zTM7ZezhWcPI8KfKsFQMsl7H9z4013+gXITAGtnKwUuji2
         Y4QmCg0AhQJVGjva3oJJzmrWrRPH+ai9vz+qzt9yV6VWZxhQxTjtxAXIN8awHNpKJPhN
         UHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410458; x=1781015258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CFsmZwqnn6DMPD7vsYdcccNw39lngm7NfIBTUlMynk=;
        b=n21DirRtQJjmfoe65TtREWQSVcQ1lKDGj8wcSmUS+P4WbwDhJ8RpGZr2diFQxbB1R4
         NY4hEPuFAD+GMaYnS2vSeABTN42rqk+DNfnEX5jpw6GKWkzPRV1BfohgqNDWkKpcBMSX
         3RCvqhmLpg/p9pMixgTJpXLvd0Xa6pITFejDIf7tICIFXZAmCkKvGEtCybkd0GC/dLEK
         L1jBrBQAPDyV3ovd0cUX/Wt1e6k+0pySsXCIrUi/KULb1DCkigVj3Paw9ReBD9Rnc99p
         uFGo9vOU+I4GOEyoa/fpb9oAMB62aWkWHE91HexzPb+Rues33IPZCu+vKs+JJBDsa0+s
         Ldgw==
X-Forwarded-Encrypted: i=1; AFNElJ84QjspLtcc8GI62u80yTRiSwPKPlsFqwfGf/77dBLnGaEydlCOtJw7KnVH/dVBxJSbIq0qYbKq/trziq6EJ/aY@vger.kernel.org
X-Gm-Message-State: AOJu0YytTewwzJ5OfuRhqBzlhybdS1v0XV5lIM0C7DqP9N4GeaX/6VKK
	mFKufXV8T/4ICzT+an/xMl1gBQWVHtlAuyLldjE12F0NsUONXSBK9BkQ4LxziShvhrM=
X-Gm-Gg: Acq92OEwNFKLnBH0K+g9ezfyUjdEqr78n4KtAAT+8BiMD+lphK2FIcbCdEc1Aowtpk7
	/hFAsLvZGT84r5T0bskVbVUqroZ+DxCqvzNUhdoE98U6JUAiwjf9rKJuGGEILy+PhZ28OliOBA7
	yhqfPa2+WtiCL6K20c9CHTC5A2OH+xINCz/anoF9ylqetg5AGKRS4cbjZCxDp+ZFhrh5dYI915H
	FaWExGl/DQBx2099g5uZN8s/ebeRDAy8l4G/0bXEL02z8n81GPrWZpn6+kdmE6OwZAfb9dG42FS
	4GiOk84HSJBjgbdSe6K92X6eh47K4pE7NmB3cuD6MB67dQH/UACC/lSUTcp3h4CT0yXmy1pnzST
	lJ2xANA3k6LuU45SJn7hUL5Aqb+Uj+2OQt2A3ogZSKhqPrOk4cLQduHAcZPJ854/8H20Bm3KsUm
	1rbqm4YXSQDqo8IBA68wGmfQJU7AL81Fm6nGbf94omXWs=
X-Received: by 2002:a05:600d:4453:10b0:490:6869:ef13 with SMTP id 5b1f17b1804b1-490a2918e9fmr208222895e9.14.1780410457984;
        Tue, 02 Jun 2026 07:27:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:59 +0100
Subject: [PATCH v2 17/18] perf test cs-etm: Speed up disassembly test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-17-85b5ce6f55c6@linaro.org>
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

We can use exit snapshot to limit the amount of trace to decode here
too. Also each call to objdump is quite expensive on kcore so limit it
to 2 samples instead of 30. We only want to see if there is no data at
all.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight_disasm.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index 5ee87eb7973e..2a400fd38a36 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -43,9 +43,9 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
 ## Test kernel ##
 if [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
-	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
+	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} -s python:${script_path} -- \
-		-d --stop-sample=30 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
+		-d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
@@ -55,9 +55,9 @@ fi
 
 ## Test user ##
 echo "Testing userspace disassembly"
-perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
+perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
 perf script -i ${perfdata} -s python:${script_path} -- \
-	-d --stop-sample=30 2> /dev/null > ${file}
+	-d --stop-sample=2 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
 

-- 
2.34.1

