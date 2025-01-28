Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478B12E5D;
	Tue, 28 Jan 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026641; cv=none; b=LCTTOOdvTrLyVDl0JsBpw/lHvV1wygQRR+57AcJasIWPo83cyCLgpz1YZSOFUpa0QCUlUwox3WmZoz4hrl+V7iHGXp9Ep2SkEyRBYuJIM3cvzJZoixyFL1T40VaL95o1gB8tobhQi5fdadh2FPS4w3pCMClp5lQIVFn3nsKTHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026641; c=relaxed/simple;
	bh=Nn4wZcHmjSC9efQCNA7qWPb+T1SjctE3+I3ZjUk8CS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umUyVMkQEOR0cjRs1ex/hlKeCbewaIPNJhacXA/OmUHBBVe4c2QNI+mAbJJiLDclzn+3XTs0rUMVtOjr7I0TqE72IiLBah1W75ZWIzvB8rkQ/Ya7SVSfCDPtqbY7CYsTSIkXauMiWS4FWgp7s1OonqS+XVMBzE+wGh5HB1xBX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqwWWvF4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqwWWvF4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so106304685ad.1;
        Mon, 27 Jan 2025 17:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738026639; x=1738631439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFaFTCbcg6zys7LF9nbLF72mqooIsgBWF8oFYAhUGHc=;
        b=FqwWWvF4H/I0+gDrtENENktTwI7+mG0/p6MdM2GT3TSHKoIZbEWghFdG5Nt98KPuUG
         6VFWWVcMvjTP4rmnc7zNZiXrRkzNn6uqiSWXM6DiHOiQKl2xQSPU+AQ3+USmhCG4+BjI
         nYbMSPjoLNX58I7s4aJFS4e3oboHQzVj3FfGSP6mZ6YMOLKPoNzoFhDRsXCwUc5QmXj2
         5SiGcCPLPjnqiNjphzojIYrJdzlXBzfcmMo24TQSeaJamH+Iwa0N9T+SpYynE4rzZTHh
         6o7FZK7K724BX60fUg4knf55Wgc9xKJzMJsYWbO+PGUwwPDosBEpwoAa5GiVamnHsXNu
         ULKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738026639; x=1738631439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFaFTCbcg6zys7LF9nbLF72mqooIsgBWF8oFYAhUGHc=;
        b=fT23LysVI9uxDy1PiXwyer00YuyLkyAesaLnq+R4FLvx+OvNxJAK7PSVsvOBgzzj5l
         I4WdKzVkZkHwHViqQToNlr7bNmknEaLvi7O/6TiEUCsufy2ATnbDxp7458CAWkESGyVB
         52qnw7JLT2KJbYXLZBO89cU80kyqwxOSXrZ4B9jCF4kfYy+YALHRJ3Z6zqXCGDb7TfQM
         o8Eykezv5gmokWOfMyz8ahKDTFVG6taYr+qDlgl1tJ60bRXmcwRcWNJ1l4kx4ldeOez9
         rbMtfIwCCf5RQwl7wYiY6umVNy3KIpyh03audTErnfszHuEVYlGDQax/4t/Ub0KURIdi
         d0zA==
X-Forwarded-Encrypted: i=1; AJvYcCUW2CZtCIwRzl7n7HkV/k3ehX2mSCEfbRBu3ddYLKw9azii3gcxrGQvcCVmgsK6HGh4jOQb8TQKr07gU7MKtGcGPg==@vger.kernel.org, AJvYcCUfKFkCgPtHPtx1dKpTpkBeKFCD8Kp7Of7VU7LjPEXP55LW4RSl/TASheCn0v6hmA8jV8vFxIEB/TpoQI5GXuKU0+bA@vger.kernel.org, AJvYcCW2kXf6IdiH6+8Vfsgx41nvv+c1PSi1BOtqc3NavOv0WGobNgf588T9Rmu93PEOvgMd9OHlC2Xjkf3VLSY=@vger.kernel.org, AJvYcCWYmLtbH4uAMRsde7FbIcrgtE0EOLzRme0SaunJQUTKHzXiRrDK19yCuegWGO9aAJNzKFGrN5AINu1vvrVPFAE1QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY03fSow2CJh7i9dNhscYh7OwJh420swQH5WPAo9IDwPphRD/T
	N13MfAPIUCZ/2nUCbMW6W7P5XsoaGO+GCaYB9nZCsPYcRZA9jwjne7D4B8RKokfk5sQSoYCvRxk
	FzKO6nSiNmFFX49jMUFE1j/rXqYg=
X-Gm-Gg: ASbGncthhBrNxLW64xp+4huj3zpUzttPy5Fh0auBTkEf3rLuToYxol36sWW2jjDvBq9
	UBlQRYbittKNw7Xjfj/3kdzTVs8Vmtgk60VchxjTbu96g+Q63FlcEhDytc5jIYgkpMQqcZaJoax
	UwCw==
