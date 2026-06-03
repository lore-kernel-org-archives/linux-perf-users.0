Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D04657E0
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481865; cv=none; b=MyqWiBLoQvLjqP9jeFe8Wdi3cFUwT1bFAQ2EUtJ+1f4R/PAVUpu3xwX1jQz9WmpdtAW7wql7vX4jw91n/CMOkPVnlUcpbQmsENRf8nep7Bju6kdU6h6xNfYBXePOkXXHvEbGJdGkVNQ5E+G8OozOlOi08L5Mcg96yBq4hIdUudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481865; c=relaxed/simple;
	bh=8LSDPEyYFg9oEMScO6e3DlP1X0ZKaHJzrU3+/imMTps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqQ1ALUA8omvjNDxrkuewn2Eng7s3/OKgdp2uqDTh2oqYco2BjgJYDc1SjCL5E4qHYhBYkq8KH+d6hUPfJnkUhuGAmnrp5UCXuBbgO2ymmSJszAsjbxBSbuyMlBNIJOR5+2mrJ0QoCS2SZsjVpZWDGoiQSX/XqjpXrACUBlf4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBpeRwd4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBpeRwd4"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef616daf6so5051762f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481861; x=1781086661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CFsmZwqnn6DMPD7vsYdcccNw39lngm7NfIBTUlMynk=;
        b=VBpeRwd45cPbckMGAt35t3w4Z4+6esStr2Fw4PW7/puLyiucuKIvGsWUWiVqz8LsKR
         sf9GBjab7BHwK7FU49oAEm/vlems9TxQ78Ho8QmgAbLZztcvD+7yOZw+1v/ZduXGKuNE
         0vOj3vkUrmZ30VnuoRXZwWIPnvacO6Qc2Z2wYFLmaY+zIXFN9QyxC29ypuzu30y7V163
         AE/2G9z0jhXxbI09DULYfJ/VDOhZJIK6cDUtFY7PGi3yRVvs01yjPftj7mFH70+xVE5W
         Varb3UUnQs0zzJezaCg+6f3bV7yFE79Ngzg2vDOW0pyA0yy2h2PIUvbsNcOaeRKy3/eE
         mA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481861; x=1781086661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CFsmZwqnn6DMPD7vsYdcccNw39lngm7NfIBTUlMynk=;
        b=YNfdYvm/UqGCpGjnm3/QfMMwxFgcuilKSnvfTVFzolSA7tXlyigagT5843fMCOxCcB
         9QqbSVpP1Ei5HH0mGbHKvGBRCXtgJtylf6JH3xPAjuNqIqJH1O+rJIdHpihiIJs7B6Oa
         pnlbCkYLCdfnGSKMb1wJdNgLvePT7u3i7HZtG1G+Agen4z8FF1N4KROrl4ebyJFPb5nF
         oVPVScxFtn9jrJv52Z62rrMYcHsxsTGTcxvOKSLJeO52AhIXP7fpbVgJg/PFZN1nNOUo
         fXaFtbKHAFnvlYO7TymAWz8VBL7UPf0Vbuv6IzjJ7j+LhvFrl6L/0OuNSPwZg9YkHsX/
         mcvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/FWdAlSM1bAQ6yMioRezyXCDR4CZBsiYLJ/CKLozDnvBJKNgKyhkUuzG1m+Aq7pdroE9GJ007c2/umOqpNtBL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpyu/kGP9WpCGWwm4kDZunVKyLZSYZNi9/FXkT/ZDppuDM5/Zk
	TmaCJx4aRhGcHbofirPrtolSOtVf/JIIsBlU0FrbbtN6schUPqPoKiRQVfell04j2Jc=
X-Gm-Gg: Acq92OFfib/UbTdjWjHReqT7LJngyrRU0WfUMgZ2/7JuiQ+1ugUMU4oDfHcabiLWn1g
	XnWI1nDhwRs53jngod/K5uy3ERNgB5pw8TRdcdG38Qm1hNvrjOsFsSIR7ArB1zY3Lz2TW3m5PM0
	4uxoofLTxHQJtI0dGFffDgAmGXVzj3DXTgYxO5f8msSCgUbasNi7rtjY1zAIc3rKo7D8Zj6Gjnz
	FDOQ/BwOG0gs+YgJWcmKVYBlRU5eECCxwa8CtiNk98NmEXYMxBdps62CzBTBe93wPhyRR8HfZ4M
	EmKj81mIgVKEHO3cYW8GzdVNFyoF2hw3P70e8wSBAtSao2NxA9ZD9BQXn6dK+kqwBeV66z9De1L
	W7roLZ55NGF6tr+BiVEcUtTxKr+zQFpUs3uyA8YIoSH1o8CLQPFGiL2gzA1hjpeBB69lE3UQ3fs
	kelHWk62+8ARXx7U/8jLOSCiuZvVLUqNVVRvIxMmKi8ew=
X-Received: by 2002:a05:600c:a311:b0:490:b724:dbe3 with SMTP id 5b1f17b1804b1-490b724ddb5mr31187235e9.8.1780481861383;
        Wed, 03 Jun 2026 03:17:41 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:22 +0100
Subject: [PATCH v3 18/19] perf test cs-etm: Speed up disassembly test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-18-c392945d9ed5@linaro.org>
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

