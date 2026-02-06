Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0202D7D59
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354057; cv=pass; b=kAvF/3FACnUgk7XQJuDEkLCTbNzKlxVq1KPxTTeABg5gbLqZGenr+bWzRp60wxqWRRYfay5UOjF/lh3m3Em7TG1QeNnIUtTubGwaFHcL93r+YHFhJX/QtYQGESLBQd7GVT0q8ooUUXlSeFoP8LIuxDqSM1f81EkBnNKcgNfF950=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354057; c=relaxed/simple;
	bh=8qnqepGyoMFsYnQ8mw1Wk6JuUtP2ANo3I+pbtv9t9OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oer5BWXGW3qEtqYC+Iarj5c7cmNH47dNgsAFvEQn+AN+3fwyOJGFzroJW34PmHB4aewOH4lqUWK25RRTP3vuZE/DYNb3c0PYzKVgl/iMdNFx7xIjNTlqZRvZQWZk2KJHJ1Zpci8hQbz2UEiOjtvPdA2BKduAzP+kj8Q1iqpE6C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkwGkTtu; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkwGkTtu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a76b39587aso32715ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 21:00:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770354057; cv=none;
        d=google.com; s=arc-20240605;
        b=Vc1KmumIc3jMR6o/H0qXxPk6yxPEQaoh4ZeS0ICyfGo8zZdPKXD1S7hSCkfLjvETRd
         SQAedLfpw2+jxgssYqF/Cv/7YGIC+Eo0Uywf9slGzyugGvem8OcKplafa+a29oOxe7xv
         WBub0/0D4BpfYuaHXhWD+Ohq5gngMRNkd1V/ICXRwowXw4MJkbK9Ptz//s6VSktTlUPa
         gVHtqjsmzoB79pUJ0ASCOqNfQIzKv5iPALf2P4agn3f6jqJNrrRD6TjSW4TDlo3SXFKU
         u1MXfR4P5PTAq32mx0gaex/SHbtiaH6+iHoKNPCD8JjiZ9rYxSXjZhkxXd3+OXNeUzRE
         QE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLLeTvQ9a0+cEvpGQZPATnbYzCCv2L22rr9TC7pVu+c=;
        fh=w6BEaEDBgHcV1FtKGsGAMUev9kS0T2s0mxM4jZk/EpI=;
        b=LlsjhgW5++YIiKiZlBHqIE6ZP7PNfTy9j3bFXI/tgzbUjL9pHQ/EIzUDTW9byNx7TO
         2z0Axk3uTqRFA6zfvXmRSYlrVqAxUfQJVtDCSJKQfdW2hGoMKoH63uAwg9nv0Z5ZASFw
         9Puc3O9JRMuF9+Mil7jPSNP76sWFXVPN9Zdw9Apz7P9ZyN0w0WF9157bgvxMh3Kr2sM2
         07SSRETuWC3JwBxhAoB5pmGisKPyjoMkl9+HrTLC2Zv5fawuQThhnEaD4L4XoT5RqpPA
         mc5QcARTlNkziMs7FW5/KHQo6mJB1TMRa1OmHmc8D9wVXDD5MbsJHa/oY2LEfL0RrHPW
         pMyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770354057; x=1770958857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLLeTvQ9a0+cEvpGQZPATnbYzCCv2L22rr9TC7pVu+c=;
        b=EkwGkTtuyeKC6oTBRZJpG5Q2nDVm5Br+HscM8PekkXDAI+un8e3DzDYZplbUMoUT6i
         AH76EoAeT+q1NSqumAgeAaOdcszbv79Z70s18SmMz14SDeX8Ai/1CPC6zkIxfTTLD53y
         MU3n2iWU5ayRyz2t2DNYkuMN1xu+5MFG6nqljUCG32kmmTyNMmvPdcJEy/7pb3htQOJc
         J42ITs66873cKiw8M1gxfksVxzsSRgiadSAZUZz1/SSdi03x+Fqi622LWyMxmG2h6rRU
         u5xghdhSuNY9W+lLmKF3j8ilJm3n03+Ikq4j51wHJ76ufUaiVdFlks2kFS8KRDhY+9xD
         aQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770354057; x=1770958857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLLeTvQ9a0+cEvpGQZPATnbYzCCv2L22rr9TC7pVu+c=;
        b=jAEstBGYb9r7hy8MadjQoOh4jUP3PobUdj87AbIF8cHsin0gtSy6Qel9taTugSZjI4
         TazWzYCBrIXKRK2FG5mUeYbwD9PbKXjCmu+3PRTrazhBT/7B0XXx4ADw+jI67AXzDcqt
         EQk0s3tw4GFkY+BtGESihRPBQWd1m1e+X2YNXlYQ/IYX04upd8FXeTHTsCis8PlBcg8v
         eEQyCbm6J9D4+KzE1BCyEkFYq6v5xTsMgAcbGUQ1SHCIyB6c8zIxN0fO6iHyZfJoWvYX
         3BhSa6HRhxTYrSE6CnXIZKyOwJtVP6ooUOpWddUgmCJ0FXfOvqF6/3ZybdI9UTc8x1lM
         jYOA==