X-Google-Smtp-Source: AGHT+IErUgz35mMH3qAG+m/OwZiXkMtp/dHI46GDjB7DXUOVSTFpNDmXEP3InJAvgwMhkX3/csqCXJusKVPj4tDMqmY=
X-Received: by 2002:a05:6a00:90a7:b0:725:e05a:c975 with SMTP id
 d2e1a72fcca58-72dafb71980mr62534824b3a.19.1738026638933; Mon, 27 Jan 2025
 17:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe> <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
In-Reply-To: <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 17:10:27 -0800
X-Gm-Features: AWEUYZl7iOz2pUsRE6fa6X6fx09gcs8IsZFe9bpaBJVvzlkLrbLaD3ZiVfoaRao
Message-ID: <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Indu Bhagat <indu.bhagat@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:14=E2=80=AFPM Indu Bhagat <indu.bhagat@oracle.com=
> wrote:
>
> On 1/24/25 11:21 AM, Josh Poimboeuf wrote:
> > On Fri, Jan 24, 2025 at 10:00:52AM -0800, Andrii Nakryiko wrote:
> >> On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
> >>> +static inline int sframe_add_section(unsigned long sframe_start, uns=
igned long sframe_end, unsigned long text_start, unsigned long text_end) { =
return -ENOSYS; }
> >>
> >> nit: very-very long, wrap it?
> >
> > That was intentional as it's just an empty stub, but yeah, maybe 160
> > chars is a bit much.
> >
> >>> +       if (shdr.preamble.magic !=3D SFRAME_MAGIC ||
> >>> +           shdr.preamble.version !=3D SFRAME_VERSION_2 ||
> >>> +           !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> >>
> >> probably more a question to Indu, but why is this sorting not
> >> mandatory and part of SFrame "standard"? How realistically non-sorted
> >> FDEs would work in practice? Ain't nobody got time to sort them just
> >> to unwind the stack...
> >
> > No idea...
> >
> >>> +       if (!shdr.num_fdes || !shdr.num_fres) {
> >>
> >> given SFRAME_F_FRAME_POINTER in the header, is it really that
> >> nonsensical and illegal to have zero FDEs/FREs? Maybe we should allow
> >> that?
> >
> > It would seem a bit silly to create an empty .sframe section just to se=
t
> > that SFRAME_F_FRAME_POINTER bit.  Regardless, there's nothing the kerne=
l
> > can do with that.
> >
>
> Yes, in theory, it is allowed (as per the specification) to have an
> SFrame section with zero number of FDEs/FREs.  But since such a section
> will not be useful, I share the opinion that it makes sense to disallow
> it in the current unwinding contexts, for now (JIT usecase may change
> things later).
>

I disagree, actually. If it's a legal thing, it shouldn't be randomly
rejected. If we later make use of that, we'd have to worry not to
accidentally cause problems on older kernels that arbitrarily rejected
empty FDE just because it didn't make sense at some point (without
causing any issues).


> SFRAME_F_FRAME_POINTER flag is not being set currently by GAS/GNU ld at a=
ll.
>
> >>> +               dbg("no fde/fre entries\n");
> >>> +               return -EINVAL;
> >>> +       }
> >>> +
> >>> +       header_end =3D sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> >>> +       if (header_end >=3D sec->sframe_end) {
> >>
> >> if we allow zero FDEs/FREs, header_end =3D=3D sec->sframe_end is legal=
, right?
> >
> > I suppose so, but again I'm not seeing any reason to support that.

Let's invert this. Is there any reason why it shouldn't be supported? ;)

> >
> >>> +               dbg("header doesn't fit in section\n");
> >>> +               return -EINVAL;
> >>> +       }
> >>> +
> >>> +       num_fdes   =3D shdr.num_fdes;
> >>> +       fdes_start =3D header_end + shdr.fdes_off;
> >>> +       fdes_end   =3D fdes_start + (num_fdes * sizeof(struct sframe_=
fde));
> >>> +
> >>> +       fres_start =3D header_end + shdr.fres_off;
> >>> +       fres_end   =3D fres_start + shdr.fre_len;
> >>> +
> >>
> >> maybe use check_add_overflow() in all the above calculation, at least
> >> on 32-bit arches this all can overflow and it's not clear if below
> >> sanity check detects all possible overflows
> >
> > Ok, I'll look into it.
> >
> >>> +struct sframe_preamble {
> >>> +       u16     magic;
> >>> +       u8      version;
> >>> +       u8      flags;
> >>> +} __packed;
> >>> +
> >>> +struct sframe_header {
> >>> +       struct sframe_preamble preamble;
> >>> +       u8      abi_arch;
> >>> +       s8      cfa_fixed_fp_offset;
> >>> +       s8      cfa_fixed_ra_offset;
> >>> +       u8      auxhdr_len;
> >>> +       u32     num_fdes;
> >>> +       u32     num_fres;
> >>> +       u32     fre_len;
> >>> +       u32     fdes_off;
> >>> +       u32     fres_off;
> >>> +} __packed;
> >>> +
> >>> +struct sframe_fde {
> >>> +       s32     start_addr;
> >>> +       u32     func_size;
> >>> +       u32     fres_off;
> >>> +       u32     fres_num;
> >>> +       u8      info;
> >>> +       u8      rep_size;
> >>> +       u16 padding;
> >>> +} __packed;
> >>
> >> I couldn't understand from SFrame itself, but why do sframe_header,
> >> sframe_preamble, and sframe_fde have to be marked __packed, if it's
> >> all naturally aligned (intentionally and by design)?..
> >
> > Right, but the spec says they're all packed.  Maybe the point is that
> > some future sframe version is free to introduce unaligned fields.
> >
>
> SFrame specification aims to keep SFrame header and SFrame FDE members
> at aligned boundaries in future versions.
>
> Only SFrame FRE related accesses may have unaligned accesses.

