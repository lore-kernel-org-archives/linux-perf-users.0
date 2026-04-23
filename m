Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E673A872A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965760; cv=none; b=RXExSErt6E7yTSsGUDM5bcIx/E5gKxO5FGasfBn1F+kDx/H+7ToZbTMnnbnMmZxO6q5/0UDIGl/k+W+lOZm8efeJnvnQFIUPdb1nV8JT1mP0RkaIGJOSwSZL9d+5Rj+ZB4DLIGZB0mCnC4A8/NwGRAU015qoYKOwb6EVwDLlP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965760; c=relaxed/simple;
	bh=kbu91miAhJ/uxreLuzFTT8fU/t806GJZgTxiktjnF+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tA54SWrFfsI1sYzYxdOhMXLwxZ+mvR8AybVy0p9kxSPuaZnSpjkBoUKrBbhTin4dv+Ib2rllYbeFn691CAyAeYFHrJSLDdzuIvkH3Kjt7vcUHNlJ44ld5WrmLy+oUsEQ/DyUqN4E/uY/SlxjBfM/rOJgtKcYkKLRBZ/d6Bsvhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2jOcB3m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2jOcB3m"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so3666307b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965758; x=1777570558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+m8M29eqk9de6dbvvJWlkqdX1t+b6gyj+kzk8w80DI=;
        b=j2jOcB3mqGeo/+M4JjcbG1CpQsQ/qwgytYMOS/RAZjOkwt9GB9GVF/dCLPc4wNY3ap
         xNnfloRPANLerIZ5OLMxXpSxMWf3ntywkWfb8BA2IrUdrnR8fkaExtXiHjlfgBT07Uie
         30j3G/zCqD7s21tRgfLJVyTyP90dU0oGbRCbZx7HAuWUMGL0i22nitRCSAzw+ktyZUiI
         C3xNIvHEsX2r8W/ODIQcjiJFRlMlyLAWgBqKam5gMTG8byqhByHJ52CMMndNbNk2k2v/
         8WmcuYPz72hvOf2KsILgyigayCgtiv9tEXVp1r/xrn5KqkFkX2cOLeedf4ZUrwG8u7/I
         ZCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965758; x=1777570558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+m8M29eqk9de6dbvvJWlkqdX1t+b6gyj+kzk8w80DI=;
        b=Q0OU97GN5fntxHM29xHRzyMhO15OXIpow73bUiwSWpKDY5dSLGwqZ63BUr5KqOk+ZV
         HBmSDg00EQZkimsuAGUc1heqIp3Optd3n2Y/jxsdF0StQ4NoU9LvxJhca3ECLnRk7oiH
         +XKJXmrS6lmBhhWTFiNZ4ijraZy3AWksRlG/FCsrYmDBS5riTkCpQZ+4LzCzyo2QoLpQ
         EnOu+uVGPRhCG1mBUn8eqGO066M0otwF3SIwVLs+xN+d4hLXwSRDQe2Irq1wKc2XmLu7
         ts/wg5yxZLrqdAyBokO5ry6SmouIu1D5XDC8aKV5wxKhpUhbOVId8OEMnd6e9z5T8SEG
         FXyA==
X-Forwarded-Encrypted: i=1; AFNElJ/HxHwUQZOUFZC61pr4jjRyjxI1O5ZWXyNhdop6VFfBBk7yl/32iqblSw8WBDt6ayKkbF6hRw1PPDzilvF9m0Yv@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrnHrNxRBc8mbpzkNCJHK749+ji5tVBmIN9vNuRM9dHz8YzcX
	IShrDS3ynHsZycNe5mIfxly7/6RsbdE48hvnK95k+Z+SqhO69ei/uLE+
