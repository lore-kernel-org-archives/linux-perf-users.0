Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF8151982;
	Wed,  5 Feb 2025 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797395; cv=none; b=F9eirJSJpwVMXauipkWkw29jLQ6UkRlt4FHXhtPofJhFQ5b2HUNxBqjQvy5zPNhPY5UhR/mqJY808+9Vi5hwZZ5NwkpzqDqWhOBlhMh//7G0HZv9zjNaOhw2reHiKwkarJ8LtvGlhIxDVuhgnbDCN1jsrxqVBLOiMmfUQ/S0iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797395; c=relaxed/simple;
	bh=Wj/CVGRDhj0AMnzehxYIMirf36EFQvNnh80CifiIIdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQakeDau8GQ34O3KASjWsNQD1eb1uHdOySNVNUVEv6L56fqDGqeEKEThMo2lSOfVi3+JEtjAalRb3RcQNsJo7M0xNZ/fLC2Fu0jBQVSUvAoMeRUE0u7hVFns85TYWKJUBkzO/9sV5V6soXaVv0gfqqKbFtJCK/i8Lsts2T/XIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzyA0aXk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzyA0aXk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so71372366b.3;
        Wed, 05 Feb 2025 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738797391; x=1739402191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DLDGFQsA5eYi3/SKJsY3AMMc7oAiwthh6U/3j6aiA8=;
        b=KzyA0aXkoqkq93C9tJ+5WWOLwGSOWi27AeXN8tYsZWQqmN66jXQlxiCQw9ThGcfo1O
         dWgwFxGrSq1bVMpiYQrNSbxNUoQuWQ8FucibRfaZowiWO5mgZWojH+4JIgfVnBJY4C1z
         50J4sBeEydbl8H8EzjqcR/Wjg8PjPNwAOyEFgITYoyNarh+xWZwmlvR8tNnI9Dd5bVVk
         yfP+HTrz9iFKuHwUaMM6uwV3VMXjnSKG6EtIVK8F9y+Bu6xUVuKOdnD+Z3G1lSnOaLrK
         2lYafX82PqakIRdnkyrJunEtNM9hp5aCM26CBdB4nlwKc0Cklq41dahei69mI+AhAmuh
         PjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738797391; x=1739402191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DLDGFQsA5eYi3/SKJsY3AMMc7oAiwthh6U/3j6aiA8=;
        b=Ya1oOJZTVWAIuWFMQyxQ86vqbdBDiQVXRHGo4yOv2nYRRX7oOVnI69b5XjILt80l4/
         FwMhuUP586ruGilOBrXOYaaxnWxZseOtG/K62wLyVHls9HWu5F+TonPODb+K+yfe4nPq
         RG3Ci1cVimP+7zDWB5/6KE4a6xuLI3EqwypQ1dTpXHRcpmHzduRVKbxw5noUCaEwk6iM
         LeLlQjUVnj72BBmTlOoS+H4lPVwwglQIuj7LQDzex8M5+tJ78rV4E1PbxB9S9ujjOXaK
         OWlnNRHSRhDsMeyQV6FkDN477ae1lDIfVtfyq72PJzDK+KHZyda40Txgzymm9P7or6N8
         2Ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUmQWlOQjkmCjqEZt+Z6EUtvtW3Wmgb71vJx0zk+QFfdrjkza5EIKYwARUYZzO3OFPm67jcAiZUfzu7wO/dy5VWTd3S@vger.kernel.org, AJvYcCWPRfe+v9hghrndFSzYPpnkCm8jdP6alt0pksD4mF4ZIegA5AlZfem9/XaSwFUpAl21EKDm5bys81PRwutwP25ctA==@vger.kernel.org, AJvYcCWig0EnOT2XoavNXOqLDrjvDD8xhMlphP8yp/iI+JoxGeCmrOlTx0mR+XBMS8NwtNxs0JmdaFL21EIPb+E=@vger.kernel.org, AJvYcCX62cZZVVX4eupxmH2bbA3hboD5m0eWTLFrkkhJE7btLqtBsh/s6z1ef1J+hgf+v3CxwirbebLo91MqBkurWNHDkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynitwhgv4a5yzCcJ2evQnXxGB2m2mgiKKH+p11lNALAp2cYIPW
	iw6ezAVkCBAcvwf6xNSi1aqVopxqiCDM72hO1MABGuyVPq1ZKkqwJSm/L2l3nHUlLvXRhml+B8o
	CSho7/vHCsBlTNJG7Bm2f1exwt0w=
X-Gm-Gg: ASbGncvUywV9+Du4iAxAsxscPmNxKpVpkmSrpB7bwy/PkuRF2TvoDm7/T0ZFvvdiCq5
	Y5d1VHaIcTYt/3tKnts7koo14WvRNiLH3nMf4+hWjuhnopM3ITY+H4J6MQbyqn66jP9cBK1LIcv
	0uWYpkUtmet3Ql
