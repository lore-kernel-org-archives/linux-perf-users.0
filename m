Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC334E779
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374070; cv=none; b=Pg6+ifhY2Q4HETaYc39Vfoz3S/waUkvCkrZMhn/o139uCMyv4dOeAR9p0Sw5KkglEK02IEG1pBxo6dHSAIxeHaMVznK7+5q++dRrhvASSgmItUyFYlK5TmoEj4y5RpCdcpyR264PmnMz9b65nCZtfT536OxbhbMlafRYOZvUeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374070; c=relaxed/simple;
	bh=Q8LqcvCRulwlmm/Efnm76HOirpHJ/zu+2osri09jxeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuPJEEbiMpqAu0+TCtDmHEtSj0T2JkxJduchCWfiom2SPFTrHRCuLBwgSru+iwK9t72amXyMkoP76Y/Mzcq0wOGl0e1OJZN39IJbXTWRIAP35nINKQV95ntNUfLpAhlMeqn22EKUU8VCSwseR2ryJVcIT5AEhErHabAph517bAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7qZKe9v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7qZKe9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785374068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oep9GUzmGHr26u2If40/oW9YH4ApgXIqp1l7c/0lb/w=;
	b=X7qZKe9vCvVLzBl4dkdGtP7hW2kj4Ga2VoilCro+kQjHmJHLtRmiotqN2KyjcS8rbx10gg
	TrAZBgyoLW7QVX/I7QmnLA707sgnpKCJ9Dx2wyQZI4Rat8hzJHo/SWXNJJOGcFFxy0AWmv
	diIc4mMpUJdOt3XIDkG1ErXNNUCVFJ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-_2QrTJkqNL6GEL1URfKMOw-1; Wed,
 29 Jul 2026 21:14:24 -0400
X-MC-Unique: _2QrTJkqNL6GEL1URfKMOw-1
X-Mimecast-MFC-AGG-ID: _2QrTJkqNL6GEL1URfKMOw_1785374061
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B967119560A2;
	Thu, 30 Jul 2026 01:14:19 +0000 (UTC)
Received: from localhost (unknown [10.22.81.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB8531956094;
	Thu, 30 Jul 2026 01:14:15 +0000 (UTC)
Date: Wed, 29 Jul 2026 22:14:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	WANG Xuerui <kernel@xen0n.name>, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [RFC PATCH] ARM, ARM64, LOONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <amqlZiO8rxu_k08L@redhat.com>
References: <20260713144939.FuCj9yvZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713144939.FuCj9yvZ@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jul 13, 2026 at 04:49:39PM +0200, Sebastian Andrzej Siewior wrote:
> Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> delivered with disabled interrupts and perf intrastrucure expects
> disabled interrupts while the overflow callback is invoked.
> 
> The callback then sends a SIGTRAP signal for which it acquires
> sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> must not be acquired in atomic context.
> 
> Delay the event callback until the return to userland.
> Add perf_arch_hwbp_notify(), a generic perf callback which delayes the
> actual callback invocation to task_work_add() callback. This callback
> invokes the architecture defines callback arch_hwbp_send_sig().
> This requires struct callback_head and the functions require
> ARCH_NEED_PERF_HW_NOTIF to be defined.
> 
> This was reported against ARM64. ARM and LongARCH follow the same
> pattern are also converted.
> 
> Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Reported-by: Waiman Long <longman@redhat.com>
> Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This is approximately the fifth iteration at which point I think I can
> share what I have.
> 
> Could this be tested, please? I tested it on arm64 for arm64 based on
> Luis' test. ARM compiles my HW lacks support for this I think (gdb
> aborts early). I hope the best for LoongARCH.

I tested your patch on baremetal (3 different aarch64 machines) and 3
different Virtual Machines. Apart from the one VM that didn't provide the
HW breakpoints the test used, I was able to reproduce the problem with
v7.2-rc5-rt3 and earlier kernels in all the other setups. Applying your
patch eliminated the backtraces. I ran several batches of 2000 and 10000
executions in a row of the gdb test from the original thread without a
glitch.

Having DEBUG_ATOMIC_SLEEP enabled in the kernel (along with PREEMPT_RT)
was all I needed to reproduce the problem with the unpatched kernel. After
I applied the patch I run tests with and without lockdep. No backtrace,
no complaints.

I started working on trying to reproduce the (possible) problem Sashiko
highlighted, but so far, no luck in reproducing that specific scenario.

Best regards,
Luis

