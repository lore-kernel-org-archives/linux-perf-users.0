Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5423BA24C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710837; cv=none; b=mG16Ew3FieZxT8hK117bcnI6ExZ8YnrSJdXrFdeCvw7MTzCLoXedcsc/ySf49mczvV4isoikWBLs6MUrnRaQE5h0GeLac893WsnxfzL5WWsFKMYugqzoilEmLbrGKbFA6asUFqBqzpAcnvjv0HgrUoaoyvjJ0ZmsNEnJsAY89pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710837; c=relaxed/simple;
	bh=vW02KOU5qndWFI5Kbr8zih/4D7EhB9UqxDCMlU5uBtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt6hM2Nv7jbs2C0FaJMQw9Sja9MwlnxjdvLd8pMkAOUEFtOS20ygPGLdXeit1Wgaa8aXKS+XO5W1yCvk4GyTDIqXC6jAWPpb3J1Qg90CjaBLATFv+Vsc1JkRKJo8S+wvl5SJoxx6t6c/FY0DchRvAC+sRXOvd5nMPLCdDStTCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7VfrFoP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7VfrFoP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso22276415ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776710829; x=1777315629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zb1CzXElV/JafdZJDqAqdzrpLqJEbxaPbWiaVDaWpI=;
        b=c7VfrFoPzfksxrVeKnfwPUcPAmNou4e30BlJP8q8rgwgTE7Km/f0qOvDPrg48NUD4A
         Ym4ST+iPmDXhx106c+h9+yOATQxcAHbhkmYv5COGGsPnydF6P8KkVWWRFv09tU8cwOOQ
         AH/nGvpXtlicD6RD60yjSU1dqv2/JefDTop/WAOv2DNGXuohlY50pYL65EMQobiPWn+A
         smwJzNdlldSs0S2yxZLynHC1hElB0aOanRjrzhTdPVzcF1oFhG7M51QJm8Q2975g49Bx
         Gx6ULK+NYFsQFd2uFvcTPGaiWntWRGabg3kYai0q4yz1sSkKGUoc4V/QoqVJvIOJHwJB
         PQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710829; x=1777315629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zb1CzXElV/JafdZJDqAqdzrpLqJEbxaPbWiaVDaWpI=;
        b=pxYLGa1mCbL5RqYK+zJEaD/Z+Ad8CL3tLJ/9ji9zhm+/Xr/dzHqy95Y1FaDygufSdM
         VlGfmHgWjuIelB5BITRH0oign3gxetSAd7pf/+I7hCtwFqhaTw/G+XtRcOZ8icVxlnIa
         mLNdi+6DexeLYzAzfjp9bbc5GFRP4rO5aaD7jg6xi/fcAPdhFNUHrDa1QIHnfNkUYEZA
         CSxpmF3eWaz+shvGWDWuA/eDQjec3bdk1xFlQxmMObeGZ+x5/Cr4W/DX+kEsNmureScY
         M5my/RMLtQ5xzZ3vkeilTHRqksCptdhjyfnA6jokX3NBRSjRCXVCoNRERbtkHTSLkhI+
         BFPw==
X-Forwarded-Encrypted: i=1; AFNElJ9uQldYq9T4oEhAtrYqj7jCvDHskuZat24ztf6GpyFcN647JDkQPMKjwI4gaUc8EphP9uM2ZBEAV+ER2idkvxVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YymlcnHdWpOP742lE83hjZ9x/Uuj9A6c6+7y3Rl95rRvFgUEzVu
	abgHqDH0RjLSufOzZHeagYiX+893zgOnh8k81TR0fiRu6pJJQ3uaMrEN
X-Gm-Gg: AeBDieuT7v1xXo7iaowZpI0nxkXguKQPJ+RH6k4l2ZCC7/T24xRIUC8wAwmA2K8dCQg
	YqsWODNfEfI5OeeNGnaN7bL/sHTxio0iiT6esY5nUx3P4+g4pcf2XSZHruIQqz3WCltqRkXZlAE
	agROkxP1H6iiRHEI9rdCoaEy+GuJfPxnkC3KIAgTHYi3WoEHpqpQSzHsv1VVrRf3zMrFMV6LjOd
	fm2qbx5tcm6m6AyAk8+zvBalAhmcCwVU+ADk4hFzTOPXq1PDTt3qSOG36cSnRWeVzJnwhIpb5wI
	/8iwcWCmn5fX2BRtdHbPwS70mdx4U5csUKXT6n4+21eDzbIq2NUwRTNJ8/hMC5uFdOQM3me7WW6
	kGTKj2uIj+/Jkwv/S4xlz/WqAI/j1cfcT9DBoLu2rTvYEGo2gQrJgDeRVLLpA6j9QCd7l1PXCwX
	FgqqwCGJgXoMcfshrpKFYLY8t3t2BiiSye7A0wY4vIkQ==
X-Received: by 2002:a17:903:11c3:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b5f9ef78e0mr130724395ad.28.1776710828613;
        Mon, 20 Apr 2026 11:47:08 -0700 (PDT)
Received: from archlinux ([205.254.163.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0d0f8sm103913295ad.47.2026.04.20.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:47:08 -0700 (PDT)
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
Subject: [PATCH] perf/lock: enable end-timestamp accounting for cgroup aggregation
Date: Tue, 21 Apr 2026 00:16:56 +0530
Message-ID: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
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
context in userspace; fix this by adding a cgroup_id field to
struct tstamp_data, recording it at contention_begin using
get_current_cgroup_id() when aggr_mode == LOCK_AGGR_CGROUP, and using
ts_data->cgroup_id to build the aggregation key in update_lock_stat(),
matching the contention_end behavior in BPF and ensuring correct
attribution of incomplete events.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/bpf_lock_contention.c          | 4 ++--
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 ++
 tools/perf/util/bpf_skel/lock_data.h           | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

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
index 96e7d853b9ed..d0e2cad02fa3 100644
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

