Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C29213240;
	Wed, 22 Jan 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549761; cv=none; b=GGQRzCqaXuSg6V71iMvITVbQqSxGw0jV/DUXgqClak1OfzeCzOOkquNUt7QLZgM+Z4VubLZgkrlzRmy/5BSmGMJUijh4oT7Es1/DnKcM1mi+yz3r+roVMxVVHD0TsEf8aTlF5N/4ADMwx4BYDBoe6PbfXPhxgV1ml+FE9+MJqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549761; c=relaxed/simple;
	bh=PS/saersNv2KAu4ql0W5yEeCsb8jJfLGGbfpc4rtuvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5MXNQGQlTAPZlQrWiSZ2z0JjyY7GFms9o/1GxFT3q7lsNaYOlg5D1Ima53cTH/tLP/LZnmns7iWlmpJVC9dtYMOgNzGLh/5gNRu9s7z3vtPX0CK2UAcZUqK9QFQZtC6CpwQ4e0EBMDw9W/GJ7dIk+PKolG0Ujk/fhIOTcmrqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=krKDeU14; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krKDeU14"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cDDklsV9CLZX5Yk6aVrIEBswD2Xe5ZP8qdbqlJWZTPQ=; b=krKDeU14FiNnvTpukYVlucR3Ov
	ORF7XVnP/zIpa3I8UlZUcEIQyVvpVtOzn2B2519MGCGbnnhuRIZ/FvGLvmgLeX9avROFnbGiiVVCM
	0jjFj90kEWQZld8Gw/tKB0XydSfAcpVWG9Wby7qiRaujQNxzapxfQoevec1UUCj8LQd/99PCUh9Cj
	/bniIfqNjYCRQhvZRDtWHjZbp2LDLWAgMkTdF1VpDA+ijm7Wou3NRswW/XfvPK2zE2fU9IND+mWJs
	kCacVXLONZGpC0vmilgfB7bjeDE4lI6b2qJ2EHoBUTMY/HneMlTbXHVHzZpFq/3xQvaTrF0aESxzR
	z+F8D66A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taa3x-00000001BIi-0VgF;
	Wed, 22 Jan 2025 12:42:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1AD6300599; Wed, 22 Jan 2025 13:42:28 +0100 (CET)
Date: Wed, 22 Jan 2025 13:42:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <20250122124228.GO7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:30:54PM -0800, Josh Poimboeuf wrote:
> If TWA_NMI_CURRENT task work is queued from an NMI triggered while
> running in __schedule() with IRQs disabled, task_work_set_notify_irq()
> ends up inadvertently running on the next scheduled task.  So the
> original task doesn't get its TIF_NOTIFY_RESUME flag set and the task
> work may get delayed indefinitely, or may not get to run at all.
> 
>     __schedule()
> 	// disable irqs
> 	    <NMI>
> 		task_work_add(current, work, TWA_NMI_CURRENT);
> 	    </NMI>
> 	// current = next;
> 	// enable irqs
> 	    <IRQ>
> 		task_work_set_notify_irq()
> 		test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME); // wrong task!
> 	    </IRQ>
> 	// original task skips task work on its next return to user (or exit!)
> 
> Fix it by storing the task pointer along with the irq_work struct and
> passing that task to set_notify_resume().

So I'm a little confused, isn't something like this sufficient?

If we hit before schedule(), all just works as expected, if we hit after
schedule(), the task will already have the TIF flag set, and we'll hit
the return to user path once it gets scheduled again.

---
diff --git a/kernel/task_work.c b/kernel/task_work.c
index c969f1f26be5..155549c017b2 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -9,7 +9,12 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
 #ifdef CONFIG_IRQ_WORK
 static void task_work_set_notify_irq(struct irq_work *entry)
 {
-	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	/*
+	 * no-op IPI
+	 *
+	 * TWA_NMI_CURRENT will already have set the TIF flag, all
+	 * this interrupt does it tickle the return-to-user path.
+	 */
 }
 static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
 	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
@@ -98,6 +103,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		break;
 #ifdef CONFIG_IRQ_WORK
 	case TWA_NMI_CURRENT:
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
 		break;
 #endif
