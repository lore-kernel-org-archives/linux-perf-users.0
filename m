Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4F4431;
	Thu, 30 Jan 2025 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738195371; cv=none; b=HCYhiGQEKBuYOIjHf5hDxPHVKdSpxNJgatZt0RtRV6v5vCwrl1BpMtEuF/qUCNsmAQaxCHM945n29XnvTY8N6ocVsBZiaNYYwn/bWO2nQu0fQt27wG6SChKvnUT1EKL44wYXCA+BAbWDldUjIn1lZ23uB1bdWgfrloypdcnFtiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738195371; c=relaxed/simple;
	bh=HC/SwzpCqcnfyf/P7UY0s2iXQmWXapuqywmN/+aREBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8SHgMaAQekmfAhdUJxnkR7Xke4s+Szu1FCuTC3UV0yqN0+UKAEfLnS6rPMKDyS8954Pqf9mwRoabBcFAr1cyYtKlAhYEr73PXGYu7CfMPEDiVcuxdv5qm02erwjGKLOWmD9BmYFZ/pteEs5lLkaCJDR8nbGGWd+DnSBS7MOAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jejQ+leM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jejQ+leM"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21c2f1b610dso4741465ad.0;
        Wed, 29 Jan 2025 16:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738195369; x=1738800169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i9OmXdthxkoLC7sQudX4oyJT3DTxHdRqdZZLGEU7IE=;
        b=jejQ+leMwlZNoXfWr9TQpKzRodxKTEweVXMzh7onB9qpAggQfXsD18TbEzEi/lC7yp
         tJIkc+n2Z3VQ70AVYQvycmaHUf8tqy69bKOD2ADPM+2sbdFXf40VStk+2P9mUPN4x4hC
         As2iWxnbxVkY8tU1lJ8IuZfG1bad/kLCI4SGWs14sg1cC6irNXw0ipmZm+ilxJzUMKdA
         nmGh146T1VtlsdoRhoCxbCJx6nDfJjmkLkJJDYI3sBuBFygWX7h/j/vpf5lmY1R07wSz
         Gs7Qw2wMPLFweymQKyua/s0ZzdewfKMLwyGGiiH898Oc8qi2x4j+k9Guty99UZ5B3VYd
         gMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738195369; x=1738800169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i9OmXdthxkoLC7sQudX4oyJT3DTxHdRqdZZLGEU7IE=;
        b=OYCkcakBbS5Rd/V+q11LOeS53z694hF8x2wfvx6kgj3sBLgVgZYn+wlROLiqo9NlNP
         ieWIZuKNpPiiF12vj8K0gzyCjSSVu2F1Qy/h0ZM4fY7g+PBKFfdgSiRC7wQU8pZi0+Tz
         XUf7uFh2JTm9p/bJ3j0xSYvtXNSRmIwP5Igb8L8LWr24ZNz1/j7yfH2FGil5I3Hk6ZKU
         F4zztIX5uSB8nx9T1eewJeU3tx5WECZjkAx0ntWHRm90a5aRLjk5Cj8h+7diVdPBuJ9c
         UX/TTFeteXlt5eHFR06xiBoqdkyT09x8PFtyxbREaYjYXR7O1zA89evXQk+EIys6+1AA
         9QDg==
