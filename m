Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211A4D2EFB
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367722; cv=pass; b=YgGJDv9lpUEs0iqfKnVgXYlbcZ9bKC3VmdlS3sJKgnX05sdnVebKk7SzbaoJHjTNoSjfmhd8CZU0EA1rznL7JcoHVjwYE5JuzY98FP/xSU2AtZPTHlwGp/Y6b4TKxNrm4b36GWDOcaUgeI7jMWTLlkqXyXDVOujYZcBi/LoUqsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367722; c=relaxed/simple;
	bh=sOt1Bryk+Oxa7Fxrt6mMhlSIFpbqXbl83ndSRGg9HlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtCLl2QPyNuQ0o9uwDZmWig5iNrjxIFx6BvizTv2XM8ihVVKddiz2x+/OG2IvdsF7/sS5bj6aWLp2dZ9CQvYSeo3bkZOIcZAx+q0zJ/Icjkcmc/jviW4rJElK1QVQJRMxvhua9Wol+DA4RMyrIz5lXvEBx5QjPFYwQsRVJXOJS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mK/sgXo6; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mK/sgXo6"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52faa58bff5so73881cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 13:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790367720; cv=none;
        d=google.com; s=arc-20260327;
        b=ouSaaRG4RG4JF0TpIlN2OufJdTP0TPSwgaNMH2730MLtHEyvXOUahqkV8/cgtrPyop
         L/Hr6jlaflTYeXVOyKYIvPxancGIbs2G9p0b4q/zwR0RRHA7STEIoa09VhJF2Nl808Gq
         529VbBOxA8/COGFs49RWjC1aNQxVgj0Sipcxx0R6Bf5fnmbiqZrgXu1zq47iQItQ8cT1
         05Yv3R7vprfbGUaq4xcOfzfQ9CyUz7byOZI0u2mP5T/Trg44yHKYYyENheSoRbrmZDbx
         gf/q5bK0dyj6m9tR0plQ9TtDWa5t/U85CSE8W9k4tI3HevH8p2wICgYWZeKWOkHLaALw
         HDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X0gi+G5GK2ryrXr3Dgeum1cineZZb5AvOJsf1d2sjyI=;
        fh=1fGc1oyiZSddfpVhsQIxCUUwy2cQwgTdJ5wDPrYDlBw=;
        b=oWmoUQZWXAPATa/NCQCva3G4QwdU58qWzyGynQrphEgQLoK2QfydsN0fOQJW18wQsp
         fZwt/F+I+FELyJvfRO3c4xLXelh6EY2rA+zNVr1Uml2en0Z7JNVY5+EwRtZdSfX1Yh9x
         SgvYSGMHIMnLDY7WK8uPiL6U1jsK2bR/FSAl7jfjipU1K5kDLEzNYkFGR/FaRAQzz93I
         4IrFDlJOZfykg0krxUU+q96nALaQce1R6epSJSzvz9Dy8I/5XdJSKUDOKoNCD+cGDxju
         qayPGoABYyVO2li7sr+Ar4h4Yt+X4sJseTgvrT2NlRyjTeebnwAzOCrHM5E3MsEThmBd
         Lupw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790367720; x=1790972520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X0gi+G5GK2ryrXr3Dgeum1cineZZb5AvOJsf1d2sjyI=;
        b=mK/sgXo6SlZjzoJ1dHR5FgiJcFt47jOQUTR2uslH/t1W7/NLTR0JA2X/YCTgnLDFdO
         HDfDxPOpe2YMJuiSGzX6MEMaSr+pM8pLFEBkWveB/okQDYyTR1bvy64mJioE/lwJh3f7
         3lxJW6UhwvkyHeMPBZIO5cQltQY9UCaJ2/hM9mVqMN8YBr0a3luVTrMJGfU2SoSwbmxd
         In+mKy5hNpNFfCgXgkHIATtOTwt2n0AKsv4kEumRVZYNTxjNT+jvsZ2fZMEDb2CHt+bv
         nJSgsuctH61y18UHXutk+bcvsqYply1nsNn5QgAbScD8l1hSVRVXzd8YS34kZ2XP3rmb
         95yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367720; x=1790972520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0gi+G5GK2ryrXr3Dgeum1cineZZb5AvOJsf1d2sjyI=;
        b=hOGKZHXfBCZXo8nIKiVzAz6Ww5UTLhCZHA/rC0385A/i7rLOS84Ng7dIoRubO5L3Sr
         8uTv0QJfjyH0I1p2ignNxggFZ0rMgwPdCLyaD7Y6O4j10uDClvtv8ILxXyfRc/Th5Uil
         UaQxCK8bXlKiutIqNO+Gri/4vnbvVm3SOectMbe7f8rVYMeZ+TOJrwo2geMLHJ6WYEtf
         T25EnGw/8CsYeJ2mXAMNwJohzGrGl99R1f/Sy46OUZWXm5DlmTrZfbAKdSwVyx6vl/NF
         SW6M02UOC/i4G6wcoNsJWNmBN0DN+fQkYYlV5+gPiSZwUWlFIgtAyBiQeArHpJ8qnPJD
         aa2w==
