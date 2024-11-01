Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1481E47BC;
	Fri,  1 Nov 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497385; cv=none; b=PmmGO2WY9GCUzt8IMTAod1S7qrogmYkRk0cBQCULqZZKYNJ1PCKf+OvWj6Xr2NwYA3Vxd3MNnTde8il1QbmkyII8gGT6sO35/WIWnnU5knSVVdBs6z/vITbvcwny44s4OW9zmh+4AVF+93TvxvtyRVrsROQNF2J3/B+4ROacIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497385; c=relaxed/simple;
	bh=LskIb1qIQx1ILGa3bL59/zRaBlbeR2lnNshvYuMbgZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQdyaPtWZJJxkfPgFfD5U//fpQZF4msibvX62AHsfMVC4QAh6SHrV/aqyTUPDT0lGP/1fJacN4AjsC0uhpNoRRO8D7vcQCzNHXIu3AnX073VONwFqrxB09j9SFhY6FbpUqsWPpVEhJFl9LyAj/sN7/srzhFCPN9xdyIZiCvhCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A1LZMBI025732;
	Fri, 1 Nov 2024 16:35:22 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A1LZJNr025728;
	Fri, 1 Nov 2024 16:35:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 1 Nov 2024 16:35:18 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101213518.GX29862@gate.crashing.org>
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org> <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com> <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com> <20241031230313.ubybve4r7mlbcbuu@jpoimboe> <20241101190908.GV29862@gate.crashing.org> <20241101193305.afwfopg4ryrrgxfb@jpoimboe> <20241101193510.53xj5ybz6vyyqb37@jpoimboe> <20241101194800.wmvjljs7uxcuriem@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101194800.wmvjljs7uxcuriem@jpoimboe>
User-Agent: Mutt/1.4.2.3i

Hi!

On Fri, Nov 01, 2024 at 12:48:00PM -0700, Josh Poimboeuf wrote:
> On Fri, Nov 01, 2024 at 12:35:13PM -0700, Josh Poimboeuf wrote:
> > On Fri, Nov 01, 2024 at 12:33:07PM -0700, Josh Poimboeuf wrote:
> > > On Fri, Nov 01, 2024 at 02:09:08PM -0500, Segher Boessenkool wrote:
> > > > On Thu, Oct 31, 2024 at 04:03:13PM -0700, Josh Poimboeuf wrote:
> > > > > Actually I just double checked and even the kernel's ELF loader assumes
> > > > > that each executable has only a single text start+end address pair.
> > > > 
> > > > Huh?  What makes you think that?  There can be many executable PT_LOAD
> > > > segments in each and every binary.
> > > 
> > > Right, but for executables (not shared libraries) the kernel seems to
> > > assume they're contiguous?  See the 'start_code' and 'end_code'
> > > variables in load_elf_binary() load_elf_interp().
> > 
> > Typo, see load_elf_binary (not load_elf_interp).
> 
> Hm, actually AFAICT that's only for reporting things in sysfs/proc.  So
> maybe it's assumed but not really "enforced".

Yes, this is copied to mm->start_code (etc.)  This isn't used for
anything very important it seems, it seems to be a leftover from when we
only had really simple binfmts?  For a.out it did actually make sense,
for example :-)


Segher
