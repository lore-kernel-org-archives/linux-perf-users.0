Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622178;
	b=SnQH1P5S6QE6xK3D9Y7myp9PZOR6dATub7gnWRwy7I3IGnrr1HhhLwn8cL8EDHbH6xsV
	 53VxjdT7SN4uNhcSeUNh4f7r6ZcouqZRMiWN95e846wxMneW7Vvn1FVuvIY+XSz41wtID
	 GWzf0vUDulAWUESQ4VY/gLo3E3ltNKgVJeGIklDsnYidWAse2mhYFInkjIaS5l99YeOdL
	 7WXTan1zWVfXTXYm9f19iOZ14T4jNl+HfBSfxyGXw88wEEZw9nSo2RXmNMav7igdMWp34
	 A36oUM3jOMTfj4oeZY4I4sqcnIkPyNToE657klnQDWi8hmc41+iuPkf20l6pHvtX0mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622178;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C4qcYKKvyhn1Crgt+VJMLJb3fr6kFe4uBJb+QM5xlKs=;
	b=5asBfUwWHtOBUHej1hFtsei7RXen95XMgg9qPhsi4gBwwcBcnFWj5jWixbOJ2Vmp1M2S
	 PjEXXmXbp4Rcv03WYP4cf8/FegrAKO1LdzI79C3JFIefSSYgQ2yNhGqLQpH7bDbecMiSW
	 o6AbsDwwFtTSFNuPg2JPgjBtpCh5+n9YevgreA7up9hKmi5LlQC4ixXcz6rywX2pzkk1/
	 QwDIQD4rc9zxh3x5pfAoVB/1PzvO88qPxVMMTjVh40xccgBT8FRRJm9nXGBN2ScL8h59G
	 YUxOjY8wIprlSSs4sQQmLWFZ6tywjHSrgF8EYwjciVczi5FLtgT/J7SepGQ4zGLEscg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dk4aUohp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1349606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dk4aUohp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D23B1F000C3;
	Wed, 21 Oct 2026 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622178;
	bh=C4qcYKKvyhn1Crgt+VJMLJb3fr6kFe4uBJb+QM5xlKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dk4aUohp5HC6x1/Z6X1NcwZnSMhjc/t8LMfKBCuFNjEUTLJHz/+Y9XhjzH24oqK9L
	 cCRAwHJltY+4jO5MUT30gv3xnJiNi2p4uYmGN8Fkx9jVu5kt8Nn0j+8+fbsJZXjnzH
	 L8QU5N0I3uLzHDU47U1UQNdl8Ny3FXTXTjhUBrh2gX1dtwevCwsGoI2vZHXXeJzUou
	 yZcIVHGUEhgHDcPFxAV4+69JQEx8XXq2xvWqGEbQfRE4po41qlwYQJYk3yFYSYB69Y
	 P41/LF3kX6WvFQ2BSDayYGDa4uegCqIpiwRHlj05CZXCmyGNekpHYenjC2MtBbNnrW
	 B0tIpuSK47cMA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 04/12] tools headers: Sync linux/gfp_types.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:43 -0300
Message-ID: <20261021223555.28372-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  f6c786a95e95 ("mm: gfp_types: fix __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT documentation")

That just rebuilds perf, silencing this build warning.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/gfp_types.h include/linux/gfp_types.h

Please see tools/include/uapi/README for further details.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/gfp_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
index da47aa089f01c992..190191411009f265 100644
--- a/tools/include/linux/gfp_types.h
+++ b/tools/include/linux/gfp_types.h
@@ -134,7 +134,8 @@ enum {
  * %__GFP_THISNODE forces the allocation to be satisfied from the requested
  * node with no fallbacks or placement policy enforcements.
  *
- * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ * %__GFP_ACCOUNT causes the allocation to be accounted to the active
+ * cgroup context.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
@@ -313,7 +314,7 @@ enum {
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
  *
  * %GFP_KERNEL_ACCOUNT is the same as GFP_KERNEL, except the allocation is
- * accounted to kmemcg.
+ * accounted to the active cgroup context.
  *
  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
  * reclaim, start physical IO or use any filesystem callback.  It is very
-- 
2.56.0

