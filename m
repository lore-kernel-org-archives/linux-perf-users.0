Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896F1DC991;
	Fri, 24 Jan 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754871; cv=none; b=AikaxeXnKwkXqSG/gH//7WZD9Niff1pGZkijcsxFF2E8xNcmdlFmJlfREPEHyYMhUbeNC4CPWWDe6Y/KWLNPBs/dyDyqfvosb7ZPUMLWJRwh+NUL4k+3mcHhtqqmTvhLf9LtvAjv6jF4ioPhxZvrQVI7CeYnZsx9paU6pdPh23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754871; c=relaxed/simple;
	bh=I5tmt+70ICd7d5igqLSA99RYKpDqk16i8KZMhMRbxaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISzDhfd5R2RsHi4YnL4O+bVvInEt6QpoUW+gHP1BlLjz6I3Wx8f/Q6D6p2/MT6RStUiLcEV7uETlbKCJzEsuZVU04FDTSD8/VrsAIkzPFA7+EDyZt/jMEitXIwaVQFxhuG+UyIQSlV0xwvQLhif5va4ND4Z3farwGRHD2p3jxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEMt+LwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEMt+LwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E152C4CED2;
	Fri, 24 Jan 2025 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737754870;
	bh=I5tmt+70ICd7d5igqLSA99RYKpDqk16i8KZMhMRbxaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEMt+LwPbOo2w2MLvCaHupYmV/s5GLSkqJxqMOjpTDvPG/BfW15ZVBrPSXw9E/RIx
	 lMihZ9a6Np649b7cMh4h1RHXHEBA9oc6lnuaJBmVGb+voP67P5aiw52Hl3i9QPEENY
	 KRVZ8puTVf+kwm7wcj9571MYhspVcYj/00l3w/KRbNe8V8yXSJyAwV278gQqIxpbcc
	 cvKnDR+h5kuZzlPZgXlfmI9IaNjfKejNyiQL69rv0czskSNB00IgFzq6TCzLSe1533
	 UD39n5sStH2qWPoMo0j6Wy4WzB6/2dYUXTuO7MuHmYU8e8wmoZg0Q2BtG1sOrry1V4
	 mJ8eap52+NrOg==
Date: Fri, 24 Jan 2025 13:41:07 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20250124214107.ycccp4gapbdudzux@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <CAEf4Bzb=YFhsLFuK2Zowb1dsXnQPA1uyQUuQ0yXXQbEpeeyDaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb=YFhsLFuK2Zowb1dsXnQPA1uyQUuQ0yXXQbEpeeyDaw@mail.gmail.com>

On Fri, Jan 24, 2025 at 10:02:46AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > +static __always_inline int __read_fde(struct sframe_section *sec,
> > +                                     unsigned int fde_num,
> > +                                     struct sframe_fde *fde)
> > +{
> > +       unsigned long fde_addr, ip;
> > +
> > +       fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde));
> > +       unsafe_copy_from_user(fde, (void __user *)fde_addr,
> > +                             sizeof(struct sframe_fde), Efault);
> > +
> > +       ip = sec->sframe_start + fde->start_addr;
> > +       if (ip < sec->text_start || ip > sec->text_end)
> 
> ip >= sec->test_end ? ip == sec->test_end doesn't make sense, no?

Believe it or not, this may have been intentional: 'text_end' can
actually be a valid stack return address if the last instruction of the
section is a call to a noreturn function.  The unwinder still needs to
know the state of the stack at that point.

That said, there would be no reason to put an FDE at the end.  So yeah,
it should be '>='.

