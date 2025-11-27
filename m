Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348AA3FBA7;
	Thu, 27 Nov 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282011; cv=none; b=JfrSsYdDUPuVEfWRMg6ccjQJIC9+IZe1oKnOHb0prC1WGJD4oTwMPMx6DTNbgCDXPV0RyWTBrJhhzRB1B14WGaJfV+IpAJBmgjTI2eEAElqX5oZnvc6otbOyDG5G8d7nx2pyTJgFpmwBM8stsiZ8lxbkGsRdneWdi2zbwG9PgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282011; c=relaxed/simple;
	bh=TyyoBW2Cdk+8ZJ6lKW+yUP9T0YjNCK7qa9bJpo+Fbe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTYS+ASab10ktvBTkbmIO/i7utjrtnmqYCyYnkF/JszISwo1tqMiW0ROY8hXbyL+5wwKoYyd3ERb2KtB1Qmtx/E+kalxQnE7WbjrdLlCQDaHojMHlwReHMidv/ZMABGx+e6uMmuyRCgzdcrRmGXyFXcVVoRcwK1MpfFtzoZelss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjBAw3Ni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjBAw3Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD67C4CEF8;
	Thu, 27 Nov 2025 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764282010;
	bh=TyyoBW2Cdk+8ZJ6lKW+yUP9T0YjNCK7qa9bJpo+Fbe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjBAw3NiXnjbFo/57RJR0DT3CLy46ytsEBdE8pgPy3ZNbcdpD1OnyySSs7Sk1rgzz
	 7c1ExKviqQfY74udIQ01p5RjmSbTYdJND8QD8BTzaC8cpAOuNzvWrzCA5G/xzr5P4e
	 zaEY6sIwlUNobPMKkOX0vSKWPTypzmzfUQ/sj4S0AxRCOOKOyNdGuiJ0DRrVMoGLKc
	 J5XE0oPyYJrl7GLmpBVFZMVEzPjF/Mx72IoFZMVBkhf8EF2QF/jrF7Jo/lZYmwpycp
	 eg7UQDvTONN3/HwfY6uT0LcKpXigl5aVFVd7WBqGFqpnk+NdSvAAZNipSndeou3MNe
	 xPiaOPKvzv9mw==
Date: Thu, 27 Nov 2025 14:18:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>,
	Fangrui Song <maskray@sourceware.org>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID
 generation
Message-ID: <20251127221822.GA2977@sol>
References: <20251125080748.461014-1-namhyung@kernel.org>
 <20251125192943.GA3061247@google.com>
 <CAP-5=fXh82HpvLhPr9uFtq=HK5V+ZL3xntz7-gspEE5az2+7nw@mail.gmail.com>
 <20251126030452.GA85316@sol>
 <aSi_zXuT8isr8jEC@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSi_zXuT8isr8jEC@google.com>

