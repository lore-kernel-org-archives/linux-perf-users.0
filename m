Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618234;
	b=iYoW5K3BFlkqDNZPCLKO3rApZx4iMxAflmSWaPh9fHY3ntf9uUWaEmdaMDaAZEChTyuw
	 31qb179XreXn8iOdDNOIaf+Q44Xpb0ZeGR/pq7sL5bcC5qvkHZ400vPkteP0z+OGM3y+m
	 jZs4k4CfI80KOKOl9hh68xeU0b/Yd4WQ9SbLvZAdqmoXV7gaLVkpqVon00FXG3GQe/6fO
	 +I4LcX9YPwog/pG6HmNAPg47fp9uCpqgzMSy9IuuEjPKfIUrxJarjy88hdwFBkldfTof/
	 J2L5EQeqQRpJXThAQwtG2AMszYMKPL4fKKSnUKiIxNu22qq9cdT9C1nXwv2ZYiUJIEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C4qcYKKvyhn1Crgt+VJMLJb3fr6kFe4uBJb+QM5xlKs=;
	b=pIyFxf4b/179Oo5nvza9X3Z8eqKDV83f1CKVk5XVR4D9qxSLSjlXpEYAv+a6EaKbXNPx
	 S8c+aueK9kmGP9FebUh+CcPKnnz8BqM/H6kJuyRynEB73jhja/G9/1NNh5p8yWZNxEeXq
	 fJjm23NN71h+0nAYIzZY6oDjQ+q6iufPgu8T4t9CM0b+LOYWFTNoRRJHTux/pXFKGbLyi
	 Q5m8Lz/MKJDds0wKPQhZDXgAY/2b+1uaHPerAB/+yd9kxnzE5pOS/8l7c3A+naAl6slNM
	 kMxmd2HHa+it0x0gP2JWDFqRoDULBh0f/K0SvgM6ABXbPcuDQNhxt7CLVhvDbn9kNeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IiZ//Ve3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E9606A32F;
	Wed, 21 Oct 2026 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiZ//Ve3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0241F000C2;
	Wed, 21 Oct 2026 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618234;
	bh=C4qcYKKvyhn1Crgt+VJMLJb3fr6kFe4uBJb+QM5xlKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IiZ//Ve34Lsa4kjnJgE39atOGB/dAicTMe7Nt3s0OJkpu/nJGL1zkCRppJX2fiPI9
	 lsb0xx0DETkCr53brDt2GSigMT9HHJfBTuaPIxnLEZsY5G3AdFzLOu40My5vI5UfHl
	 N7k67jLdANOes/vtADn0bTiozouZ281EKcwaFDlhxtijFWFFWnOtEhcYAHFjgkvk3B
	 rSviH8aobOeyI10aJ1sO1qmzV00Xt8o2UZMhTcM29antebOcL2ZGXsBfEjVViJDE9J
	 rWwI4+D16DLfqRoTlyU+jkdx/FowQpzDWZQPL/QRKp5C4vqYCF1rV7b8StxPfT8qPW
	 6C8Ftyxmk95og==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v1 04/12] tools headers: Sync linux/gfp_types.h with the kernel sources
Date: Wed, 21 Oct 2026 18:29:58 -0300
Message-ID: <20261021213007.21046-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021213007.21046-1-acme@kernel.org>
References: <20261021213007.21046-1-acme@kernel.org>
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

