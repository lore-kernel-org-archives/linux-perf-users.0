Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93275423177
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015501; cv=none; b=HTW7jsj8MFSH9a+8t7J49d4ft94mVAp2NmXBqyo3G7QJh1t0BhQd5JseZSrZcWmC0XPGIQTrGiua53WELa4kL3iPJkKSYBEYpNGRJuT1VmtaaAido1ea8Ul8xqepCR+oSiCi4+kczmcZBChHzuGedGj8TUpJ47f1KSPQ12nsAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015501; c=relaxed/simple;
	bh=FSMtqVRVy7D3pvypIs3gLf7OFxrFfmQrY4e2IbRbIqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+c6+ZFMr06WWyLHECQqbFi+In8P6C3gfA3DfFLOOYXabP4ogS1yxurmPJm2n1gU8EqsSbq9PNGzd7Uy/1QYMR1lLsUYkXDdkRHkN/Hjft4dsmnf7G7w0E5sInkvV5beaa1NXqrzrGQUJ2P3F7E9dtEV7RBFWrCiwknRZRYIy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuIvH9q/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuIvH9q/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso46460755e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015498; x=1781620298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng7BXZAmfD6H6DnpoBma7BIsuVaWOeOAye3IPeJCbwg=;
        b=YuIvH9q/a+Oz3zM2/6119F4NLMJbEpUTw+3PARabiwM/c3YAxuSGxDkwbJuCLtRbmR
         7B+BSE8RzdTPTw95vnlqpvJ90/0V/EBvAZJ770QvkONS2Y4x2tPj4Ae9i2h3HjZe1Q3A
         ErtgwBAHkbF6ERQpvlJPIR2In5oau6w11OW2GjHxUNW0BiUWGTFC/beYrRi6n4tUXElS
         Mm6Ud8GyUD8XwaR/S5F6Hf7GPkBPDvc3w2xyHvBU14CK3yh9DR7qqBMcW2PlG1EerCjD
         kNySwy3PUK3ARnq3MB1TrDYstIbHBByAkXnY1r4lj0p+obP8E4JcZIOH5Js/tc8qIQnG
         iHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015498; x=1781620298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ng7BXZAmfD6H6DnpoBma7BIsuVaWOeOAye3IPeJCbwg=;
        b=QWTp9QuGBdF0gak5ahA/BWrFq7HnYfabTUIVao3L6cg0NpvO62zuvoHAWGbUphQ01b
         /ET88+jnvHuvayt1hNv92OWROqZFQ2Dvaeqx7fzLWiyAaV2q+S/6qeNhcyJ0is2sHuq/
         Cm28kPFfRnJoobMY/Pz1QsgA1CbDyM+yUuaVhUF9CQPe4I/0qgoHO2qqpJaZz/qW/0g2
         cQGIPccpEhJFEhZ9ToEz/15vAtJr977fxpMbVIbWAe7McwAWYGIkl+lyC6kOpxqWdMsz
         EbPE+e7z5N0nbVZuq+7I56SsdH2Z9KBUQM4L2rlZhX/coj5i+difUKs6yErDVHvSf0GV
         xtaA==
X-Forwarded-Encrypted: i=1; AFNElJ8HC/AvaNUvzQSxNelBFlGSInheM27S5yl0B7v6mruRxfBi3Fk+qkFeSc4FS3lO3LWM8KGnFU6M8miRYMZUinsZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92R5HjU3A+62yQJiVHl+lIVvhusTf49SUrIAVAzRvVsDS0d51
	M4q7LnN17pr7jz2ecQbpiSWdZdevuEbgNN33C0fXAmKIHqNPVEg3gr8Sf+PAZDaMTtQ=
X-Gm-Gg: Acq92OHQ6LQbbNEbkkxW1UmPYYuAvS3d/NmVtIjMVzkmuE6NJq+Jwt+ab375Z2uV3ML
	MCIWl+1OcxkXvNx/KvE191rM13Y+C+plEv7Ud3Cy8Aqr62bDEZAYUNb1au/aMH6oje382Q+UtIY
	9b0MqM+thzUwiG/9Sr6llEZy+ZvBJssOKVX6dGU5H3QvgMx2+cgby75ILrWK7yZPs9DU09GrtMa
	ipVaGt3K83xtIEqIfjjb6cjkkCm0dGyQAqKbo8m7Qa5p21koP/2dDlBcFFW2DfOPsSUg7jNggpg
	2TOArLu6YG4ihsN9gHM5j4DeU8D4yjEIr1s27IhqlZ1cMgBAZoe8K9hILBO/8xvpltNSAh3i+a/
	pRnIYhNEzls2bmQ5jzCfo9MIqXwAiQHiuMI4r7zvJxxZEaOP87Cp3asogAb1uqmFQfj3bVBt4Fk
	9NuouhDlR+7fEKGVjg5C/FuN2GsyXZOpdXr4DQcd8XlT0=
X-Received: by 2002:a05:600c:8b88:b0:490:d354:bd00 with SMTP id 5b1f17b1804b1-490d722a2f4mr35057025e9.25.1781015497865;
        Tue, 09 Jun 2026 07:31:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:07 +0100
Subject: [PATCH v4 14/19] perf test cs-etm: Speed up basic test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-14-44f9fb9e5c42@linaro.org>
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

