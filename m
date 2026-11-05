Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793912214;
	b=aVz70P3+AKfNbNAYd7WV0+wSWPvfhhnigXB6g7CQnm/6i/LUZLptRqq+X20KbEE1s2M2
	 I1c+6+A0ZBoDTskI4UcppR4ZskgHYA0ljyuO4TBMErxnw8+urtVI5RupmPZSFtOAX4cUr
	 nrPN5gzVcWKeJF13TPc1dn7ef/me9FJK3D1ZkfWcV6srH3AuFBo4BZY6PeuTdOMX4Ecf8
	 HfgfTEhpCFw6v+rxhFqu7Lz9hYjKpggbFaNA4r1hikeGuR72cY+Cm+6tmH7Z/ELGYqz5l
	 1U8esMWkLHAB28ToQtT4005mRj/j5G3gzM90aeJVTYjV5RaGRS0cDkGnqM+yfFOE1PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:MIME-Version:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+X2CCzNc2pO0e5MDk8a84L4z7/VlZM8Ywfuz8Cg0lE8=;
	b=Xr/kHwZ3at57S3aawjCj/FFelKEJwOZUfht/DgifZePJQOsF9YAMqd4TUUV/ohZP2Jx9
	 rz+F9IK4C/m87O7SIAyhEBjvyrJxWjLBITFJYNK646a+fU8YR4Qp21geF/GnYC50bwej6
	 S72Bfctx1zGZRYmBBh4vCyXEkzGucnrH6kXwo3CmPTY0wklbLfsKsrP14hlnOMbnsEDn/
	 sYqdAioA5Op3Vyv1oJPdipgjsn5XfGIUtnxPEvyUY/GCS3l2GwRAVbMZEQ3Ywe0AMHcsD
	 lQ1GMp3r0/NXsBneNDM/O+bISmDczlCUgfGQ/+zW6WTSdqDS3oAji8GFTzMBOaFTqGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CRDX4tG0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FF606A33B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 20:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 521FF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CRDX4tG0
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c49c32650adso201041566b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 12:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793912213; cv=none;
        d=google.com; s=arc-20260327;
        b=G/eKRBF/c6lBoonlG3KtGHVFZcCBFYObIA4jQtv7ONzMB/VTbWwzexshr/8O6kSLxo
         0UzLI6ND7JLq7poJdpDiGvla2XkSosDys8KOSvl97tz40f8ZdMSYJqvE0Nf9bZp4VT9t
         njanVuTpBt01EL7MMKPZ9+HeibUQJ1zENIXlMsrr5ctGtaLAFoBWi3BJ/CWRo7I588Gn
         irgF84TwIeA0h5tOa7f33aM93e7cGfKAuby8T5Kmy54roZaokhmzWjJq0zaWtecSmmwY
         /lucqCA5vrlKnAcNi092mFBkjfop/a3VtKZzOsoidhsSEc2DeSdyOj0w516dn5VoJylM
         GPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
         :from:dkim-signature;
        bh=+X2CCzNc2pO0e5MDk8a84L4z7/VlZM8Ywfuz8Cg0lE8=;
        fh=Ze9D6BbJnc2iaT/JsxAByx3E1e6VkqWT6hG7R+xBCkc=;
        b=MlwpNz1De0j4vURDokdivvrdsb4QuMjFaoz81Y0jkbHhVIECk8QlQuSNfMkpTUwN0C
         V4iu2XqZ1GfY3qf0Q32s7noCa7Q4nQVGU05+15M8ZyBY68EAXnltzyG0Mzruk54eSnyZ
         kReKz2zE8TBNc1OiaLS7mV7dUXhf5femM0J63qkySFLcWHbxPerjEdlM1KB2RgKzPKW+
         OBj1UKnqBKuD8BnU63O14zCBH8VHg2TUDoadTC68u55qcXnc5gOIcqo/g/IJ5HR9k8l6
         07dWz8aa5BIpx7NJ0W1S3r/FVMl2Dya0eInRYaaXIOsZpeIgtnb949ERqLib84h6115Z
         2oYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912213; x=1794517013; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :mime-version:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+X2CCzNc2pO0e5MDk8a84L4z7/VlZM8Ywfuz8Cg0lE8=;
        b=CRDX4tG01TV84ABnzavhVBHA54LoUdMWazs3/A3VV5J0YlDJZdmMQ5Yj+9E0vI0Bu/
         lJZAaucC4zZbUvkL3EnFKI+oLbotCIdR/qrrnl4R9yvUtx0YLKiMLZqbt/vxQJwwxpfX
         W3QAtSfQ+wV9SeLMoSjmEZUOS6et3V+LimB5rH43o+PpWBS7OiCz4TZqZ9Y9R3k8fXyE
         bOoh9eGWAWL9ejUyukK+GRfsCoaC5kdc4gKhKReVkeGhbIr3woJGwG9ShQIyDFbjMdGv
         gQGLeQiqsSL6u59ac9tztlRqbYWLPlWSFVFEYkxYu/Jl7A/xmfW59wvp1KVHHQNX1cAg
         K6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912213; x=1794517013;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+X2CCzNc2pO0e5MDk8a84L4z7/VlZM8Ywfuz8Cg0lE8=;
        b=CuuauSID1dIGztCKDTcfh+a/hzgv7vK5NWLCqCYABqkIrlM9CMe1ToS5k886uVp1kZ
         0NvHngheQIVC4bfuq5wFjsZPg+Q6ZNcK8pKKfq7+iEXFX3OsKIQAA4VSWqWGTxU0iQ3c
         mjFPKcr/GntKQ5yrbFGMFLTw0OLhDeCNPYRmFisWHnKUhVsXyuDcj5ez07CdheZbarPn
         EMeDh2pEpGDgl5IHWfkVz397LwQVcb857jmqsj+oC3k+UVTZ7Y9OUFfO3FCyWKVqUR2J
         Lesd2te9OmBpJDDvlbd9s+tHQbxAsb3/8QPcmnEWv39Yd+8c4wg0eRIySyRJUU7Z2u2R
         6a3g==
