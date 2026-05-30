Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E222DF717
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171195; cv=none; b=e8g22sx2OO2Bi2SEgdhZVjM38xppq76kwdoz5pu/kOdTlIIFOp/kX1RoWLmDAnN29jEhemRoUnnJpGHOeZgqfm70N4OkIR44wdAbiFHLXXRwXYoQHRWsad8PbNxwyyr8LdeQIVQFCbxQcgfx6XUSmshPaM4Ctd7CCKLmNpFYYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171195; c=relaxed/simple;
	bh=5zJusSnBR/65awI1IGCM4CuwRdjvqqq0/RBbB7KSKUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVcQ9EfPQwTKDAKB5G8+k12ntVUq/xgMWGzU0eKhGYwBW5DGtSYbQTPW6ik8gCY6vtpctoPy1q0YlkxXTBuwDdkpoA4N0oudcSJpea8Hs4bIhprz8p2R3wku5tcAxP5c4KbQ18vftSjYxoTnAKOdygqgDinFpW+O7XEkiBHlDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxpdGeV7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxpdGeV7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2be1dd4af34so135763275ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780171194; x=1780775994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xWnFYquKZAEN4o53+EwT2fq4AtPddIjzLexfT3gRqtQ=;
        b=fxpdGeV7xyVY2GVfX3qaXI24cZw9tAyW7N5xOUnaQ58P50u4ld6Oleu3wJ5ADswD3A
         2BeWG1M9jUgDF3tr7rPkoNWrc5Rt82zry7aNCrYMD3+xNgMMUuEU+QZ/19zOhI6s0p3/
         qWROyCq6XJI3SY6HMWRrAiumJipmhv9chqPxGiuaexNFYyOvil0E+Q65b+09VrJtJEiF
         oYsHo3a5vugBVbNjoQzd/6kM+/hfN2uqjfigYChkIJl9inFpbMKzzjnuCj164tJS1TB5
         ZVkiWyvd7/4xbckY5hzHZPcjYHiSPlLZOieRReuv9WtiFbVPP2QLIDwD5jVTtdMOPxCp
         IHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171194; x=1780775994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWnFYquKZAEN4o53+EwT2fq4AtPddIjzLexfT3gRqtQ=;
        b=ClZsvmNY2DwUTTKVpYHWpV0UNCPN735zl4AkPBW7e3huTWLX4W9r+zU0NWOhLXTBUD
         H4mNbIi/v8ZXSsHkzL9ru2mhMgUiMXp+ExRef/NFmJCXcrb8FwWi9/YqeoWlKum1oWsr
         LTAzsmim5rKAB36zDS0Q2DHQ47r9BHK59JvVE2f3qSNgYAVS5+B0xJrx3nmuO0LcBI75
         rARv6WmdVpuHmVAREllxkDm0PHqNVSBBbMUX72dcMwzL6TUrR7am5wK3GM4u4sozzLf2
         IYqoE2Zk8MHw6mPZ7DaHmvK14xHPNIM3JtR77GY+wTl0gdo7qFzJPghZsVZuovP4GhyH
         uvDg==
X-Forwarded-Encrypted: i=1; AFNElJ8KysZ6c8WMj9fSuLwFS1EadfeN8En1l4PBaxrxPEfezpTWIYYgm9jWp2n2JNcb+S5F0NErxe9d+3bH4VkPri6e@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQ0deistc8aYLKV6lqU3X7N8dWEjTkDSVoVENN9H1WmZOgoV0
	j+SfZP1NSb1xp4A+OCuP2co/Ef4sRgIRbS/jAh62IirxJd2ruSFSqHmENCruCw==
X-Gm-Gg: Acq92OGFmyDNT5jd9XJIkjkEj1w4z/htE6w02zDYwEf6dHkOSdO/KHjl/h5Q8cEed2T
	BKetM8o6VFMKFMB5eOyABnWSzoknvIE7XCIUd8RZWsc+dv8Ivbe4WgRzCP+kWP0YFo3NWDuPNue
	zm3nm6NolE8u2B2FC/flovK5N5fvQJ29XbrgPoTIxHZkakDLhW065n/VAUApyEH5uiJGMZ+rh69
	AyOtTshbpW7vzAf0ohJXvKgcXoX0Qx7Bx+zmMWBBruJWUgTsm5QfehKrtYVv3BiWWuhD8ENnSB0
	3udLEtie1HtyfTrXDMzpBFIjZFUpCvRZRw5XRMqODLJG080JKHPADYUNeOiT0xSs0CSazljDw6R
	yMuPug7p+Bs27TG89sZLgxM+FXh3+2u6TEN1FLwaBwBi07D5LrQY4fJ8iYZ2kKUp5/JnrkDJWRE
	w08+dRwXnLqLBMHZ6LA+y9ILeZaK8RI317ZF2VgHTkvM8=
X-Received: by 2002:a17:902:ea11:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2bf36793349mr58275845ad.9.1780171193523;
        Sat, 30 May 2026 12:59:53 -0700 (PDT)
Received: from archlinux ([205.254.163.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772df0fasm5178148a12.30.2026.05.30.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:59:53 -0700 (PDT)
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
Subject: [PATCH v2 RESEND] perf/lock: enable end-timestamp accounting for cgroup aggregation
Date: Sun, 31 May 2026 01:29:40 +0530
Message-ID: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
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
2.54.0

