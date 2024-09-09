Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26B1791EB;
	Mon,  9 Sep 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920604; cv=none; b=X99sWXt0pmyE0rDrtJ2P+Li970b4yme8J7nv6Q60T7oradTYfRYgms/ypYtFj/TY7MAHp2+GLM2PKD3fJyp+Oyj0LFMQDCRFbtAgioodl3s2GQaIqdW9rXIgqw2V+E/M221swiH3hJH1tRN1k8Y7RycLsoj3fomo/pAsjN/EYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920604; c=relaxed/simple;
	bh=twWUNIIHUAfvXwjm5KgeiHSBs7BSECIU6tKwrb4f2E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1uLQJE2SsY+1J0t66imn7VFKim1HLjaBSG1K6ovisbukNxEJvxeBEmtA6u/iRA8xk/Ho4l2T7E6Jm9iOcNmBGXNb5XHNcpzp27CR/DxVX8op1DJZr5AYsZjIZpE/vsOk+sb5OigV21+J2YlEst2RGFoUKqZtCvynUIScEfipWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHZeMgex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHZeMgex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D42C4CEC5;
	Mon,  9 Sep 2024 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725920603;
	bh=twWUNIIHUAfvXwjm5KgeiHSBs7BSECIU6tKwrb4f2E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHZeMgex3JE4CQt6fz0wQSkc643QbT+JnmVuIMh9khVwWbPlNUNXKg4pUZSPg9mD9
	 qNFRM1tuJBeGG8UipB40YZI1slaNyZTE90Jy+nuIrD7/EUWb8hrw3biZ/d4stWHICS
	 wAu8jUttGvQHIA4yvJS2pew1gQo6rYpShHMhezg3tkn40cu+8qXMY7ILv600FyJ0nH
	 IoWxtyCPXFyRmtj7k+lf6ljH1IERtXzNCFFZo5Ld6uTnR96TGXSd1q4PyqxRwLGZX6
	 oY/SbnHmCt7XWdxxwEYKoDb1Lb9Q8iO9oBg7kfTB41oTn2g3LLelPSG2J5SNwikUMO
	 U3gmSb3RbSjVw==
Date: Mon, 9 Sep 2024 19:23:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH RFC 0/2] Prep perf trace for a generic BPF+BTF pretty
 printer
Message-ID: <Zt91V3lSSzahENzH@x1>
References: <20240906195020.481841-1-acme@kernel.org>
 <b3fa69b9-4acf-4a86-9ef6-be89036c2fa9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fa69b9-4acf-4a86-9ef6-be89036c2fa9@oracle.com>

On Mon, Sep 09, 2024 at 04:46:15PM +0100, Alan Maguire wrote:
> On 06/09/2024 20:50, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Hi,
> > 
> > 	This is an attempt at paving the way for the remaining parts of
> > Howard's work on this years GSoC to be merged, as we want to keep the
> > existing pretty printers for the few structs we have, that have special
> > characteristics (see the commit logs) while having the generic BPF + BTF
> > collector/pretty printer, using the libbpf BPF dumper (see more ideas on
> > the commit log on how to improve it, maybe even getting
> > tools/perf/trace/beauty/ into tools/lib/beauty/ to get reused by
> > libbpf).
> >
> 
> hey Arnaldo
> 
> Absolutely, finding the common ground here would be great! I took a
> quick look at some of the beautify scripts, and it struck me that some
> of what's missing today - and what makes this hard - is that we don't
> have easy access to numeric macro name -> value mappings for things like
> arch-specific errno values (at least not without DWARF).

Even with DWARF that is not always available, IIRC it depends on
compiler flags how much DWARF is generated.
 
> In another context, we've seen pain for BPF program writers who have to
> cut+paste macro values into their BPF code.  We've sort of solved this
> in a few specific cases by converting some values to enumerations. They
> then get BTF representations, and can benefit from Compile Once - Run
> Everywhere when the macro value is used in the BPF context.

Right, that is something we discussed in this GSoC cycle, to have extra
BTF generated from the scraper scripts, not in the kernel's BTF, but
with perf, but then that would work for ABIs, and not for internal
kernel stuff, where, as you rightly described, CO-RE would come to save
the day.

Having some extra BTF info, not necessarily in a kernel module or things
like that, but from a debuginfo server, in an extra rpm package,
whatever, but accessible via a build-id lookup somehow would be a great
improvement.
 
> But it seems to me that what both these problems suggest is that it
> would be nice to more systematically represent numeric macro values such
> that they would be more easily available. I talked a bit about this a
> few years back at Plumbers for macros as a whole, but I wonder if a
> tweak to pahole that does something like

We need to keep talking about this to make it a reality :-)
 
> 1. check if a macro has a valid numeric representation;
> 2. if so, convert it to a singleton anonymous BTF enumerated type that
> will not clash with the real macro name (so is safe to use when headers
> containing that macro are also included)
 
> This would allow BPF program writers to reference macro-defined flag
> values and get the CO-RE benefits they get from enums and presence in a
> generated vmlinux.h. It might also help here for beautify where you
> could establish name-value mappings for things like arch-specific errnos.
> 
> We've been talking about having a loadable module of vmlinux BTF extras,
> so it seems like numeric macro representations would be helpful there
> too. What do you think? Thanks!

See above, maybe we don't really need to have it as a loadable kernel
module.

- Arnaldo
 
> Alan
> 
> 
> > 	I plan to work on the weekend to plugging his latest series on
> > top of these patches so that we can get it merged in the next merge
> > window.

No work in the weekend, but took most of today :-)

I'm pushing what I have to the tmp.perf-tools-next branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

> > 	Any comment/test is more than welcome,
> > 
> > - Arnaldo
> > 
> > Arnaldo Carvalho de Melo (2):
> >   perf trace augmented_syscalls.bpf: Move the renameat augmenter to
> >     renameat2, temporarily
> >   perf trace: Use a common encoding for augmented arguments, with size +
> >     error + payload
> > 
> >  tools/perf/trace/beauty/perf_event_open.c     |   2 +-
> >  tools/perf/trace/beauty/sockaddr.c            |   2 +-
> >  tools/perf/trace/beauty/timespec.c            |   2 +-
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 108 +++++++++++-------
> >  4 files changed, 68 insertions(+), 46 deletions(-)
> > 
