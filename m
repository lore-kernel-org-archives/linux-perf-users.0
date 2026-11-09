Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222273;
	b=S31atOE0GK6b/ORqm578L7LmAwraZATY8YL1tr1JtldUPASkcu9k6yJdln+rwcn/rNRg
	 2ryA51TRiATY/rYSJZG0T+vftgbx3g11dkviEvS3elrASmo+6XlP0g3QRggGu2nV6OmMh
	 YrSrjV/R89Ip5sw8+lSpItATnsV/lTdHeyMMTtVsX9Bb5wiNoz27FTOMgC5YDLseQmkai
	 AVXnR16F2GYhegnUmdM4hQuYICjukr71uGkihdBHM18OkT0+WDDSocOUiQCuvHE4PxYga
	 OrifQov7nFtozooy4yDWmS0ACJwMuKXyWkLOqgsCnyBmyFlZjxU+9NyuNLv0lVH/DqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222273;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:X-Mailer:Cc:
	 Date:Message-Id:Mime-Version:Subject:X-Original-From:Content-Type:To:
	 From:X-Lms-Return-Path;
	bh=Y5Lzomot2LyKiavuKiwRHLXi9C7DIBS9PkpU70qoGZQ=;
	b=xcYT3634tzWQbJ2sAuUgEyIkWHc5Kx/0yghvYRrQHMlWIb68oo95GRD3dNnvhh2F5TFl
	 BO8S+VykE6d6gvyKy2clAppFAnGq9ExeGLSDs+BnGQYtn/HS+HKD5CBhxajhM3MnYEW8o
	 kZhUCXJUuyvc+ZrDuQQ0P2z9aCvNxTyMdYjLwT6YIZNpthohHPHSD5FAX9o0WbTUKfzKe
	 gBoNHaafDaKo8qcclL2SL3p35HaxXwB8wzjxo72XcGIrP1s+klzcoiRzuJaR4tCPN0uGd
	 CYLfELRr6BpxPTsyJlykOlHMyoDEZ53SPiNZBC0jb1x2mAkLj58R8DCye2e/GfNGKOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=haWrxf6C;
	arc=none smtp.remote-ip=209.127.231.113
Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F9606A325
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=haWrxf6C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794222265; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Y5Lzomot2LyKiavuKiwRHLXi9C7DIBS9PkpU70qoGZQ=;
 b=haWrxf6C94JWYif297/Q/Hy3fL1sRedEs37FjuZXdfVnmL9yP9izqWjjgHJqVMr6mLupl7
 xCjZf0HU1Mh0RmHizYtqaAYXAmf10kOnIbGyDwAp6JhmkY3klHOZDH5A2Ph8kxHOAhxVut
 LpMcCox1ot8rijGaA7c/qSo+kE802RAAYpXKMfj2YURJ8T7w/753Lf2xVG9ZA59Zarwg5I
 ZgxDSpvny5Dwn2jGYuZPI+eRrzYlm0ZZMgdwU3dSfISD7pkAB30pZaq7meAV6eGBYk+fey
 QigLZORhi8bLo0L+Wnvigb6JJ6COtyBl2lo0bXFZr0IaJSaazmAIGbaQtE5ERQ==
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Cc: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>, 
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, 
	<irogers@google.com>, <adrian.hunter@intel.com>, 
	<james.clark@linaro.org>, <x86@kernel.org>, <kim.phillips@amd.com>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Mon,  9 Nov 2026 19:03:56 +0800
Message-Id: <20261109110356.27709-1-zhaogongyi@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: [PATCH] perf/x86: Reject pair-counter groups with no GP budget
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <peterz@infradead.org>, <mingo@redhat.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26af1a8b7+981cbe+vger.kernel.org+zhaogongyi@bytedance.com>

AMD large-increment events reserve an extra GP counter. A syzkaller
reproducer opens a perf event group until the adjusted GP budget is
exhausted. x86_schedule_events() then WARNs on the unschedulable group.

Treat an exhausted budget as a scheduling failure and return -EINVAL
through the existing cleanup path.

Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per Cycle Events")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 arch/x86/events/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4e344fb1a..20ba7b5b0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1246,11 +1246,13 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		 */
 		if (x86_pmu.flags & PMU_FL_PAIR) {
 			gpmax -= cpuc->n_pair;
-			WARN_ON(gpmax <= 0);
+			if (gpmax <= 0)
+				unsched = 1;
 		}
 
-		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
-					     wmax, gpmax, assign);
+		if (!unsched)
+			unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
+						     wmax, gpmax, assign);
 	}
 
 	/*

base-commit: 59f1398140869432c7171b9a2a279ca315467c4e
-- 
2.39.5 (Apple Git-154)