On Thu, Nov 27, 2025 at 01:17:01PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Nov 25, 2025 at 07:04:52PM -0800, Eric Biggers wrote:
> > On Tue, Nov 25, 2025 at 06:55:39PM -0800, Ian Rogers wrote:
> > > On Tue, Nov 25, 2025 at 11:29 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 25, 2025 at 12:07:46AM -0800, Namhyung Kim wrote:
> > > > > It was reported that python backtrace with JIT dump was broken after the
> > > > > change to built-in SHA-1 implementation.  It seems python generates the
> > > > > same JIT code for each function.  They will become separate DSOs but the
> > > > > contents are the same.  Only difference is in the symbol name.
> > > > >
> > > > > But this caused a problem that every JIT'ed DSOs will have the same
> > > > > build-ID which makes perf confused.  And it resulted in no python
> > > > > symbols (from JIT) in the output.
> > > > >
> > > > > Looking back at the original code before the conversion, it used the
> > > > > load_addr as well as the code section to distinguish each DSO.  But it'd
> > > > > be better to use contents of symtab and strtab instead as it aligns with
> > > > > some linker behaviors.
> > > > >
> > > > > This patch adds a buffer to save all the contents in a single place for
> > > > > SHA-1 calculation.  Probably we need to add sha1_update() or similar to
> > > > > update the existing hash value with different contents and use it here.
> > > > > But it's out of scope for this change and I'd like something that can be
> > > > > backported to the stable trees easily.
> > > > >
> > > > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
> > > > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > > > Cc: Fangrui Song <maskray@sourceware.org>
> > > > > Link: https://github.com/python/cpython/issues/139544
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > That commit actually preserved the behavior of the existing variant of
> > > > gen_build_id() that was under #ifdef BUILD_ID_SHA.  So I guess that code
> > > > was always broken, and it was just never noticed because the alternative
> > > > variant of gen_build_id() under #ifdef BUILD_ID_MD5 was used instead?
> > > >
> > > > The MD5 variant of gen_build_id() just hashed the load_addr concatenated
> > > > with the code.  That's not what this patch does, though.  So just to
> > > > clarify, you'd actually like to go with a third approach rather than
> > > > just restoring the original hash(load_addr || code) approach?
> > > >
> > > > Also, I missed that you had actually changed the hash algorithm.  I had
> > > > assumed the perf folks were were pushing SHA-1 because they were already
> > > > using it.  Given that the algorithm changed, there must not be any
> > > > backwards compatibility concerns here, and you should switch to a modern
> > > > hash algorithm such as SHA-256 instead.
> > > >
> > > > I'd be glad to add an incremental API if you need it, but I'm confused
> > > > why you want SHA-1 and not a modern hash algorithm.
> > > 
> > > Hi Eric,
> > > 
> > > Thanks for the help with the hash functions! There's a bit more
> > > context in this thread:
> > > https://lore.kernel.org/linux-perf-users/CAP-5=fWLgaWsv82dcPajVk=UmBbmwyEd7OVp6psZQ4TiXh-Meg@mail.gmail.com/
> > > 
> > > So genelf is trying to take snippets of jitted code and create ELF
> > > files from them for the purpose of symbolizing in perf. The buildid
> > > hash being used is SHA1 and I think the MD5 support was removed as
> > > unnecessary. The problem this patch is addressing is that a JIT may
> > > create many identical stubs which then end up being deduplicated into
> > > the same buildid as only the code is hashed. The BFD linker seems to
> > > have the same issue (Fangrui filed a bug), gold and lld appear to hash
> > > the symbols (which Namhyung adds to genelf here) but still yield
> > > different build id for the same source assembly code. It is possible
> > > to hash the address of the symbol rather than the symbol itself, but I
> > > think the intent for the code should be to best match what a compiler
> > > and linker would generate. The problem there is that this differs for
> > > every linker :-)
> > > 
> > > Something that is unfortunate in the code now is copying/concatenating
> > > all the build data for the sake of producing the hash. It would be
> > > nice if the code could incrementally build up the sha1 hash to avoid
> > > the copying. I don't know if there is functionality for this
> > > currently.
> > 
> > Again, I can add support for incremental hashing if you need it.  But I
> > don't understand why you want the hash function to be SHA-1.  Also,
> > given that this seems to be a regression fix, it's surprising that
> > you're suddenly changing the inputs to the hash entirely, instead of
> > just going back to hashing load_addr concatenated with the code for now.
> 
> Historically MD5 or SHA1 was the only choice for build-ID in linkers.
> I don't know if it's changed lately though.  But because of that we
> support build-IDs up to 20 bytes and it's in the UAPI too (well.. it's
> implicit in PERF_RECORD_MMAP2).  I think we can support other hashs if
> they fit into it, but SHA-1 would be the right choice for now.
> 
> About load_addr, I don't think it's the right fix.  We cannot have the
> exactly same build-IDs as before since we already switched to SHA-1.
> What we actually want is a way to generate unique IDs for each DSO.
> For that purpose, it'd be nice to use sym/str-tables as Fangrui said
> instead of using load_addr which seems to be a quick hack in the past.
> 
> So I think I can merge this change for stable fix.  And add incremental
> SHA-1 (thanks in advance!) and update the code to it later.

If it needs to be 20 bytes, you should just use a truncated SHA-256.

The only use for SHA-1 is backwards compatibility.  Which it seems you
don't need.

- Eric