X-Google-Smtp-Source: AGHT+IEJDfbh7SEDUe4tondcRVHUutSHBoPjnGuZCyC2km7vCq9pS3l2q0aVyzOzD/58UCHeqMYto6aRmA7bywUIb+s=
X-Received: by 2002:a17:907:7ba8:b0:ab6:ed8a:601f with SMTP id
 a640c23a62f3a-ab75e23496emr420053766b.12.1738797391080; Wed, 05 Feb 2025
 15:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe> <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com> <12cef882-b5b2-43e5-9d78-abe4354069dd@oracle.com>
In-Reply-To: <12cef882-b5b2-43e5-9d78-abe4354069dd@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 15:16:11 -0800
X-Gm-Features: AWEUYZnxkFChWkdis277aPTXT7H2tb7k8z7GpjlJm_lHO1y5rltDUpAyKQMlV-s
Message-ID: <CAEf4BzaU+citw78376tnN11R0ypyN+nZKTjYN7P1y67Rq+_D+g@mail.gmail.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
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

On Thu, Jan 30, 2025 at 1:21=E2=80=AFPM Indu Bhagat <indu.bhagat@oracle.com=
> wrote:
>
> On 1/27/25 5:10 PM, Andrii Nakryiko wrote:
> >>>>> +struct sframe_preamble {
> >>>>> +       u16     magic;
> >>>>> +       u8      version;
> >>>>> +       u8      flags;
> >>>>> +} __packed;
> >>>>> +
> >>>>> +struct sframe_header {
> >>>>> +       struct sframe_preamble preamble;
> >>>>> +       u8      abi_arch;
> >>>>> +       s8      cfa_fixed_fp_offset;
> >>>>> +       s8      cfa_fixed_ra_offset;
> >>>>> +       u8      auxhdr_len;
> >>>>> +       u32     num_fdes;
> >>>>> +       u32     num_fres;
> >>>>> +       u32     fre_len;
> >>>>> +       u32     fdes_off;
> >>>>> +       u32     fres_off;
> >>>>> +} __packed;
> >>>>> +
> >>>>> +struct sframe_fde {
> >>>>> +       s32     start_addr;
> >>>>> +       u32     func_size;
> >>>>> +       u32     fres_off;
> >>>>> +       u32     fres_num;
> >>>>> +       u8      info;
> >>>>> +       u8      rep_size;
> >>>>> +       u16 padding;
> >>>>> +} __packed;
> >>>> I couldn't understand from SFrame itself, but why do sframe_header,
> >>>> sframe_preamble, and sframe_fde have to be marked __packed, if it's
> >>>> all naturally aligned (intentionally and by design)?..
> >>> Right, but the spec says they're all packed.  Maybe the point is that
> >>> some future sframe version is free to introduce unaligned fields.
> >>>
> >> SFrame specification aims to keep SFrame header and SFrame FDE members
> >> at aligned boundaries in future versions.
> >>
> >> Only SFrame FRE related accesses may have unaligned accesses.
> > Yeah, and it's actually bothering me quite a lot =F0=9F=99=82 I have a =
tentative
> > proposal, maybe we can discuss this for SFrame v3? Let me briefly
> > outline the idea.
> >
>
> I looked at the idea below.  It could work wrt unaligned accesses.
>
> Speaking of unaligned accesses, I will ask away: Is the reason to avoid
> unaligned accesses performance hit or are there other practical reasons
> to it ?

Performance hit on architectures like x86-64 that do support
unaligned, but it's actually a CPU error for some other architectures,
so you'd need to code with that in mind, making local aligned copies,
etc. In general, I'd say it's a bit of a red flag that a format that
is meant to be memory-mapped (effectively) and used without
pre-processing requires dealing with unaligned accesses. So if we can
fix that, that would be a win.

