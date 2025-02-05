Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA34217F23;
	Wed,  5 Feb 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796731; cv=none; b=UbdEHIuGdSeD+75KhVxADyaMZE2NG30fCvDfYcu3V9arnfoiYGdqkHWb7mbD/s/k/BXtOc7LzZIX+T+RMYu5/UUUT2YWc6iGbHX2tPMuGu/cKatmZzTYLp9XzEa1g/6QDOTQWxvXI4Cip0E/dlj083KChrcFaNxAfpc5HhSVxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796731; c=relaxed/simple;
	bh=QZs8oI8epbJ/roNmknquSVLCgBNVCyGNwQL/Gy2TGl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr6X8DxNn8hCvMjK0lhaKGTaZu3Kv68WCSClK1KL3Rk3Lo3T5g7P0+xzydNzq9YC4D6x23WHlz1WgQ1NxMGNb5lhjQEQ7lg6zyJaIsGkvn8Tb9XaK97iF84z2tdH+TzLgDDifYAdjGsRaKJX530pXKfyN2iVfvpG2m//yMTQG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYzyVVpp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYzyVVpp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f42992f608so357613a91.0;
        Wed, 05 Feb 2025 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738796729; x=1739401529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tg9fVecprHSBkd8RZVVGCGxOSrmcjXLqlZW+aeAZvM=;
        b=kYzyVVppQtr/Iv4QJdbPvFEj7pkEKZd2Ol4+0pzvn9zC2epdh3pfAWNS+XsHHdFD2y
         hGAUfmJH22ojL9Zz3V+ovK6+ir4DX0Dih6Z4utMkqDDCENX/gGBYdm+xJDt4UsvNlkH4
         js2JsyfFbzaHVMimjRKEvAB/NU+tOH2vLOkzgbXy9ajAn4Usm2KEPXWNV0cH2s2rPSXk
         jSIZCQQ13zb9TCzXBoIreE9/c6vgUi/tRAQ7egmcsZ5munR7zD/Bl/vex3mXKDBE+vrx
         PZhdY+JjxXeVO9qbjk4SCb8I8sj1w+q97a6BV5N52kPWkQy8inVUHUfdau++shiN9Miz
         9YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738796729; x=1739401529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Tg9fVecprHSBkd8RZVVGCGxOSrmcjXLqlZW+aeAZvM=;
        b=qhdy5Uv8Oh6VxkHiGkgZap2Gim/8PeUS56kMm7tQ0Yd7ap2LDDfx3NBnI2fI469neD
         4BKZIGGJGyn5EFw2KEkS1Xk1antj1P+W4g0zCXuizcp0YoqyGjsNzYkR00Bx4oTluWBP
         PXy2CvJaAehPTbaJUyWAg9unLhDIlABxvRuU3dTW7N3hf0pM94ZaGXA25gu9EVYiUPKb
         WFxVtnT00ZAuqMjNXONt/7IsHpE1XaYB9xP5ghaUDhZfBftzRXx4QZ3IEBwQujxvOuSx
         IrR/X+bkCINzHJc7quCfE2WmY5imZi8eVfyyr5Tcbm6mLdUDtf4auUP/TM+t7eP6miq0
         Tb5A==
X-Forwarded-Encrypted: i=1; AJvYcCUhLo7oXvPfNzBOohOnCqrjXEH9GvdFdUuL6bIOZQFhcufh0HXByV40k/lYKyMn35CvnRM2sCJcAOpneok=@vger.kernel.org, AJvYcCUjyIQbXdDpG8hVj1P781mkuXIcfmQp+vN2pSsuvRiXHUrQk7TpaX48fjHcffToMJsxZbK39nsVnGJOKMo5cysOog==@vger.kernel.org, AJvYcCWNSLfweXgCHLtK2Lkv7KhvUg910k08dBmUVEsoqoFBXd4FPKafJjhO/Crj5XMF8aOfPMRRNWAuY0sEEUwWX3vmbTRw@vger.kernel.org, AJvYcCXMLgza4xSeSOfSwJI6JAwG+GA7r/FgQj+8Px0x3Bw2HI6i1/+HKTkUmifXySalCuQ4FWRxMYw1gnllGGS8gcIvVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3cTTnkYkjaC5+26PuO9gfFQD0LYEqF5iApfFsxKScDeF6Li8
	iYqsfzljBA/Fw0cdSQ+WiCEs74i+xoQFe3aOIB3MzZnba7S6knEu0gWS8VWovaHGUqlN7CJ0pqJ
	AmLZcRXL4ZAiPGNyo3VWuVEGGwiM=