Yeah, and it's actually bothering me quite a lot :) I have a tentative
proposal, maybe we can discuss this for SFrame v3? Let me briefly
outline the idea.

So, currently in v2, FREs within FDEs use an array-of-structs layout.
If we use preudo-C type definitions, it would be something like this
for FDE + its FREs:

struct FDE_and_FREs {
    struct sframe_func_desc_entry fde_metadata;

    union FRE {
        struct FRE8 {
            u8 sfre_start_address;
            u8 sfre_info;
            u8|u16|u32 offsets[M];
        }
        struct FRE16 {
            u16 sfre_start_address;
            u16 sfre_info;
            u8|u16|u32 offsets[M];
        }
        struct FRE32 {
            u32 sfre_start_address;
            u32 sfre_info;
            u8|u16|u32 offsets[M];
        }
    } fres[N] __packed;
};

where all fres[i]s are one of those FRE8/FRE16/FRE32, so start
addresses have the same size, but each FRE has potentially different
offsets sizing, so there is no common alignment, and so everything has
to be packed and unaligned.

But what if we take a struct-of-arrays approach and represent it more like:

struct FDE_and_FREs {
    struct sframe_func_desc_entry fde_metadata;
    u8|u16|u32 start_addrs[N]; /* can extend to u64 as well */
    u8 sfre_infos[N];
    u8 offsets8[M8];
    u16 offsets16[M16] __aligned(2);
    u32 offsets32[M32] __aligned(4);
    /* we can naturally extend to support also u64 offsets */
};

i.e., we split all FRE records into their three constituents: start
addresses, info bytes, and then each FRE can fall into either 8-, 16-,
or 32-bit offsets "bucket". We collect all the offsets, depending on
their size, into these aligned offsets{8,16,32} arrays (with natural
extension to 64 bits, if necessary), with at most wasting 1-3 bytes to
ensure proper alignment everywhere.

Note, at this point we need to decide if we want to make FREs binary
searchable or not.

If not, we don't really need anything extra. As we process each
start_addrs[i] and sfre_infos[i] to find matching FRE, we keep track
of how many 8-, 16-, and 32-bit offsets already processed FREs
consumed, and when we find the right one, we know exactly the starting
index within offset{8,16,32}. Done.

But if we were to make FREs binary searchable, we need to basically
have an index of offset pointers to quickly find offsetsX[j] position
corresponding to FRE #i. For that, we can have an extra array right
next to start_addrs, "semantically parallel" to it:

u8|u16|u32 start_addrs[N];
u8|u16|u32 offset_idxs[N];

where start_addrs[i] corresponds to offset_idxs[i], and offset_idxs[i]
points to the first offset corresponding to FRE #i in offsetX[] array
(depending on FRE's "bitness"). This is a bit more storage for this
offset index, but for FDEs with lots of FREs this might be a
worthwhile tradeoff.

Few points:
  a) we can decide this "binary searchability" per-FDE, and for FDEs
with 1-2-3 FREs not bother, while those with more FREs would be
searchable ones with index. So we can combine both fast lookups,
natural alignment of on-disk format, and compactness. The presence of
index is just another bit in FDE metadata.
  b) bitness of offset_idxs[] can be coupled with bitness of
start_addrs (for simplicity), or could be completely independent and
identified by FDE's metadata (2 more bits to define this just like
start_addr bitness is defined). Independent probably would be my
preference, with linker (or whoever will be producing .sframe data)
can pick the smallest bitness that is sufficient to represent
everything.

Yes, it's a bit more complicated to draw and explain, but everything
will be nicely aligned, extensible to 64 bits, and (optionally at
least) binary searchable. Implementation-wise on the kernel side it
shouldn't be significantly more involved. Maybe the compiler would
need to be a bit smarter when producing FDE data, but it's no rocket
science.

Thoughts?