X-Forwarded-Encrypted: i=1; AJvYcCVXVWSRGgUGbula/Eas+CsG5ONmNYsCvJ/WxKyWdJyQhHaOK1IHza3xCSbQuc7MkJkYS2p36n3a3tbyeMPLyt8d@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+XZBltQR1GptpdByhNXlJ5bZcqRKlkqHklPCmijvS3WbYA0d
	JsmGlWlVOs8yOqdbmoOz1Fw6/U+35lkK7No3lhfLCR/WFNJRZLbLXS2SyU7U0AtIt/Cwwn9ZoQ1
	hHy0+jjYzmA1woHdw6tvuqqXhlyu7BW3kXT/X11ii
X-Gm-Gg: AZuq6aL596GYylCAhV7EBjL4AK2ezvVLq7DIfPoqNQ1Ji1WZQTv+EHSebQ7Rz1o1MIm
	11mqkr2Z4v+rHe/ewRTczeiOQtVgAsuFLfDB+Wt93TzzCA+HN6lIDF3+NHMXZKtt0PSkguZy1mq
	HRDGmUd9F2YzGuuSnesIl6E66Mon0j3DD2zlxNwMCLMX3L5XgYSV7luw9rAbezG42ruLfD5hcWJ
	E4zEWzKaSk5Wb9U+xTV0nakEDEicYkEULbf3xep4YsyD7auTQ8tNwQwjBAT4P+bmPYlr2aW
X-Received: by 2002:a17:902:ceca:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2a95232ae6fmr1885525ad.12.1770354056609; Thu, 05 Feb 2026
 21:00:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206012743.2617945-1-namhyung@kernel.org>
In-Reply-To: <20260206012743.2617945-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Feb 2026 21:00:43 -0800
X-Gm-Features: AZwV_QgxQWm7zp32HEOVOrRN6gviWXpN8VSMx2Upu3rIXV51wtlMou8scN4LxgE
Message-ID: <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix register usage in data type profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Zecheng Li <zli94@ncsu.edu>, Dmitry Dolgov <9erthalion6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 5:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On data type profiling, it tried to match register name with a partial
> string.  For example, it allowed to match with "%rbp)" or "%rdi,8)".
> But with recent change in the area, it doesn't match anymore and break
> the data type profiling.

Hmm.. the blamed patch was a strcmp before and after, so maybe
something nearby changed causing this:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Dc31040085914f1188720073baa43d1483693c0a3
```
- for (i =3D 0; i < ARRAY_SIZE(x86_regidx_table); i++)
- if (!strcmp(x86_regidx_table[i].name, name + 1))
- return x86_regidx_table[i].idx;
+ name++;
+ for (size_t i =3D 0; i < num_entries; i++) {
+ if (!strcmp(entries[i].name, name))
+ return entries[i].dwarf_regnum;
```

> Let's pass the correct register name by removing the unwanted part.  Add
> arch__dwarf_regnum() to handle it in a single place.
>
> Reported-by: Dmitry Dolgov <9erthalion6@gmail.com>
> Closes: 7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 61 +++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 880b1bd300c21e67..2e3522905046c1ec 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2447,6 +2447,29 @@ int annotate_check_args(void)
>         return 0;
>  }
>
> +static int arch__dwarf_regnum(const struct arch *arch, const char *str)
> +{
> +       const char *p;
> +       char *regname, *q;
> +       int reg;
> +
> +       p =3D strchr(str, arch->objdump.register_char);
> +       if (p =3D=3D NULL)
> +               return -1;
> +
> +       regname =3D strdup(p);

nit: Given register names are known to be so short it feels a shame to
do a full strdup for this.

> +       if (regname =3D=3D NULL)
> +               return -1;
> +
> +       q =3D strpbrk(regname, ",) ");
> +       if (q)
> +               *q =3D '\0';
> +
> +       reg =3D get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_=
flags);

