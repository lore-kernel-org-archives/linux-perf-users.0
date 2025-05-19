Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7282698BC;
	Mon, 19 May 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642453; cv=none; b=fzZalqFtRLAKnQrs990JlTmh8/eaYVRVT59fE5dA73RdsDzF0g1w+ZOhx9QLZWDjFFMUN/H0dZUaU94hrr/pxUYMw5uhnXE4HNcrhzTICLuNkCH8iahGYvrqVq0o1uWueFFwIuoiI5yiJ7PXOPGEqlR3e6bRBiwERi9pCvznXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642453; c=relaxed/simple;
	bh=yRuPylOt3kGe2ry08bqHotgyK2mzZBuTIpbiqLD5sIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AimMHxLxgkb+YK1qVT7jwTLmSQ0KCI17flE5q2XFElhr/qgET/DnkKtDfpPDJRamxNgdEnl94tthJcAmTYslO5k6K1lSm0jyeFpV2R7JtgJydA3iHKt9Li/B9OaxzBMoD8DF5qi3Ub2kWOnyVwjgdWVRdrSnWfLN4YQcuF+xEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWZkoNPs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWZkoNPs"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-317f68d0dffso52668151fa.2;
        Mon, 19 May 2025 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747642450; x=1748247250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwwc7zz8RwpZE+tQomEO7USEBEct1RL32QmkFi3jFrk=;
        b=hWZkoNPsfaayhSPnnK88KhaJkvtlbZPjOzGch+JTGrGFClEbF5YMKfcYek8es6YO3+
         YtwnkovLUDJFppLXuMK74ODsBE19EAza+04yi2usEEaNyprAYmfexqgAW65vkEpWhsY+
         eEMnAi+FbiRCTAddDYMZtYWuan6pmZPaVLwNVYXMtPTHt0sSX4igj5qi+bl60Bkdpeav
         9RmUGDXEZYD1IcBo7iiolwdvqeSrzIodTPaO+CufAhxM4V9wEVDguUJTSSByLeN+qhZa
         qxULjpXg/rsCupVB7/26HvXfg7gIyA4ZClnr7+hFAJtRo9RnjHzP0pw4Z5LmFbOVpOv1
         DhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642450; x=1748247250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwwc7zz8RwpZE+tQomEO7USEBEct1RL32QmkFi3jFrk=;
        b=TyUSury9KNtP1KLCJMhSZyUZtXnCn0GruS9CNI9k6nVf9OcD9wb8dpqSIyYOdSgNou
         B+AUQlQRpnT8VuMCtlDWNjATQkq1hY4ENJEAjEwpqVsx4Df2jAKVW6zaa8nSvpPMNhae
         /skhGKsN3gVDp+7JOLL5+JNzHWFiPwPoJ9f8EDDmb9f4y2yrGbQiTMy/oyrYNeXWF6eQ
         OMqIU4oI+Rz8TfjDDjf6Fkit9PXxsZ2JHCu2vSQgbpD6ga4W4ZkfxvVKMZfTnPnV44kL
         5Xx9rjs2x4+/Ck0j5fGFV1oKZNuTpotXdu/CgMzN2OOscBa/uqbMDo3DPJDhmHiRE7r6
         koNg==
X-Forwarded-Encrypted: i=1; AJvYcCVCrTWyFVazVZHGDYqi59uhiLp2BWVlJb4Di+6iZOQeOXYth5p4HggMkOzxJmJP3m9rop4Voa8AWpZ9YWUOEzVbHA==@vger.kernel.org, AJvYcCW+BG+aSA53mxaJRXQSfB8uby2HviZvnZl+EkKhSaT60QhegVVMNZvYtFOvdwDszYlUFoKsC7kDi7dQRqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JmNuAYL4PtDauX4Mrkf3gLxLw4xxb+GmvF6VnMy34gf3i9au
	bt7hdg4kMqLsd6rV8UZAkiXg4dS8WBjP19ZP8EZTv8J6TGaBGxk+qnxPdzR97r1UPofkKaELv4v
	l4zTAbPJJGYpRLaqYAS3U6oMR6R1q6Mk=
X-Gm-Gg: ASbGnctJeHN3UTzeKRmjDhIhoYv/jDVgUMdd1lFQfHzsDm+ZvGMHODBqMnlPUzDtiLT
	Yd2xa1Ps8N3o5+VKQW0+1l8elpBupeWTYU7vFUiKH9+Tdv/wjAJoxbytrPUF5wdNaV1Qvga7Fo2
	xAYIvk52EHP+zf7GKl4E7Tsn7zs6piGPVI4Q==
X-Google-Smtp-Source: AGHT+IEUVdwigpKS0BPeqjXhcYtkYwGsYnqU1X9BSXzUgZ8PdV7fqujNcImjFC9c9smpDP23OqyzE8sMIyHm/q4DQX8=
X-Received: by 2002:a05:651c:31c5:b0:30d:b366:d259 with SMTP id
 38308e7fff4ca-32807700167mr31903171fa.10.1747642449683; Mon, 19 May 2025
 01:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409025202.201046-1-haibo1.xu@intel.com> <Z_hoH0fu_NnEUUfe@google.com>
In-Reply-To: <Z_hoH0fu_NnEUUfe@google.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 19 May 2025 16:13:58 +0800
X-Gm-Features: AX0GCFtx-eO_q_oMQHBumsX1dzxmSFeZMNLugF74KQnQU0QPQgysXvntx4WvZr4
Message-ID: <CAJve8okP5wy-GNDCsDywgqPPmLSf0q1vGH573vXepxw7j-W8Qg@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Ignore mapping symbols on riscv
To: Namhyung Kim <namhyung@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kindly ping.

Regards,
Haibo

On Fri, Apr 11, 2025 at 8:53=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Apr 09, 2025 at 10:51:56AM +0800, Haibo Xu wrote:
> > RISCV ELF use mapping symbols with special names $x, $d to
> > identify regions of RISCV code or code with different ISAs[1].
> > These symbols don't identify functions, so will confuse the
> > perf output.
> >
> > The patch filters out these symbols at load time, similar to
> > "4886f2ca perf symbols: Ignore mapping symbols on aarch64".
> >
> > [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/
> >     master/riscv-elf.adoc#mapping-symbol
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
>
> > ---
> >  tools/perf/util/symbol-elf.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index fbf6d0f73af9..55b1409b0593 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1733,6 +1733,12 @@ dso__load_sym_internal(struct dso *dso, struct m=
ap *map, struct symsrc *syms_ss,
> >                               continue;
> >               }
> >
> > +             /* Reject RISCV ELF "mapping symbols" */
> > +             if (ehdr.e_machine =3D=3D EM_RISCV) {
> > +                     if (elf_name[0] =3D=3D '$' && strchr("dx", elf_na=
me[1]))
> > +                             continue;
> > +             }
> > +
> >               if (runtime_ss->opdsec && sym.st_shndx =3D=3D runtime_ss-=
>opdidx) {
> >                       u32 offset =3D sym.st_value - syms_ss->opdshdr.sh=
_addr;
> >                       u64 *opd =3D opddata->d_buf + offset;
> > --
> > 2.43.0
> >
