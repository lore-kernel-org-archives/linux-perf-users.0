Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2761CFEB2;
	Fri, 24 Jan 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758352; cv=none; b=iAPbL6ySRL6NTqIxnyIz6xSEdKgPIhGR3b3lLo+97vjZWn+Cu3dXKtoyMZO8ZbG48fFVgaPWaSvjAebK5suiLuwd4NXLlewhSxF97E1V/r9QDkJIVGjAB54AllWzSsgasfqGXWWwVnML4xWMC75jse26dPuT2FyBF4dbKtbKbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758352; c=relaxed/simple;
	bh=bOC/DoQi+gBwJE3OIca1li3yeKPNO4dGJyXkW04s1JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsCAP7Gke1BxGiv6gwXvxKJkO+LNXy+I5uS6kojl+X22UQJyLa6XikZXWYZsul/u4hwQbWAYaPhYj3wHPIIBgZJzcoG1khO1o29VY5LU0cvMVJJL7yCMpc5JaLtVSv/JW7v8JaDgv/NOpIB8dW6cyIXpohDhiUwtFUZE1tvjtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+w4JQei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+w4JQei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0646DC4CED2;
	Fri, 24 Jan 2025 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737758351;
	bh=bOC/DoQi+gBwJE3OIca1li3yeKPNO4dGJyXkW04s1JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+w4JQeiazizMT636wWcoYR7BjcxDDLxcfnLt5L2d82hgAzVwq3N6mr6AWqJW8tMm
	 aUu713XKVeorGdND2Ei5rJSlu8bPJoF63CvfYssYTLRK7RPDiCDFosKr6zRuOjIBab
	 B73WO1XV+kBWuLOncurfUSs8aiF05x0T6cwHzKn/Vge1cTdeHCRP9bYWDylZhXSxvX
	 OD9EPiP1Qfbtytd30E12HHh1sh2Nep/EOIrQHF3qzVvyldP844YsxEPWuyY+qUD7zc
	 LqmGzMeGn9DuuB0nrBZVqvJVC4+92ikNDnKZEWypoXzsXf/GxtVdjJuugdQ83aApWQ
	 5ZfR009tJChpg==
Date: Fri, 24 Jan 2025 14:39:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Indu Bhagat <indu.bhagat@oracle.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20250124223909.sw7nfdjx4da46vyp@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <20250124151340.2c173332@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124151340.2c173332@gandalf.local.home>

On Fri, Jan 24, 2025 at 03:13:40PM -0500, Steven Rostedt wrote:
> On Fri, 24 Jan 2025 11:21:59 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > > given SFRAME_F_FRAME_POINTER in the header, is it really that
> > > nonsensical and illegal to have zero FDEs/FREs? Maybe we should allow
> > > that?  
> > 
> > It would seem a bit silly to create an empty .sframe section just to set
> > that SFRAME_F_FRAME_POINTER bit.  Regardless, there's nothing the kernel
> > can do with that.
> > 
> > > > +               dbg("no fde/fre entries\n");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> > > > +       if (header_end >= sec->sframe_end) {  
> > > 
> > > if we allow zero FDEs/FREs, header_end == sec->sframe_end is legal, right?  
> > 
> > I suppose so, but again I'm not seeing any reason to support that.
> 
> Hmm, could that be useful for implementing a way to dynamically grow or
> shrink an sframe because of jits? I'm just thinking about placeholders or
> sohething.

Maybe?

I was thinking the kernel would have sframe_section placeholders for JIT
code sections, so when sframe_find() retrieves the struct for a given
IP, it sees the JIT flag is set along with a pointer to the in-memory
shared "sframe section", then goes to read that to get the corresponding
sframe entry (insert erratic hand waving).

It's still early days but it's quite possible the in-memory "sframe
section" formats might end up looking pretty different from the .sframe
file section spec.

-- 
Josh
