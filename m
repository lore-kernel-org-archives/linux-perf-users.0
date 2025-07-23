Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0B17C91;
	Wed, 23 Jul 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304872; cv=none; b=OYNceXlZ/hn0QJcda1MX/Ppwn3e1R51L3M3bLKJHJ3Uy5DFrW40KdqPlbzB7Syh6scKEZ9lhWFDKPpZUmkwc41aQ+O/fVRMsnS/R5AAY5G1eQIGHol+kNXPNqfQZ5IQe3jGeCzqolhvv5tJEobco1LX+wdiWu/jZrsMHe5f0ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304872; c=relaxed/simple;
	bh=hPWMMmywbOOEzN+S87+NwwdTnc0omrEhFKsvJPqdTgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puJ6WEPJxxj/UmiBtthXfnd8p2FF0IyvLcLZ12UwWrYjRrKyKkuELzJMGOxMi/kncgon/IFJruNJBMQbduVAOLNN3XuBZmegutD2wX851lMX8TcpXnHgnqkeqR9O21SzaYyQdYknohFeLQBUNvaq5OaiTsOO72VMTNBIOpujY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3510c22173so41134a12.0;
        Wed, 23 Jul 2025 14:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753304870; x=1753909670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IMiDdl5dSKdreUaUPFyQ/2CpyhV6qLtFUX9jkTE9Bk=;
        b=eYsdOXB1Dz6iyOKAL+VP6aapg43IyLDS0Rj7Ipl4/3hZpkydqgHiRJstzTOKzDBB5m
         eXGn8u5ioW6YVjmUvcnSeahjjvfySCWKfaIz7iPiC5BmqL3SEVWzI7fxP/aIsKHrN+19
         FWmJBgQbY58rukjBCNpM6AH/YEB9h0NCwfAy/PciKm+3z7qmVrgh1jHFM0afXDRW5JYf
         349apI2SH44yiyEeDPpaOmWdxv+zRET6uXneF0LxxhJtpUFfAnk6GXCDLOPdYjMVgAbH
         15JAGIYMQAmj7TcmSQOKqZGFhbncJcSPgI/GFivIID+zizdDzgQxgr/WVt/pJ2ASX63I
         W5hA==
X-Forwarded-Encrypted: i=1; AJvYcCVuEj34w2KqrZNEHJBsmqEjY4U01SXI3TDOPcYj/Ag373WTmk6fQ0yZFmgN9V6LKyEUCyBOkre5V0cQ9EJgfeKN+Q==@vger.kernel.org, AJvYcCWmXzTW/qihjANKuAne3gnag3DI/deq1Ietu0RWfzcTz31P8YpB0jFF3VNOGe6Eecn3mQ6ovmE86LKCBSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS0rSb6skbpHr/K8H7FDe3XRjLplbi1D5RhOQKSGxZWoCM478
	Ks85c7CZ3txTIHM8ufDFvzQPwzXuDmet0YnzDFPgfhNyDVwecIjE9zT1
X-Gm-Gg: ASbGncs/4nMu10tJO3FEuXhG9aMQ3iymINyDNMGivaVZwtjtcxyx7r6+gOleMsGGGKT
	eoNYPMqTOFSrrrZs60+lFlsOY33gKgxh51tRJclG4RhWUl9MtEKgnJpnXtsK4as5C+HPd0JvpqF
	wefaAZp5b3DTpAUqyyrt4rnOIVEGoySpk4Y3/4XfT8E1KTdj9atFSnglpcfHMwCfKRho2sIBjF/
	oVUfVhWkXFSNxVxIiy43CE2GZfkyVPnFo1cHdSNFalwvrdnKgLpgEk3pO7FUr2jyTAP9KV1IGGg
	T/grbbPnJFLZttv52Cadt5/J1aqybvzUGXHJGAQfqY2hfFdNcSG+48RVydj3I2xvzvC/Ek4/vdE
	mfCBoi8QPbo1/zPSMoSRjFEE=
X-Google-Smtp-Source: AGHT+IEi131jF0DgSED99zXtWgOrXDGfJi5rNwdTWqxbh/HdaMC7dTOr3gW9pa2J13t2/D/l+T+ncg==
X-Received: by 2002:a05:6a20:3ca7:b0:239:d43:4820 with SMTP id adf61e73a8af0-23d491af241mr2497205637.10.1753304870583;
        Wed, 23 Jul 2025 14:07:50 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519e169asm2335508a91.13.2025.07.23.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 14:07:50 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Austin Kim <austindh.kim@gmail.com>,
	Michelle Jin <shjy180909@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	syzkaller@googlegroups.com
Subject: [PATCH] perf/core: Prevent UBSAN negative‑idx shift by throttle/unthrottle group
Date: Wed, 23 Jul 2025 21:04:28 +0000
Message-ID: <20250723210426.590974-3-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Where perf_event_throttle_group() and perf_event_unthrottle_group() would
invoke pmu->start()/stop() on events still in the OFF state, leaving
event->hw.idx == -1 and triggering UBSAN shift-out-of-bounds errors
(negative shift exponent) in pmu enable/disable event. By checking
'event->state > PERF_EVENT_STATE_OFF' for both the group leader and each
sibling, this ensure only started events with valid hw.idx values are passed
to the PMU, preventing negative-index shifts undefined behavior.

The issue is reproducible using the syzlang and C reproducer available:
Link: https://lore.kernel.org/lkml/14fb716a-dedf-482a-8518-e5cc26165e97@kzalloc.com/

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
Tested-by: Yunseong Kim <ysk@kzalloc.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: syzkaller@googlegroups.com
---
 kernel/events/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..e5cec61be545 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2684,18 +2684,28 @@ static void perf_event_unthrottle_group(struct perf_event *event, bool skip_star
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 
-	perf_event_unthrottle(leader, skip_start_event ? leader != event : true);
-	for_each_sibling_event(sibling, leader)
-		perf_event_unthrottle(sibling, skip_start_event ? sibling != event : true);
+	if (leader->state > PERF_EVENT_STATE_OFF)
+		perf_event_unthrottle(leader,
+			skip_start_event ? leader != event : true);
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->state > PERF_EVENT_STATE_OFF)
+			perf_event_unthrottle(sibling,
+				skip_start_event ? sibling != event : true);
+	}
 }
 
 static void perf_event_throttle_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 
-	perf_event_throttle(leader);
-	for_each_sibling_event(sibling, leader)
-		perf_event_throttle(sibling);
+	if (leader->state > PERF_EVENT_STATE_OFF)
+		perf_event_throttle(leader);
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->state > PERF_EVENT_STATE_OFF)
+			perf_event_throttle(sibling);
+	}
 }
 
 static int
-- 
2.50.0

