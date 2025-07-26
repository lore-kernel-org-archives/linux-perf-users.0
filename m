Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A6129E6E
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490689; cv=none; b=SyhipBBmf1JelC//U15Iapa/kivPIT9JkHhFgIV+I2DNEX1EQduWvh/iXRP1ow8vgS0bzgp9CFtOLPVK4v0uSvMwpDd5kZzKL7uiXVVwOMBwZeUusUp80tonE2AhLk7HWPzfWRxk4m6yuDFdpYPWqsSSbCFaMZDiL1l0azpGrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490689; c=relaxed/simple;
	bh=9JFB9IXapt2d7PBmF4Tk/F4nAX0jKPDuyt5xJWIWPgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbg5UT9jczmKKXiGQulgTM7TcrlViqvdnuJAW2UGGxQ3I1wqHevX1xNYMHJnOg0fPW/5DtNFMoa+3YqVQ73klOdnF8nv/dVrKcPyUAchlEey2/OGZ9jtIItRGT8Yy0AQJecQJyu4fro9QModPPbRGJl++Rs4xJWS9eUE9TYt7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2toMk+kC; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2toMk+kC"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so42705ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490686; x=1754095486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPWnUybGUUkWCXTqRdDIxAceE2NePosWnljOPJMqdUk=;
        b=2toMk+kC7E6iIBtteBsOBsh13T4m2RP9gW/+T+BrHIfy8EqP0Eh5pP2d3XJ3vxV2NQ
         yy7+CoucCuV+ifM6ZofwrgCh8hn1O2fSV5RpoT5ai94kvvOSnI9x9sRTgwkM5B7PjKSi
         uFLsk67TkT+wopADtxJ6otVB5wula+cDB864cwLQCbYAru+ZXvTIpfeMxZhEsOjnJdxF
         bdV4mWHG37I/r2MDfqxn7hnLaBUiPlrPgf23cyZfOXi5OTkQC6q4LchhS3yBOOx0arlv
         5BnmahyPHy8OAUIM3+j6xw5lbxKixIzKhg6eQh8CghEfeVix2jY/I5pCccMJuutbO1oC
         erRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490686; x=1754095486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPWnUybGUUkWCXTqRdDIxAceE2NePosWnljOPJMqdUk=;
        b=ezE31qzkK95rBeSkOTfvH34cXRC9C2ka8p8pz3hDG6Dn3Cw7GIu8IyFKepRuTuhGIh
         nZnZmUi761KTA/feSxUcAAcDGdM7v2idKsiKLUd2t9rn1wzFitOmSTbwIhs1iZ7uo+NQ
         C6LmV8sVtr7cmc0H6ZpoSUbMAFwzIOkLVZjJ2y9PYISOraPH5rK/raByjeDZ7gMxDtLG
         ITnw0J15f309aQFPZ1DGCFdxBloT3DDEdD3poIMNXITX9mb2iCpd3YpUjw5cj2+6SjUM
         1L1VhGFYUDaUakipkljpOca1MzXTF9KIkas8J9/G/ngNkSYVe+ZjzNTMryp/PlglbSjv
         MBIw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0sE1P5SLi5IeGjTANfrtrQOjVmHzJAw+d1vp9EH1llWPgo1jLbQc38rLAzIs6UCp/Yhj9D2maGwWYROYeTeT@vger.kernel.org
X-Gm-Message-State: AOJu0YzTK+o9AggpJM5MTLaiPBa9QV/SY+TjqOOfptC9kH1D2tDd/098
	BLNez6RPsYJC99i7atiRHRtT22hW18vpk8XtRK00i6+tiNz9QZp+STNCjLgAxPYGWide6Lpv+pC
	v+VTETVVdUwLbKtmAhFsQSh2qm/CbApeW8wNUlMAbs/894HEu5sCVNIG0
X-Gm-Gg: ASbGncu2avkRcn1BQwGh2d5SvkAQuQL3fX3rPeii8zVW8xW6aykSW6gpazAfprULTCe
	uBCTeTlUxeRHpJeX2WEbnMJL2Zmrjbv2gRMoS+viMrs014+7wCstV6AsLL1A159HzYevs4FUqQW
	U23YEM6xJG11f5fgI2nNzQUv9KGGi9OBUGTjppRBjGR3TXElUIwcuocsy6ETNu0N9Wg5knYa8+i
	c5mg+7W
X-Google-Smtp-Source: AGHT+IEHep2QYo3/LUJWt7WhvNXreRM+1G567+rK9hz7zyyMGGvYlVYw4NBVEb6WWUvJpA/Lns63orazNlcJeanqKbU=
X-Received: by 2002:a05:6e02:1d96:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3e3cce7e6famr904165ab.17.1753490685878; Fri, 25 Jul 2025
 17:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-9-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-9-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:44:33 -0700
