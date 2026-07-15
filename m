Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D774A2E09
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137766; cv=pass; b=jP4JDKiDHuRq8EZB01KUzR4dq9D5cBmmjEhn69XupDfI3yuR3Wy6msGGBEijEYrIbsqpQMrzv6YzjoTCyHD+9OYhcGVNrp48JfP+AAbRypnZMA5bQ/BI3P4xWIWK1Fxxm+iYgsmdqQtvGCx+aWPWzubTnjPZonZaLC20d8ztigY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137766; c=relaxed/simple;
	bh=JZQ59ZjoILqkp70e90sag9FNdxXhmlCmyt6aW1OEoyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6EW8xGrOyDwJa2MNwoGHR2XKjHUl3p2zIeJ6PyFbmLvnfIEPYUT7u/JG+ROiTt1MRiQkYzIuWQYmrb3CH1imFdzN+UwzTLRQZuKVE3SyRwPWTKCx1aiWhaWCz0UsJtzVZGyLbsy5nV2ZbM1rN0LZitFdR27tSx8oppiz5DFIik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDbVpUJG; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDbVpUJG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab97c86bdso8635ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 10:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784137764; cv=none;
        d=google.com; s=arc-20260327;
        b=c7rSKUnKeQm47r3cQuqTUzLgeSzj6cxKZjFO0AcdjALuJPml5m8+OxcnELn0fr7Txs
         Jg9SKG+7gZfB4ZT+iyHAVomENIJzy+/GRuKbxHrxm4qzByNtvxpjUYEdIQP4ZDx/o34D
         CIJnIKA44/YkSqE4gI4Y8DJr/8bE1bUOw5btrZPaPOHs+2yr/S6Q+UI8keaM9b0FfPay
         4Ci4nTuJtvcRJcxd2/JMyFn5WKgUKZx/QYF46CBAONXoTNJm2dFqgUfI5zaSvcrHSsOe
         DK+10IX8lkzrCIoa0Q90UeFdYkmYwMbATQZH7IRXhBSwGr4hJJlVH58MGO52OHg6lxv6
         0Hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q7mDc21uYbopadQ6bq3Bs8W21x1yOAa+HS91tPAWnuk=;
        fh=g12RQ5f/2Lv+2pKwvrBHBC4jiIfCBsqh+hMKL/rZkus=;
        b=i3VYI6Ocn9/cOyZuTT6yhwNhkH/cZdEaUBv0kGjZHDmHPbebcKQW3n040hLI7H12mo
         G0isi5vfdJIv0iqjheSqpGFWrXHBSvs1QDp8CMW2O4WDykuz6QxXxVwN21l1jupctf0y
         ITduqz3O1O9Q79WYm7VwQLU6TcVlKmx1xPFcnW7Mgl0RPlLnoEAUISy58PR6V67J5aQv
         QosKluxHgM8KZa/FLJbyWTeAGlAYCyWrXK+QlXamRQtSVY4m//Lxkxs7Fy2JLkGwf96e
         MbP7hIXoCiDmCemgdMxBQrj8Q+H4gbfzo3NR0DAhqO6s2ffwXzYJkLcFcu+1yLH10Bne
         KmsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784137764; x=1784742564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q7mDc21uYbopadQ6bq3Bs8W21x1yOAa+HS91tPAWnuk=;
        b=eDbVpUJGo5JWqwKjHVzrTZ3TRPJDgTXIquZnEdkgHq5v01fVmjjX6FHvMx/94rYXgR
         XRs+z1AtSUwwh4VxHfILavJDNrloPvTaTW/Zo0HQS1eiDXCuKobch25D4ahHCFWI7Rfm
         F8n8nV0Mf+oqtxwMWV9HhLlS36oz9gGIuguoFxvlje+qDFEZe7gX6HWxCZpid9gGIbQz
         RhQmxZnY6mpWc3fxRwP5FwDvZ1/jMIpyBssH71b203Oqut1Dug/IVMJlzuxK9SzhpX6j
         WsiHViFz1FAF4LviK+jcvqO9ST82iesrxZqfOpDSvVJKtBxYIdLArZYy+u0SGQxiMjMf
         gTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137764; x=1784742564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7mDc21uYbopadQ6bq3Bs8W21x1yOAa+HS91tPAWnuk=;
        b=RCiSn/M6L5rC+8oIvn3pLcvVHHSs/QUrgF76DZiGofmMasfCrpirIe7d0hmOoWiXQZ
         wTQEPB2hLJIglXe6Vcv7lI9XAZJjVjE77A8maePDltD63MAdNvHuBa8xRairSntbn5ZM
         vmZJiDlGuBQuOl7XE3lpx5/9n7QL9hOsIYmoOYJg3vFYEMHSJ25v0kKD9XHgPnSWAH06
         ZvyjHBpbEkELOaCh12m7hbGE38i3bZxGhOS1WhZ/lsqhM3Ex9dPzjj1k3TZXQIcgLoqI
         5qoNVj6yXq6rBeD45s12PPM2Grs4LDamx74lH6d21tp/kGQtFWukJ8ymClT/DumlhmRP
         BvnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2dduWoDoJhTNBwibr5ccRJDThPLhhrssi0CZF2wVwBTmpxzn7ddfoNhEG+W0/7eXUGSwBHTwZsn2E7mpo7uIp@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwAPLp01kwhOvw3cWfJzdEublXuvg/skQbBq+IgZsj+29mHcf
	y/ZwsPFeBcJJTJZlR31tADqgzLBABxy6uLcOXOSCnZ1oAk47tN94/oFa80gvf81LqqrWXcN8Q38
	4tjmlBD/ht/BNySCHK5N1kWZNAoZh2HNvCTrMFjQX