nit: Perhaps pass a regname_len to avoid the strdup.

Reviewed-by: Ian Rogers <irogers@google.com>

It'd be nice to have a test on this to avoid a regression. Dmitrii's patch:
https://lore.kernel.org/linux-perf-users/20260127083030.5909-1-9erthalion6@=
gmail.com/
does that for a Rust struct Buf, but it'd be nice to do something similar f=
or C.

Thanks,
Ian

> +       free(regname);
> +       return reg;
> +}
> +
>  /*
>   * Get register number and access offset from the given instruction.
>   * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
> @@ -2457,7 +2480,6 @@ static int extract_reg_offset(const struct arch *ar=
ch, const char *str,
>                               struct annotated_op_loc *op_loc)
>  {
>         char *p;
> -       char *regname;
>
>         if (arch->objdump.register_char =3D=3D 0)
>                 return -1;
> @@ -2482,31 +2504,14 @@ static int extract_reg_offset(const struct arch *=
arch, const char *str,
>         }
>
>         op_loc->offset =3D strtol(str, &p, 0);
> -
> -       p =3D strchr(p, arch->objdump.register_char);
> -       if (p =3D=3D NULL)
> +       op_loc->reg1 =3D arch__dwarf_regnum(arch, p);
> +       if (op_loc->reg1 =3D=3D -1)
>                 return -1;
>
> -       regname =3D strdup(p);
> -       if (regname =3D=3D NULL)
> -               return -1;
> -
> -       op_loc->reg1 =3D get_dwarf_regnum(regname, arch->id.e_machine, ar=
ch->id.e_flags);
> -       free(regname);
> -
>         /* Get the second register */
> -       if (op_loc->multi_regs) {
> -               p =3D strchr(p + 1, arch->objdump.register_char);
> -               if (p =3D=3D NULL)
> -                       return -1;
> -
> -               regname =3D strdup(p);
> -               if (regname =3D=3D NULL)
> -                       return -1;
> +       if (op_loc->multi_regs)
> +               op_loc->reg2 =3D arch__dwarf_regnum(arch, p + 1);
>
> -               op_loc->reg2 =3D get_dwarf_regnum(regname, arch->id.e_mac=
hine, arch->id.e_flags);
> -               free(regname);
> -       }
>         return 0;
>  }
>
> @@ -2585,7 +2590,8 @@ int annotate_get_insn_location(const struct arch *a=
rch, struct disasm_line *dl,
>                         op_loc->multi_regs =3D multi_regs;
>                         extract_reg_offset(arch, insn_str, op_loc);
>                 } else {
> -                       char *s, *p =3D NULL;
> +                       const char *s =3D insn_str;
> +                       char *p =3D NULL;
>
>                         if (arch__is_x86(arch)) {
>                                 /* FIXME: Handle other segment registers =
*/
> @@ -2599,21 +2605,14 @@ int annotate_get_insn_location(const struct arch =
*arch, struct disasm_line *dl,
>                                 }
>                         }
>
> -                       s =3D strdup(insn_str);
> -                       if (s =3D=3D NULL)
> -                               return -1;
> -
>                         if (*s =3D=3D arch->objdump.register_char) {
> -                               op_loc->reg1 =3D get_dwarf_regnum(s,
> -                                                               arch->id.=
e_machine,
> -                                                               arch->id.=
e_flags);
> +                               op_loc->reg1 =3D arch__dwarf_regnum(arch,=
 s);
>                         }
>                         else if (*s =3D=3D arch->objdump.imm_char) {
>                                 op_loc->offset =3D strtol(s + 1, &p, 0);
>                                 if (p && p !=3D s + 1)
>                                         op_loc->imm =3D true;
>                         }
> -                       free(s);
>                 }
>         }
>
> --
> 2.53.0.rc2.204.g2597b5adb4-goog
>
