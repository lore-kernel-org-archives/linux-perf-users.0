Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F32777FC
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142544; cv=pass; b=VEpyimuBInfOzCCy8w2bu9MxV9xLBIcZo4UmesDEj6blnfxINPvlkBHAhfoOIHZGcS2fjxXWZfh2ud5K+2wrQUtzf7lK+JtJufA0zcJBXk9eowCJxdNXsaNVS5jlgdrU/Sv6+tpZf5JKpXz1NL9x+TeZ12wK3qEcjlx8E+ji2Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142544; c=relaxed/simple;
	bh=dOiaMeQCvuuFlMcETnxoW2LUri7ZCSp6XqWoH17eweI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg7+kMgQqTwwDAmz3v4VZ3oWIUbTm7AvfTTYFpwIkb7vx4HNOh0WO7wPo3bzpdNrZnC6VLXD2i01qIg0VtIM+wbSjtnFi0eFmI6gJeh6G1vD4ht2PKOLuf7KxyfgsquWXD7uSLeKjupaWuNS7cTw1HsvNeHUj7YdmHe4XW9drWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgAhZLVh; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgAhZLVh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a885af8ee7so3335ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142542; cv=none;
        d=google.com; s=arc-20240605;
        b=N8jIsLDS7cSoBB9ZfyOQx1K5GBrLckAUxSJMblXwwRBIpNcNS6pecg1WTJgQlVHmYK
         7/96xoi2Ox0vmZVcsD7siqiCpz2Kr7VwfSzCxzZzNHTrjFHW/c2bzL2rLQd/TsUDDgm6
         lhmgYflmQPSSzZFGBd15xzILVVYLvlWxudVKIYICm2hOXQFzMc12h3myYX0U17EceS5K
         oqIXSFJ58C2TYp7lO/DHijIeob+3VtLe8ZdZKWTHwau6AkIr5FbCi49PAbTuyFW9XJlQ
         rJuVj8Y39XjMRTG7z69Hhk4Vrt0Zh1WW012D5KdAY9WzaXUP//sjoJ5JPibYsNKM6lsF
         ILgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7jJtHFhrqqAxMkBMaH0Y3vOzZoAcI5uGhjIjjWQ6gI=;
        fh=UxP8Yhv+PNDfoK9Vv1AxR5DlVhxkvQz+BbtF9kMKqZY=;
        b=cRhA/KvIFbmUFU4V4CgHr8buH0nhIWiT5oYBQvT2hnWWnFM8rxUiNAQ3LNExqNOHz+
         HGWaw+dMtC5slJ36LVgrUvoiPYkr2YcdwNuNSv2p869CfVbZoJN2QKoqEQntCUK57lPs
         eM9Xonn6WumOlumbbB5YLaFYS5ZeFhJuv3q4ScYFsKU7fJWZMZN8q7AZkQgcft//kjyI
         4Y++TKgpadX4eVfgvNynEWVOmmC9XMfVqtVNQxIm7x77hXAkzuruiLvGDkXI+d6mHma2
         lHRwzCeNT4qlpvoyWcA0Xb1b/YxMiSGTuOzCJsOqhFoJZfAjJDhR1kbwS4yIsroRjSbS
         F7AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770142542; x=1770747342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7jJtHFhrqqAxMkBMaH0Y3vOzZoAcI5uGhjIjjWQ6gI=;
        b=jgAhZLVhEZcsHVoozFSXiq6GVGzUtvReR4uiIkpfHfYPiOhIBgP4Urybe/tqxFdlty
         VYJI+4feh7G5vV/QPXMtbZUGTkeFSRa4sctKN6f8HH4xWfC5DTzYGUTv/H0Pgq9z3ZQ/
         SqsPktgROLn0cXlgBjijE9r/qZdC01S7HMk9hPMaNb92u2Cr226Ndz7kGpziOTabsrHt
         7CV+kGhVm1ppdP3UxM5s0xWwfxCqintlP34vRBlKCKV5Va3jzshH/gfgAJc/VQ4XfKPL
         qeJL1JvhYHa3SokAmJIG6kNN6bfJkovEszd1U7IO0PY9+sRoIJKGvJ9BeBmbwZxfkEPK
         rRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142542; x=1770747342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7jJtHFhrqqAxMkBMaH0Y3vOzZoAcI5uGhjIjjWQ6gI=;
        b=me3qDqRl6d5sv3Q9pTJC+Mw+Gw56hnBoGJY/8FP64O5cRrDFqt/H2VvloAzES2xqAh
         93FmmDn0stHXL1twcpXsBehacsHosXkeXbUQ1Q4hwXNkLyRtl88SIsdWhko1bnDwVBDk
         UB+xEFrj3QK/b6mhjWOHeRiN6rhIiav1ZLDUeeNLIPPoT9qcTHBSEay4SjDIRN5sD76W
         o3RI4cASZM0q3JlEw9Y9Ln9rL7I8W7O3rn8IpFz2IumNqoZR+DxR+UuX6GShOCmcLP6X
         19vLsZ9Y6ohUAoRNXhT2h4Z0G3Pg+8PVdhL3TKFoBlzURY+FAdblZ28JxsR3iTW/o+fK
         BMqw==
