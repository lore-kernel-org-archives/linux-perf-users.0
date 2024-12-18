Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCC1B4233
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543762; cv=none; b=Q0sIUsh/UWSRaOF87i4dsHbIMS1osfdnXSY78Wx7Y7A7vLrwVeCNdXXXATSmpYkJQyf3VURexu5tmk4+dl72diZlXs1aVpWXLkyn70QpYZtFKlS7ABhgn1se7ZN/VdtSw7u/iK6qQ85nPoMxQiHp4TGGMJ+zGw7RGqZmOvFmWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543762; c=relaxed/simple;
	bh=a5BIMZ9/WZQypogs7JCenGm61s9RheV53Xhp4lOgWHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ4fp4goGRnemUVUdFsSr+Nk5D9f14CRuxFXqtwgK6mv+b5wX+ty6slhOuhqzJYDaSXclxRvXxcLagqT7QmgdfWaqI+BlmvyUD5SXPzZ5nQBa/nREysymtrjVnvAuKYka4ciVOPX94r00ESGz0hgZKiPwX1c3rpCC886WW+HURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/xuraVQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/xuraVQ"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so105ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734543760; x=1735148560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovwOzVqRNTlJWmdVUvDuHkd2o0TqMMKPC2vbVMPNCyE=;
        b=G/xuraVQ+RgMB6UvrsJQcAGah43H/Tqo1grKZAMI5sSwki9o316CgkNXZqxdDDJosx
         b4PjnR4mPvFSvTMIhJJW6G8hMdIIMXIWrOPc84yn39AJ0egqziPpMqHIqxMrf0o6ZzA7
         EWV9dE+ivarTqnjTZuQt3ixmpkFRtMMR8zyyLn/G7AZQqpKuUEOmgcGSmWGqi6nKGcKu
         +onQacKyMQlQk7kZEBP6+Po3M04lMzx5nDQ3IIK6dqA4xZcUzX7Us7ckcnX8Nt4hE3T+
         njE7EvGLpyaxFwhwWdkofOKglUBbTh3inn7yaD2+plQxiUeM/XdUSfvUqwPQVkktcQSG
         xGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734543760; x=1735148560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovwOzVqRNTlJWmdVUvDuHkd2o0TqMMKPC2vbVMPNCyE=;
        b=g60jJVq9c6bNQdozYUlXUdHuhX0/38dpOeTqmft7LYLSXAK8cF2MOD2hu6w+PYy95A
         699iniJjGoSAb08W3vJg/1tCwDvvH2t8MiKR65AGPPuXLn0hkTcor2592mxjDEZkR3Eq
         FDrEO9ASPKcnkoqbveYYgB7q35XumyBr21tSlJ96RH0O1wAlYqsygVdkM7oVkjOebe5/
         ArNk0Pf9hkpQ8F6gLsP7bwdRh9uO5W/xz5NYOYUVyW0sNiTdNuY9+1BB7jo3C7bFvQ2A
         52kQDNbVcVyQZM8tJqiZ/ITtfkEMCnkP5pCfG82N2fwh25lAD35rIdt6zP/LqrHEwgIE
         ud8A==
X-Forwarded-Encrypted: i=1; AJvYcCUWMYFIBRQHcb8AztpN5/EfDyhsr5eyMqvt+NfB9qxQ93PV6KywtoLJO+HFeWU/US/xiCxzHBUb1DC+TsCBtxY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4sWTk4T6ano8g2TtPDIbxdns/W2SwiXYNmNfgsai9sH4LmHg
	eb14pFG0mc+aJM2pnd6tTk0eJi6Q0iN6W1xaUNcymfWroRgR1dh2kooTQk1csxxv1YSd7CEj2q4
	HIAcVcnkLFUjEHRjrKEWMfG3UROS+LUuOWAH2
X-Gm-Gg: ASbGncuBoRYMb0M6vbHRw/dewM4PQKc9/NUJ7liJ+f3lssU5bgIRxbVl/vvcJOES9CK
	ibpNGV/9ReUP+D7yP5IhZ5DvPd5VGiGz0IOph8co=
X-Google-Smtp-Source: AGHT+IEIh+1suEOmUuJeuZwlcjORjarBOMSXJYpqt7YiNZc5E2Z7kISPr4a7ZfB4ARdidQdmLArR84x2VBkGviYd7x4=
X-Received: by 2002:a05:6e02:216f:b0:3a7:e616:8d2f with SMTP id
 e9e14a558f8ab-3be373b35e7mr3070475ab.7.1734543759435; Wed, 18 Dec 2024
 09:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com> <20241216232459.427642-2-irogers@google.com>
 <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org>
In-Reply-To: <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 09:42:27 -0800
Message-ID: <CAP-5=fVeW+XARtWtdR=XX47w-ZznKiGdhxDBy=Le_QTS=R6SQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf cpumap: If the die_id is missing use socket/physical_package_id
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 4:04=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/12/2024 11:24 pm, Ian Rogers wrote:
> > An error value for a missing die_id may be written into things like
> > the cpu_topology_map. As the topology needs to be fully written out,
> > including the die_id, to allow perf.data file features to be aligned
> > we can't allow error values to be written out. Instead base the
> > missing die_id value off of the socket/physical_package_id assuming
> > they correlate 1:1.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/cpumap.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 27094211edd8..d362272f8466 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
> >   {
> >       int value, ret =3D cpu__get_topology_int(cpu.cpu, "die_id", &valu=
e);
> >
> > -     return ret ?: value;
> > +        /* If die_id is missing fallback on using the socket/physical_=
package_id. */
> > +     return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
> >   }
> >
> >   struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
>
> Hi Ian,
>
> I sent a fix for the same or a similar problem here [1]. For this one
> I'm not sure why we'd want to use the socket ID for die when it's always
> been 0 for not present. I wonder if this change is mingling two things:
> fixing the negative error value appearing and replacing die with socket I=
D.
>
> Personally I would prefer to keep the 0 to fix the error value, that way
> nobody gets surprised by the change.
>
> Also it looks like cpu__get_cluster_id() can suffer from the same issue,
> and if we do it this way we should drop these as they aren't valid anymor=
e:
>
>         /* There is no die_id on legacy system. */
>         if (die < 0)
>                 die =3D 0;

I think this breaks the assumption here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/expr.c?h=3Dperf-tools-next#n244
hence using the number of packages. I think we need to make sure there
is order otherwise we'll end up with "if no dies value present" or "if
dies value is 0 ignore" everywhere. What is strange to me is that ARM
may have the die_id present but have it contain the value -1.

> And last minor comment this could do with a fixes: 05be17eed774

Thanks,
Ian

> [1]:
> https://lore.kernel.org/linux-perf-users/20241218115552.912517-1-james.cl=
ark@linaro.org/T/#u
>
