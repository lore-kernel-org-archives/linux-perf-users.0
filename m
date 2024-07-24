Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2731158DA7;
	Wed, 24 Jul 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837968; cv=none; b=QKhKyjDI7dUf6mAm/o1yCBq5SyRHtob73kjl8L/3apNR6DKm79P9MmKpujpm1myezsb3hcMKoSN1DJzbAgmYgRUDTafdEVDRy6PnSQ2efvNJhTkaUefUWFu2Rfmko0Nw5VJR68zhhAHZvW/VDbbh1QbRklyF+P3KL3ArRIZSBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837968; c=relaxed/simple;
	bh=M9xNnH9A3o+JbidnMTWZbkgXxw+NqYPjjPDUFgusnPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8D0B7rBAG37s0RO294GdV+5WF5VDxbEIoOruyTrtBObvv6jA2vCLkSmdcJdXk4g2WhDKvH7vZ9zv7akGDQfqYb0nzpQO31E3Hwi3LudpSlpz3q8XYk9WXayQa8UmIEjb+DQOGrOGZv7ii6Ey7zPxAHI8KVI79KDEnf5jmaBMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d1d6369acso780557b3a.0;
        Wed, 24 Jul 2024 09:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837966; x=1722442766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpUG3opiLz2xR43uxtV0MHYwVyplNn+0MniIggPsJ20=;
        b=JQBJQ8g6LxBbdg29uGDlmVt/AtLcEmFnC9xWCWuOysRg8+EBotDpP72Jp9mCnWbIw5
         Mf0DGmcWQVOsqcC9ZwWx8Ps0q37ES7eIqx9287TPYPbc1/H67Nxp6Xye1ehqfxdWUzGS
         Ov9CIzu0Yog1jI1s5DRWh5l/SLQjfgg55WSSN9YiFP6RlNN87Wv/6p+3hPFX3/BoseZY
         hEmO0vK7L5nmo5e0X0GQJ94wsxTyYe61/HfJHwzGO9zBjLYeF+hlNRjbS3og38QBmXcG
         ehrtFyIWP0tceTlOF6pM/qkH/JHdlsuByqsn6919BJnFUMAqa6k2gb/vaQ6PuO10qUCy
         twuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4nLZbO0aYuTL8Oo5jvCy8e8WEcvLlr9dxDNbaReM3G7P1Hb6qUx9nyxuyRmOmPYtlEnXEztO15gAsFMUeoES/XoM/tHMsyDtsffPS
X-Gm-Message-State: AOJu0YzqYaXvfmQd403TECU70iF9sRbJVlAgWwvyvYtH+BnRfLNX4meP
	Wq3rrfIdKcLH7Tnwk6PfSJ8eLuG/aFarqluDjX0dgelGf5YugFFu20AeBOEB04AHEKvnPst0v5m
	hfDdSb+WpADk9YsuG265ifNgzAMI=
X-Google-Smtp-Source: AGHT+IFzeqzAiyRDu5VoP52MvfbUxNgzlRFo6KYBMbArZGgNQZS33tw4CGZPkkS4T3SESI8IUKDVyMf7Ki1ZcOr6TdI=
X-Received: by 2002:a17:90b:4b52:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2cf2207e990mr161813a91.20.1721837965963; Wed, 24 Jul 2024
 09:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722211548.61455-1-cachen@purestorage.com> <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com>
In-Reply-To: <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 24 Jul 2024 09:19:14 -0700
Message-ID: <CAM9d7cj20KdEtg8v93+bt+ZmpTzin=N3DfAX3K8ELHLkccoeqQ@mail.gmail.com>
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Casey Chen <cachen@purestorage.com>=
 wrote:
>
> Ian / Namhyung,
>
> Could you take a look at the latest diff PATCHv5 ?
>
> Thanks,
> Casey
>
> On Mon, Jul 22, 2024 at 2:15=E2=80=AFPM Casey Chen <cachen@purestorage.co=
m> wrote:
> >
> > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > thread__find_map() could return with al->maps being NULL.
> >
> > The path below could add a callchain_cursor_node with NULL ms.maps.
> >
> > add_callchain_ip()
> >   thread__find_symbol(.., &al)
> >     thread__find_map(.., &al)   // al->maps becomes NULL
> >   ms.maps =3D maps__get(al.maps)
> >   callchain_cursor_append(..., &ms, ...)
> >     node->ms.maps =3D maps__get(ms->maps)
> >
> > Then the path below would dereference NULL maps and get segfault.
> >
> > fill_callchain_info()
> >   maps__machine(node->ms.maps);
> >
> > Fix it by checking if maps is NULL in fill_callchain_info().
> >
> > Signed-off-by: Casey Chen <cachen@purestorage.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> > ---
> >  tools/perf/util/callchain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 1730b852a947..6d075648d2cc 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entr=
y *he, struct perf_sample *samp
> >  int fill_callchain_info(struct addr_location *al, struct callchain_cur=
sor_node *node,
> >                         bool hide_unresolved)
> >  {
> > -       struct machine *machine =3D maps__machine(node->ms.maps);
> > +       struct machine *machine =3D node->ms.maps ? maps__machine(node-=
>ms.maps) : NULL;
> >
> >         maps__put(al->maps);
> >         al->maps =3D maps__get(node->ms.maps);
> > --
> > 2.45.2
> >
