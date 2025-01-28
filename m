Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84E23BB;
	Tue, 28 Jan 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024761; cv=none; b=WB1bAuAo6JpQ6UDTVfLqTRKpGShtti64I6wHWV8SrnplRO0d03DpZt/rLW+RBGV4zLNZg30eG9ai8X8yNTtL7di4AMkETsAafybW1z7z3AvQ81TCSjgfS0t4P5YF4EWRkatmZI7Qnz0jggWMGlCijRLiI7rmaLel0jUrFUkXLmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024761; c=relaxed/simple;
	bh=1jA0MRCRkbxv5tsVHqhKax+PS8q9JzCzxj3LqvMDAjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUTDkkqJg3fJorOuSJGm9/zlG0VwrdDghYiMrMlKrdcyNCzWetxokx50SnTywmx9LL4DjWWCTs8J86dDwd8qz3g6FDQDUGCllYplRsmlcfN3nI0rILY84YkFHd12VXE2CJnflGPYVEXILjqO9g7/QEVwqs5dF8CokY0WwXBMbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJACF4/z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJACF4/z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21644aca3a0so117505425ad.3;
        Mon, 27 Jan 2025 16:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738024759; x=1738629559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyF4HdH2HC+WiKUWnt3Coztwd9+2Hr9YrVrRF0/4INM=;
        b=HJACF4/zOBXX5jzvXiD7ti8x5lhUF0n4tVsIc2KckYPlP0DUdb+wRPJhSRoIR/1Zpp
         M2oTfpUsVL9QGToneqKTDn8QJYeDr/knCLTQEBPoweYNuCuBuN1oM27y6z0hqPs62AkH
         9dqgLE3v7E/yjE9HmAjQl2NQic8xMk7sKwPBrrJDU3EDHXjSzy7CNMFdvnD8GhdBIysx
         QK2pt95R2I95jGRqPLFmwBS2nhXVtc0xyM6CzbLSs/LO03coR6y7I0OOKeuxITysDQLo
         JxOQFJqZ7yLWGGg/sjRM95CFbvB90RbkT52RroBKN6P+iMwAhGCXjUONLULTjpn4Vq2h
         yvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738024759; x=1738629559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyF4HdH2HC+WiKUWnt3Coztwd9+2Hr9YrVrRF0/4INM=;
        b=SMq64HG6eSiDY1wWcpTmgoO3tPhhUUod5bhfdjicMo6HrFeKqhFfIkQnKjIzPaQEwT
         uKge6I+sZFnRSTxrjwvWMzH6MhlOB+fHUmZhcqo71oRsvyMEI5QphOug5Od8NXp0ZaG4
         VuJT109KwROfCJ8VHwvtWv/fYH4+CHgdhm2RzA/fMN5mVECs9ZLkbzytgLX/EWorTK3B
         +ZiiCRkoc3TtVyy2ODBxkIrMvw/GPvrQQ4mggXoG5yeVyklJSeZXyzi2HBSNTLJYg/oN
         /rs8xIZzxy+/KoHQdOjsHFztlKr2OSEyqikt6vITZn34KTtkc1oAh3l5f14VUUhGMbMq
         S3KA==
X-Forwarded-Encrypted: i=1; AJvYcCVPCwN53JR89bw8pH1lEAWz8vdUwflQtX/d9xo93qIDDNWX5ThH3F7YvGkAxmyDMSug2rwgH2wtTI/GSjCbOhb2Jw==@vger.kernel.org, AJvYcCWINUypN0MdViKfE3kaIJgLQymXy5tKKqtZtLT2VwRUkWF7eMeS0p6EJmGhOT4AhHjONiLMQerBSTPxyMsri5X3QhvI@vger.kernel.org, AJvYcCWnE+JN51yajhiiUyfB4fMc+bOg2X8+LY0cJ5HTkKl5xMpzXy/W+7m5bjxsn3XUnGEux1ImWwO8X07tP6o=@vger.kernel.org, AJvYcCXYWvstGhIuc2/UBrDdo57hlD42DAncIMfdDmkbSMhaYS5lVrukk/S2iZfY7DUUGCFIw0qK0cj4vzrycoRhWfyS9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SPLM196NqiF5ELXxEQouEqmzlM6HZtNt4eslGDtsQ2SZ+kXP
	Hik1ZWdF2iz60Z+8T3HvQrRBng4u3ZxO9PZYFvmprruYSerJ2Ga1RykxAWY0HahyX6Zt6iBlmLZ
	2A7r43TiYkNIWqj6Gx0sEJW05fMc=