X-Gm-Message-State: AOJu0YwJheG+RyQsgfDoCzWoMPscsU+T9q3n30wRS3Vqu9V3UyXDFfQ7
	CNnSwUYBgsIF2XY5m7iyPgnPbnMPIlZbrJdaPgFIll+0TE2MwE9WvfG5VmZ6EAgsSaQU4s4s0C7
	tTclCFW4ds/mXksKb1uISNsPpGBd7+jg5u3aQHePUPLrv3AEkZ3HuzQSxvcI=
X-Gm-Gg: AZuq6aJ43RY+um0fCDoZ5VyY8fR82NJm8Uak8l5H+gIdfjOVmWYjH38ZbXIA7qniFdF
	CWhC/1nm/TvSiJEYnSl0Y5j0eOupX9CHr3b35tkzhPBi2gTYV2Zc7LO1MYc3GQFyf6FOXpbOmVS
	2K1wiWHcgCHHwhg1VMm8G+c+FYHWMTApbNhQGj93Pyb3TcW0qQqv4udwEktfM3IA7hdjk2rSdJ7
	Pr+9Mp71m0vfoXbvTLDWNZB18NUpgbXriS3YbiRqL3fbBpRGGnfOTL0apV3fBAGsVXOudJjCy69
	vxWSNCNm+qnq70lqqOM2UXRlRw==
X-Received: by 2002:a17:902:cf41:b0:295:1351:f63e with SMTP id
 d9443c01a7336-2a93453683bmr112165ad.10.1770142541945; Tue, 03 Feb 2026
 10:15:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127083030.5909-1-9erthalion6@gmail.com> <aXjvF3N5ZGJlZzFi@x1>
 <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>
 <7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o> <aYIKHjxCGFbReY7Y@x1>
In-Reply-To: <aYIKHjxCGFbReY7Y@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 10:15:30 -0800
X-Gm-Features: AZwV_QgRAhOO7J9asNM51qO7uG-SX_fZZd2pZuvOT5iu_lJcPGMBtblAD0NpHsY
Message-ID: <CAP-5=fU-aJYKAcbFeFYcgMfpvt8oY4BTxEgczP_rvUAiJt+U-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type profiling
 and rust
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Dmitry Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:45=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sun, Feb 01, 2026 at 11:33:54AM +0100, Dmitry Dolgov wrote:
> > > On Fri, Jan 30, 2026 at 09:44:47AM +0100, Dmitry Dolgov wrote:
> > > > I'm not managing to reproduce your results, can you please elaborat=
e
> > > > some more?
> > >
> > > That's most unexpected for me, the test output I see looks like this:
> > >
> > >          : 54     for _ in 1..count {
> > >     0.00 :   5423b8: mov    %ecx,0x7c(%rsp)
> > >     0.00 :   5423bc: mov    %eax,0x80(%rsp)
> > >     0.00 :   5423c3: lea    0x7c(%rsp),%rdi
> > >    12.28 :   5423c8: call   541f00 <core::iter::range::<impl core::it=
er::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
> > >     0.00 :   5423cd: mov    %eax,0x20(%rsp)
> > >    10.21 :   5423d1: jmp    5423d3 <test_rs+0xb3>
> > >     0.00 :   5423d3: mov    0x20(%rsp),%eax
> > >     0.00 :   5423d7: mov    %eax,%eax
> > >     0.00 :   5423d9: test   $0x1,%rax
> > >     0.29 :   5423df: je     5423f6 <test_rs+0xd6>
> > >          : 65     b.data1 +=3D 1;
> > >    13.69 :   5423e1: mov    0x48(%rsp),%rax     # data-type: struct B=
uf +0x18 (data1)
> > >     0.00 :   5423e6: add    $0x1,%rax
> > >     0.00 :   5423ea: mov    %rax,0x18(%rsp)     # data-type: u64 +0
> > >     0.00 :   5423ef: setb   %al
> > >    11.17 :   5423f2: jb     54243a <test_rs+0x11a>
> > >     0.00 :   5423f4: jmp    542426 <test_rs+0x106>
> > >     0.00 :   5423f6: lea    0x30(%rsp),%rdi
> > >          : 73     }
> > >
> > > Where '# data-type: struct Buf' is as far as I understand a manifesta=
tion of
> > > data type profiling succeeding. But my environment has slightly diffe=
rent
> > > version of rust -- I need to figure out what's going on here, thanks.
> >
> > I've being testing this in the same way, but without any rust code --
> > just on a simple datasym workload. Surprisingly, it seems that
> > 'data-type: buf' marks are disappearing even in this case starting from=
:
> >
> > c31040085914f1188720073baa43d1483693c0a3 (perf dwarf-regs: Clean up x86
> > dwarf_regnum code)
>
> > I'm not sure yet why this is happening, but don't see anything in the
> > commit mentioning that -- since there are no code-with-type tests yet,
> > maybe an unexpected side effect?
>
> Ian, can you please take a look at this?

That particular commit is largely adding an i386 to dwarf register
number mapping table but it also expands the x86-64 mapping table:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Dc31040085914f1188720073baa43d1483693c0a3
The code to search the table is largely unchanged so my guess would be
that the new x86-64 entries are causing a dwarf register to be
returned in cases where previously this was -ENOENT. This may have
broken the type profiling, but Namhyung would be the expert on that.

Thanks,
Ian

> Cheers,
>
> - Arnaldo