X-Gm-Gg: AeBDieswdyBr+56ZqwkOzGfdFcxdzfDOc9o/Lf5n9QjCF1qhATFOLMzt10aFK7C3vAh
	nND+dfNiiGEqSdScpSA8qIc9kT2THpxICRWV4A/umILc8tP5Mz6s+m66dRYxpGfuLJ9Coyir01s
	/SfY/X2tvaQLj22y7CNBHqaAY6tM8rDylyu35vB/9kiluI3OA+g7MdCOH4GeJ0sqB9jEySVowHh
	F0JnBT+7oFy60ENGovdv0bylpBas1nvZU2Nnr7PrUt59b9SKEXUgSktUvlsjRg4rX5Jnf+usVhE
	VmnTISBiaDP5PvbH+391nmKa3F19seOciRDFkTHaeyaRU99/IIfCH4OXiAMV7XRojqWy0BdPdM5
	cYiT08vVRmD0h+P8DfiwsYlN0KGuXeA+8pn5G91Ua6Gu/s4eslax6Odl9h1cGpoT6KWxEOMG44Q
	qaxf5qP+iaPJqQInh+4yC9OtudRC1FZriXq3GiyU1CQuK2R85RoH5A
X-Received: by 2002:a05:6a00:e1a:b0:82f:7bec:2050 with SMTP id d2e1a72fcca58-82f8c90d174mr30725301b3a.39.1776965758167;
        Thu, 23 Apr 2026 10:35:58 -0700 (PDT)
Received: from archlinux ([205.254.163.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe901csm26171363b3a.48.2026.04.23.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:35:57 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tycho@kernel.org,
	suchitkarunakaran@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] perf/lock: enable end-timestamp accounting for cgroup aggregation
Date: Thu, 23 Apr 2026 23:05:05 +0530
Message-ID: <20260423173505.73223-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_lock_stat() handles lock contentions that start but never reach a
contention_end event (e.g., locks still held when profiling stops), but
previously treated LOCK_AGGR_CGROUP as a no-op due to missing cgroup
context in userspace.

Fix this by adding a cgroup_id field to struct tstamp_data, recording it
at contention_begin using get_current_cgroup_id() when aggr_mode is
LOCK_AGGR_CGROUP. Capturing it at contention_begin is semantically
correct, the contention cost is incurred by the task that had to wait,
not by whatever task happens to be running at contention_end. It is also
preferable from a performance standpoint, as contention_end runs just
before the task enters the critical section.

Update contention_end to use pelem->cgroup_id instead of calling
get_current_cgroup_id() dynamically, ensuring both complete and
incomplete contention events attribute the wait time to the cgroup at
wait-start time consistently.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/bpf_lock_contention.c          | 4 ++--
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 +++-
 tools/perf/util/bpf_skel/lock_data.h           | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index cbd7435579fe..1a5bd2ff8ee4 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pid, u64 end_ts,
 		stat_key.lock_addr_or_cgroup = ts_data->lock;
 		break;
 	case LOCK_AGGR_CGROUP:
-		/* TODO */
-		return;
+		stat_key.lock_addr_or_cgroup = ts_data->cgroup_id;
+		break;
 	default:
 		return;
 	}
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 96e7d853b9ed..139199811020 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
 	pelem->timestamp = bpf_ktime_get_ns();
 	pelem->lock = (__u64)ctx[0];
 	pelem->flags = (__u32)ctx[1];
+	if (aggr_mode == LOCK_AGGR_CGROUP)
+		pelem->cgroup_id = get_current_cgroup_id();
 
 	if (needs_callstack) {
 		u32 i = 0;
@@ -771,7 +773,7 @@ int contention_end(u64 *ctx)
 			key.stack_id = pelem->stack_id;
 		break;
 	case LOCK_AGGR_CGROUP:
-		key.lock_addr_or_cgroup = get_current_cgroup_id();
+		key.lock_addr_or_cgroup = pelem->cgroup_id;
 		break;
 	default:
 		/* should not happen */
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 28c5e5aced7f..652e114e6b87 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -13,6 +13,7 @@ struct owner_tracing_data {
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
+	u64 cgroup_id;
 	u32 flags;
 	s32 stack_id;
 };
-- 
2.53.0

