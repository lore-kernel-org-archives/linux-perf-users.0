Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B25436355
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015505; cv=none; b=MP80badl7CyDrpk0b0luVOCX35L2iJO3HKNj4apsS24aHf/F7VbUWJpsjoYdpGTaTx9ucfNdibw3mKiswiPx1atlIGc6lQPFOqaXNnKlK5Yg4T+du/PibtsYZ1VPCglliVJtOXBg62TCvF68fL5fLdUCKSJwoNxs1dj7YZM8BLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015505; c=relaxed/simple;
	bh=wObRJmm3gTlf7wqz3XGbcKcAk4UU+DK+eJvukw9px/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwpCZfJz9J/bR1AoEkRSc5W+orSOxtc5kxLfZJkPUt+Q/XG/r4SaDf737qzENdc2tsA4h4/RNm0Pet+bY+tdk3VXp5usCdA33adZRh5d30cuUU6vHbMIPpzQNXooaPdXCvrbBg6dTIiCEe1EfjtuDQcgW4ERZ3LtlZZHJAsn5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3AT+Snh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3AT+Snh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso47866245e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015502; x=1781620302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdUeDLTBd8NbSbxSGmF6PVOlpVLflZ1t9lCb20G1ZuE=;
        b=q3AT+Snh4hGqs8HFEpgiBkean8HJ6dVgN7hg23oT0M/ftl4FNoANrh/p43bhuCQMfi
         v6yicTO0PYRTRtBzERpfBGqa/WzJty7+fleAzNbAhm9hrZ5y/Ubt7OG/8uiAsJQ6w4BB
         IH0Xlunw6t+mUsnauPQr4oVrBf4DT9wEvBKbyNwdrrK7k6ABEp8mryEt0wg13cviCH2Z
         1tZ7PCKQ5WFP9Ebzpllig9td8sQrsJtfOFOajHmxTVeNeaKchi5wEhU/kacwsy3xTYQ+
         tgZgrumVN9ug0SkEw8X8s8RAE9HTkuvGCNYfbXuXpPeLWVZcu5ZyFL0ORIPkKnzqFeok
         Beqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015502; x=1781620302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VdUeDLTBd8NbSbxSGmF6PVOlpVLflZ1t9lCb20G1ZuE=;
        b=j6nbvNk7kYhjYQMHHV6gfbXjuZTN/LjJ6wvFyGwzV1tYJJXf5hoaZIxs/H8vM3znNc
         JungAb/0ZOFt5RIIwh12r997IjeOESCoWDM+N2z6M7S9a3LEB2JCLTQer86S+7Gpy4OJ
         hmRCGs0RGkzRNtU2S1UjTeyxN7VrvCH5zKcvqKG7Bn5jzKMialu2lIeE5mKv8Ku8UioJ
         5ImhVfJKmDYmoW0ZIwX6mobjx4N9I2nL7ZKiypzgdL1NGchLzuRqUVktn6vEyMQWQXHa
         S0N1kAKXANSgZxmcGWWthwRGWZwcheGQxqBhMQrjCgvkrm9Z1MZXHTQ/KTtazslpx90i
         LX7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9tsFJKsqtZu13AWa3lZIkvzXdli2ehgQgihXjVfcUlNLxELSty5S5sMphGeQNc9Ljg7TQ1zCvq7gqO8MNZlbDI@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfwVtdguiBsVVhWPExQSLd4yYLDouQiJz9/zDqQNu4vKhZQzA
	qIg2DK03qxK+EzdbbmP6Vx/c2pA+lxkowi9xTzPtvslVp5YNJC7D1kxzUtBrXM2c5rI=
X-Gm-Gg: Acq92OF0ko5IOJPXMwlwixK3XCa6k82jyfTm9gVz1OaJZE0YElzu4wwGmxT2yllfzFZ
	CXSp8bXmXoqFV/3bUyRByD+MOPmpeCJDxc6xlFdeH473E8SnRretCwhXo/R38mHqJuWTk0mFxUn
	HmZSF9foDfrcHyhXlPvqNHY+444mzIuNiRZcoe7D76cyUe9LDmSsCKdPihZLQiK8kkIwBm+xxt2
	w/XnzjUGbHK74lTbJ6LIVXFTvmFWOgRxV6Fb4Yu1rVmgt1YkjX4mlgdarnvwnLBCdLJNAOqNj2P
	ywjvOozkIxVAdr5HnKWdyCczJRUg0ZOkrYsxoqhoa7hXb4+Yfw7Ccq7ZY+0Q+Luc3bNvjQFy04B
	eKAelfwdU/59C8OBkZE4iS3Yc+Mwa4ln4WdTM2EdQveZGRzjVG9NU1E8qN6JT7g1NpyPJK9i0mg
	yxq/jJUQbiqAFLKH9XxwAS3C/9c7LjbiGDt+oouY614u8=
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id 5b1f17b1804b1-490c25b1277mr393849115e9.12.1781015502478;
        Tue, 09 Jun 2026 07:31:42 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:10 +0100
Subject: [PATCH v4 17/19] perf test cs-etm: Add all branch instructions to
 test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-17-44f9fb9e5c42@linaro.org>
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