X-Forwarded-Encrypted: i=1; AJvYcCUtNZD42MtepcPRyJ/wHI7Lnx8esOKwS10jlGtQsSiDGIVTy4+jEVStbTGvlOMg6Y05WDuxqjXeunGqmjTCcBc0AA==@vger.kernel.org, AJvYcCVL9xtnvs2v7UqSBEXlc/nDGfWJ/j4qw8zOoUmlXgiD9Xb+AZQhJEPCiPVoWP9XfIuUKtTf5k85vynLaQw=@vger.kernel.org, AJvYcCWjyLxykFyFFUsV8lgXCK/QKNUDHLARvhiJMqB/fz+3RsxfttY5VdeX4CQJL7xSZyRROmlYyizqDz4kTPsPNl2nYrat@vger.kernel.org, AJvYcCX2cGAqmpQ4NkTHqNLyaXmIKUTg+BQcyBJcMFwq9sBmdXRS4OKC8pmd7cXALUdq1ZIGise4wTt2h95rGMa1zNSkpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4a2KFkQo1DxMVJrubyCsGAV4sRry/xb2lFHCft+yUSkryONHu
	Y5VQCC0l8bvWJrYerOnI/HvIHf/Mz/0Qq0QDDzzGcvtlzhu114uK3S0bMhMpFtP8xPtS2xV/Xmg
	TdGioKUU76Nl2ZQquffyoiS9mLZA=
X-Gm-Gg: ASbGncvN34PIADBTEqgUqE+QXgOqeiq/UQ/JBS1McysItSUGhQJnukLeNlDd4flBQls
	U3AUoNbhz98baaY/FYjzQl2qIPm0BxMQXLRUehIcv3056RFooygC95gFM/g+Dv/S6q/MEh+kBNV
	RHKQT/mwwX1NC8
X-Google-Smtp-Source: AGHT+IFsO18O0hUt7w46W93s+/FJHueaEOWJj3xZ/LFKvhLlSO94OifQCGMQ4fx0KvByo6BLQvtkRIOSPzKToYnfRpA=
X-Received: by 2002:a05:6a20:a11d:b0:1e0:b5ae:8fc1 with SMTP id
 adf61e73a8af0-1ed7a5fafdemr8687035637.13.1738195368612; Wed, 29 Jan 2025
 16:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe> <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com> <20250129020249.owmklacvuvss7z7n@jpoimboe>
In-Reply-To: <20250129020249.owmklacvuvss7z7n@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:02:34 -0800
X-Gm-Features: AWEUYZmjLqNnkOquBUYMqH3OY6TP1DDhkht7xmQnu_4DYMNbFw0ndESRS5toW5o
Message-ID: <CAEf4BzYvrAAJv0+2FceJfizRURUsWxUBzRL-VOquM+VtAe-goA@mail.gmail.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, x86@kernel.org, 
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

On Tue, Jan 28, 2025 at 6:02=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Jan 27, 2025 at 05:10:27PM -0800, Andrii Nakryiko wrote:
> > > Yes, in theory, it is allowed (as per the specification) to have an
> > > SFrame section with zero number of FDEs/FREs.  But since such a secti=
on
> > > will not be useful, I share the opinion that it makes sense to disall=
ow
> > > it in the current unwinding contexts, for now (JIT usecase may change
> > > things later).
> > >
> >
> > I disagree, actually. If it's a legal thing, it shouldn't be randomly
> > rejected. If we later make use of that, we'd have to worry not to
> > accidentally cause problems on older kernels that arbitrarily rejected
> > empty FDE just because it didn't make sense at some point (without
> > causing any issues).
>
> If such older kernels don't do anything with the section anyway, what's
> the point of pretending they do?
>
> Returning an error would actually make more sense as it communicates
> that the kernel doesn't support whatever hypothetical thing you're
> trying to do with 0 FDEs.
>
> > > SFRAME_F_FRAME_POINTER flag is not being set currently by GAS/GNU ld =
at all.
> > >
> > > >>> +               dbg("no fde/fre entries\n");
> > > >>> +               return -EINVAL;
> > > >>> +       }
> > > >>> +
> > > >>> +       header_end =3D sec->sframe_start + SFRAME_HEADER_SIZE(shd=
r);
> > > >>> +       if (header_end >=3D sec->sframe_end) {
> > > >>
> > > >> if we allow zero FDEs/FREs, header_end =3D=3D sec->sframe_end is l=
egal, right?
> > > >
> > > > I suppose so, but again I'm not seeing any reason to support that.
> >
> > Let's invert this. Is there any reason why it shouldn't be supported? ;=
)
>
> It's simple, we don't add code to "support" some vague hypothetical.
>
> For whatever definition of "support", since there's literally nothing
> the kernel can do with that.

