Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B61132103;
	Wed, 25 Sep 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247982; cv=none; b=gk83XDXm8bCinF5rDqqx4q9JwuZnZMsWUums8zDB8sg1KbUtw2hfmRTiBI3YaCbYdv6Nsv1BcUL72sbJUg4/xof22sxFOTJQFF1+XMKU0iWaGvODEe6kVWr/cJTuskTlMjWAPt83JmdQxzB82rt2LeXm+25I/8moMCt38fpLI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247982; c=relaxed/simple;
	bh=r/UpZHRugg7E4XJtS4snutbnJJxhERlRPA+IfA/58w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRtN6zutcgiZELk3HDiBor677886qoK/B1rlTiQsaTIWWX5CrFgOMlrsmy421XjXiFZRo4vE0y9DMPsDBYKE0Sc31bFrlqDQXCTYesgpAtbbOEj16wosimmAbFqvSwx+wxcMA7uIJiAiTPFFnL5B6C79BK7QfFhVVjQd1Xf007U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nErFxEMy; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nErFxEMy"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso5347194276.1;
        Wed, 25 Sep 2024 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727247980; x=1727852780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFGHk5zglVrz/FssJKzFrZhryMd+Oo5FMWLKTN8i03Q=;
        b=nErFxEMy7Qhe0xukytMcx3m4pNMxB74yjCO7TvUqXqCfDW1joj8XENXc2YAyayHA4K
         hhTqcwhTo6JCzSjYMWxepB7XiTnU2QwZfJ6VImWuFjk6i+G70rwdz+Ri43ls+FrTGQEn
         uVheZndQ4CPfGlxOMwBtM7nIhva0BPUKNaXWaZajLO5lth3z2brI0yfoyff0I8deXMgL
         Tgtg31F3llr3h+P76kZ3F9UpxZbJN5WFY5UUNi0m6wbo4p1WncF5wmOTKQstB2FlUVTR
         nKpNX0msB6VpzC5oE1aZui6rz/CNWpo/zJPz0lsxiELYxQsc611U/wsU0+EjFOYKWmyw
         xg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247980; x=1727852780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFGHk5zglVrz/FssJKzFrZhryMd+Oo5FMWLKTN8i03Q=;
        b=t6/CXVh5qp5S5hM8wO60IHo6rU61VZEveRfMGQmtw9Wgc2g9ROlMZnqRbrTFr+a4Go
         DcRttXrUhrIyie2+sxpjVcx3VgzJLf35cyC+v9Fl0S5h++92Gzh+Iqd7c/cXfTj2VVa/
         Rk37D3T/Wwa1Y0opubChlTuW+LNOA7PWFhTHEECqLM0PAnytWbA+/az/ZTGCg5grnkNg
         gEYgzSnfZm0QKPNhHNfk/Sdr28poAdkskbfMehHhyc/1zErMy1Fog8SO6X3cPcvimw3F
         EEMtuBdQBEiEvIUK9VQEymMzDoe1/kq9Sx3LU82Cv6QKma/Q3eEIZyIXsdbGXsPT458J
         7L3A==
X-Forwarded-Encrypted: i=1; AJvYcCUqybbJ21kOaNYJlo/CDBHzKzb/Fy+zSMne+KqBPPG4fi05ChqniRizkR4xEGD1tRDZ+V/5CkYLb583nPBbLql8qg==@vger.kernel.org, AJvYcCXRMndBSM+XNGYYSUBxl+2opK0+aGvAeyEfRcKlzs4tll1icR79WpVLHHdRq7Xlgx7IpIQgjXJhfBGUJRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMPGYsevibQJzXyRmd90po4xh+iB5IGNwOAplnRvYxiSamvZS
	GNwRQFFe8lrc4P+I7ZnkGBK2xgIuB33IjMnD71MBzVpkFhzeUeXo/k4eLtK8dG+TZlQljOa87jX
	qqwcC1JLvbeaexqw2ieN1mhO91o4=
X-Google-Smtp-Source: AGHT+IFeMfY421OnlUNrXl1zpzXVmA1iKNUOTtXF6ryLxY6T+v2AvNFDqCW6wcCl+vW2nTTgR8+OdrQfdWI6G28c+TY=
X-Received: by 2002:a25:694d:0:b0:e25:7573:cef with SMTP id
 3f1490d57ef6-e2575731445mr178642276.51.1727247979823; Wed, 25 Sep 2024
 00:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-2-howardchu95@gmail.com> <ZrQBbMiIt1NCvxbY@google.com>
 <CAH0uvojQORE2WJziQ4Ru8vsZzr6OLsnn3HOVRkWHW4VFzpKkEg@mail.gmail.com> <CAP-5=fUtcWzGV3n6igzs+eq8dEw2WYsnp8hNeKSUF+6yhZQMcw@mail.gmail.com>
In-Reply-To: <CAP-5=fUtcWzGV3n6igzs+eq8dEw2WYsnp8hNeKSUF+6yhZQMcw@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 25 Sep 2024 00:07:11 -0700
Message-ID: <CAH0uvogkdEfp_X4Tzc+WGeeuByTDBG9eaHyfeWZ2MbHoMZd6cg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] perf evsel: Set BPF output to system-wide
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 24, 2024 at 7:53=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Aug 7, 2024 at 8:58=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
> >
> > Hello,
> >
> > The event does open, but bpf_perf_event_output() in BPF will return
> > -95(-EOPNOTSUPP), so no output. I think this EOPNOTSUPP is not in
> > bpf_trace.c's __bpf_perf_event_output(), but in perf_event's
> > perf_event_output() called by BPF.
> >
> >           <idle>-0       [001] d..4. 154921.079230: bpf_trace_printk: e=
rr -95
> >
> > This is also a bug in perf trace -p <PID>.
> >
> > Thanks,
> > Howard
> >
> > On Thu, Aug 8, 2024 at 7:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Wed, Aug 07, 2024 at 11:38:35PM +0800, Howard Chu wrote:
> > > > pid =3D -1 for bpf-output event.
> > > >
> > > > This makes perf record -p <PID> --off-cpu work. Otherwise bpf-outpu=
t
> > > > cannot be collected.
> > >
> > > I don't understand why it's necessary.  Why isn't it collected?
> > > Is it the kernel to reject the BPF output event to open?
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > > ---
> > > >  tools/perf/util/evsel.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index bc603193c477..b961467133cf 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -2282,6 +2282,10 @@ static int evsel__open_cpu(struct evsel *evs=
el, struct perf_cpu_map *cpus,
> > > >
> > > >                       test_attr__ready();
> > > >
> > > > +                     /* BPF output event can only be system-wide *=
/
> > > > +                     if (evsel__is_bpf_output(evsel))
> > > > +                             pid =3D -1;
>
> This matches with libbpf:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/lib/bpf/libbpf.c#n11967

Thanks for pointing it out, that's a very good reference. Namhyung
actually came up with a very good solution and based on his idea I
posted this patch series:
https://lore.kernel.org/linux-perf-users/20240827092013.1596-1-howardchu95@=
gmail.com/

Thanks,
Howard
>
> Thanks,
> Ian
>
> > > > +
> > > >                       /* Debug message used by test scripts */
> > > >                       pr_debug2_peo("sys_perf_event_open: pid %d  c=
pu %d  group_fd %d  flags %#lx",
> > > >                               pid, perf_cpu_map__cpu(cpus, idx).cpu=
, group_fd, evsel->open_flags);
> > > > --
> > > > 2.45.2
> > > >
