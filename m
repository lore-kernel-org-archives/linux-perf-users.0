Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21243296BB7;
	Thu,  9 Oct 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993998; cv=none; b=CP48PDoQwOnAjcBymrapc8Z248Wm3yKFG0r6RJ1yTNaLZq/xtEc41k1W07XCucDFYH6PMTO4WlhvWfuipnQ6rfsdGHh4OPZSyiX6nFKsZG4Ygn8Ok5HUP34ZtFnAhEOpTXkl/bnt6KCqtv03zpw72H+qJfj0AB/Uud2l3O3pd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993998; c=relaxed/simple;
	bh=T5zn5Ca+xwqy9DqiIbsdQnH105gGdThs9cfyRZRrRTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+HEhsyqG1FcK5Z7XyCenSs15IVcqSRXLt6/7Urex8jrEZAPiLi/eGcaYWFW2hF9t38/SgjJOqMFCZAf2Fiuw1ZA/eZhhPjhrwx/S2gwHrmQSiw6JPQkpdjtm4bHz3hI4Xx3Uy1w4DLuHTyB9RxG61IuXRwFMcNpheVQGf915/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H4efYigj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H4efYigj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iQjhKM78ouddX3MpS9K7Fayl/6sYD/3M0x3yfLZ4K5o=; b=H4efYigjJ1G6Z3m5rUJDaCyHYS
	hCxaIL7hrQjGg8v4twsTQ3ku9lcBNtr+QStTSjn21d+6mcZS1OyAgxsVKx12dgZmSKOBsmliQXTnH
	gmZ6yT49Q7rr0F4OxlLhgTkuxtjlOQ44ibibxIKXyFX8VJl/bm2apEtQzP8RpAxJ34bLpuuaKM5A6
	QP+iVN65zD1K9l2XlWeQLPgO6rj38tcSl+gV7oCHXR9ksHVRBV1KMdUPU1ZFuXerMtpXOjtmXphaJ
	GtV5+jkc45SmWjFkKMVwPRJoqPUYfJQCzQq9+lwlzMtp71EiOTS0aNIQNHE74Ep9D2ky4uGAvdyy4
	y7KsJYtw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6kp0-00000001FpM-0zBT;
	Thu, 09 Oct 2025 07:12:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C5BC930039F; Thu, 09 Oct 2025 09:12:17 +0200 (CEST)
Date: Thu, 9 Oct 2025 09:12:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: George Kennedy <george.kennedy@oracle.com>, mingo@redhat.com,
	harshit.m.mogalapalli@oracle.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	dongli.zhang@oracle.com
Subject: Re: [PATCH] [PATCH v2] perf/x86/amd: check event before enable to
 avoid GPF
Message-ID: <20251009071217.GB4067720@noisy.programming.kicks-ass.net>
References: <1727725947-18058-1-git-send-email-george.kennedy@oracle.com>
 <5837f1b6-b111-4ab5-888a-7a00891f3a34@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5837f1b6-b111-4ab5-888a-7a00891f3a34@amd.com>

On Mon, Oct 07, 2024 at 12:13:56PM +0530, Ravi Bangoria wrote:
> On 01-Oct-24 1:22 AM, George Kennedy wrote:
> > On AMD machines cpuc->events[idx] can become NULL in a subtle race
> > condition with NMI->throttle->x86_pmu_stop().
> > 
> > Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
> > This appears to be an AMD only issue.
> > 
> > Syzkaller reported a GPF in amd_pmu_enable_all.
> > 
> > INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.143
> >     msecs
> > Oops: general protection fault, probably for non-canonical address
> >     0xdffffc0000000034: 0000  PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]
> > CPU: 0 UID: 0 PID: 328415 Comm: repro_36674776 Not tainted 6.12.0-rc1-syzk
> > RIP: 0010:x86_pmu_enable_event (arch/x86/events/perf_event.h:1195
> >     arch/x86/events/core.c:1430)
> > RSP: 0018:ffff888118009d60 EFLAGS: 00010012
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000000000000034 RSI: 0000000000000000 RDI: 00000000000001a0
> > RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> > R13: ffff88811802a440 R14: ffff88811802a240 R15: ffff8881132d8601
> > FS:  00007f097dfaa700(0000) GS:ffff888118000000(0000) GS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000200001c0 CR3: 0000000103d56000 CR4: 00000000000006f0
> > Call Trace:
> >  <IRQ>
> > amd_pmu_enable_all (arch/x86/events/amd/core.c:760 (discriminator 2))
> > x86_pmu_enable (arch/x86/events/core.c:1360)
> > event_sched_out (kernel/events/core.c:1191 kernel/events/core.c:1186
> >     kernel/events/core.c:2346)
> > __perf_remove_from_context (kernel/events/core.c:2435)
> > event_function (kernel/events/core.c:259)
> > remote_function (kernel/events/core.c:92 (discriminator 1)
> >     kernel/events/core.c:72 (discriminator 1))
> > __flush_smp_call_function_queue (./arch/x86/include/asm/jump_label.h:27
> >     ./include/linux/jump_label.h:207 ./include/trace/events/csd.h:64
> >     kernel/smp.c:135 kernel/smp.c:540)
> > __sysvec_call_function_single (./arch/x86/include/asm/jump_label.h:27
> >     ./include/linux/jump_label.h:207
> >     ./arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:272)
> > sysvec_call_function_single (arch/x86/kernel/smp.c:266 (discriminator 47)
> >     arch/x86/kernel/smp.c:266 (discriminator 47))
> >  </IRQ>
> > 
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> 
> Peter, Ingo,
> 
> I've been blocking this for quite some time without acting on it. Since
> the patch is trivial and harmless, I'm giving an Ack here. However, the
> underlying race condition is still unknown, so I will get back to it.
> 
> Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>

Does this want a Fixes tag? If so, please reply to the v3 patch.