X-Gm-Features: Ac12FXwKFtkaUOt5oHGOS4d5yrst1_xqdIh5_OnIcCc3aJSP8ffW-lYND28Bamc
Message-ID: <CAP-5=fWJxCq97Oss3NXbXEKHeNXbif9-yWvktNRQvwtm3H3jbA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] perf annotate: Hide data-type for stack operation
 and canary
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> It's mostly unnecessary to print when it has no actual type information
> like in the stack operations and canary.  Let's have them if -v option
> is given.
>
> Before:
>   $ perf annotate --code-with-type
>   ...
>          : 0    0xd640 <_dl_relocate_object>:
>     0.00 :      0:       endbr64
>     0.00 :      4:       pushq   %rbp           # data-type: (stack opera=
tion)
>     0.00 :      5:       movq    %rsp, %rbp
>     0.00 :      8:       pushq   %r15           # data-type: (stack opera=
tion)
>     0.00 :      a:       pushq   %r14           # data-type: (stack opera=
tion)
>     0.00 :      c:       pushq   %r13           # data-type: (stack opera=
tion)
>     0.00 :      e:       pushq   %r12           # data-type: (stack opera=
tion)
>     0.00 :     10:       pushq   %rbx           # data-type: (stack opera=
tion)

I believe the intent in the dwarf is to say where the caller's callee
saves are, but the stack slots should just be saved and restored and
won't be used for anything interesting, perhaps for exception
handling. An annotation like:
# caller's RBX at stack frame offset -48
could perhaps be useful.

>     0.00 :     11:       subq    $0xf8, %rsp
>     ...
>     0.00 :     d4:       testl   %eax, %eax
>     0.00 :     d6:       jne     0xf424
>     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-ty=
pe: struct link_map +0xf0
>     0.00 :     e3:       testq   %rbx, %rbx
>     0.00 :     e6:       jne     0xf2dd
>     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: stru=
ct link_map +0xf8
>     ...
>
> After:
>          : 0    0xd640 <_dl_relocate_object>:
>     0.00 :      0:       endbr64
>     0.00 :      4:       pushq   %rbp
>     0.00 :      5:       movq    %rsp, %rbp
>     0.00 :      8:       pushq   %r15
>     0.00 :      a:       pushq   %r14
>     0.00 :      c:       pushq   %r13
>     0.00 :      e:       pushq   %r12
>     0.00 :     10:       pushq   %rbx
>     0.00 :     11:       subq    $0xf8, %rsp
>     ...
>     0.00 :     d4:       testl   %eax, %eax
>     0.00 :     d6:       jne     0xf424
>     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-ty=
pe: struct link_map +0xf0
>     0.00 :     e3:       testq   %rbx, %rbx
>     0.00 :     e6:       jne     0xf2dd
>     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: stru=
ct link_map +0xf8
>     ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 06ddc7a9f58722a4..6fc07971631ac8a3 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -765,6 +765,17 @@ __hist_entry__get_data_type(struct hist_entry *he, s=
truct arch *arch,
>                             struct debuginfo *dbg, struct disasm_line *dl=
,
>                             int *type_offset);
>
> +static bool needs_type_info(struct annotated_data_type *data_type)
> +{
> +       if (data_type =3D=3D NULL || data_type =3D=3D NO_TYPE)
> +               return false;
> +
> +       if (verbose)
> +               return true;

lgtm given the many overloaded meanings of verbose.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +
> +       return (data_type !=3D &stackop_type) && (data_type !=3D &canary_=
type);
> +}
> +
>  static int
>  annotation_line__print(struct annotation_line *al, struct annotation_pri=
nt_data *apd,
>                        struct annotation_options *opts, int printed,
> @@ -844,7 +855,7 @@ annotation_line__print(struct annotation_line *al, st=
ruct annotation_print_data
>
>                         data_type =3D __hist_entry__get_data_type(apd->he=
, apd->arch,
>                                                                 apd->dbg,=
 dl, &offset);
> -                       if (data_type && data_type !=3D NO_TYPE) {
> +                       if (needs_type_info(data_type)) {
>                                 char buf[4096];
>
>                                 printf("\t\t# data-type: %s",
> @@ -2138,7 +2149,7 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                                                                 apd->dbg,
>                                                                 disasm_li=
ne(al),
>                                                                 &offset);
> -                       if (data_type && data_type !=3D NO_TYPE) {
> +                       if (needs_type_info(data_type)) {
>                                 char member[256];
>
>                                 printed =3D scnprintf(bf, sizeof(bf),
> --
> 2.50.1
>