X-Gm-Gg: AfdE7clX091eU+e/YkHQX4KtdGIzpbaYCFUT41mqy+HZaXTPSHLo1NIJkR6kruy6gEw
	hILDlse5gqZjdEeo3FLt9NKFpZUVH5hNEq6Sh+Q8h6VaW/LiGtrcsywadZvewG/02tVT36+QcUj
	sTvToFDxj4o8lB7q9PzdP2fH81+3Wep7QlJs5wAQaB04rksU/OK77XZAVxv7fUYHUosSxpqjfT5
	B625YlPn4et568cYnFq+5XEJs+T4VHMVlOE7u294GSWSxIuhwqb+ZMWISIyXY2LxM4UUwXV8E7Z
	q+Uaji7XFOGSgpi12N4VL2b1u5n7KXuhOkdIxA==
X-Received: by 2002:a17:903:13cf:b0:2cc:f9b7:8c7c with SMTP id
 d9443c01a7336-2cf1966f3fcmr254675ad.21.1784137763460; Wed, 15 Jul 2026
 10:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707034019.241762-1-irogers@google.com> <20260707034019.241762-2-irogers@google.com>
 <0cb89290ad307e4c1d020997a24a9662@codethink.co.uk>
In-Reply-To: <0cb89290ad307e4c1d020997a24a9662@codethink.co.uk>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 10:49:12 -0700
X-Gm-Features: AUfX_mzaJceD7oZ0lQzsH7OZNuTw2vbVOC4gdLVIsQ2Nbno-I375PWi4gQKkPLk
Message-ID: <CAP-5=fVBLmfHgvtzrDULYUAKjNpkacDsQ0WX2wgWA8mrR4SFhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf jevents: Add more components to the metric
 sorting order
To: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, Chun-Tse Shao <ctshao@google.com>, 
	John Garry <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 4:22=E2=80=AFAM Nazar Kazakov
<nazar.kazakov@codethink.co.uk> wrote:
>
> On 2026-07-07 04:40, Ian Rogers wrote:
> > Nazar Kazakov reported non-deterministic builds due to the metrics
> > being reordered in the jevents.py output. The metrics were largely
> > only being sorted by name, add in the expressions and descriptions.
> >
> > Reported-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> > Closes:
> > https://lore.kernel.org/linux-perf-users/20260706175624.692736-1-nazar.=
kazakov@codethink.co.uk/
> > Fixes: 40769665b63d ("perf jevents: Parse metrics during conversion")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/jevents.py | 5 +++--
> >  tools/perf/pmu-events/metric.py  | 6 +++++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py
> > b/tools/perf/pmu-events/jevents.py
> > index 376dc2d24162..3c6cfeefbd5d 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -570,13 +570,14 @@ static const struct pmu_table_entry
> > {_pending_events_tblname}[] =3D {{
> >  def print_pending_metrics() -> None:
> >    """Optionally close metrics table."""
> >
> > -  def metric_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> > +  def metric_cmp_key(j: JsonEvent) -> Tuple[str, str, str, str]:
> >      def fix_none(s: Optional[str]) -> str:
> >        if s is None:
> >          return ''
> >        return s
> >
> > -    return (j.desc is not None, fix_none(j.pmu),
> > fix_none(j.metric_name))
> > +    return (fix_none(j.pmu), fix_none(j.metric_name),
> > j.metric_expr.ToPerfJson(),
> > +            fix_none(j.desc))
> >
> >    global _pending_metrics
> >    if not _pending_metrics:
> > diff --git a/tools/perf/pmu-events/metric.py
> > b/tools/perf/pmu-events/metric.py
> > index a91ccb5977f0..11c7162825f4 100644
> > --- a/tools/perf/pmu-events/metric.py
> > +++ b/tools/perf/pmu-events/metric.py
> > @@ -623,7 +623,11 @@ class Metric:
> >
> >    def __lt__(self, other):
> >      """Sort order."""
> > -    return self.name < other.name
> > +    if self.name !=3D other.name:
> > +      return self.name < other.name
> > +    if not self.expr.Equals(other.expr):
> > +      return self.expr.ToPerfJson() < other.expr.ToPerfJson()
> > +    return self.description < other.description
> >
> >    def AddToMetricGroup(self, group):
> >      """Callback used when being added to a MetricGroup."""
>
> Tested-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
>
> This fixes the non-reproducibility indeed, thank you!
> I haven't tested mypy patches as I've just cherry-picked this one.

Great, thanks!
Ian

> Thanks,
> Nazar Kazakov