If under the format specification it's legal, there is no reason for
the kernel to proactively reject it, IMO. But ok, whatever.

>
> > But what if we take a struct-of-arrays approach and represent it more l=
ike:
> >
> > struct FDE_and_FREs {
> >     struct sframe_func_desc_entry fde_metadata;
> >     u8|u16|u32 start_addrs[N]; /* can extend to u64 as well */
> >     u8 sfre_infos[N];
> >     u8 offsets8[M8];
> >     u16 offsets16[M16] __aligned(2);
> >     u32 offsets32[M32] __aligned(4);
> >     /* we can naturally extend to support also u64 offsets */
> > };
> >
> > i.e., we split all FRE records into their three constituents: start
> > addresses, info bytes, and then each FRE can fall into either 8-, 16-,
> > or 32-bit offsets "bucket". We collect all the offsets, depending on
> > their size, into these aligned offsets{8,16,32} arrays (with natural
> > extension to 64 bits, if necessary), with at most wasting 1-3 bytes to
> > ensure proper alignment everywhere.
>
> Makes sense.  Though I also have another idea below.
>
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
>
> Binary search would definitely help.  I did a crude histogram for "FREs
> per FDE" for a few binaries on my test system:
>
> gdb (the biggest binary on my test system):
>
> 10th Percentile: 1
> 20th Percentile: 1
> 30th Percentile: 1
> 40th Percentile: 3
> 50th Percentile: 5
> 60th Percentile: 8
> 70th Percentile: 11
> 80th Percentile: 14
> 90th Percentile: 16
> 100th Percentile: 472
>
> bash:
>
> 10th Percentile: 1
> 20th Percentile: 1
> 30th Percentile: 3
> 40th Percentile: 5
> 50th Percentile: 7
> 60th Percentile: 9
> 70th Percentile: 12
> 80th Percentile: 16
> 90th Percentile: 17
> 100th Percentile: 46
>
> glibc:
>
> 10th Percentile: 1
> 20th Percentile: 1
> 30th Percentile: 1
> 40th Percentile: 1
> 50th Percentile: 4
> 60th Percentile: 6
> 70th Percentile: 9
> 80th Percentile: 14
> 90th Percentile: 16
> 100th Percentile: 44
>
> libpython:
>
> 10th Percentile: 1
> 20th Percentile: 3
> 30th Percentile: 4
> 40th Percentile: 6
> 50th Percentile: 8
> 60th Percentile: 11
> 70th Percentile: 12
> 80th Percentile: 16
> 90th Percentile: 20
> 100th Percentile: 112
>
> So binary search would help in a lot of cases.

yep, agreed, seems like a worthwhile thing to support, given the stats
(I suspect big production C++ applications might be even worse in this
regard)