X-Forwarded-Encrypted: i=1; AKwUvByvwz27hIdAv1P+oidXT1otXGIsUHH+oaPCfFgaXuG8lraHXhd/WWclbX1lyqQDGjoN7iddBK9a1kpUjCA4+hlZ@vger.kernel.org
X-Gm-Message-State: AFuF++lWHIAi7wRCeHdim5MJg9j4tkaq2MEJH+oSKEmwE8He1JR14idW
	jfa57J+n7rFEZwvgSDTJcKJlD92CQ3qjLLf27bonptUJL+m+7Vq3GnFs3o353QduFDEEDPFWoaL
	fQ8ilA1itfeMn3QZTLzlwoIUAOYuS+PJmRHTuGvrX
X-Gm-Gg: AYBFou3XCqtgva69oq1684HZXpkskBOXbM9ho9GSwHUCv4eE2p6/7QroLMyNaSWAuIt
	4d9WPaGPk5CYu6e6eopc7frq6MPYHm2mSlK2hpKzri0ofYhouDxdxQDt88kDb/tBalRIuTkG9q1
	sSh4RQXW8UsdlVXguKtxov6deemPcs1Gx12w80j8qqQjz1LkMWGxia307FkSd2nvUFj2Bo+D0hD
	Ui7rpNsAb8YWvQT5vsCw+Nh8umE7P3AeDctsDV57toXaopuC5Bf+IfjPSYBRxJcGaDPjSSpVMII
	eboQvA2nyUFe5cRfqjL4v6lc3WYuaHvytrJccMGDN8Ao6CwkxgIfEt+LogCQPNr7yRn3YasosuD
	t5FhiJGAiZu/2KlSXVfGe
X-Received: by 2002:a05:622a:1a8f:b0:532:c8ca:5ae9 with SMTP id
 d75a77b69052e-533226f9f89mr660001cf.11.1790367719382; Fri, 25 Sep 2026
 13:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-3-3e4e234c363b@uber.com>
 <CAP-5=fUumhE1-DT3a-EBYQADy6Az=nViGmz==n1ocqXiXAEQjg@mail.gmail.com> <CA+w=M=RJYSCuk1SoU+OR53Odf6OyKMsjDMUAtaxSmD_4Zyq7oQ@mail.gmail.com>
In-Reply-To: <CA+w=M=RJYSCuk1SoU+OR53Odf6OyKMsjDMUAtaxSmD_4Zyq7oQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 13:21:47 -0700
X-Gm-Features: AclHuK_Ev_ywUg_xKDVZaUqkULrA-zicLebaCnXdtLmoik360d-0oCFEYOm-qog
Message-ID: <CAP-5=fUm_MYpz+K9qc9T-=Xy2FT2=FRgWpkmQaZvqrO1tuVYsw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] perf symbols: Factor out duplicate symbol selection
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:55=E2=80=AFPM Alireza Haghdoost <haghdoost@uber.=
com> wrote:
>
> > > -int arch__choose_best_symbol(struct symbol *syma, struct symbol *sym=
b);
> > > +int arch__choose_best_symbol(const struct symbol_candidate *a,
> > > +                            const struct symbol_candidate *b);
> >
> > Given you can change this function definition and only change 1 C
> > file, is there any reason not to make the function static in symbol.c
> > and move the struct symbol_candidate definition also to symbol.c?
> >
>
> Thanks for the review. Patch 5 calls symbol__choose_best() from
> symbol-elf.c: the lazy index resolves same-address duplicates from its
> index entries, not from struct symbols, and uses the same policy as
> the eager loader. That's why patch 3 makes it non-static.
>
> struct symbol_candidate has to stay in symbol.h as well, because
> arch__choose_best_symbol() takes it and powerpc overrides that weak
> function in arch/powerpc/util/sym-handling.c.
>
> I can say this in the patch 3 commit message in v4.

Thanks, I saw this when I got to the later patches, sorry for the noise.

Ian

> Thanks,
> Alireza
