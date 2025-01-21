Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43E1F55F5;
	Tue, 21 Jan 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482651; cv=none; b=hHt0pjCCt05yonqlI2BLo1OJTr504t17/DQfCYos9wpQu+PsYlwgC/nk+rVcTRPV9HaMM7wethLW/Nuq0KsTaBF1U1IhBa0AL6ln6aoZ38NVka/CZ0SMr2JfWEHcjU9B4UGOpWPsvUaU1zSWvfJlNAkpqyPM1PtMIv83MPj4oP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482651; c=relaxed/simple;
	bh=RexphgXcca/HGAbF5WYL5QDvHdKxYQYIozdWYBmj5A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJopZ5I5NaEiNo1K9JmL+bYIrx1Jes3Fdez/+eUpGsiFcpTnkYiC9Ji01rNf/luaFYpb8B9ixTagGi75AczehUA/r4eh3bHoaLqtBmma8XbgOTl/DN9wNPvkarAPoJJ6E7gHKWNbOra0bsQvIp9Un5iGnwsag3Qb4vM11Jsv11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsWSOv14; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsWSOv14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE8FC4CEDF;
	Tue, 21 Jan 2025 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737482651;
	bh=RexphgXcca/HGAbF5WYL5QDvHdKxYQYIozdWYBmj5A4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jsWSOv1496bIgcgUpxvsW/FXnsgTo4nZ4LMCQvVtiNBOKtRBbvmPUC5q/jo02pkw7
	 grfIHNphyvqt+cFBaXaz+M1foVYsKmoCEv/cYSpVkWzHgQg8B2+xX3KgGxA8F1Ph01
	 YKHQAndk6+Lv1bGtwJnB4KLJPZGAkTMMejqrP5trayN6Is6dFvuGDtqYB+l3JfJdXS
	 RIzBupNNaaGd8s9oD+hZkcstLOaZRnaADVmaojYk/49ArSwLU+ONiGmZMU9Ics/6p9
	 le1Q2XRFqfNRtb3zjZJDA7+GrXadyBxrir027pm5N6wpGgIlrD+kkhzTArBjstxg32
	 p24IJ6Tx7srRw==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce76b8d5bcso52948165ab.0;
        Tue, 21 Jan 2025 10:04:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKlSnutER3nSKwoMqFKxTrLH3/zj6XGYCaavxYTRhuULK9KCDU0LXmc9PSMkJaQvhNy3nQrc/Ceo2bZquqlSOOjw==@vger.kernel.org, AJvYcCXQNbka3cnkd2iJOeeE0pJzli88Vo0yp6JSLxfc5gojDMX42WgLVm/iS+eDUE6XfacCNV1CVbLPa5Gl0fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUjGMKiKQYacrsDrCjrA6XxWxsAHzxuaOWMNZuLdsHZPW0fPv
	1XQWnEXHcY31zK4XTTkzotqzf4+8a0hNAKEJXB1/mQrLd6FjpkQu1oJVuvZyw+v5qLCxX8N2LCN
	hLzQBuyZ1sntE/rWNVWLmswQTXzI=
X-Google-Smtp-Source: AGHT+IHPewm/sy5sENGYg2Sic/HGyofJS3pKDEfijNPXAUH5JX7pndzHiNeTlI3O/V/rpgZM0jsUT6I+i817RGvNdYM=
X-Received: by 2002:a92:ca47:0:b0:3ce:867c:f51b with SMTP id
 e9e14a558f8ab-3cf7447e655mr139372915ab.14.1737482650454; Tue, 21 Jan 2025
 10:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111202851.1075338-1-irogers@google.com> <20250111202851.1075338-2-irogers@google.com>
 <Z4Us_aB9PNk63MbG@x1> <CAP-5=fWrFGM=TbQ5zBjdBAyDLJhJ48K_6TLHt22jLhnV11OG_g@mail.gmail.com>
In-Reply-To: <CAP-5=fWrFGM=TbQ5zBjdBAyDLJhJ48K_6TLHt22jLhnV11OG_g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 21 Jan 2025 10:03:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5UgMSrs=rJpZw6nPTqteEZRa=tt3XvWKq4oMk6rLGbrA@mail.gmail.com>
X-Gm-Features: AbW1kvZGba6Hj8Tk0hboEmoq_SzzMp9msrvn0y963nB2E0MZbsoAPYidjAHXlNw
Message-ID: <CAPhsuW5UgMSrs=rJpZw6nPTqteEZRa=tt3XvWKq4oMk6rLGbrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf build: Remove libbfd support
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Clark <james.clark@linaro.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian and Arnaldo,

On Tue, Jan 21, 2025 at 8:52=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jan 13, 2025 at 7:10=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Sat, Jan 11, 2025 at 12:28:49PM -0800, Ian Rogers wrote:
> > > libbfd is license incompatible with perf and building requires the
> > > BUILD_NONDISTRO=3D1 build flag. Remove the code to simplify the code
> > > base.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > > diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bp=
f.c
> > > index 1fee71c79b62..a891a0b909a7 100644
> > > --- a/tools/perf/util/disasm_bpf.c
> > > -
> > > -int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args=
 *args)
> > > -{
> > > -     struct annotation *notes =3D symbol__annotation(sym);
> >
> > Song,
> >
> >         Have you ever investigated how to reimplement BPF disassemble
> > using some other library than this one?

I am sorry that I somehow missed this thread last week.

I haven't looked into alternatives to libbfd.

Thanks,
Song

>
> I think doing it using libLLVM should be straightforward. I sent out
> this series to make libcapstone and libLLVM loadable using
> dlopen/dlsym:
> https://lore.kernel.org/lkml/20250120173208.344231-1-irogers@google.com/
> See symbol__disassemble_llvm in patch 5:
> https://lore.kernel.org/lkml/20250120173208.344231-6-irogers@google.com/
> the difference is selecting just the BPF disassembler, so don't pass a
> triplet, force it to BPF.
>
> Anyway, one option following that series is to factor libbfd
> dependencies into a bfd.c in tools/perf/util. That way we can try to
> have a common interface for capstone, LLVM, etc. The other is to
> delete it, which is my preference. I can add the BPF disassembler
> support to llvm.c in that series and rebase this series onto it.
