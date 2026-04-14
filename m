Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0B38B7DC
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153886; cv=none; b=pu17ITfHYe5Ruptkafbm6B1obC5FvRYzE/rr0Cu6tIQK87s6+z0+Pz7IbFw+0JECzVce19voqbsCh8dtMtGxp0RRmD6/UNnF/fOWmWb1s49C9GG0gpaGAheYxlCNV+FEzh9CzXiVyW1m7sg3UR4gq1PfT6+SFroWuaM60YMzFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153886; c=relaxed/simple;
	bh=Ec6D8ghiJod3XJD1Pjf1H4xYLvALUzxMeT73/KuO6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ipAjprL6wwGJICUzVJbr3yS3ENDr9zKZ3u8+UlPfzSgkFVikLiiBf3zfbbtSxxbUifhIgeavAlUo66zgkrMEI7e5AAV7pxq9jsFVej7XyaxFlAGn7KwoxCj8Bx5+mKsnY0XTIJV/kMSzivXbUoCmyM1SPVSzifYwVUkP/l0Rc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b=HzU+Tj7w; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b="HzU+Tj7w"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso1318655a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20251104.gappssmtp.com; s=20251104; t=1776153884; x=1776758684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cv7zAPMflcyGHNeP1lrJ+83AUW2Bg3mHm0koPEfVDwQ=;
        b=HzU+Tj7wFyGNIY/jA22o6nyqtjdWiDPnnjBVrIleQuBc6QCTawgddmmLkXfo9S/Rkc
         9XU6RvdOJ0wEqqmGK4Omdu9I3Ech25sgI6SqSkZpKEdZPQGWw/UuW+Z9F5RrdNEItoeL
         zYr7VSlN5Clfw6VXnV7AbO7+ALEPLwjTYgWrsM7jwG00X1I1r79e3lbrkdJe6PzpnYPH
         rUMK2HUXTqrH1hUvT6DU0TK2tF3p9pCWZJ0I8W2o9sysI7/GpWGqtle5sDsQgNJbD0if
         WHJcba/GD22v2EFbEjgnqNBMq19jqclMQiSOtG5iLh/LR0yKNHC0hSkUidUiEHO14++B
         3CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153884; x=1776758684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv7zAPMflcyGHNeP1lrJ+83AUW2Bg3mHm0koPEfVDwQ=;
        b=Qykx/P2P+VzLDId7RpQYqylMlVaiyG5Wmh/zQ2WiXvcbQjf7q7gQzhihDxtjZF4VCf
         nMJMvB+0MjPmZS7uxjIKFud0KoDHoqEa2oIYQEm10NI/VIe7bKbx9RBAXou85xb3wrLH
         FI3Tp08ncsXGml0sq676tnWykOa3rq9amqTTT369I34/kIqFapu51iTF3rCyRVOxRjEp
         nkAmI6daTw8NjavNvNFOW44t2Y9Fu5ygMHK9Uon+x57JBGui4/3D4jyJNVZ5LRbIZju6
         vvr66tVu5rQgR1UTEYQZGVjlq8YopHRQSaGkoDDfiYkf+vDNpcz7RC2SUhbIdjYmVgwG
         Ugiw==
X-Forwarded-Encrypted: i=1; AFNElJ+VHl6KA1jNaRsjYvya1G9VrNjKychucBMQxkhWHZk4pWUvNcDZML6uPGKFv2ccdxewJ8wRZhhbhHGXDpU14Y+1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9nMbsTE8bVmUwz5MhOKbMWC5hpQjk8RcHHOd/wTlofJc6vsN
	lxaU0iKFab8FheU5dJoZof4kfY1YjllxA1l7s9WgLNlWe+Bc4aHfnrQre1ZSMCOPt4Y=
X-Gm-Gg: AeBDietopJKPBP2u+OqWP3nhpTsstlwz0v+hDHsIl/t8uCY2bZTVay+7+0InDh8Zw+Q
	aTThPGsHPtJQo9FB5mn3UULxQ7w7EZbn75ccaXPNMruygYBl/IwrQXkWPLdSiAV79ELeQ1QK8Yx
	YdsGvJTQVtTWTM5VUlUn07/XL7jHd+wYGrpgRcfqu4g4iepCeVPcNCk4AUt+d9kloPnJbsf2RG8
	3AJMNBO3SYnUVpns+xMAp6HrmUiyVdAmKHW2NXNYnKM7BKHbCCqS+1PD+cGpohn8wdU641YKn0P
	Pu6Br0uoDoAbmHHibwXPhCqnSxBHBwUEhD6UMk64XXKDO0L1nl6YvaT+yWhYeB5o7V+PHEjb4CD
	OOp1c1lNiuAJpXdsZrcY5faB1TzOlMuy83mUwTbbqUnQTwsL1ECrvKyBOrnerKM6O7bMUa3F8eN
	jmYjnsy1KGAg==
X-Received: by 2002:a17:902:7607:b0:2b2:49a7:a5ca with SMTP id d9443c01a7336-2b2d59411admr109194875ad.5.1776153884528;
        Tue, 14 Apr 2026 01:04:44 -0700 (PDT)
Received: from xpc ([2400:8902:e002:de21:a5e:ca8a:49d9:fb8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e04e20sm136683025ad.32.2026.04.14.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 01:04:43 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	WANG Rui <r@hev.cc>
Subject: [PATCH] perf loongarch: Fix discarded-qualifiers warning in _get_field()
Date: Tue, 14 Apr 2026 16:04:24 +0800
Message-ID: <20260414080424.320060-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Haiyong Sun <sunhaiyong@loongson.cn>

arch/loongarch/util/header.c: In function ‘_get_field’:
arch/loongarch/util/header.c:31:15: warning: assignment discards ‘const’
qualifier from pointer target type
arch/loongarch/util/header.c:36:12: warning: assignment discards ‘const’
qualifier from pointer target type

Signed-off-by: Haiyong Sun <sunhaiyong@loongson.cn>
Signed-off-by: WANG Rui <r@hev.cc>
---
 tools/perf/arch/loongarch/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
index 0c6d82333..46f53a74f 100644
--- a/tools/perf/arch/loongarch/util/header.c
+++ b/tools/perf/arch/loongarch/util/header.c
@@ -26,7 +26,7 @@
 
 static char *_get_field(const char *line)
 {
-	char *line2, *nl;
+	const char *line2, *nl;
 
 	line2 = strrchr(line, ' ');
 	if (!line2)
-- 
2.53.0