X-Gm-Gg: ASbGnculywJxGfpy/Pcl/DuiaA4HGNZV1y2z9S4WmRvCFvLwtHnIZkjU45ezys6msBa
	QXtXAt+9vm7kgJPU5FN0wRGVk3YOA0QYfJoXQI2EbiGeddALo5M0N1LROxIepsOFHbWxgODkYMq
	GjZsXy6js7CTta
X-Google-Smtp-Source: AGHT+IFlLS0YdzB4OxO+h0dwZPUj3Z/hL14JGgioWJMbMELb4zIrgvsNEwJV6WCu1wieOrVzJst3AZIIsefRV+sM2cc=
X-Received: by 2002:a17:90a:d604:b0:2ee:5111:a54b with SMTP id
 98e67ed59e1d1-2f9e084041fmr6790567a91.31.1738796728715; Wed, 05 Feb 2025
 15:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe> <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com> <0837be81-ec2e-4dac-bc42-91c626c22b9a@linux.ibm.com>
In-Reply-To: <0837be81-ec2e-4dac-bc42-91c626c22b9a@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 15:05:14 -0800
X-Gm-Features: AWEUYZmigCm675PTePq6ZBxFpy1cZX0yWJbw2d0okMyiHRAN7vj8ot3_pc-ooKE
Message-ID: <CAEf4Bza2npJdh-aBcH98aNjiuwuw_kRB1fnMfTGCr+Y_Yv8gWA@mail.gmail.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Jens Remus <jremus@linux.ibm.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer <fweimer@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 3:02=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> wr=
ote:
>
> On 28.01.2025 02:10, Andrii Nakryiko wrote:
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
>
> Just for clarification of the SFrame V2 format, as there may be some
> misconception. Using pseudo-C type definition:
>
> struct sframe_fre8 {
>         u8 sfre_start_address;
>         u8 sfre_info;
>         s8|s16|s32 offsets[M];
> };
> struct sframe_fre16 {
>         u16 sfre_start_address;
>         u8 sfre_info;
>         s8|s16|s32 offsets[M];
> };
> struct sframe_fre32 {
>         u32 sfre_start_address;
>         u8 sfre_info;
>         s8|s16|s32 offsets[M];
> };
>

yeah, sorry, copy/paste error for those sfre_info, it's always u8

> struct sframe_section {
>         /* Headers. */
>         struct sframe_preamble preamble;
>         struct sframe_header header;
>         struct sframe_auxiliary_header auxhdr;
>
>         /* FDEs. */
>         struct sframe_fde fdes[N_FDE];
>
>         /* FRE8s / FRE16s / FRE32s per FDE. */
>         struct sframe_fre{8|16|32} fres_fde1[N_FRE_FDE1] __packed;
>         ...
>         struct sframe_fre{8|16|32} fres_fdeN[N_FRE_FDEN] __packed;
> };
>
> Where:
> - fdes[] can be binary searched: All fdes[i] are of equal size and
>    sorted on start address.
> - Each fdes[i] points at its fres_fdei[].
> - fres_fdei[] cannot be binary searched: For each fdes[i] they are
>    one of those FRE8/FRE16/FRE32, so start addresses have the same
>    size, but each FRE has potentially different offsets sizing, so
>    there is no common alignment, and so everything has to be packed
>    and unaligned.
>

yep

> Regards,
> Jens
> --
> Jens Remus
> Linux on Z Development (D3303)
> +49-7031-16-1128 Office
> jremus@de.ibm.com
>
> IBM
>
> IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsra=
ts: Wolfgang Wendt; Gesch=C3=A4ftsf=C3=BChrung: David Faller; Sitz der Gese=
llschaft: B=C3=B6blingen; Registergericht: Amtsgericht Stuttgart, HRB 24329=
4
> IBM Data Privacy Statement: https://www.ibm.com/privacy/
>
