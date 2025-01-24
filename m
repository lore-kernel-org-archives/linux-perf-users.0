Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345A12AAE2;
	Fri, 24 Jan 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749613; cv=none; b=lhO8BwAh8M+zWhzvx4ICE7gKlItD3IX1OCXH5W0teaLaJ8o4kG7cAL93cx0YhKXV8+ytzQPKPlFVb055xuyDPYf18pfA0uTtQl3ZEt0pUSI7Atwc+mY5/B5uh8aViIhWo8e04WaL+QPdO9F+rNhaIy4nAmGcVH677IWNYtqzeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749613; c=relaxed/simple;
	bh=dqCkwAfyBLaej+FaOlthYPlWUS/p1KP2S6mZHCUwu/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBuDMG4hRbwLY1itwLVZX3e0U5TMRKKjnwQpffrsegs/o+GL2Xy9lw1LEINHGfdQM3Zz+phhhCrpnAdCxNBxsvhR8ezZnkVWv7hbeuA0JotnPtSWEDIY5HYPETINv8K0EZFU98RzL/O6a5Zx2bDtSJU533UPAYI/kYAgvtjzEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD3AC4CED2;
	Fri, 24 Jan 2025 20:13:30 +0000 (UTC)
Date: Fri, 24 Jan 2025 15:13:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Indu Bhagat
 <indu.bhagat@oracle.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kernel.org, Jens Remus <jremus@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20250124151340.2c173332@gandalf.local.home>
In-Reply-To: <20250124192159.ypvqwoqjvhasamev@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
	<CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
	<20250124192159.ypvqwoqjvhasamev@jpoimboe>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 11:21:59 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > given SFRAME_F_FRAME_POINTER in the header, is it really that
> > nonsensical and illegal to have zero FDEs/FREs? Maybe we should allow
> > that?  
> 
> It would seem a bit silly to create an empty .sframe section just to set
> that SFRAME_F_FRAME_POINTER bit.  Regardless, there's nothing the kernel
> can do with that.
> 
> > > +               dbg("no fde/fre entries\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> > > +       if (header_end >= sec->sframe_end) {  
> > 
> > if we allow zero FDEs/FREs, header_end == sec->sframe_end is legal, right?  
> 
> I suppose so, but again I'm not seeing any reason to support that.

Hmm, could that be useful for implementing a way to dynamically grow or
shrink an sframe because of jits? I'm just thinking about placeholders or
something.

-- Steve
