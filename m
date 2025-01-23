Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518927E105;
	Thu, 23 Jan 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661691; cv=none; b=MqW5JZ9L7Ty6jsr94pzq2we+VRIlEIE9ioA33HvKIDZGGb3wzEpui3xESqhUyOysUaKBzRtCN30Jj/YrzxUz2lcvgedDSkaUq6xSQnAbA3rN1m6+kuBzZ5DIoYlwlQTavz3E9t8j+U5+l9yy3cUNda3MWd6h/joxB1HSJNH/ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661691; c=relaxed/simple;
	bh=4OZUMahQr6grs1KkHk533XdOBWmWRuTtDLr2ZlVRCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7Cu+FcL6dDY5lxz12YYlje0S9n2PlEdXZ8WQ2bpo0FY20Qw52F1a8HWQjM3qwjj1F4NDZqIYF+4hWYZ1sErnvj4ADUMFDaSvj6WnOx5cfPXWKn8vAxD/rXBSVCXDVZYXcpeyquce+pDaBJo0lDzN6XVM6RO4vb7wQNhCRq/VXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/fYTcKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/fYTcKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98609C4CEDF;
	Thu, 23 Jan 2025 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661690;
	bh=4OZUMahQr6grs1KkHk533XdOBWmWRuTtDLr2ZlVRCYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/fYTcKp8BIOTHmux2RUZsXDWI5fnqFWE1Qtww3BV2q2G7suRlodN26K82BrGcEa1
	 Ld4XvxtTETkWI5agnSicQvaErnmlxLo8d6QMiImsJ4wNkOUi5Xuz72kofehrlwITdK
	 jCsz54/13GAuXVek2JFiwTbxKgmxmmsTI4lccazcNfy2VdK2o6eDJGyHEAhC1GM5E7
	 ASP8bObR1c8vKR5aKOiiC++zbX3ptZOZ5Ndh9AjTlIVz3bYLMx1tzn9BomOuubCPYu
	 JCA8thJgcbfculLGXIKDfRkqCXlTag52dsVrZpUMDkJGK6vcDb6xXVZ5By1hCT1m1f
	 CW6j3Cf/yrGJA==
Date: Thu, 23 Jan 2025 11:48:07 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
 <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
 <20250123084026.GF3808@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123084026.GF3808@noisy.programming.kicks-ass.net>

On Thu, Jan 23, 2025 at 09:40:26AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 02:49:02PM -0800, Josh Poimboeuf wrote:
> > On Wed, Jan 22, 2025 at 03:15:05PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:
> > > Oh gawd. Can we please do something simple like:
> > > 
> > > 	guard(irqsave)();
> > > 	cpu = raw_smp_processor_id();
> > > 	ctr = __this_cpu_read(unwind_ctx_cnt);
> > 
> > Don't you need a compiler barrier here?  __this_cpu_read() doesn't have
> > one.
> 
> What for?

Hm, I guess it's not needed for this one.

> > > 	cookie = READ_ONCE(current->unwind_info.cookie);
> > > 	do {
> > > 		if (cookie)
> > > 			return cookie;
> > > 		cookie = ctx_to_cookie(cpu, ctr+1);
> > > 	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie, cookie));

Should not the 2nd argument be &zero?

> > > 	__this_cpu_write(unwind_ctx_ctr, ctr+1);
> > > 	return cookie;
> > But also, the nmi_cookie is still needed for the case where the NMI
> > arrives before info->cookie gets cleared by early entry-from-user.
> 
> So how about we clear cookie (and set nr_entries to -1) at

I think we could set nr_entries to 0 instead of -1?

> return-to-user, after we've done the work loop and have interrupts
> disabled until we hit userspace.
>
> Any NMI that hits there will have to cause another entry anyway.

But there's a cookie mismatch:

    // return-to-user: IRQs disabled
    <NMI>
	current->unwind_info.cookie = 0x1234
    </NMI>
    unwind_exit_to_user_mode()
	current->unwind_info.cookie = 0
    IRET
<IRQ>
    task_work()
        callback(@cookie=WRONG)

-- 
Josh
