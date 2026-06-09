Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C934B1A7
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016046; cv=none; b=TbzQ4u8QAse8OrIYKqY6zuHBCKewb/MZM8G2lQ60pBxoyr1xxr8+WjkIbbyCgcKdh5M3+NYb4BGdvj3NS6sBk3LdUjAfulZFv/RKvx20zPuBSRMgLsZmhnIxXAziJny5UEOjwbq1vELlrgGD60RDa12xx0X9TViBkRPOCRTocK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016046; c=relaxed/simple;
	bh=FSMtqVRVy7D3pvypIs3gLf7OFxrFfmQrY4e2IbRbIqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dv41qiX6Cul8Zt6RpjhGftZ4OwXAfADSE98sNa+E6+2SE5VdzOXiq3rxEzLB8hDbrC+wV5FnAZIIYkNmcGcBKzBzIY1V2XrNoQvXg7SemVT+GWRrvv87m3jk3Xoyriu0Ftt1FblKG2IErsVgM6GMIqwAHQR+1PbdCQwqT6+lLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z53EiAEP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z53EiAEP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490a76757e5so36751565e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016043; x=1781620843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng7BXZAmfD6H6DnpoBma7BIsuVaWOeOAye3IPeJCbwg=;
        b=z53EiAEP14qyNAbzHYVk4LMZC23WNrFWujlu8v/9L+pEXX31BIN72EBlrDudaAOimC
         sig/ouiNGs8JU5BPUJAaLWaEUQzVCtICMR0fzHfjYoJRwApxVAqFChL9fci24TeDQJUs
         bG+dYAKniHeJPQxN8TLxTs5Eu2kTBgLGUBvvWpOC6vc1QTLwocihA7YGzY/SNpRDcDNz
         7sf+0DI2c7Wl0U9T03nQXovT7TzMIS6wdtphcN+nQZqxFQO1q+R05Ac3Sx/zZLrniPX2
         daZB5gnqUfxGNLyBQV6YGYTGnBd5b5cdxHeFKqE+ZM+fnxoUHthxsgTW8oF2U0lF3Thc
         YtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016043; x=1781620843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ng7BXZAmfD6H6DnpoBma7BIsuVaWOeOAye3IPeJCbwg=;
        b=FTywJiQROg1692HzwjQoLoNzvA6V2OX2EVOQ7ipqMc3F4cCuVteT6yi2/17zEL6gkD
         KM+4VjxSkkL/XfabBqcoZxMNlvU1TUbkvXsOnCRI73ty+mMzC1gTpezF/xUn5oSLHf8A
         l44dhC4eNC5jP57Wbuf4cDQnFADHPQJrfVPERAmg76M0OVeryk5a4+aQ6XqR2wbNL5GM
         M5Ji9RHzb0RUkVKQfat9EKzSjEXkd3kfMD+V9K69dkdeZQLCuqqpYx9d2ISbttzMUdCv
         j+Zh5mweOm/DOe6aew0DwHBm2/Xs7lZf9ocX3Zph/qDqyb+uoN7nihvWCi1tARxyIDqz
         lR4A==
X-Forwarded-Encrypted: i=1; AFNElJ+PbLE+lt6fWNO9DYvccQ1Szie/rVgclxjsHij9/2UcQbQp+peQwjpiyXAk16StqvQBOxNZYn+lXQxXCsF9OEQW@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNp18vDFP1v29qKtYlh8EHZhyKZUeKokhH2Wp51/cctZU589B
	rSFkOsV3T54lvpq2t7dFUg47oUCcorxGknEn5rsDJ6tuoG7ZcLUgjKIr0vHUoy7Dtm8=
X-Gm-Gg: Acq92OGhmSrD7V+x7YAz42PQAywiDpx1wfrrwuVuGlRddIQsuFM3jAXw/JIYBSzgDQ5
	kmZwEGVvGkaAWZUaTrSXAxbObRXjsrqY/cKbFEnnoTEWyyORMsq8mj6m5y9U0l/VzbwXddvGBUo
	yj+MNpcAFQXoX3zPA4LILwc5E39h1lUznrwa4l3XqkwjZSsWt7uGEMRkk81fNmjq2ygpP8Ngyqf
	wU34794GeV6mejIqg9JC73HROcikXhdu6qlCs8KmYz9pD6IIacnzFfwaytn/QJG8sVKoL83wxp8
	/+Ew6h6+FF7ZMERkhGTW5VZef9jRWPHiaVcF4ixNACbI/AmVxRnU3IyFZqU4aOb8g1MvJHaVq74
	Zk4vC0uWvGKiKIM6rTWr1D/sOaLfi/mAqNtY+3Z1lNpjMZ5h3hVR1f4m4YIpaxmDZvvLSYFUC7k
	JefcG/Gf4Cw4NbD9O4ebc/4+KRLdm0giZXIwbf22EGwas=
X-Received: by 2002:a05:600c:8b0d:b0:490:b9ce:a73c with SMTP id 5b1f17b1804b1-490c55662b1mr334065995e9.31.1781016043268;
        Tue, 09 Jun 2026 07:40:43 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:19 +0100
Subject: [PATCH v5 14/19] perf test cs-etm: Speed up basic test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-14-d53a7d096a19@linaro.org>
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

Like the name says, this should be the most basic test possible. Kernel
recording is slow and already has coverage on the systemwide test. Perf
report output also has coverage elsewhere. 'ls' also produces more trace
than 'true'.

We only want to test if the combination of recording options works at
all, so fix all of these things to make it as fast as possible.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index da2f599393e2..83295a8fe179 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -179,10 +179,9 @@ arm_cs_etm_snapshot_test() {
 
 arm_cs_etm_basic_test() {
 	echo "Recording trace with '$*'"
-	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
+	perf record -o ${perfdata} "$@" -- true > /dev/null 2>&1
 
-	perf_script_branch_samples ls &&
-	perf_report_instruction_samples ls
+	perf_script_branch_samples true
 
 	err=$?
 	arm_cs_report "CoreSight basic testing with '$*'" $err
@@ -246,12 +245,12 @@ arm_cs_etm_snapshot_test
 
 # Test all combinations of per-thread, system-wide and normal mode with
 # and without timestamps
-arm_cs_etm_basic_test -e cs_etm/timestamp=0/ --per-thread
-arm_cs_etm_basic_test -e cs_etm/timestamp=1/ --per-thread
-arm_cs_etm_basic_test -e cs_etm/timestamp=0/ -a
-arm_cs_etm_basic_test -e cs_etm/timestamp=1/ -a
-arm_cs_etm_basic_test -e cs_etm/timestamp=0/
-arm_cs_etm_basic_test -e cs_etm/timestamp=1/
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/u --per-thread
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/u --per-thread
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/u -a
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/u -a
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/u
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/u
 
 arm_cs_etm_sparse_cpus_test
 

-- 
2.34.1

