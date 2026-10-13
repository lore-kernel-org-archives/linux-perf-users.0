Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA633A6F06
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879240; cv=none; b=HG7wYo9wlMgrH7ZjWWWRU+rav5/jPcNmWA/aI9RmLl2amQdI/gTx28rS8ZIlMnXK+cSRUjBWtwsEYepQzC8bpfQxfdNPrN1uiXrslfi5fYtHlm/ENDdKCoDtCGGGLAl9JQjF8SXn5d4EHF/A0KscRKEgCzBP0VWeS38HTlg3cHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879240; c=relaxed/simple;
	bh=zR2wcIj6f6knLwgvx40lbshBDqlnSEwOvPz3Nf4LgEk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FnFiMFRW0vvkDguF67N02OsU4vqbwRdVzCTmsDsXJd1oHPoEEXsTn1Na6Sb5VMaxi7/1Jw+SeKTanCSzz51jS71Au1PNw24XTlWay0/lyHrCfrXGkMtwHqKY7RUdAio1vSJXsQoOIiYlgojaKHL83Lcq0ivm0fNEWHrwiNvQPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN7Bifyr; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN7Bifyr"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33e6279a1d7so391618eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879238; x=1792484038; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xE1I3ZXDdooBxa/SXyn2tT8+8Iug/sRWcdxfucclDw=;
        b=FN7BifyrOXAjxZbZ5r0Pmka8kGyw9JzlrgUV1LoSRNm5s+wux2Poty4uwcsYjdx0y9
         3I2KsR+BU0P74q2Etb/R8ei0Od5/luhZbm5xZFfDtEn8nGUfeWdwaqgEBMbjXR02VzRo
         Wa4a39fpVZfNbovCCqW7mrU6T0TgRbAigepy6oNeo8ZmgLMircpIVsowsYESl1uUhXMF
         RC2hshRbsxpD/4mucQFXeit2CjJ2NbC/BU1CD7VTTOyVn3Tp2GN3FB34atg6X12gdtG6
         W6urtlthILSntHHO3kNMswp8aTaoVl7g603zQoYdX3OJuBZCudXJCB/FUGarsIsFMYkl
         ijkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879238; x=1792484038;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4xE1I3ZXDdooBxa/SXyn2tT8+8Iug/sRWcdxfucclDw=;
        b=yveRVZKd68wg/0dhHDT7Z21yjevYr53Sn/gSOPZa8wsLaBBgxgdz45VX8YNoaz9MLX
         LzqH0aFIQb+T4tGgWQermpKBlFHuqHa1QiXxZ6LeKVe4WGI+qpsi5wGpw3ID0sDOVMFb
         vkmGbQW9Q4oCP7QxArEHmd9L6w2nfseDKxArhEPk3n0C8h8QVjLHezUJN2Tj/FKhtadR
         tPR76DEwXxYgtsDi+m5qDZg3ywOqavWrxArTPN3K1jWNmE9CKP9+0ha78uHHATb/nboY
         Af851JSMhkkDaqVsWYMLgjut7gS7AUpvrgVIfNIMRLFHCvRwwRJ83I3eOT5JHt5+pYiq
         cEiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBrUY/zh/xca27FAsMkBc4OTX8v3fuB/9+XOjkl8C1dwGpWNLBbULEFevEi9rBv2mJE6ocb5xEKOjNbyAUfkQr@vger.kernel.org
X-Gm-Message-State: AFq9FYL6Ldw3x871NALopfgY3lX1Bno7N9Cgkn4+ekT7xF/k0TZPTrrL
	d7Z3TUmTUISv7HoutOssn2beHXoHrN0DB73yXPZBXRjiF1EiizVV2KCX
X-Gm-Gg: AYBFou2cs3tTX+i5uRkB8mBC+JinWo1KkdNJKO8wsrXoFCbiI6OnjAe/3wxtRv0sugO
	28COmaFdOx++1jlR9mI6qQUI4KXo4ITohqg4azkIWwYn1gW6KjyquIz81Z0HE3z+7gQ+8jVqUzq
	rHB+5ucSljCxt4vOhLLTr8QMexzCXG43h2WSGj5QE4KJZaUhmlXie3tASHuEIZ1ehy7t3w1fVT5
	LJc6LocSwonekcUuKFZjy4MCUlbLTTp21QMn5GCkyWTVC8jn+zPS5oLyhqV5Phe3uXPdU1hFwez
	5M6ABicejxo+7P+F69ikKZwWLaJz6fdsuXf9JBHZHA0SZl7TrCNQtHHES9XshWT6+KRUksVDBpL
	a77iYLF4MFyU9gHIgcwhNB0BTXmhHVCNsV9g2I6ucEH5Z0OlixOhKeFevsxLQnRsqGsCuBS+QID
	O1OTIVGSripXzu6EqSsDJmtZGkMOek7Hd0QOHY8Ap5m7ijjvZ4iax6zXeXnhM1KXR9SsjboABGu
	t2fIw==
