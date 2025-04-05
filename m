Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E03FC3;
	Sat,  5 Apr 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743885045; cv=none; b=m3TMEu7xlj5shg50OFM4tIyM1aATxuOnZg1V04qCY5SGvw5FKLP1058MAbY1zWKP0kIaCkvarAompKRkZCdF3kFVNxssQohDkqrbhNZA+6I0gwaw4SgjVP+/oXyjcQWGNsNXn3/Gm23Re0QK5oSR9kzJ1aHRHVFwaSu1o/h6TrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743885045; c=relaxed/simple;
	bh=592/DYeE4rV/PvvRdjDT+n9BuKH+8hLaJtJPesSSxkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUDmtDqLREzaDudngYYvokJ52el7H98Ur05V8843ZimMr2pyrhc39wZBDA6nTfj84+0M4hZwud+gu2jSKguVWRGl6YrNOMR7pRvM1Rc1eNaZa4l5Z+AmRqrspnzsRe0aHpeYxcTciOHuRRKClxT06LtP1uq/REZUDI3rSb534oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osit0nMV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osit0nMV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500cf80so260906185a.1;
        Sat, 05 Apr 2025 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743885042; x=1744489842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFZ87RkgEvE5OWvML1O0pzoNbsXsPPEFnlwAAyAkpNU=;
        b=Osit0nMV/bsOUhBri8cFNjncQIhIpTQVcuzeYr0GhqOETuUhLjjZKLxx5BnMylO+PM
         gzB9B5gglbiDvVBbYqHc+pZsTFt3t4rwtlHhGXE6hAzEFyE41ZP08FvI277lPjhz8fgt
         He+XAfIAgt3HSZL+tELFBnNTJ3auBLXsqP3mOhOVuRJb007giMMxxa9P6t9ItC24qIXj
         GxCJY/hYB+SUnVZCyKMdYAadS/6X1Z6TgsaGRAtc0jlNpKxSQKQpELBiU2XAmu/gHTZ5
         z7uTNR1NmSX81yyG7QYCCVQ5wHA2HcQ82ARMqP4RM5RRmBqxlv3PfdoXk7kMC6Gva8if
         No3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743885042; x=1744489842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFZ87RkgEvE5OWvML1O0pzoNbsXsPPEFnlwAAyAkpNU=;
        b=v8YvrU1cpon9mnAenwGqU9ZWuPFxmtxKM9RW2Yn8XaBvhmGRHrwrx3tvTLZ/AFVcqt
         z0EpEQNA2QNasskHEGe4i7TO3OxyLXbybvTCFmJveprSk/Z21yp2i+sgK7WzUmrLb8Us
         tpr66Bp2fDehXVOzNN7oMd3LWbg2pO6wW6BY+xidy5P6TZ3ze09E5802UnAwfptrBb1e
         VeKjCMtR2QL+T1hn1PlPqvf+SCcJukvAggFV2lphVFmq2ymqlSX2LKSwCcT83ncIJqQy
         BJtux4bI2kIDI9NiFjMMXFfF/5J2SackOP3qDEawzJPyeD7XF71SL7XSI0TW08isu3gz
         IBnA==
X-Forwarded-Encrypted: i=1; AJvYcCXnyx0DpPeRUCojdgUgJ65thNOHSIqf3eWwBRDXgAlcumhCfE1WzvwHtWRuMKrKz7e/qqCageyboPTW2lYkG2E0@vger.kernel.org
X-Gm-Message-State: AOJu0YxyY2UsJFMpELcAa3IuE5RSQ90nUnznRln05xfhZH5zAq2GZwE7
	l7Fx0MbXK0QaMRGCWpCNn7nvf+o9eMNyCCjNTjEfCs9z4WkomhpA
X-Gm-Gg: ASbGncsNM8nmvl3q55OLhL9tdzsynG+fyOjdxs4RqJAjnNXZTl+692WgktXwesBg98E
	DDFD1zYNm64UaS13IF+VOY+H8xKcVUYBbYleBASEatSgSP5k4xuOT5vhxhz0nJc0DS5+PSNiQZB
	ACFH0zNZBJw/gwWC+b/tzLPqqkmJuSBrR5OuNZLF7h8oStzz8d27oyImScpIsRQuIXFxWIZ0y2U
	WxT7LpORbwKKRungWKXJ9SB0U9CwDpNKyTdov3jk8VlzEUoQNzZcJK7/b0YZR39NDhf+VglqugK
	+o/VO7CiWgRlftKHB+IgjfcNzE1pv0R5RZe0j5EQ9PCQrXaAHfzo/gH+JCo=
X-Google-Smtp-Source: AGHT+IGqvxIn7+jtL/y34/XygapLxgoGndRyHSw1XKBdPKp4mDWf3UFd4ITwDeNHFgIJ0JPUcEXFyg==
X-Received: by 2002:a05:620a:3723:b0:7c5:cdb5:271b with SMTP id af79cd13be357-7c775a0f60dmr965736585a.15.1743885042551;
        Sat, 05 Apr 2025 13:30:42 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96e566sm384878985a.63.2025.04.05.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 13:30:42 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	Gustavo Shahrouzi <gshahrouzi@gmail.com>,
	syzkaller-bugs@googlegroups.com,
	syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Subject: [PATCH] perf/core: Prevent WARN_ON(!ctx) in __free_event for partial init
Date: Sat,  5 Apr 2025 16:30:36 -0400
Message-ID: <20250405203036.582721-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the get_ctx(child_ctx) call and the child_event->ctx assignment to
occur immediately after the child event is allocated. Ensure that
child_event->ctx is non-NULL before any subsequent error path within
inherit_event calls free_event(), satisfying the assumptions of the
cleanup code.

Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff3aa851d46ab82953a3
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0bb21659e252..153ba622cfa0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14016,6 +14016,9 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
+	get_ctx(child_ctx);
+	child_event->ctx = child_ctx;
+
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
@@ -14037,8 +14040,6 @@ inherit_event(struct perf_event *parent_event,
 		return NULL;
 	}
 
-	get_ctx(child_ctx);
-
 	/*
 	 * Make the child state follow the state of the parent event,
 	 * not its attr.disabled bit.  We hold the parent's mutex,
@@ -14059,7 +14060,6 @@ inherit_event(struct perf_event *parent_event,
 		local64_set(&hwc->period_left, sample_period);
 	}
 
-	child_event->ctx = child_ctx;
 	child_event->overflow_handler = parent_event->overflow_handler;
 	child_event->overflow_handler_context
 		= parent_event->overflow_handler_context;
-- 
2.43.0

