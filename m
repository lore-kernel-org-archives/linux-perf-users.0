Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658338;
	b=Hlc3JvgXWlXcpwJUdnRpUYhGnCvs5LWXqjRDJwx8nVesILY06DwsIw8tE3w9TSEsa0gf
	 FIG6sY0NtbyjPL0VDBnvm7jWFY2QikTK0XPYlU1uE8i22rLoq+cDEkOUP5kS5/U+AgvBS
	 gw9dYfLaNRC9+5NhZcr5sDwQYvy1Po9AjZ3KUThpzoxdx+8BkEojU+o+yZoAfuW7agqOE
	 eDD3m28OoghQ2sUFA7J2fC9rRyEkRq5033cp4L53oTzSBQ2N0UixTABMTA68Jb0UvNGpI
	 WFm+74QYvCQmJnen1ogh2ZR4F+iik5aILpyNBTijHcpuiLVIBQeca+9i+vZXYiV+Mdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=naPOPpnUpSjS5NQvx1jt7vZZU6xL1qIaqN22lRjW6gs=;
	b=aDFrDuBO7npOhMIDDoI3YCFjxqhBV2m4+hy9JxwXnm6R/fKiKjrqoy5mrIJvFDYVFMhc
	 dEjOa0L+jhgWTnrhXjqNBBUOOj+thIsnFp3xt+167x+quDXvR3MW9eu4MgpVNGmsuq5Qr
	 Y5xhCEHmqw81z6nV6GYukP5Y0xkHQ/u2kdiB7EymZ6ar6WCRMGN28qh7j+SD4FVDDSz9a
	 cIg8TF4WGg/Y2ibLgOf4I230MYhiLBQRqj6v7xKBZT+zK7ziY/sp4GX7cjJZVjfWCg6p+
	 ELA/ma1aEoerMTAJ/qEARbht6xos1nz+p1TWFlAeggecPgSC2o8vmElr+0N2ljJwU9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IdFkpUHP;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9C606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 08:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC9C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IdFkpUHP
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso628402a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658338; x=1793263138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=naPOPpnUpSjS5NQvx1jt7vZZU6xL1qIaqN22lRjW6gs=;
        b=IdFkpUHP4I+TVDz/Q9BV6HTNR1t6NZ5TvdAZUJDjuR5fc7hx9QyQhJf+2MWs6P0nQr
         ++xG3iLYN3ptZnYF59PSmSCuSnscvqqpqtiXL46oeRiCv+sejRw9G+EUQjJ8V1BGe4pi
         6Nyw+Frs+SrPapjOrmYCJLyvQW4Y1Yab1qF+fpsInClPWImwFl6FjF0NgY1zIY3kics4
         09MtZqBVZ6E1SVd1rqlZgZsFwQegGdn3FJRUntZSy4vLE65DUed8pzVSSbM9quMqTzxS
         zFQuHUYF9nGof+GcVtVkZcglgKSzAeknGWduPWh8hyzI26HIL5nLMXc8v8dJ+TxRGLy1
         wHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658338; x=1793263138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naPOPpnUpSjS5NQvx1jt7vZZU6xL1qIaqN22lRjW6gs=;
        b=vaxp04oSEeSFeV9Q2uTv8MidyDYMeIMhCEzu8wXlonNK1Ixbk3xpLZSK9dJUsli5OI
         uTFUOgIFCdOIh4IkWEqLTlF4nJgE/7CwvT1XUZIMHMCg6Lq+dDnYlVB44gRL6sAnoR6w
         M5XBa76Qv88R9V+w4ZeOIPglDij+JBLHom6HqQvupd+ffkSa3XeW3djSrtQPmuSWs/iJ
         2d+KsceYlmw4761HnDHQh9OuNe9WSMcyX3b/sWcfUIllx12fWBXhV1WtlqYCzGIxSMMx
         aC4//Cl88zhnanRArqkLFTb9SXQM4/ZCLqKMbgK2lG2tsAaYfCFCxibTj9Pu8+grxJSc
         4MSg==
X-Forwarded-Encrypted: i=1; AKwUvBwddXPTMWH0rH23KUSJcbDDG0C6LB//YFMGnBeREoGZKG5TWogUO9DH1qzB/a3oYoBLkk2+cbWUnev+YKCKqDjp@vger.kernel.org
X-Gm-Message-State: AFq9FYIkAogFWJRPaCqqcBHnkuFchUGDIsLtEXGXX7fWpjwi9D/ncLoW
	jLa7ifCg7/tou5vvFghMN++yv83BLq0J6lUVFZ1q9f/Gph64NQk/TOaT
X-Gm-Gg: AYBFou1Eqp2KU1q2gOU5VITBWbAEh5zevIZo0jKPZ7sTcDl7TkEHWQ40lVDtCRCAVHL
	oc+z6vGrjQzTQm9haX/Ti3KmFMULobWr00IzzIdfsEXFvprHol5pBGEzpKq1nYZYIyI8l1JrXZ8
	ZLycDA0XCldsIzMkF5yIVFt6LlLNHBfd9ljmtYcse8Mb4ytoW8a0s+jctM0JyNkMrBuiB0CMmAW
	/Tn1kf01lWOzxxJESl39wc0kaoOUtwPxdfLgu6mQcxCtWSz9FQS/2+Ekh2pejgngh/CjZYspOYI
	KdT9C7P+utHwiuSSGnYSmTmqjjvzSauGMSuEt4U53c92xqEqrM7cCTkx2MPgyi3zyWrl/govGSB
	Zm2nU9IsxTh8oAsQFAt8OKYFvYRuUrj6Gj3bIU5/9Zp8gld5kVLHeZc+4m8RJtz0ooQPUNf5ICa
	NgvsI2iMn0fEI/OaCcRJFxPRhPRvVMuxDDfGP9HTc2hPqlmAOU1Pd5otN60LXMIK1mbxaJugnuS
	TzOFkAuFs4vG7nBwrdB5JrpLjM1rEpZzvMOVMwhPjS1xNa2JdldBwh1sTf4v117q2GKTEjBqlN8
	HrA+Bijf429RVNdjFP0BAyvPhWhzLWihJAMRUNk=
X-Received: by 2002:a17:90b:4c85:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3ad86d08e8bmr3602906a91.29.1792658337510;
        Thu, 22 Oct 2026 01:38:57 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c58sm3210160a91.8.2026.10.22.01.38.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 01:38:57 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH] perf/core: Remove group siblings before the leader in move_group
Date: Thu, 22 Oct 2026 16:38:42 +0800
Message-ID: <20261022083849.90948-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

During group migration, perf_event_open() removes the group leader before
its siblings. The context's active lists contain only group leaders, so a
concurrent context switch can no longer reach the remaining active
siblings after the leader has been removed.

The context can then become inactive while those siblings are still
active. Removing a sibling in this state takes the inactive-context path
and calls pmu->del() on the calling CPU rather than the CPU where the event
is running.

Remove the siblings first so that a concurrent context switch can still
schedule them out through the leader.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 kernel/events/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe33fe1..5bf8053 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14230,14 +14230,15 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 
 	if (move_group) {
-		perf_remove_from_context(group_leader, 0);
-		put_pmu_ctx(group_leader->pmu_ctx);
-
+		/* Keep siblings reachable by group_sched_out(). */
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
 			put_pmu_ctx(sibling->pmu_ctx);
 		}
 
+		perf_remove_from_context(group_leader, 0);
+		put_pmu_ctx(group_leader->pmu_ctx);
+
 		/*
 		 * Install the group siblings before the group leader.
 		 *
-- 
2.54.0 (Apple Git-157)