X-Received: by 2002:a05:7300:7aa2:b0:351:a9b1:73c with SMTP id 5a478bee46e88-3537deccaffmr17164789eec.2.1791879238101;
        Tue, 13 Oct 2026 01:13:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a0f:3942:ce4a:aee2:c79c:f675:56b2:6833])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm38355874eec.6.2026.10.13.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:13:57 -0700 (PDT)
From: vineash <vineash30640@gmail.com>
To:
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, kan.liang@linux.intel.com,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86: Don't WARN when the ext_regs_buf allocation fails
Date: Tue, 13 Oct 2026 16:13:20 +0800
Message-ID: <179187920064.3441876.15687522011658301558@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

reserve_ext_regs_buffers() wraps the per-CPU ext_regs_buf allocation in
WARN_ON_ONCE(). The allocator already prints a warning with a stack dump
when a GFP_KERNEL allocation fails, so the WARN only repeats it, which
Documentation/process/coding-style.rst asks not to do. The failure is
also handled: the buffers are freed again, the event is still created,
and events that ask for SIMD or extended register sampling are rejected
with -ENOMEM in x86_pmu_hw_config() and event_simd_regs_validate().

syzkaller hit this with fault injection on next-20261002. The trigger
is a plain hardware cycles event opened while no other x86 PMU event
exists, with the allocation failed:

  !per_cpu(ext_regs_buf, cpu)
  WARNING: arch/x86/events/core.c:441 at reserve_ext_regs_buffers arch/x86/events/core.c:441 [inline]
  WARNING: arch/x86/events/core.c:441 at x86_reserve_hardware+0x6ff/0x880 arch/x86/events/core.c:458
  Call Trace:
   __x86_pmu_event_init arch/x86/events/core.c:825 [inline]
   x86_pmu_event_init+0x109/0xc50 arch/x86/events/core.c:3003
   perf_try_init_event+0x140/0xbc0 kernel/events/core.c:13261
   perf_init_event kernel/events/core.c:13365 [inline]
   perf_event_alloc+0x2145/0x5680 kernel/events/core.c:13640
   __do_sys_perf_event_open+0x669/0x2d40 kernel/events/core.c:14185
   do_syscall_64+0x12c/0x7b0 arch/x86/entry/syscall_64.c:84
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Drop the WARN_ON_ONCE(). This matches reserve_ds_buffers() and
reserve_lbr_buffers(), which also handle allocation failure without a
warning.

Fixes: b84c96283684 ("perf/x86: Enable XMM register sampling for non-PEBS events")
Assisted-by: Claude:claude-opus-5-5 syzkaller
Signed-off-by: vineash <vineash30640@gmail.com>
---
Notes (not for the commit log):

Found with syzkaller in a QEMU/KVM guest with "-cpu host" (Intel Xeon Gold
5118 host).

Tested on next-20261002 (x86_64, syzbot's upstream-apparmor-kasan config,
gcc 12) with a small C reproducer: write failslab/ignore-gfp-wait=N, then
open a user-only cycles event with /proc/thread-self/fail-nth set to 1..64.
The third injected failure lands on the ext_regs_buf kzalloc_node().

  before: 3/3 runs hit the WARNING above, at fail-nth=3
  after:  3/3 runs without any WARNING; with failslab/verbose=2 the forced
          failure is shown at reserve_ext_regs_buffers()
          (arch/x86/events/core.c:439), and perf_event_open() returns a
          valid fd, as before

The WARN came up in the Sashiko review of v9 of the series. Dapeng
preferred to keep the WARN_ON_ONCE() over propagating the error, since
that would need a lot of fallback code:

  https://lore.kernel.org/all/89f316ca-936b-4938-9421-2f96cfdc4837@linux.intel.com/

This patch does not propagate the error either. It only drops the WARN,
since the allocator already reports the failure.

The patch only removes the WARN, so failure handling does not change:
the event is still created, and events that need SIMD or extended
register sampling get -ENOMEM until the last x86 PMU event is gone.
x86_reserve_hardware() could return the error instead, but that would
also make plain counting events fail, which seemed out of scope here.

The reproducer is available on request.

 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9b1a9032e..4df792b13 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -438,7 +438,7 @@ static void reserve_ext_regs_buffers(void)
 	for_each_possible_cpu(cpu) {
 		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
 							  cpu_to_node(cpu));
-		if (WARN_ON_ONCE(!per_cpu(ext_regs_buf, cpu)))
+		if (!per_cpu(ext_regs_buf, cpu))
 			goto err;
 	}
 
-- 
2.25.1

