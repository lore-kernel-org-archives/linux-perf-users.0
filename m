Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C1425CC0
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410461; cv=none; b=X0rU1/YxyH9tWgOn9Bq3iZwScYgjj0KcSLk9iDz5dxy0xjaa5C2RxqQ4Tp3XJEqt6P0yjQsiRRoEzz1+sCYvKbriHNS32e2txCtdFlMrtWJXpm5QFuSIZ64D+7RmuiJJUBdTY2JkxpzaC9KYSmN5rm3j12Vr15RcoifHotAdZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410461; c=relaxed/simple;
	bh=kiF2OTFMHPFSfKgoJlJ6LUHEtfynLX2Gc37z45ui+yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dD+FA+F2CcszxBSejsHVfQKszq7BFdhiretnRFjemwOi2N0CDgoMSEuXlX27LvAnT+enk211QDV7dAOJwTUrIGhe9NyZ7e+9LFf0Srp3biC0ZY+VJpdjQ61SgIs74GfUpmMoD1nDYQa3kUDmAqoGzeNFq89g6w9sPfdlKh9UdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jv7gnym1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jv7gnym1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a765d410so29461165e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410457; x=1781015257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlDlLwXjKsadrJWN67gG6GxzbQU2KCIjPSaxtLGJjnQ=;
        b=Jv7gnym1U4iKfN6BE4yjZ1BtzxIQux3BD2TmtuxpQvnPCGc5RKaqLE6KenwzNiJbLw
         2U+cAMnO8UMHbxDwC4kllfMoqFLk8kAj65La/lpSqUQEXl/wnZRmmm7dIdZXHQzrqNiZ
         tXw9BfaA7tbOghNLkxBJwdB3jc8gSP4C/CwfTOntI5wS1Xww3DZnrpIT7kpC9Vj4iyp5
         vhLVUe+ceFWEuFUk4r9eXBYcnyD2hDqcVxz2m0u8RTAakFiU2M7xxGTUm50koPWo9g7x
         rgRjZJG71DirmxCv7NKDpuo4UnZ+paTUbgBA2uVGBNqrohS1OMincuTdKwgy+JQ9YsYi
         cL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410457; x=1781015257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlDlLwXjKsadrJWN67gG6GxzbQU2KCIjPSaxtLGJjnQ=;
        b=TuGFV6kMrxO1Mj9wk27rjVV4Nn9K3zORr1ERhFFxaxArSIcJDCt0bhU6AD6u7AbaQN
         xf5qK9Fjk+OzXu8sY6XgDUVg4oa9r2XIwE3mg6M/Smv/kIYrfHkAfTPJEqyYUanwkG0n
         imTt+OW3wZLhsoML2BIUjon0b+FZw+mtaand3HGwWCkagkwWq5V9Vtu6u2nonfSqx8rm
         x6vjzQs0sK5I8LcUFHWWbpMcTjZQ8wJSGqTbaLxjThrsmsax2pQuS6atpFnnhZ3GOBVD
         ylFRu18XoKOOMLwGPfiYB3Ja1oRJA2hZhGKHlcAHRIuuhaF1+3pE3EAPOxPPgbq1ErIA
         POHg==
X-Forwarded-Encrypted: i=1; AFNElJ9ubHcNph2bO+bo/BVbJiI0PBhpnRZoXVD6zvhvuJZRbmtdLLg3yMk98CXexArOqLW8IjVTHm7Pj9h42ixtbZ+W@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6L2guil4BM6+3FGLLXKf7YzkuWI7qoUetVFLG+6VJDpTfWlhf
	1TWsHYtY0yo7sbkZZ2GgpAxhwDD14yok17Tg/vGBmPCTXqX1Ld+z8r0dnDT7CpRcPYk=
X-Gm-Gg: Acq92OHPddjgHvIZtqLMnh7SbBF+4JCEku/gCUIoU6iso24859G2lpv1xGqdOFMDaID
	ngHj6fBcQws34dz+ObTaslJr+ki/17ssZljUWyv/4h0GovUH7YqCJLArppnmx94w1Setipvj/KH
	o9a3ZjP5GiFPsmV42OkeoWRwg786o82VIUW5vHY1Y8JatAHPpwnoA1HXdqOm5/mVKzvpC2b+ywg
	6VoysbW8XhMXA852Dcj6BGvhCG5qpO3KWB9NGFFYKDFLlRXrYM7dxNZq2ObBjxH/s5C3EZt67iH
	TVdWieTRgpcclh/htQ0aT7wPnJV6gJjnTmO1sIvSELQ8E2d1cBVDgEusgSpbN8KK7Jc6SgSIxNC
	UXFwf+0mHuGxwVgSchJCJ4SMRKlCOzzerRe1R1ecvyCJp2FaSjjwsryblmNrJ1ua2K6rlLZrall
	c6RAZ+/JjAkIDsPxge4eKN51Q1TLM4EvXSv844gl4iWCo=
X-Received: by 2002:a05:600c:c11c:b0:490:4663:691b with SMTP id 5b1f17b1804b1-490a2923a3bmr241787255e9.7.1780410457017;
        Tue, 02 Jun 2026 07:27:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:58 +0100
Subject: [PATCH v2 16/18] perf test cs-etm: Add all branch instructions to
 test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-16-85b5ce6f55c6@linaro.org>
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