X-Forwarded-Encrypted: i=1; AKwUvBx3keOiJVKSopwXXnb4LpCwWldtrym/cRq9LsUtVGv01A8MDkbMjzU/BCOXoi9LF0rjAYE/7ftLdxlVjYnso/Cc@vger.kernel.org
X-Gm-Message-State: APuU4Z+OnJ6fQN+KYb3alTuWXsY3Fa8G1VPygStWLkOAnICIarBqxBXp
	k5/cjIU5cYyU9Zd9d5HyFuWmuWyXFrxCvLqmTULxpSc6HDp6IUe11QibGDpbfhAVek/wdhSSqRB
	ur64yviriELVG/oqh+u3p0i5spPsV31Q=
X-Gm-Gg: AYBFou0chtSaP9q1nNysanxBCR4K0DKULszBuuN0a3t05A4vGvN8zHds7ynuuXlZZmd
	gvGmAIIXIMeGKNHPVp1dP50xp74hXckE1z5yxopaxpVo/E7Lj+Ce2fMqQP9zOhvUjy4yNV5KQO+
	2STJBJjsxu8QhkoPhipxagxm64QiNb1uYB8UOpOqJiOloFCM8pNy2V72sOquPiNqFv/ZUJeqnWq
	8BmIDpv0vCHGVfP88R97ZGQBT+nWN81eZk+aX8MEBBYfJ0eSVknyAcPfv0tP+viu0mR5iLDbQOo
	/RhzFSwrZp6yoqDaoZnJVx5ii8GqshqQ2xaCzSfY/fboAOVRbY+ix1q6BxyBcamrXCGHiWlwKPi
	tMx212UiV9s14JLnG+6B+tw/fXz27aPtj9DfOhk9Nnu5UAM7mbY6Ye7rhIQ==
X-Received: by 2002:a17:907:3e0c:b0:c40:5de7:33d3 with SMTP id
 a640c23a62f3a-c4d34c99a67mr62789566b.35.1793912212470; Thu, 05 Nov 2026
 12:56:52 -0800 (PST)