> > +static __always_inline int __read_fre(struct sframe_section *sec,
> > +                                     struct sframe_fde *fde,
> > +                                     unsigned long fre_addr,
> > +                                     struct sframe_fre *fre)
> > +{
> > +       unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> > +       unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> > +       unsigned char offset_count, offset_size;
> > +       s32 ip_off, cfa_off, ra_off, fp_off;
> > +       unsigned long cur = fre_addr;
> > +       unsigned char addr_size;
> > +       u8 info;
> > +
> > +       addr_size = fre_type_to_size(fre_type);
> > +       if (!addr_size)
> > +               return -EFAULT;
> > +
> > +       if (fre_addr + addr_size + 1 > sec->fres_end)
> 
> nit: isn't this the same as `fre_addr + addr_size >= sec->fres_end` ?

Yes, but that would further obfuscate the fact that this is validating
that the next two reads don't go past sec->fres_end:

	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
	UNSAFE_GET_USER_INC(info, cur, 1, Efault);

The explicit "1" is for that second read.

I'll do something like SFRAME_FRE_INFO_SIZE instead of 1 to make that
clearer.

> > +               return -EFAULT;
> > +
> > +       UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
> > +       if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size)
> 
> is ip_off == fde->func_size allowable?

This was another one where I was probably thinking about the whole "last
insn could be a call to noreturn" scenario.

But even in that case, the frame would be unchanged after the call, so
there shouldn't need to be an FRE there.

In fact, for the unwinder to deal with that scenario, for a call frame
(as opposed to an interrupted one), it should always subtract one from
the return address before calling into sframe so that it points to the
calling instruction.  </me makes note to go do that>

So yeah, this looks like another off-by-one, caused by overthinking yet
not thinking enough.

> > +               return -EFAULT;
> > +
> > +       UNSAFE_GET_USER_INC(info, cur, 1, Efault);
> > +       offset_count = SFRAME_FRE_OFFSET_COUNT(info);
> > +       offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
> > +       if (!offset_count || !offset_size)
> > +               return -EFAULT;
> > +
> > +       if (cur + (offset_count * offset_size) > sec->fres_end)
> 
> offset_count * offset_size done in u8 can overflow, no? maybe upcast
> to unsigned long or use check_add_overflow?

offset_size is <= 2 as returned by offset_size_enum_to_size().

offset_count is expected to be <= 3, enforced by the !offset_count check
at the bottom.

An overflow here would be harmless as it would be caught by the
!offset_count anyway.  Though I also notice offset_count isn't big
enough to hold the 2-byte SFRAME_FRE_OFFSET_COUNT() value.  Which is
harmless for the same reason, but yeah I'll make offset_count an
unsigned int.

> > +static __always_inline int __find_fre(struct sframe_section *sec,
> > +                                     struct sframe_fde *fde, unsigned long ip,
> > +                                     struct unwind_user_frame *frame)
> > +{
> > +       unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> > +       struct sframe_fre *fre, *prev_fre = NULL;
> > +       struct sframe_fre fres[2];
> 
> you only need prev_fre->ip_off, so why all this `which` and `fres[2]`
> business if all you need is prev_fre_off and a bool whether you have
> prev_fre at all?

So this cleverness probably needs a comment.  prev_fre is actually
needed after the loop:

> > +       if (!prev_fre)
> > +               return -EINVAL;
> > +       fre = prev_fre;

In the body of the loop, prev_fre is a tentative match, unless the next
fre also matches, in which case that one becomes the new tentative
match.

I'll add a comment.  Also it'll probably be less confusing if I rename
"prev_fre" to "fre", and "fre" to "next_fre".

> > +       unsigned long fre_addr;
> > +       bool which = false;
> > +       unsigned int i;
> > +       s32 ip_off;
> > +
> > +       ip_off = (s32)(ip - sec->sframe_start) - fde->start_addr;
> > +
> > +       if (fde_type == SFRAME_FDE_TYPE_PCMASK)
> > +               ip_off %= fde->rep_size;
> 
> did you check that fde->rep_size is not zero?

I did not, good catch!

> > +       fre_addr = sec->fres_start + fde->fres_off;
> > +
> > +       for (i = 0; i < fde->fres_num; i++) {
> 
> why not binary search? seem more logical to guard against cases with
> lots of FREs and be pretty fast in common case anyways.

That would be nice, but the FREs are variable-sized and you don't know
how big one is until you start reading it.

-- 
Josh
