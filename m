Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE034E747
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642599; cv=none; b=EmfW8FtKlCL/3CDdTBaiHC6K3Oxx6xOE5Jl+lqh8m5bjL9ru4g5kiNZ4jxi+zsGhEIZdVV0z0U28LnFEEoWzefUV8OsfiImVOrhmXjV2mNUZEak0Vg4k/dgD0/b2HCfL/1ygtUTSX96r6IMQvlJwWg6mEjeqNFBfRzOMSc2lf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642599; c=relaxed/simple;
	bh=DXs5JCpWJKCEkc7iuBQoDcwCbXCOV4p16Pl+XZolqC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRhhpGhHJF3r3j1HNvYDOdbcfaXLjxR8CB1irn80e2Of3NifA9/HGW3yB+2RQMVxfVf/0Bb8wO0SHdPIHwMZgHYqQNMaKS1dsCPXuBsfiILNiO2/S+6NhgmFeG+q1c2EnRl7nckKvk71+r1lATDSs3XbGDj6lUXAkRATr5JxgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMPqL0/1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMPqL0/1"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82d029fd52eso3433835b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775642591; x=1776247391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AU2utJvkUidUfp4jkj+rsm9KrKFB7YOYVa4X+ttSgRw=;
        b=YMPqL0/1UUVP7yy5lTgHdAMS31hjcqNnrqPOSXzfTOquTfv7k8OhhjFpnyo8gUBwgu
         lgBnsEewW5Gok3jpuYkFBdKbaaXBmxRL3GG6U2s6L1pM1Li50BpVfxd7gu9nVXL05E2n
         OPmeEBM4zK4W1Zd9CkuOUbvwSSPiU5A/Np7hFd+4iLdeav+IBLZBHCEEkdhR7gtj7wRt
         kBFbuJn1EFkCw1ZykRCk4s18nMaBLIMPmy48hsuwgOZvzjcRVXQOPX/+wW0FsGttpY4N
         QLGeI62uGu0JVvuE6Xq8mQh8hG6g5RUBRMbXDzlmrSDdTr5b2mpaSOsfatNdVgGDWQuL
         KTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642591; x=1776247391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU2utJvkUidUfp4jkj+rsm9KrKFB7YOYVa4X+ttSgRw=;
        b=leuPBIQALN3XUjSDbhOp/k0nDVx53rqP1dtzG9647EX4IJ+ZusavDL5DfQfX0JoVZF
         Oe+qaCK7/R6OS3pqhLxTx0gTSbyeivU7+Hb/Bdq+U2+eUgEP6/vfJvopOF+AkrqZfY/U
         ITLYM7lz2ODoAFz7SdPK0RufzGLhhlGaeMyYizQ9fR7DF6YasDYtOgsf1IMGawJTmoRh
         FQrE3+qK5hhqOR8JLL4b6xjBIpzsSUdFFPR95mb7HD6BReMEtq8dtWniduxDMiEkIjyG
         HFijkCkXZkyfH4uwZ+GO35vlyaYYr92Ysbqcmy9R0Bmh6zN8Pli65MT5PTbou1Omwkli
         tQDA==
X-Forwarded-Encrypted: i=1; AJvYcCV3GO7/gZNvlpJOxOCt6YNa9vCnvQBQIZ4+NLrJE2LRIVs2Pps8sN4BSCXZcbCsLg8DppkTktAKmmrPqGs3AT+1@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2AFQtu+8OZ26aLeIfOLRJtzv2D0thMuQVc+lUcyhYvdXN5qA
	m6t1UWPJVNvb6bEDwWMM9k4n6MYpxV3K6v3y9FO4DeK6WOCqkPbaBrk7
X-Gm-Gg: AeBDiesbVVk8orBJou4eaiP/1D9AOlLgjllB6K9/0ShiU95BNFvWolcpq1mOvmU6JCo
	aU7ZauD0Sn6ViEven2XhQzZnwJK42tfbAPEZKIVG0wNmxwL0OROmCDSz9YIEzBznCi6I7eaJcus
	5aetKX+hdXfj3rzP7YkkHxpDd/svrWdBwFuSz9FeNY/KSa1CQUZnpn0KEVsK9uz2mpW9RPGzbGF
	ge+s164ycn6ynrbNk3zQcwuwVzUAEpW1GWfPmzBJSJaJ/EWBWB/zakmCe4UQmGLushAYfolldu5
	PlPjFCt/oPXR6SlB4IEcj/SIP+9JUxssx3mLrP4JabIOZlCN0NNbbQDM98YRqezZYhKQxb4YgzD
	jYFPpduVlZSa5bFegwRZWm0UvBI7wtmvA/KacBTvxAB/aKy0IS/h2XEJ1A8cJXXAhbkZ8X8KU7w
	NuJ6wR9OSLDq4VG0/RWYfT4QYRsh0hgrmduAdv5KV7lrKC1AkmNICPvykkGa5RhKq9
X-Received: by 2002:a05:6a00:950d:b0:82c:9f73:a33 with SMTP id d2e1a72fcca58-82d0dbb9944mr21611486b3a.44.1775642591429;
        Wed, 08 Apr 2026 03:03:11 -0700 (PDT)
Received: from LAPTOP-KU1E7KI5.fudan.edu.cn ([202.120.235.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3ccc8sm25654756b3a.19.2026.04.08.03.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:03:10 -0700 (PDT)
From: Keenan Dong <keenanat2000@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	andrii@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Keenan Dong <keenanat2000@gmail.com>
Subject: [PATCH] uprobes: clear extra_consumers before pooling return instances
Date: Wed,  8 Apr 2026 18:02:47 +0800
Message-ID: <20260408100247.2065245-1-keenanat2000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ri_pool_push() returns a return_instance to the per-task pool for
later reuse. The pool reset clears cons_cnt, but it leaves
extra_consumers behind.

A reused return_instance can later grow a fresh extra_consumers
array and then reach the cleanup path with a stale pointer from its
previous lifetime, leading to a double free of the recycled object.

Free and clear extra_consumers before putting the instance back into
the pool so every reused entry starts from a clean state.

Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 923b24b321cc..24b9884a2667 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 
 static void ri_pool_push(struct uprobe_task *utask, struct return_instance *ri)
 {
+	kfree(ri->extra_consumers);
+	ri->extra_consumers = NULL;
 	ri->cons_cnt = 0;
 	ri->next = utask->ri_pool;
 	utask->ri_pool = ri;
-- 
2.43.0