>
> However, if we're going that route, we might want to even consider a
> completely revamped data layout.  For example:
>
> One insight is that the vast majority of (cfa, fp, ra) tuples aren't
> unique.  They could be deduped by storing the unique tuples in a
> standalone 'fre_data' array which is referenced by another
> address-specific array.
>
>   struct fre_data {
>         s8|s16|s32 cfa, fp, ra;
>         u8 info;
>   };
>   struct fre_data fre_data[num_fre_data];
>
> The storage sizes of cfa/fp/ra can be a constant specified in the global
> sframe header.  It's fine all being the same size as it looks like this
> array wouldn't typically be more than a few hundred entries anyway.
>
> Then there would be an array of sorted FRE entries which reference the
> fre_data[] entries:
>
>   struct fre {
>         s32|s64 start_address;
>         u8|u16 fre_data_idx;

even u16 seems dangerous, I'd use u32, not sure it's worth limiting
the format just to 64K unique combinations

>
>   } __packed;
>   struct fre fres[num_fres];
>
> (For alignment reasons that should probably be two separate arrays, even
> though not ideal for cache locality)
>
> Here again the field storage sizes would be specified in the global
> sframe header.
>
> Note FDEs aren't even needed here as the unwinder doesn't need to know
> when a function begins/ends.  The only info needed by the unwinder is
> just the fre_data struct.  So a simple binary search of fres[] is all
> that's really needed.
>
> But wait, there's more...
>
> The binary search could be made significantly faster using a small fast
> lookup array which is indexed evenly across the text address offset
> space, similar to what ORC does:
>
>   u32 fre_chunks[num_chunks];
>
> The text address space (starting at offset 0) can be split into
> 'num_chunks' chunks of size 'chunk_size'.  The value of
> fre_chunks[offset/chunk_size] is an index into the fres[] array.
>
> Taking my gdb binary as an example:
>
> .text is 6417058 bytes, with 146997 total sframe FREs.  Assuming a chunk
> size of 1024, fre_chunks[] needs 6417058/1024 =3D 6267 entries.
>
> For unwinding at text offset 0x400000, the index into fre_chunks[] would
> be 0x400000/1024 =3D 4096.  If fre_chunks[4096] =3D=3D 96074 and
> fre_chunks[4096+1] =3D=3D 96098, you need only do a binary search of the =
24
> entries between fres[96074] && fres[96098] rather than searching the
> entire 146997 byte array.
>
> .sframe size calculation:
>
>     374 unique fre_data entries (out of 146997 total FREs!)
>     =3D 374 * (2 * 3) =3D 2244 bytes
>
>     146997 fre entries
>     =3D 146997 * (4 + 2) =3D 881982 bytes
>
>     .text size 6417058 (chunk_size =3D 1024, num_chunks=3D6267)
>     =3D 6267 * 8 =3D 43869 bytes
>
> Approximate total .sframe size would be 2244 + 881982 + 8192 =3D 906k,
> plus negligible header size.  Which is smaller than the v2 .sframe on my
> gdb binary (985k).
>
> With the chunked lookup table, the avg lookup is:
>
>   log2(146997/6267) =3D ~4.5 iterations
>
> whereas a full binary search would be:
>
>   log2(146997) =3D 17 iterations
>
> So assuming I got all that math right, it's over 3x faster and the
> binary is smaller (or at least should be roughly comparable).

I'm not sure about this chunked lookup approach for arbitrary user
space applications. Those executable sections can be a) big and b)
discontiguous. E.g., one of the production binaries I looked at. Here
are its three main executable sections:

...
  [17] .bolt.org.text    PROGBITS         000000000b00e640  0ae0d640
       0000000011ad621c  0000000000000000  AX       0     0     64
...
  [48] .text             PROGBITS         000000001e600000  1ce00000
       0000000000775dd8  0000000000000000  AX       0     0     2097152
  [49] .text.cold        PROGBITS         000000001ed75e00  1d575e00
       00000000007d3271  0000000000000000  AX       0     0     64
...

Total text size is about 300MB:
>>> 0x0000000000775dd8 + 0x00000000007d3271 + 0x0000000011ad621c
312603237

Section #17 ends at:

>>> hex(0x0000000011ad621c + 0x000000000b00e640)
'0x1cae485c'

While .text starts at 000000001e600000, so we have a gap of ~28MB:

>>> 0x000000001e600000 - 0x1cae485c
28424100

So unless we do something more clever to support multiple
discontiguous chunks, this seems like a bad fit for user space.

I think having all this just binary searchable is already a big win
anyways and should be plenty fast, no?

>
> Of course the downside is it's an all new format.  Presumably the linker
> would need to do more work than it's currently doing, e.g., find all the
> duplicates and set up the data accordingly.

I do like the idea of deduplicating those records and just indexing
them, as in practice this should probably be much more compact. So it
might be worth looking into this some more. I'll defer to Indu.

>
> --
> Josh