X-Gm-Gg: ASbGncvkcZqo4AXAttWmcbRO5gimhwpxrlCsClP0I/bkHjwvCBEDJ5Vs8oh8R8HzsZk
	H1q4/sqbTMs8JTthD+683Iey0saGwXkOhqLJ9o/hlgDVXYz88uVcWl8+Wo0s/WhXRmrDJTebFg5
	myzw==
X-Google-Smtp-Source: AGHT+IG9r54fvAqRkat2cGuwOk3u26H8/NuOEqSNw2BDokU0rqnDPrP6WuTQdyK5csmiHB+yTHYCvXY66d8d7gQ66+I=
X-Received: by 2002:a05:6a00:4293:b0:727:3cd0:122f with SMTP id
 d2e1a72fcca58-72dafa04710mr56021535b3a.9.1738024757428; Mon, 27 Jan 2025
 16:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <CAEf4Bzb=YFhsLFuK2Zowb1dsXnQPA1uyQUuQ0yXXQbEpeeyDaw@mail.gmail.com> <20250124214107.ycccp4gapbdudzux@jpoimboe>
In-Reply-To: <20250124214107.ycccp4gapbdudzux@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 16:39:04 -0800
X-Gm-Features: AWEUYZnl7juwX3MAZEJ82fNuvmf29PnMRjGzZY-YV0fRU_zHWZeyxANTmRLj3I4
Message-ID: <CAEf4BzYqDk5pGbmCz3XX1a-RXRKSLw9QwD+wUEABinVG+HZ1qQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
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