>
> > So, currently in v2, FREs within FDEs use an array-of-structs layout.
> > If we use preudo-C type definitions, it would be something like this
> > for FDE + its FREs:
> >
> > struct FDE_and_FREs {
> >      struct sframe_func_desc_entry fde_metadata;
> >
> >      union FRE {
> >          struct FRE8 {
> >              u8 sfre_start_address;
> >              u8 sfre_info;
> >              u8|u16|u32 offsets[M];
> >          }
> >          struct FRE16 {
> >              u16 sfre_start_address;
> >              u16 sfre_info;
> >              u8|u16|u32 offsets[M];
> >          }
> >          struct FRE32 {
> >              u32 sfre_start_address;
> >              u32 sfre_info;
> >              u8|u16|u32 offsets[M];
> >          }
> >      } fres[N] __packed;
> > };
> >
> > where all fres[i]s are one of those FRE8/FRE16/FRE32, so start
> > addresses have the same size, but each FRE has potentially different
> > offsets sizing, so there is no common alignment, and so everything has
> > to be packed and unaligned.
> >
> > But what if we take a struct-of-arrays approach and represent it more l=
ike:
> >
> > struct FDE_and_FREs {
> >      struct sframe_func_desc_entry fde_metadata;
> >      u8|u16|u32 start_addrs[N]; /* can extend to u64 as well */
> >      u8 sfre_infos[N];
> >      u8 offsets8[M8];
> >      u16 offsets16[M16] __aligned(2);
> >      u32 offsets32[M32] __aligned(4);
> >      /* we can naturally extend to support also u64 offsets */
> > };
> >
> > i.e., we split all FRE records into their three constituents: start
> > addresses, info bytes, and then each FRE can fall into either 8-, 16-,
> > or 32-bit offsets "bucket". We collect all the offsets, depending on
> > their size, into these aligned offsets{8,16,32} arrays (with natural
> > extension to 64 bits, if necessary), with at most wasting 1-3 bytes to
> > ensure proper alignment everywhere.
> >
> > Note, at this point we need to decide if we want to make FREs binary
> > searchable or not.
> >
> > If not, we don't really need anything extra. As we process each
> > start_addrs[i] and sfre_infos[i] to find matching FRE, we keep track
> > of how many 8-, 16-, and 32-bit offsets already processed FREs
> > consumed, and when we find the right one, we know exactly the starting
> > index within offset{8,16,32}. Done.
> >
> > But if we were to make FREs binary searchable, we need to basically
> > have an index of offset pointers to quickly find offsetsX[j] position
> > corresponding to FRE #i. For that, we can have an extra array right
> > next to start_addrs, "semantically parallel" to it:
> >
> > u8|u16|u32 start_addrs[N];
> > u8|u16|u32 offset_idxs[N];
> >
> > where start_addrs[i] corresponds to offset_idxs[i], and offset_idxs[i]
> > points to the first offset corresponding to FRE #i in offsetX[] array
> > (depending on FRE's "bitness"). This is a bit more storage for this
> > offset index, but for FDEs with lots of FREs this might be a
> > worthwhile tradeoff.
> >
> > Few points:
> >    a) we can decide this "binary searchability" per-FDE, and for FDEs
> > with 1-2-3 FREs not bother, while those with more FREs would be
> > searchable ones with index. So we can combine both fast lookups,
> > natural alignment of on-disk format, and compactness. The presence of
> > index is just another bit in FDE metadata.
>
> I have been going back and forth on this one. So there seem to be the
> following options here:
>    #1. Make "binary searchability" a per-FDE decision.
>    #2. Make "binary searchability" a per-section decision (I expect
> aarch64 to have very low number of FREs per FDE).
>    #3. Bake "binary searchability" into the SFrame FRE specification.
> So its always ON for all FDEs.  The advantage is that it makes stack
> tracers simpler to implement with less code.
>
> I do think #2, #3 appear simpler in concept.

Whichever makes it easier across the entire stack (compiler, linker,
kernel/unwinder). As long as binary searchability is possible,
especially for FDEs with lots of FREs. Making it per-FDE just allows
to pick most compact (but still with good performance) representation.

>
> >    b) bitness of offset_idxs[] can be coupled with bitness of
> > start_addrs (for simplicity), or could be completely independent and
> > identified by FDE's metadata (2 more bits to define this just like
> > start_addr bitness is defined). Independent probably would be my
> > preference, with linker (or whoever will be producing .sframe data)
> > can pick the smallest bitness that is sufficient to represent
> > everything.
> >
>
> ATM, GAS does apply special logic to decide the bitness of start_addrs
> per function, and ld just uses that info.  Coupling the bitness of
> offset_idx with bitness of start_addrs will be easy (or _easier_ I
> think), but for now, I leave it as "should be doable" :)

Those offsets are relative to fde's start_addr, right? So, generally
speaking, should be usually small? I my understanding is correct, then
yeah, coupling is probably ok.

>
> > Yes, it's a bit more complicated to draw and explain, but everything
> > will be nicely aligned, extensible to 64 bits, and (optionally at
> > least) binary searchable. Implementation-wise on the kernel side it
> > shouldn't be significantly more involved. Maybe the compiler would
> > need to be a bit smarter when producing FDE data, but it's no rocket
> > science.
> >
> > Thoughts?
>
> Combining the requirements from your email and Josh's follow up:
>    - No unaligned accesses
>    - Sorted FREs
>
> I would put compaction as a "good to have" requirement.  It appears to
> me that any compaction will mean a sort of post-processing which will
> interfere with JIT usecase.
>

sgtm