Received: from 374130946952 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 12:56:50 -0800
Received: from 374130946952 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 12:56:49 -0800
From: Joshua Warren <joshua.s.warren@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CADjP6_CC-jv6nyEHaLj=Z0eyjubOJZuiKESqszW3LgTJTTQ_Aw@mail.gmail.com>
References: <CADjP6_CC-jv6nyEHaLj=Z0eyjubOJZuiKESqszW3LgTJTTQ_Aw@mail.gmail.com>
Date: Thu, 5 Nov 2026 12:56:50 -0800
X-Gm-Features: AclHuK895C5KKBs4nmSrxjqf1VGW67u10b4C9T9Hu24NVenn9zuP_x2G0Umt0hI
Message-ID: <CADjP6_BYHrO4fOdYWpnHjjoP29Pih3bxn0eO2F5tbHCwBpP9Tw@mail.gmail.com>
Subject: [PATCH 1/2] perf/core: Avoid charging mmap aliases twice
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

commit 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()") hoisted
user_extra = nr_pages above the rb and AUX branches of perf_mmap().
Before that change the alias paths (mmap() of an already-mapped ring
buffer or AUX area) reached the single charge site with user_extra = 0
and extra = 0.  After the hoist they carry the buffer's page count, so
every alias mmap() charges the perf mlock gift (user->perf_mlock) again,
through perf_mmap_account().  extra remains 0 on the alias paths, so
mm->pinned_vm is neither charged nor leaked by an alias -- the duplicate
charge is confined to user->perf_mlock.

The excess is never removed: the final close uncharges exactly the
first allocation's charge (perf_mmap_unaccount() for the ring buffer,
the AUX close path for AUX), so the per-alias charges stay on
user->perf_mlock.  Alias paths also charge without passing
perf_mmap_calc_limits(), and an alias mmap() that fails in map_range()
is torn down via perf_mmap_close(), which does not release the alias
charge either.

The inflated counter throttles later mmaps: perf_mmap_calc_limits()
clamps the recorded user->perf_mlock at the perf-event mlock budget
(sysctl_perf_event_mlock scaled by online CPUs) before adding a fresh
allocation's user_extra, so once the counter is inflated past the
budget, every fresh allocation spills its whole size out of the perf
mlock gift into mm->pinned_vm and is tested against RLIMIT_MEMLOCK
there, and can be denied with -EPERM even though the real usage fits
the budget.

Charge on first allocation only: drop the ring buffer alias-branch
charge and move the AUX charge from the common tail into the AUX
first-allocation branch.  Aliases share the existing charge and the
final close releases it exactly once, as before.

Tested with a host-level regression harness that compiles the
accounting code straight from this tree (perf_mmap, perf_mmap_rb,
perf_mmap_aux, perf_mmap_close, perf_mmap_account/unaccount/calc_limits
and the internal.h helpers) and drives full ring and AUX lifecycles
over it (single-user, single-mm, single-threaded; nothing runs in a
kernel): the unfixed tree leaves nonzero user->perf_mlock behind on
alias and failed-alias lifecycles, the fixed tree balances all 22.
The harness is tooling, not part of this change.  Compile-verified with a
focused x86-64 defconfig build of kernel/events/core.o; the kernel was
not booted and no runtime kernel reproduction was performed.

AI coding agents in the omp harness wrote the patches, the reproducer
and the measurements.

Fixes: 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()")
Signed-off-by: Joshua Warren <joshua.s.warren@gmail.com>
---
 kernel/events/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7..c8bb805bc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7332,9 +7332,11 @@ static int perf_mmap_rb(struct vm_area_struct
*vma, struct perf_event *event,
 		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer
-			 * multiple times.
+			 * multiple times. The alias shares the ring's
+			 * already-locked pages; the existing charge stays
+			 * as-is and is removed once, when the last mapping
+			 * closes.
 			 */
-			perf_mmap_account(vma, user_extra, extra);
 			refcount_inc(&event->mmap_count);
 			return 0;
 		}
@@ -7443,9 +7445,16 @@ static int perf_mmap_aux(struct vm_area_struct
*vma, struct perf_event *event,

 		refcount_set(&rb->aux_mmap_count, 1);
 		rb->aux_mmap_locked = extra;
+
+		/*
+		 * Charge the AUX area once, at first allocation. The alias
+		 * branch above shares the already-locked pages and adds no
+		 * charge; the single charge is removed when the last AUX
+		 * mapping closes.
+		 */
+		perf_mmap_account(vma, user_extra, extra);
 	}

-	perf_mmap_account(vma, user_extra, extra);
 	refcount_inc(&event->mmap_count);

 	return 0;
-- 
2.39.5
