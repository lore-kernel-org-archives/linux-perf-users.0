Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3336C9D1;
	Sat, 21 Mar 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090789; cv=none; b=oP489qySfmaqibV3VGvrqC/45CvJjMQgbtGFIj3K3a+O5nRpEKopX8bvXHhvl1jWVIkugvJNdUPHTHfAHM+hOsIEA82Vt0ynDq2+k6ctPUq2HVSsKyx/pNMQnuXf4rOrpxABcn5vEWQbSixUW6t3AZGKLq3QYA/jlDQXU4ZrDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090789; c=relaxed/simple;
	bh=l9hc0FlCNbSSXlfftXMhIcgT2lTlb3L0L7K401Z3evI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvmjeexL/kKZwXY0azNGBMUJyb4g8jkSz8WXZpIh31QebLep1RtgDBW3EOcmcYs13OvksNs27/olS6sn4zbxSAUGKlXXice6lpROeJQm4zwPd6Cfqh+zkNyYnLN4JmnCrGvlQhb1+oc+Mp0NwE25MhzGOZlQD0V3Lyx1zNj1AJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=E1LbIaEm; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="E1LbIaEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090720;
	bh=tULSZOujYEogVxJi4Udhlq1PQ0TiddtvQzXXkFi2F6U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=E1LbIaEmUTFTx1HfA864b82186Qepr9ATEHuBASD7agl9b8/sShl0EcHtDYIBXPxO
	 UntD0EIsxqFIFxilIQBr+Kp9yl8jo75rcMfyD3VMmYvIlgutheprzeTAt+XYJfDf36
	 1CoejVAVNoR4Nr1q6kHYnJ+cNwA5RgmY8GBL242M=
X-QQ-mid: esmtpgz15t1774090718t1390ea96
X-QQ-Originating-IP: kbZs3Li2vd0xPbbQyOwSBVPzuu1W27jAmTirPaTeXhA=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:58:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16548554169117854485
EX-QQ-RecipientCnt: 17
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] perf/core: update outdated comment for refactored ctx_flexible_sched_in()
Date: Sat, 21 Mar 2026 18:58:35 +0800
Message-Id: <20260321105835.7389-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MKnpPHYEGQ6FnPMopnBLPvV4eJAiyjRianaLjYl23dHZACMGLZbWOvtp
	pDyHkOJMmLTMsaMDY8jlfWv1FqSExouMPbDfv2kllp8BuFKBou3xkxPKmHLwzvq3iF9/FHn
	RObRyN69kq+1wB7h7wfQlYJqWf/U2MSWJHehdbNbMiVt6aLvLUq+lJ8KSExj2dmWQqMzcKm
	/cgx2o+f+8bHE/8KKa793U6C7TRUMr/1etNJrqvT72x4+JoBeLPWvB+pnOPEANlhBQPCJ81
	1w8tG9KMF0NqyG3Q0C2HlLFiOon7OiOxMmY+kWvq/1BmifQpgLPtsIkQ7Nq/dUVctmthl02
	P9nHKAQBFIfBLYHvRxabAiNteBt1pV1lchdWDowdEBUMCmW1iGgEhA2xGrwdY3unklYs53T
	+PJYWbgVKobkg3GtkYEb8B7sKCl3t4kFe9xWHrqPiAHIaSD3YmJgasK2BEO49JJFsso6+zx
	J6zIbmeWyewlbMQvR07hBJlz9GU032NLs3R1nwqd/O09eV2Eh9O24WXJ/lAPZYavxzwR67r
	ubNY3m9cyGj0TCteRSr+50O6WH5cMhynYY+H7bCrGkzNIa4R8Z6leAahPp0+7cMQhKlhJsG
	92ikL7paoIf9jrGCJZnfAKOP8CoTh5WS+VL53iSxB4H7KV/TdzLeyvWPnxsgsl91yDjdX23
	Ip+oL7Y0iTKpiPSr7m7XD7Swnwd6gdpoi7+tsIwTZSqbDhisS/n+2dwntbJI93mM+h8RPc9
	hAD7RsOIyPVEBTj+Zl+Hfwr1EiX0/xDOmzXfu24UykOJkM3FnFX8ytbQ7NYVhdVwE5LcU8b
	FGL9TSySITXwHlShdbAKgvNho4ZmApzy/4RypvwddvdSOPNf6EwnCiZiUFGuPJyE4IdRDiK
	1VnXDNOhaWtEWnm7Fuo8lBjCkrFWhlLfXDUJKjt3dk71ojK8ee8j+VPMTOBkVF4eyobFBj8
	TJ1iQ5PyG79Tqog2g6Sx0ftVjB3mz7FfKeKn14+/SE9zOHFQYnqu/YZIjs6as6jSvNNqVmn
	43zcsH2PRqtvDQ/+qUmOtPDwVMCxN/K5e75rhf70fV2hnAC90tY15RBXdgVsbRlKrKEHlCD
	1zHomuBn9MG/s5iSW8L+uK7iSd23GXB+g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

ctx_flexible_sched_in() was split into pmu_groups_sched_in()
for scheduling a single PMU's event groups and ctx_groups_sched_in()
for iterating over PMU contexts by commit f06cc667f799 ("perf:
Optimize perf_cgroup_switch()").  ctx_groups_sched_in() was then
folded into __pmu_ctx_sched_in() by commit 2d17cf1abcbe ("perf:
Optimize context reschedule for single PMU cases").

__pmu_ctx_sched_in() is now the function that schedules flexible
events and may re-set rotate_necessary. Update the references to
ctx_flexible_sched_in() accordingly.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ac70d68217b6..463440774f26 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3556,7 +3556,7 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 		/*
 		 * Since we cleared EVENT_FLEXIBLE, also clear
 		 * rotate_necessary, is will be reset by
-		 * ctx_flexible_sched_in() when needed.
+		 * __pmu_ctx_sched_in() when needed.
 		 */
 		pmu_ctx->rotate_necessary = 0;
 	}
@@ -4575,7 +4575,7 @@ ctx_event_to_rotate(struct perf_event_pmu_context *pmu_ctx)
 
 out:
 	/*
-	 * Unconditionally clear rotate_necessary; if ctx_flexible_sched_in()
+	 * Unconditionally clear rotate_necessary; if __pmu_ctx_sched_in()
 	 * finds there are unschedulable events, it will set it again.
 	 */
 	pmu_ctx->rotate_necessary = 0;
-- 
2.25.1

