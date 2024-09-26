Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735D15AD96
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380533; cv=none; b=HDKIH0gvQFzYFAM+extqmYlMaotVyfolc+a+kWWBSg4YD8o7YdCOOnCEJqeuQQY8MAQ33PdVTeudnztbaMwaIo4wzlshq/WpLdEhuS5q7tMevJmMs7h8oAJclzQhdpO3KtFYV+uS6Y1uqHbomvuq7eMbzQoPDHS2wDESEOkaVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380533; c=relaxed/simple;
	bh=lBd5mJe6k/VAIV3m39ptxOGSOCwzSN+UkymqdQWr5e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISB93YuajqJ1inWQjzBEmZxP1wQe0PRR7hY+OoB1jYk+37+P8/qFjUCEJYHtsbGZAtnDeCwrWevD8hj8rhh67p+BIFB8it+ZpexMua/XAi/D0ieJ1WUEGylDqtFDm/50PILtqohHV7485ghxBwqrERBnoLZsOjLH65OYf1n80mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gn7valET; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gn7valET"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a2769d774cso47385ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727380530; x=1727985330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiDFvKDJ5+dCBHfNJ1K7SK22sj7fM9aEUAoUFxxe8R4=;
        b=gn7valET/Ji24T6t9dNqjaF3mqJ4ldwAk8PoPU4i1maD2iYJ3DCYFAmx7/ZpESaMPv
         YrS0TMSChF69dupOdzk78Fi/QSviodcEn4m5cNu/m2ajo3ztYnp/Fdh9NZ6Liy2M4sdJ
         nQ1yng/RkvVQDkV91XCNT7TVnQcesuIZATJICJnInkGUdWUjMHXhQZidLdlhaTkm5ytM
         snEfF1LXaIAP4ScDoykCckPlL7PAP5HFh6pEJfQKVcJda6ZVR0fnpOdwMJMlspwBDRot
         WYRp1Ju/qZOaQrjoFLZlIIM8oki+inPVop4jSeoyUt82YlI9SPOcYbZwJz28GXIiblmH
         LbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727380530; x=1727985330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiDFvKDJ5+dCBHfNJ1K7SK22sj7fM9aEUAoUFxxe8R4=;
        b=Cmb8X7ZPICdmtii+8Ml/u9S1iEQ3SQIPczVr3e3Pn105pj9641rZTHpNlisgYxoesg
         QOiL95LotYM5wfcB7pt/vo2xdzyBQ5z277rUMKjDQs8Lv5RtpTzAOTvXjhq/czn+nWim
         BYwCrvtlysooJBxVgRaNirYVgxU4t0bCUS9p/ruLnpXAQYe9RShSQlPEfswzleDc6JWc
         X4yWOBWIdaSFFpRWjZZuHOhVtO4qyVYEkrK2sPnsa99tZy7l2JAcFhW5EgEvVZnzKHQ+
         DxdFVEQtHO/kHjkr9y2bz6KVV3kgKpBH2R5Zg5LHYEVOseCNilCI78IcE7uit4HAgsKg
         Vh+A==
X-Forwarded-Encrypted: i=1; AJvYcCUv4EPlrcse+4Z7v7ELd41w9Yh5lcONJS8jnDT3Zxy8CEBi0Z/jXbwyuwxmlYb73KLkFrVnI+V9Dn7Ouu016XUK@vger.kernel.org
X-Gm-Message-State: AOJu0YynT72yhC5hCWSG6H7jdiJDGgMv4EX/2yVgl++nHJ+rhaZ4upNs
	yQ0FWokBVmgCsyzBhpecq0ktNM5ZS++NbXz46LvLM0QdY2MAKIxMUebcVLyDWlU77qWKjxUwy5g
	9096zU/Ukm4iXVBdTJiFOmPJeUT4QYH2Z0QzK
X-Google-Smtp-Source: AGHT+IEgvN2hF1hcHycMVhWDzye/+BvTmaUsr8C8ylFCp0KWa9jQUiCY1PjtJKyXKGx+KA80/c+6igdUKeLYVyP5RMA=
X-Received: by 2002:a92:c26a:0:b0:3a0:a9a3:8a74 with SMTP id
 e9e14a558f8ab-3a3459f71d2mr631385ab.15.1727380529874; Thu, 26 Sep 2024
 12:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com> <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
 <ZvW4iZpTinJKWIFD@google.com>
In-Reply-To: <ZvW4iZpTinJKWIFD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 12:55:18 -0700
Message-ID: <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > The name dwarf can imply libunwind support, whereas
> > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > > make it clearer there is a libdw connection.
> > >
> > > While it only covers libdw, I think the idea of this macro is whether
> > > the arch has register mappings defined in DWARF standard.  So I think
> > > it's better to keep the name for this case.
> >
> > How can the dwarf standard exist for an arch but not define registers?
>
> I meant it's about the arch code in the perf tools to have the mapping,
> not the DWARF standard itself.

But we guard those definitions behind having libdw:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
So we only have the regs if libdw is present, not if dwarf is in use
for libunwind/libdw. Hence wanting to be specific that they are just a
libdw and not a dwarf thing. Trying to use the regs in libunwind code
would be broken. That could change but I wanted to make the code clear
for the way things are at the moment.

Thanks,
Ian
