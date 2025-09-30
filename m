Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDA1A83ED
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263074; cv=none; b=KmM5PsTRvSGtHM/e7EZece9jWmMJZQuBWR1jv7qCrzrpW7k0P3ZnCfe74gpLbLE61cjz5IrU8eHWK4YKR8u2G9Vkd06RvNIp8s6bFanjrHbRDuashuL1gzQwfQxCsXnk7snXGseekzmxr4dU9EMZ7vmAnDeZrsB/WQqvCWjUU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263074; c=relaxed/simple;
	bh=28CiOOtE1+utCGkn71XoVKwktkzm+lmXvMrk0Texmhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8QYDgrjdoLXYGSbH2kL4w4WF/UtKtU03Hz22txo67WLaCPUfQ6cbGKBTH9aDoB1uyBCG7+KV7sy3lTVZejzzBETJRAMMLKSPUJYsymMDafDZ4jibJP6H4Y+d8zFtD5OalY71PcbAUOwZGjewR0pjgB1nQM0jk80UQ7ApepQ7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkK9+ffG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkK9+ffG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so2725ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759263071; x=1759867871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z35lL/3kx403pYQW8IvvheoMziA8YGpWpHWvXvsIQU=;
        b=ZkK9+ffGx+h4khUErsG9ROuKLdKQwG3HIpjLxVvFR+mDzLku5pe9yvP0yFta1Xv/aU
         OIfe49eiPpQHqCkoqtdho6TzKPgkQpS5noh2EXWIIOocblrWs4QTz1/aJ8oKX8jIOgrV
         BgtjwxLJCNZ+TQ8ybBUgFbMl6aIBzW1gPyZWlMK9ud9f9ekcX5FDMFBXuTXPBlopHE7K
         p5EOQ35cgPJkTR1mAT9acW3TchW+gqit4Pe8ETo2ODTc9koF99S2eUXvLl33Ww4Iqs0r
         GFuEwycBCLnBQJNmBahLC7D7plpf2B9Y5mY5QTWZ/Qr1XkgaxPXIGjqVxsKHmqZ7uF0O
         JIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263071; x=1759867871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z35lL/3kx403pYQW8IvvheoMziA8YGpWpHWvXvsIQU=;
        b=R8pMyi9lQCOhYr18CDnPxOEJrBGAKz6TfXzN6Q2tF8Q7Rmj0OongesV31uiehRb55R
         5EVA2GcPlA9krR+F4Cksu8hwWqPXWEaZPSigoFLvG8QOPYVyMytmPDhdHDITzCUg8hal
         z9dRFW+VjGbyq8zIRhIWTAmftqSSiFzI75e5og5INZmTQczi3YgwUPTgAt74YO5JnV65
         AE+nbBCr0+lvemChYKJJ5LJz5LRscb2U9gmpdlySy06uB6JtS78Q1bRSDy4TL40g/YT7
         eYagDZXpbrAF6mYZrPtuWcyFGb3ZaHTTAQzSH2HJW+NbUasF5f/YSHZK5HgLG9/CvDIh
         f88Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAVlsDEvJIQw9EPkjQlHINSmWcw0zwkgfmoU1gDKn+6PlXiVf/DV/z3X30BV1yt7jDp29+8fZkMf3J5yy7hhZ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gFvTMXNVvE3bWefZlo4o57Z+5US1guTk4nET3nuTvPesFVTZ
	uIpGyFPqniRjN0bFfZYomJz3e6nEMC61PDOyOdB9h7QlQSkflbX0I7A7O6XqNHCEwKt42DKEPpa
	GpIxcmSYlOFmVq1BhhPsJjq2lPPflARsRJICqYVqS
X-Gm-Gg: ASbGncuPkaySHwtA3vBrNiJ1l0R6Q9VwWrHtiLCHoNlGwKh1UO4dHwFz2xmamcn8/Ln
	Css1WPIhKe2GPQ9ZDomZAmzdihiG7pVgqk5ix0OnCsn0JIu7nbnlYKxjCH91sWBpDscuzQbvdwM
	n7VCQAWlnK8uN15/iovjeiVwuRAM03z7c4kHyb4Cb1qNlIy4PMPFn0hMcqCb9Um2gNfKcKnk86N
	BGYIIM096l9hKKtlwv79adoL+7jo8mct8cJ1V2tUf2otKUZDdgN+6y6xQJctQrbVhpK
X-Google-Smtp-Source: AGHT+IERdYR1/mUI7zXBnM19rHV5/7EdktMJLu+4W1r6xYhstvFfzAM7cCBplh6Yc4QT+b1yPwrOREhwdiT63r7xiis=
X-Received: by 2002:a17:903:3203:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-28e8129b9d0mr150215ad.13.1759263070428; Tue, 30 Sep 2025
 13:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <aM3SCGOXZsP3GZal@google.com>
 <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
In-Reply-To: <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 13:10:59 -0700
X-Gm-Features: AS18NWAMU8EozYGGxgb_yx-b4bLuOaxCH94CW8izj29kx3qqp2nmTeyfVuIUP5g
Message-ID: <CAP-5=fW6tPRW2qdFE4AbXg+47CzTjDX5HEjenjTxgOZ35fFa8A@mail.gmail.com>
Subject: Re: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Sep 19, 2025 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Fri, Sep 19, 2025 at 06:06:52PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Hi,
> > >
> > >       Please take a look, noticed after processing a patch from Ian
> > > for another such issue, on a hurry now, haven't checked when that
> > > emit_string was introduced.
>
> emit_strings was added in Linux v6.17 and libbpf was tagged as version
> 1.7 prior to that.
>
> Thanks,
> Ian

Ping.

When this lands I can rebase:
https://lore.kernel.org/lkml/20250830053549.1966520-1-irogers@google.com/
on it.

Thanks,
Ian

> > >
> > > - Arnaldo
> > >
> > > Arnaldo Carvalho de Melo (2):
> > >   perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
> > >   perf bpf: Check libbpf version to use
> > >     btf_dump_type_data_opts.emit_strings
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
> > >
> > >  tools/perf/util/bpf-event.c  | 2 ++
> > >  tools/perf/util/bpf-filter.c | 5 +----
> > >  tools/perf/util/bpf-utils.h  | 5 +++++
> > >  3 files changed, 8 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.51.0
> > >
