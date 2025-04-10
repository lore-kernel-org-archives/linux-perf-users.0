Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37044290BA8
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318456; cv=none; b=TM9HMC+s+Jy9qx7fzaN8uklLvmflC9IkcM8iLHkB7nSAFxMlFD/5pb16RUzBH8aTbHpuD2ULnfS9QNYqcG/4nNUpaTn8IUwWZ/adBkuuyGZN1hRkVFyKolRnz1n3Ot8nZ9r3jbN+yhpKdq7G23r6AjAKjD3qnyzTJETZE8leXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318456; c=relaxed/simple;
	bh=DUjvdT1aq11K94lx7ceH58o071TG8H8dWuAnVtS2tKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1GIGiU33+QGZ14l0R8qAvUGm4zakT4lGThrlM/cJlHxsjxStas5fW4WAJ9an5SWAbSL5GHUCe/2/2aC7Ehk3vjJvfK9dY9JzHgDpbr/AHf3foMVlP+CWqjFCvpLEcNzfC8Mmuh5fW7A+NyUgktWd+gEl4RigGs8jpe5E+X4yx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh1UfqO5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh1UfqO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D973C4CEDD;
	Thu, 10 Apr 2025 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744318455;
	bh=DUjvdT1aq11K94lx7ceH58o071TG8H8dWuAnVtS2tKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mh1UfqO5MdYkFfpNi4jtv8Ofe7Gy6VR3SPX9shtX+lUsgA2MNzbYhV1rdFUfjPE5F
	 G4m+qsSdq+LPM9cjub/HoTT/Td3XtgojljxMmbXr2tC4lhsBS+ka5FP1hW8EGgHP2h
	 ZqHmNYSe1QS5yF0N1bbFpAYBZ+zZ6qmuSSeDwFZyY9JXo8zxhd4XASzlzXTl1R1m/z
	 awXzkNahPvZqAX55/4+sZ4vPOieIMeP+Ud9l5caXEDM3UlSPla+3DxjFK7pvqI0R/z
	 TYnROmrIJbwmLk4TC9sH3gkdOksMeujrmDD5ohdoPlQGnBt4AVuQf1q7OFqso8WqhQ
	 scII501dIrWnQ==
Date: Thu, 10 Apr 2025 22:54:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_gv8vJAXgWbN7u5@gmail.com>
References: <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_S_JB_L_t9viciV@google.com>
 <Z_XpADpc9WtUdbmX@x1>
 <Z_gunJ9C3H25Uo9Q@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_gunJ9C3H25Uo9Q@google.com>


* Namhyung Kim <namhyung@kernel.org> wrote:

> On Wed, Apr 09, 2025 at 12:26:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Apr 07, 2025 at 11:16:04PM -0700, Namhyung Kim wrote:
> > > On Mon, Apr 07, 2025 at 09:54:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > A quick test here with perf top without setting the above ends up with
> > > > the behaviour that Ingo reported, no source code is shown and 's'
> > > > doesn't work. Then if I set it to use objdump:
> > 
> > > > root@number:~# perf config annotate.disassemblers=objdump
> > > > root@number:~# perf config annotate.disassemblers
> > > > annotate.disassemblers=objdump
> > > > root@number:~# cat ~/.perfconfig 
> > > > # this file is auto-generated.
> > > > [annotate]
> > > > 	disassemblers = objdump
> > > > root@number:~#
> > 
> > > > It takes longer to show the annotated output but there is source code
> > > > and 's' works.
> > 
> > > Thanks for chasing it down, we miss source line support in the disasm
> > > using capstone and libllvm.  We can add that later but for now we may
> > > refresh the result and force to objdump when source line is requested.
> > 
> > That is a good idea, I thought about it as well and will check how to do
> > it on top of what I have at:
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-annotate%2bbuild
> 
> How about this?
> 
> 
> From ce37ae9008ec7c6ab66ee1b6632a3c51bc0802f3 Mon Sep 17 00:00:00 2001
> From: Namhyung Kim <namhyung@kernel.org>
> Date: Thu, 10 Apr 2025 13:42:16 -0700
> Subject: [PATCH] perf annotate: Fix source code annotate with objdump
> 
> Recently it uses llvm and capstone to speed up annotation or disassembly
> of instructions.  But they don't support source code view yet.  Until it
> fixed, we can force to use objdump for source code annotation.
> 
> To prevent performance loss, it's disabled by default and turned it on
> when user requests it in TUI by pressing 's' key.

That's a good compromise IMO, thank you for implementing it!

	Ingo
