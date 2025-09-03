Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9642DCF4E;
	Wed,  3 Sep 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885920; cv=none; b=lI+SWaBsArifDwlxAb9UkqkYCoWk3zwjI7ZjJ+U1Fwzp25fKFJkYfGhsDTNBTJVAFdJv+qsew59hOoC1jTa+KfofpLaQjs0MIx2QujRi56d71B9YUuwhrlz5Ex1yfYp+Cw82h70+OPJyMAnAgfFHtuAc3c4nfObdrMnwUB8h7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885920; c=relaxed/simple;
	bh=2fNzrdtA1dr20XORdrI1LwVcJMhDqFkSY3hmpIiAP2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BY29+rfiDrrYiri1p4x/k6Y8s5zl/hys6cYMiP276YI9Huj9wrklT3Bb/rZf4ISwqrg6xn/Yorur3TSTFcizTlIe0ylXXxRMP8uxJGHyPynLvZUguwoN7n7CM0YZNf8jeEXsWbuERnK71HsQ0/9GkUiI46IuuwfdQ5SOw4ZHnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvJK2rpC; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvJK2rpC"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e9baa0310cbso2074825276.2;
        Wed, 03 Sep 2025 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756885918; x=1757490718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euKRILLvx+cCKJF+yKOpjhhl9AttILHA9YKUqf6XWmg=;
        b=EvJK2rpCUMo9DPM9DR6cVAvONZdPXgyqN22z7O6IydMKBZRPXpNLP4cqCPJoVTIaP2
         zHaczzavGAA6HWp0qP0wSVNMI2BjtoQlsIEedzPO5+vX2etC+akyMTnCw5Xvn51lSSh3
         U1QVUc3TcbVPMwqdjAf+e8+1MpvpPsFRZ1YoM37v0Lrdyyp3NsaiBZua2hGhHnu/NGgC
         I+epvVn6CB3zIGeYExNtmqa+uRFAR20S/C1cYItYk291ScspP/lE6Iib7eyiOKwOhrpV
         yIY7NL1mIoIwx2+NuN8kbn8vcRybAFrHhXCxLDlfL4c+eiOYAiY/1qPn05KcRniif0wB
         NZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885918; x=1757490718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euKRILLvx+cCKJF+yKOpjhhl9AttILHA9YKUqf6XWmg=;
        b=oZ98yhG6YbccTfMsGmdnleZqcUQX9Z/cCD2J2SN1Z0kpUVmtCCrMpYAPlkWOmkd1MB
         ubSsj5a7/u51GUMpj1FW/x6g02QwLJozL9YD218WQ8wIWd4jN250yvKIvo0vBUEQ//Wm
         LFH/CPjrsm5YNPV33XY4+3thigwzeWtoXpmY97IuzePEfLNRKyD06itRXn3QV6192S8Q
         eSudYBcoSIRMvV7iu/IoW/HxCyIzRyrT40hykvWcgFvNbPpoqnoNvmUKTnJaMSlYVik9
         fGJg0kGUF7e8Qn1a2x3nSSwovBUHM3vIT0EjTnuScbf+WZJ6gJm+xLpCgclOzrlrJ0qH
         q5xw==
X-Forwarded-Encrypted: i=1; AJvYcCW2zWf9hHrWm+Y/i20Nk4w6wMIbhKrcKc0eYPuFfy/vrx+11BP+88b6gtKnv7u+uwt0fD4yvv4RiwXDfzt0Rs2G@vger.kernel.org
X-Gm-Message-State: AOJu0YwUq4o8lcrLOFyT/ksELGVm0SzV6N7jJ/tsUT9k13xcQnPky8WP
	5shn9l8+J5+iYXzYUgcngWoBMjB4AifS6jXJCRb+4oo5/HC3S22Cqegz
X-Gm-Gg: ASbGncuWLKT7aekSHSLXqM5a3FuvD7FKO9xP88FXW5ifrPJZGDOk1nCHa+ORcCY5W9j
	M+sKb5Rod/V+l6JqWs4yN2vTdRfZdiqazRX7uHS01FKBj6UxFsyqh/amvxqY5XdvDn6tbipJRlO
	OLSK+5IB891xfCZg4h2ZMJ68r7ljqft32n5BEbHM/4A0WgPsp0MNCDYHVQT0gOH68ITNP3At334
	EHEBmHZcQ0MdSgY1ngfc0m7bJRaO/MKIFQ9k0WFKE+/gPfjnTxIUaxJG+vDos/No+7gr3u2hF0w
	W7Fz1XjQmZtn4LUwfwN1LNooutS1UK398A0P9joH7ZPoSC2ZFwQlKoD/gkcG9tKSc1DEOM7Ytl3
	o2H01tBXig9o51s4/wY/AVHWuikmytIpZ
X-Google-Smtp-Source: AGHT+IGIwIHgQeiWOL5Rj/Fgam4W+h5Kfzk3drWPtG4abiyJhn1nAfpbWubQzqBDSSSQUjmJgpgnOQ==
X-Received: by 2002:a05:6902:2203:b0:e98:9646:2205 with SMTP id 3f1490d57ef6-e98a587c899mr13762492276.52.1756885917908;
        Wed, 03 Sep 2025 00:51:57 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a301:1000::20f3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08c80bsm1288391276.29.2025.09.03.00.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:51:57 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 1/3] perf/hw_breakpoint: Optimize __modify_bp_slot() handling
Date: Wed,  3 Sep 2025 15:51:38 +0800
Message-ID: <20250903075144.3722848-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reserve the new slot first, then release the old one to maintain
consistency and avoid transient failures.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
This patch supersedes the previous version:
https://lore.kernel.org/all/20250902091759.590664-1-wangjinchao600@gmail.com/
---
 kernel/events/hw_breakpoint.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..6066aff38eec 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -626,22 +626,13 @@ static int __modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
 {
 	int err;
 
-	__release_bp_slot(bp, old_type);
-
 	err = __reserve_bp_slot(bp, new_type);
-	if (err) {
-		/*
-		 * Reserve the old_type slot back in case
-		 * there's no space for the new type.
-		 *
-		 * This must succeed, because we just released
-		 * the old_type slot in the __release_bp_slot
-		 * call above. If not, something is broken.
-		 */
-		WARN_ON(__reserve_bp_slot(bp, old_type));
-	}
+	if (err)
+		return err;
 
-	return err;
+	__release_bp_slot(bp, old_type);
+
+	return 0;
 }
 
 static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
-- 
2.43.0

