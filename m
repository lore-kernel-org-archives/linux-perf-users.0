Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADB3DDDB0;
	Wed,  5 Aug 2026 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958771; cv=none; b=QFxTySSr05nbIjWvT+qvuMZtYj2l03kf6P4YVdrXpMSopx2/nOlRzOf8BFjphgO8NTektRvbUBoQVRf2c8EVze1VQrX+cYBDrq7G/oEAPhWiZoVb7RHIPhecdI0FFYBi2Ty/MGAJyJmpiNgpw4qvT+tFWnC6YV0s6fVwSG/tZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958771; c=relaxed/simple;
	bh=2eaG2oDsnWnhl9x5rQWEfwWlcul1Cx8idPicLwgn6oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxODzmkdhyFlTvo+akYACUY775Pap2Y6SUKT6JUk95M29m/5OxjRU85e+V+Kuob/6DMw9Cg9RTU8Ye6wxLzRiMNYCsjXNkRwnoe6E/7oEi9WWck8NVJrO/G0AslOluRAMLmur49AK4ojSAMDfz9SKzE1Ybmb9XIPN+PWY8DR47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSiHOo/y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSiHOo/y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gtpJCCycl4O3UvKfejrnDc8jvQURyjbtenNDflVLceQ=; b=WSiHOo/y/oG95Lu+SGvtik8NCL
	bsDTJOSA/K0lf2xYzAAFAtX34Jvt9FPmcmuYMuaHs0I70SyVFfQZqiJ38IRiunnPi4g62WfPPyOKq
	3BLtMy3fFh2SBiugoRtUt880SrqT5LzBJaVmMAr+7+NI7ffCdnPlgHgdVIJ6CKjGqG3ZoAOVjeM4Q
	D96fG79EJDTjNqcxmfnW0ejtLCGCNN+0DXBO1xi7VVMXhUk7eobx0WuSGyiX7lXmk2QWRMuvKfzCE
	6eK9uQceU+u2+MTP7/nZdt9DWQM3HDM6cMtqoTPHIJ62PFSO2MxEaxnFQAW7fa2m95rtvH1Lm0OHv
	y5cyVMbQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wrhSJ-0000000AxZz-1GDO;
	Wed, 05 Aug 2026 19:39:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB6183003DE; Wed, 05 Aug 2026 21:39:09 +0200 (CEST)
Date: Wed, 5 Aug 2026 21:39:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-ID: <20260805193909.GP776954@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565875046.714490.17724442147958346980.stgit@devnote2>
 <20260803070356.GV49951@noisy.programming.kicks-ass.net>
 <20260805153404.793691b8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805153404.793691b8@gandalf.local.home>

On Wed, Aug 05, 2026 at 03:34:04PM -0400, Steven Rostedt wrote:
> On Mon, 3 Aug 2026 09:03:56 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > The new syntax is;
> > > 
> > >  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> > > 
> > > User also can use $addr to fetch the accessed address and $value to fetch
> > > the accessed memory value (shorthand for '+0($addr)'). No other variables
> > > are supported.  
> > 
> > This seems limited to kernel addresses only? Should not also userspace
> > addresses be supported?
> 
> Hmm, how would that work? The address is global for all tasks, so if you
> add a user space address, what task would that be for? The one writing the
> probe?

Schedule the watchpoint along with the task of course. Given there is
breakpoint/perf integration this should be trivial.
