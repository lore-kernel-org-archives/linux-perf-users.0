Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874F322B9F;
	Tue, 29 Sep 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705399; cv=none; b=QW6aInFLayNlaKoQuWNg6ocJjDyLo8daY6a2KXEXkS6NZ1swkstWgrOzlBrNlJj+RifTL39E2yX819cRJ5FU/2a8o1XRNJUIcWhipDnY5njBw3jogmFOx1PcTFvaFZ4Ll8wuhoosEPV9gw9MZ9IQtcGiE3LEOuE9VBRt5eW7pCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705399; c=relaxed/simple;
	bh=jIGf+JuBrUWPkyoA7f2ubF6JzGRrafTPwlrNY0S1B6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuS+7DkG8AwuGgl1DcphDWVsFfXyShvCVcuSR5ZT5NnMW711GLEAHp0cIr0eG7bRDmhzVeJufGi1VCZmZK1X1Yg9Xge703DSR2V8fKueBWyRdQB9otZOJI+UFkB386BvQbWDH6tbrVKydh5pW6qcb3hQKtqsjQ5x6XDKXTvBdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLl7WDk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLl7WDk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D61F000FF;
	Tue, 29 Sep 2026 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790705398;
	bh=hKpP6AmRy2uEEd1qKdLiqqz3Y0+SldqHi3ro+MOIkTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QLl7WDk9m3BS//Bc2l4k4yfB4Zwpk4Kn0f2vqkosKdPdv+yx4HsHXsn3jGVbIRbUo
	 FFJyHTQfOa95qB2bn09P+m7mmUBqe6xkq8oWG0D29rXRKw2Ef4HiLiBt81S+zzqA3P
	 vfoWCXibXl0wi9eWOTBJ5RkjtyCD2Dp+79lVTKh4hUDDABRnlgo3KCrvY2tPqDIViE
	 +s/Rh3hGH909asgAT9kuazZHkZsQ+tKSGtcV/9HIhNuzejgNZEfHHbrJc6fZcgB7vm
	 YzKXjCEHCX1Whem8FgEN/BTP9RSpnlsednPVOyzCzoOkWovuIiIi/g0DcY+y8uCbKI
	 zBj+MxUJwQbGQ==
Date: Tue, 29 Sep 2026 11:09:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
Message-ID: <arv-9NWWZ14TG5Te@google.com>
References: <20260928075237.3055101-1-irogers@google.com>
 <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
 <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com>
 <arrhc_7jvX_W2uXS@google.com>
 <CAP-5=fUuwXTN6kjDrSqygN-Dy3OFuWMH705_tsCXX=dbG747QA@mail.gmail.com>
 <CA+w=M=S3USeLyFNaHSjHL+cmzssWk2Bygahetzr0dNU55TZEMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+w=M=S3USeLyFNaHSjHL+cmzssWk2Bygahetzr0dNU55TZEMw@mail.gmail.com>

On Mon, Sep 28, 2026 at 05:12:35PM -0700, Alireza Haghdoost wrote:
> On Mon, Sep 28, 2026 at 3:05 PM Ian Rogers <irogers@google.com> wrote:
> > > I think many of this memory overhead come from the symbol string.
> > > Probably we don't use most of them.  Then would it be nice if we can
> > > lazy-load the strings?
> 
> Namhyung, your guess is right. I counted live symbol allocations in eager mode
> on the sample fixture. At the peak, 986,688 symbols take 258 MiB:
> 
>    names (demangled, avg 210 bytes)   197 MiB   77%
>    struct symbol (48 bytes each,       45 MiB   18%
>      24 of them the rb_node)
>    malloc overhead                     15 MiB    6%
> 
> That is most of the 335 MiB max RSS. With --lazy-load-symbols, only
> 2,928 symbols are created (0.5 MiB), with identical output, and max
> RSS is 108 MiB.

Thanks for checking this!

> 
> > > Without the string (and the priv part), now it has a fixed size so it
> > > should be saved in an array directly.
> 
> That is close to what patch 5/6 of my v3 does. Its index is a sorted
> array of fixed-size entries:
> 
>    struct sym_idx {
>            u64     start;
>            u64     end;
>            u32     name_off;
>            u8      binding;
>            u8      type;
>            u8      flags;
>    };
> 
> That is 24 bytes per symbol. The name is read from the string table
> and demangled only when a sample lands in the symbol. The difference
> from your description is that v3 then creates a regular struct symbol
> for the hit and inserts it in the rb-tree, because the rest of perf
> holds struct symbol pointers. If the entry itself were the symbol,
> with the name as a pointer/offset union, that extra step would go
> away. Ian's patch 1 would help: once every name access goes through
> symbol__name(), that accessor is the only place that has to resolve
> an offset.

I'm curious if name_off would work well for PLT symbols which come from
the dynamic symbol table.  Probably you need to handle them differently.

> 
> > > Probably we can add a limit there
> > > and print it with offset when it doesn't have the name.
> 
> Agreed, that is better than [unknown]. The symbol boundaries are still
> known, so the frame can be printed as an offset and resolved offline.
> I can do the same for the byte cap in v4.
> 
> >
> > We load all symbols instead of lazily because we need the end of a
> > symbol, which we can only determine by processing the entire symbol
> > table as the end of one symbol is the start of the next.
> >
> 
> Ian, I think most symbols don't need the next one for their end. ELF
> symbols have st_size, so the end is start + st_size. Only zero-size
> symbols take the next symbol's start. The whole table still has to be
> scanned to find the symbol for an address, because .symtab isn't
> sorted by address, so an address window would scan it again each time
> it grows. The v3 index scans it once, sorts the entries and fixes up
> the ends there, but keeps only the 24-byte entries, not the names.
> 
> On which kernel symbol is right in the nf_tables example: the sample
> is at 0xffffffffc0c4b280, and /proc/kallsyms has nft_do_chain at
> 0xffffffffc0c4b0b0 and the next nf_tables symbol at
> 0xffffffffc0c4b4e0, so your series is right. The last dca symbol
> starts at 0xffffffffc0c4aa50, and symbols__fixup_end() extends it to
> 0xffffffffc0c4c000, over the first page of nf_tables. I've sent the
> fix separately:
> https://lore.kernel.org/all/20260928-haghdoost-perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com/

Thanks for the fix!
Namhyung

