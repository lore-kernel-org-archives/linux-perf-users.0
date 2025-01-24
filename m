Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7014D456;
	Fri, 24 Jan 2025 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746523; cv=none; b=VYG65FKk6rvxE/ivQBm+j21cV0z7T1keSAD0cd8U5/fLyi0xb0Izt+hSFpXCM45zayyfYGJ5+iKuoiJ8dO7S3oX8kf6h9f0gsM7zgRQK8uZ4BA9v1fcA/dxe4h6JPZpzCg2QBP0fLVEUcvku3fRLywLIciOlA6N2b2yYEwDvTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746523; c=relaxed/simple;
	bh=vOh/To6/6QBUUmVtmZdB19kGqyYMN/GcvDPXW9BUbqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o38+lNUgRupP1JjiTd+22jbqppJViCLMsdP7lDBsOkcSMHyUxdvdM4e7V5j+17gEfIXzxcDVCJa8Sx75m+JEpLooDBrHVEDujIBPgC55g6hQtKD26TjWDKUREB0gHikXyGEh5xOU6PKa8Kany/QPyBp3I4Qbm90HWmdZWiifr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYJe9Lcc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYJe9Lcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE2EC4CED2;
	Fri, 24 Jan 2025 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746522;
	bh=vOh/To6/6QBUUmVtmZdB19kGqyYMN/GcvDPXW9BUbqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYJe9LccDWDMyUVLqQ6278ONcmCCPcrDONKNF6h/YnVC2mUf/tlJEArdEcOE7DcoO
	 TDgbR3jcjCPAvnAG3dMaFTfZRGmrzA2oekFduFbmVIWqb8tLu6tj6kVz2Fr5Od2Fu8
	 FjRSqhEqlaH0f7lpi9hupTJ4r1u5CKb675K4SFYuk9O5P3SSWFNa5FsG1LaZwKNxDA
	 hZjclYd95azRywPm28yKesx9p++buhWbxMbK1HrUNqmt1Qdaj1V45WYSjjc6ekaRMx
	 1+SKI3kg3GP+BInMsTrCWd0GN8uKnuJvqsEGPhZ3dUOEpWfeFfiR//cHpUBdtPNe81
	 nB3Po5nJRvjzw==
Date: Fri, 24 Jan 2025 11:21:59 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20250124192159.ypvqwoqjvhasamev@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>

On Fri, Jan 24, 2025 at 10:00:52AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > +static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end, unsigned long text_start, unsigned long text_end) { return -ENOSYS; }
> 
> nit: very-very long, wrap it?

That was intentional as it's just an empty stub, but yeah, maybe 160
chars is a bit much.

> > +       if (shdr.preamble.magic != SFRAME_MAGIC ||
> > +           shdr.preamble.version != SFRAME_VERSION_2 ||
> > +           !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> 
> probably more a question to Indu, but why is this sorting not
> mandatory and part of SFrame "standard"? How realistically non-sorted
> FDEs would work in practice? Ain't nobody got time to sort them just
> to unwind the stack...

No idea...

> > +       if (!shdr.num_fdes || !shdr.num_fres) {
> 
> given SFRAME_F_FRAME_POINTER in the header, is it really that
> nonsensical and illegal to have zero FDEs/FREs? Maybe we should allow
> that?

It would seem a bit silly to create an empty .sframe section just to set
that SFRAME_F_FRAME_POINTER bit.  Regardless, there's nothing the kernel
can do with that.

> > +               dbg("no fde/fre entries\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> > +       if (header_end >= sec->sframe_end) {
> 
> if we allow zero FDEs/FREs, header_end == sec->sframe_end is legal, right?

I suppose so, but again I'm not seeing any reason to support that.

> > +               dbg("header doesn't fit in section\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       num_fdes   = shdr.num_fdes;
> > +       fdes_start = header_end + shdr.fdes_off;
> > +       fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde));
> > +
> > +       fres_start = header_end + shdr.fres_off;
> > +       fres_end   = fres_start + shdr.fre_len;
> > +
> 
> maybe use check_add_overflow() in all the above calculation, at least
> on 32-bit arches this all can overflow and it's not clear if below
> sanity check detects all possible overflows

Ok, I'll look into it.

> > +struct sframe_preamble {
> > +       u16     magic;
> > +       u8      version;
> > +       u8      flags;
> > +} __packed;
> > +
> > +struct sframe_header {
> > +       struct sframe_preamble preamble;
> > +       u8      abi_arch;
> > +       s8      cfa_fixed_fp_offset;
> > +       s8      cfa_fixed_ra_offset;
> > +       u8      auxhdr_len;
> > +       u32     num_fdes;
> > +       u32     num_fres;
> > +       u32     fre_len;
> > +       u32     fdes_off;
> > +       u32     fres_off;
> > +} __packed;
> > +
> > +struct sframe_fde {
> > +       s32     start_addr;
> > +       u32     func_size;
> > +       u32     fres_off;
> > +       u32     fres_num;
> > +       u8      info;
> > +       u8      rep_size;
> > +       u16 padding;
> > +} __packed;
> 
> I couldn't understand from SFrame itself, but why do sframe_header,
> sframe_preamble, and sframe_fde have to be marked __packed, if it's
> all naturally aligned (intentionally and by design)?..

Right, but the spec says they're all packed.  Maybe the point is that
some future sframe version is free to introduce unaligned fields.

-- 
Josh