On Fri, Jan 24, 2025 at 1:41=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Fri, Jan 24, 2025 at 10:02:46AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > > +static __always_inline int __read_fde(struct sframe_section *sec,
> > > +                                     unsigned int fde_num,
> > > +                                     struct sframe_fde *fde)
> > > +{
> > > +       unsigned long fde_addr, ip;
> > > +
> > > +       fde_addr =3D sec->fdes_start + (fde_num * sizeof(struct sfram=
e_fde));
> > > +       unsafe_copy_from_user(fde, (void __user *)fde_addr,
> > > +                             sizeof(struct sframe_fde), Efault);
> > > +
> > > +       ip =3D sec->sframe_start + fde->start_addr;
> > > +       if (ip < sec->text_start || ip > sec->text_end)
> >
> > ip >=3D sec->test_end ? ip =3D=3D sec->test_end doesn't make sense, no?
>
> Believe it or not, this may have been intentional: 'text_end' can
> actually be a valid stack return address if the last instruction of the
> section is a call to a noreturn function.  The unwinder still needs to
> know the state of the stack at that point.
>

TIL...

> That said, there would be no reason to put an FDE at the end.  So yeah,
> it should be '>=3D'.
>
> > > +static __always_inline int __read_fre(struct sframe_section *sec,
> > > +                                     struct sframe_fde *fde,
> > > +                                     unsigned long fre_addr,
> > > +                                     struct sframe_fre *fre)
> > > +{
> > > +       unsigned char fde_type =3D SFRAME_FUNC_FDE_TYPE(fde->info);
> > > +       unsigned char fre_type =3D SFRAME_FUNC_FRE_TYPE(fde->info);
> > > +       unsigned char offset_count, offset_size;
> > > +       s32 ip_off, cfa_off, ra_off, fp_off;
> > > +       unsigned long cur =3D fre_addr;
> > > +       unsigned char addr_size;
> > > +       u8 info;
> > > +
> > > +       addr_size =3D fre_type_to_size(fre_type);
> > > +       if (!addr_size)
> > > +               return -EFAULT;
> > > +
> > > +       if (fre_addr + addr_size + 1 > sec->fres_end)
> >
> > nit: isn't this the same as `fre_addr + addr_size >=3D sec->fres_end` ?
>
> Yes, but that would further obfuscate the fact that this is validating
> that the next two reads don't go past sec->fres_end:
>
>         UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
>         UNSAFE_GET_USER_INC(info, cur, 1, Efault);
>
> The explicit "1" is for that second read.
>
> I'll do something like SFRAME_FRE_INFO_SIZE instead of 1 to make that
> clearer.

yeah, I definitely didn't connect 1 with the size of fre info byte,
named #define makes sense, thanks!

>
> > > +               return -EFAULT;
> > > +
> > > +       UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
> > > +       if (fde_type =3D=3D SFRAME_FDE_TYPE_PCINC && ip_off > fde->fu=
nc_size)
> >
> > is ip_off =3D=3D fde->func_size allowable?
>
> This was another one where I was probably thinking about the whole "last
> insn could be a call to noreturn" scenario.
>
> But even in that case, the frame would be unchanged after the call, so
> there shouldn't need to be an FRE there.
>
> In fact, for the unwinder to deal with that scenario, for a call frame
> (as opposed to an interrupted one), it should always subtract one from
> the return address before calling into sframe so that it points to the
> calling instruction.  </me makes note to go do that>
>
> So yeah, this looks like another off-by-one, caused by overthinking yet
> not thinking enough.
>
> > > +               return -EFAULT;
> > > +
> > > +       UNSAFE_GET_USER_INC(info, cur, 1, Efault);
> > > +       offset_count =3D SFRAME_FRE_OFFSET_COUNT(info);
> > > +       offset_size  =3D offset_size_enum_to_size(SFRAME_FRE_OFFSET_S=
IZE(info));
> > > +       if (!offset_count || !offset_size)
> > > +               return -EFAULT;
> > > +
> > > +       if (cur + (offset_count * offset_size) > sec->fres_end)
> >
> > offset_count * offset_size done in u8 can overflow, no? maybe upcast
> > to unsigned long or use check_add_overflow?
>
> offset_size is <=3D 2 as returned by offset_size_enum_to_size().
>
> offset_count is expected to be <=3D 3, enforced by the !offset_count chec=
k
> at the bottom.
>
> An overflow here would be harmless as it would be caught by the
> !offset_count anyway.  Though I also notice offset_count isn't big
> enough to hold the 2-byte SFRAME_FRE_OFFSET_COUNT() value.  Which is
> harmless for the same reason, but yeah I'll make offset_count an
> unsigned int.

yeah, the less whoever is reading has to worry about overflows, the
better, thanks!

>
> > > +static __always_inline int __find_fre(struct sframe_section *sec,
> > > +                                     struct sframe_fde *fde, unsigne=
d long ip,
> > > +                                     struct unwind_user_frame *frame=
)
> > > +{
> > > +       unsigned char fde_type =3D SFRAME_FUNC_FDE_TYPE(fde->info);
> > > +       struct sframe_fre *fre, *prev_fre =3D NULL;
> > > +       struct sframe_fre fres[2];
> >
> > you only need prev_fre->ip_off, so why all this `which` and `fres[2]`
> > business if all you need is prev_fre_off and a bool whether you have
> > prev_fre at all?
>
> So this cleverness probably needs a comment.  prev_fre is actually
> needed after the loop:
>
> > > +       if (!prev_fre)
> > > +               return -EINVAL;
> > > +       fre =3D prev_fre;
>
> In the body of the loop, prev_fre is a tentative match, unless the next
> fre also matches, in which case that one becomes the new tentative
> match.
>
> I'll add a comment.  Also it'll probably be less confusing if I rename
> "prev_fre" to "fre", and "fre" to "next_fre".

ah, yeah, I missed that, you are right

>
> > > +       unsigned long fre_addr;
> > > +       bool which =3D false;
> > > +       unsigned int i;
> > > +       s32 ip_off;
> > > +
> > > +       ip_off =3D (s32)(ip - sec->sframe_start) - fde->start_addr;
> > > +
> > > +       if (fde_type =3D=3D SFRAME_FDE_TYPE_PCMASK)
> > > +               ip_off %=3D fde->rep_size;
> >
> > did you check that fde->rep_size is not zero?
>
> I did not, good catch!
>
> > > +       fre_addr =3D sec->fres_start + fde->fres_off;
> > > +
> > > +       for (i =3D 0; i < fde->fres_num; i++) {
> >
> > why not binary search? seem more logical to guard against cases with
> > lots of FREs and be pretty fast in common case anyways.
>
> That would be nice, but the FREs are variable-sized and you don't know
> how big one is until you start reading it.

ah, another non-obvious thing, yeah... do you think it's worth fixing
this and making FREs binary searchable in v3?

Indu, do you have some stats on distribution of FRE count per FDE in practi=
ce?

Tbh, FRE format is bothering me quite a lot... but let's discuss that
in another thread with you and Indu

>
> --
> Josh
