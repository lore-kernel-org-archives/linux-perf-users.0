Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A117BBF;
	Wed, 29 Jan 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738116173; cv=none; b=M1+7RWP+DMRXXYHpTPB/Zm66SQfI+WzPbHEGBBr5y9MG6n59PxRnHPd4T/wOXAinRd6fv0kHlz0Rgkq2a3xdahi3rtovI6QBlJd1W7KBu+LrQvF0G2t3b8r2owvmCUNVDL+/Rm+FIzvKL63kYmeN4detbNy9dJdz8UoPTjyK4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738116173; c=relaxed/simple;
	bh=Xx4BE3ryJcejEPU8ipJ4zovS4sQsOFwjiDmzGoMGHnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHJboTjpo9aul1MIfoWhH1SVVREalu/boIV6+0H9/RvFBrnQucMMrvzHfyNHTsFj/UVPgUAsgacV/m/X66XLORvnRImN7PdWrOnsXREttdct3sBSNp+H//WNkEau4XshUw0chulfq0QpiicdSBtTMIZNgKThWH23lgDTN4e6d30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5yi6hJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5yi6hJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20B8C4CED3;
	Wed, 29 Jan 2025 02:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738116172;
	bh=Xx4BE3ryJcejEPU8ipJ4zovS4sQsOFwjiDmzGoMGHnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5yi6hJejy319ZcaBiBjU8yadiznzX6YqauEM7v1mQY0cE1+8nQutDUKVp4ODIKp2
	 xo2LiHJfEGiISga20IpJZZJ2g3gHinw4mUVGseLlRF2ubP5+KdVVs68VIqNqw7YDSE
	 Ryo89YL4fJW5gl/QIvvuXtC+If7chg0kSGrKfQhcc4dfOWg4wku59BAYe4e9cww3tr
	 nNOrfZdAUU0mxZSx2a+o17j8f5wj9GRErYwzaMe0vznx2Wtca8yVtj4kUfIuegHf6T
	 i5BZkkZ2gRxVN6taG9D4yj/GvxARJdKYRNism52zADIwOZjK0mo6dX8ZUZiQPMksO7
	 sGjszHSO3FX1Q==
Date: Tue, 28 Jan 2025 18:02:49 -0800
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
Message-ID: <20250129020249.owmklacvuvss7z7n@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>

On Mon, Jan 27, 2025 at 05:10:27PM -0800, Andrii Nakryiko wrote:
> > Yes, in theory, it is allowed (as per the specification) to have an
> > SFrame section with zero number of FDEs/FREs.  But since such a section
> > will not be useful, I share the opinion that it makes sense to disallow
> > it in the current unwinding contexts, for now (JIT usecase may change
> > things later).
> >
> 
> I disagree, actually. If it's a legal thing, it shouldn't be randomly
> rejected. If we later make use of that, we'd have to worry not to
> accidentally cause problems on older kernels that arbitrarily rejected
> empty FDE just because it didn't make sense at some point (without
> causing any issues).

If such older kernels don't do anything with the section anyway, what's
the point of pretending they do?

Returning an error would actually make more sense as it communicates
that the kernel doesn't support whatever hypothetical thing you're
trying to do with 0 FDEs.

> > SFRAME_F_FRAME_POINTER flag is not being set currently by GAS/GNU ld at all.
> >
> > >>> +               dbg("no fde/fre entries\n");
> > >>> +               return -EINVAL;
> > >>> +       }
> > >>> +
> > >>> +       header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> > >>> +       if (header_end >= sec->sframe_end) {
> > >>
> > >> if we allow zero FDEs/FREs, header_end == sec->sframe_end is legal, right?
> > >
> > > I suppose so, but again I'm not seeing any reason to support that.
> 
> Let's invert this. Is there any reason why it shouldn't be supported? ;)

It's simple, we don't add code to "support" some vague hypothetical.

For whatever definition of "support", since there's literally nothing
the kernel can do with that.

> But what if we take a struct-of-arrays approach and represent it more like:
> 
> struct FDE_and_FREs {
>     struct sframe_func_desc_entry fde_metadata;
>     u8|u16|u32 start_addrs[N]; /* can extend to u64 as well */
>     u8 sfre_infos[N];
>     u8 offsets8[M8];
>     u16 offsets16[M16] __aligned(2);
>     u32 offsets32[M32] __aligned(4);
>     /* we can naturally extend to support also u64 offsets */
> };
> 
> i.e., we split all FRE records into their three constituents: start
> addresses, info bytes, and then each FRE can fall into either 8-, 16-,
> or 32-bit offsets "bucket". We collect all the offsets, depending on
> their size, into these aligned offsets{8,16,32} arrays (with natural
> extension to 64 bits, if necessary), with at most wasting 1-3 bytes to
> ensure proper alignment everywhere.

Makes sense.  Though I also have another idea below.

