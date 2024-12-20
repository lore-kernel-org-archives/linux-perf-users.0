Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1721638A;
	Fri, 20 Dec 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706826; cv=none; b=WBNr/PGEaF8esR5w76YBgjTDAlz22QIobgc+X2dbf9MNDXkvTtWKKN0LowomavQlB5Zt8gty3AEYMQQMI/7sAL6Jl8jkFgTmxg2PWUxrAfeGt1FK2Z159K/HY5Cqf1fJnR8cd6irHrCc2zEohdlquD6fsbEqWmLpnTru56jjXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706826; c=relaxed/simple;
	bh=ib5f/q6D5v9u2GfUhumRn13ihcv6B7tgfoOPCUcJDdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ub5K2yvC56zahIqPPE8tByZ6/dI/i7Qz43qbTUzXUD/xuRhzxVcmnJG5Cn3iKPAsjxVM/fWPJBlIUTzXTU1telYQaKMw16ENAxrAuagsnhBhOT3syrB73txNx7FDxJocFRK7zqCyj1IQgMR2QYI3rCAf4VX0FSQs3uFgmtAlFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU/clo+D; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU/clo+D"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea7e2204d1so209286a12.0;
        Fri, 20 Dec 2024 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734706824; x=1735311624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWhUurpsh9uykRZLd2NRHB96G5i8cYPTkYob/the7LY=;
        b=YU/clo+DuDSTi8hTb7rfUTdlsnggxUcKPLzAFCexLft17K8BVcuhmaCtaJK7i1qBDU
         SgwbwV2J6siE6rBT5Zuu0xX4IX9Jm1cojEd4xmdD6SiO35xWgitsnmR8BzUDHnesGUh1
         IUYtQZuHcAIip/Fa5trbdT5UY1Xj5GiGGwBKIjiSC9gOhUQDkSg/CJusqvmEuZPqKjMf
         UV/U2IqerieOzEzOhCXJfosuGXkGhKf9FjIwx1Kh8JfXcLPJnBxrBx1VsmpW7pHNNxDu
         zZB+8JF/OqyG8Kg8J3N8PJFzszKMtVpIyB6uhaMx2U5+z2hx84CndWn40itceTBMb//z
         kYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734706824; x=1735311624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWhUurpsh9uykRZLd2NRHB96G5i8cYPTkYob/the7LY=;
        b=gEZlLn2rSQVoGJjPIM6lqA73zVoDpVBOBZgWJGGYvd3JTycQVmEtFozkQ1xguwNQgc
         n4n1ftkhlVu4bsZi8jsBXZI92K6P/d8YDZwOjVQyRKX2rhHoqOrZJApPpyXsirRnXEgp
         qq6MklLvigSwXTJ5ENexIuWPSnjTk/pXQpUgPcyLf/4YE4P/OTnYCHz+6T7Ijup1OpDa
         cyz1rMk+RdPcjPWp0m0RgYLf2uggAebiR8IRAGhzXMAMtpbmTLKIETC+OqwM03fCFUua
         LSro1TP3GzU1O7L6pw9xZ3j5I8uMAOh77uIIEcGpez12bsTB70t2vGMYMb2p8qSXgKCL
         4Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCUMOSn2+W7LINV7LayZOFH3JWyqzgpsAUh3NtbAJo5F8uWJ93DYonYvMPD5mw1ytCT3c9jIXokidIrntU8=@vger.kernel.org, AJvYcCUk/852a/nPpz7VgZOEDBdtz8DSBVDioZ8YLitcXw4glOdo/VaBfLuBVTJbx4uaGOZZ292YOXVwiWmXsw9zXxZfEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAeXFFCNZYRUF5fm9KOadCWhREWh0T/t09Y9XUYh8z5pOvfvu
	X3Ms9NBRDZ/HeaoWo5sLgVhnuI4dngbeK+rw7pLwt9ZEFu37uxE+Zym/iRPooJg=
X-Gm-Gg: ASbGnctVWCbxyXKf3XftTpAPuRuf+JfRtRJnZBB4943A7j/v8WRpCZXlUQ4X+IMqUN6
	TeoKSEYeZKi3DnUSnlvaDuh34CupyW6W1jptekzQ2OXJX+9wcNieEf/BJFGcfTcXJhJC5THSITl
	ZZWmjdzMTXDa+qcEf104VHPxPxBbSbFGlEmJrJGAcJ9APZqN7GnNykecxRCejHp28g+zL2hrPL5
	JNrx9leysTnDqq2YJGfXEKiuMaJu18jU102bMMIyXtpO2+ff7KOnb8=
X-Google-Smtp-Source: AGHT+IF2bFfXBTew+MKhtzu1z+iCeSZfs9wm26pm1urA+Sm+6+rFKbOnmFLphfdDobDOOpSxh2Y2tQ==
X-Received: by 2002:a05:6a21:3283:b0:1cf:4dae:224e with SMTP id adf61e73a8af0-1e5e04503f3mr2084651637.1.1734706823742;
        Fri, 20 Dec 2024 07:00:23 -0800 (PST)
Received: from ice.. ([171.76.86.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b8e867d7sm2957152a12.46.2024.12.20.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:00:23 -0800 (PST)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: john.g.garry@oracle.com,
	will@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	graham.woodward@arm.com,
	bwicaksono@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH] perf: arm-spe: Fix null-ptr-deref in arm_spe__alloc_metadata()
Date: Fri, 20 Dec 2024 20:27:02 +0530
Message-Id: <20241220145659.66066-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When metadata is allocated using arm_spe__alloc_metadata(), if the
metadata version is 1, metadata is returned as NULL. This value
is dereferenced later in arm_spe__free_metadata() and it can cause
null-ptr-deref.

Modify the NULL check for metadata to return -EINVAL even when
metadata_ver == 1.

This issue was reported by Coverity scan [1].
[1] https://scan5.scan.coverity.com/#/project-view/63616/10063?selectedIssue=1636359

Closes: https://scan5.scan.coverity.com/#/project-view/63616/10063?selectedIssue=1636359
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index dbf13f47879c..55827d8ce133 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1497,7 +1497,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 
 	metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
 					   &nr_cpu);
-	if (!metadata && metadata_ver != 1) {
+	if (!metadata) {
 		pr_err("Failed to parse Arm SPE metadata.\n");
 		return -EINVAL;
 	}
-- 
2.34.1