> Note, at this point we need to decide if we want to make FREs binary
> searchable or not.
> 
> If not, we don't really need anything extra. As we process each
> start_addrs[i] and sfre_infos[i] to find matching FRE, we keep track
> of how many 8-, 16-, and 32-bit offsets already processed FREs
> consumed, and when we find the right one, we know exactly the starting
> index within offset{8,16,32}. Done.
> 
> But if we were to make FREs binary searchable, we need to basically
> have an index of offset pointers to quickly find offsetsX[j] position
> corresponding to FRE #i. For that, we can have an extra array right
> next to start_addrs, "semantically parallel" to it:
> 
> u8|u16|u32 start_addrs[N];
> u8|u16|u32 offset_idxs[N];

Binary search would definitely help.  I did a crude histogram for "FREs
per FDE" for a few binaries on my test system:

gdb (the biggest binary on my test system):

10th Percentile: 1
20th Percentile: 1
30th Percentile: 1
40th Percentile: 3
50th Percentile: 5
60th Percentile: 8
70th Percentile: 11
80th Percentile: 14
90th Percentile: 16
100th Percentile: 472

bash:

10th Percentile: 1
20th Percentile: 1
30th Percentile: 3
40th Percentile: 5
50th Percentile: 7
60th Percentile: 9
70th Percentile: 12
80th Percentile: 16
90th Percentile: 17
100th Percentile: 46

glibc:

10th Percentile: 1
20th Percentile: 1
30th Percentile: 1
40th Percentile: 1
50th Percentile: 4
60th Percentile: 6
70th Percentile: 9
80th Percentile: 14
90th Percentile: 16
100th Percentile: 44

libpython:

10th Percentile: 1
20th Percentile: 3
30th Percentile: 4
40th Percentile: 6
50th Percentile: 8
60th Percentile: 11
70th Percentile: 12
80th Percentile: 16
90th Percentile: 20
100th Percentile: 112

So binary search would help in a lot of cases.

However, if we're going that route, we might want to even consider a
completely revamped data layout.  For example:

One insight is that the vast majority of (cfa, fp, ra) tuples aren't
unique.  They could be deduped by storing the unique tuples in a
standalone 'fre_data' array which is referenced by another
address-specific array.

  struct fre_data {
	s8|s16|s32 cfa, fp, ra;
	u8 info;
  };
  struct fre_data fre_data[num_fre_data];

The storage sizes of cfa/fp/ra can be a constant specified in the global
sframe header.  It's fine all being the same size as it looks like this
array wouldn't typically be more than a few hundred entries anyway.

Then there would be an array of sorted FRE entries which reference the
fre_data[] entries:

  struct fre {
  	s32|s64 start_address;
	u8|u16 fre_data_idx;
	
  } __packed;
  struct fre fres[num_fres];

(For alignment reasons that should probably be two separate arrays, even
though not ideal for cache locality)

Here again the field storage sizes would be specified in the global
sframe header.

Note FDEs aren't even needed here as the unwinder doesn't need to know
when a function begins/ends.  The only info needed by the unwinder is
just the fre_data struct.  So a simple binary search of fres[] is all
that's really needed.

But wait, there's more...

The binary search could be made significantly faster using a small fast
lookup array which is indexed evenly across the text address offset
space, similar to what ORC does:

  u32 fre_chunks[num_chunks];

The text address space (starting at offset 0) can be split into
'num_chunks' chunks of size 'chunk_size'.  The value of
fre_chunks[offset/chunk_size] is an index into the fres[] array.

Taking my gdb binary as an example:

.text is 6417058 bytes, with 146997 total sframe FREs.  Assuming a chunk
size of 1024, fre_chunks[] needs 6417058/1024 = 6267 entries.

For unwinding at text offset 0x400000, the index into fre_chunks[] would
be 0x400000/1024 = 4096.  If fre_chunks[4096] == 96074 and
fre_chunks[4096+1] == 96098, you need only do a binary search of the 24
entries between fres[96074] && fres[96098] rather than searching the
entire 146997 byte array.

.sframe size calculation:

    374 unique fre_data entries (out of 146997 total FREs!)
    = 374 * (2 * 3) = 2244 bytes

    146997 fre entries
    = 146997 * (4 + 2) = 881982 bytes

    .text size 6417058 (chunk_size = 1024, num_chunks=6267)
    = 6267 * 8 = 43869 bytes

Approximate total .sframe size would be 2244 + 881982 + 8192 = 906k,
plus negligible header size.  Which is smaller than the v2 .sframe on my
gdb binary (985k).

With the chunked lookup table, the avg lookup is:

  log2(146997/6267) = ~4.5 iterations

whereas a full binary search would be:

  log2(146997) = 17 iterations

So assuming I got all that math right, it's over 3x faster and the
binary is smaller (or at least should be roughly comparable).

Of course the downside is it's an all new format.  Presumably the linker
would need to do more work than it's currently doing, e.g., find all the
duplicates and set up the data accordingly.

-- 
Josh
