Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D01A38F9
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628853; cv=none; b=MqhdjTruYDjLFIPXru7s43S0hhBlVjuvjNLD+G3v31APkfWMBQul+taUqTmlTzbCObQe7rXRz59HEDuheM+tYsqjNF1tc34IPdBKsQTFPV7z3wblmfxF9SwuzDA+uszCl6uDELqckw/+FUEAkHg79f5Uq2xAXWwG4QvCc7ylpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628853; c=relaxed/simple;
	bh=7HAnDvaOJzeCFEh0r+1gzgJRV7lxBVpdVn3iI9CEJE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL2lZIOSRU7zamhq7fEi6ZsJQvJWOGnZtUbxWu2Gy7erhYih1uTJkKFpXOOvaNt9e8oGHBlBVNOtveQr+y3IZLrYBgnLusrDqEKAYJUSyqfUSK3+ZzYxwy4wirX3G0pu7yVCCu8JWFbnU53jn4AQ/GH3hWrP1G6GvUY3WbWqNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeqG6sC8; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeqG6sC8"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so197605ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 09:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734628851; x=1735233651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff+DryC3F8b2bbubAwGiNOQv5h7iNKcJnTsSYM4t/00=;
        b=VeqG6sC8CU7BFO3PENOIUMQDJqOOXzpfoZFU1l3icrQdYGba+sTOvZO63f+sMDZhOm
         6Tz5ZjA+K+IOGgNijlzVqxiljBLul5BLD48vIE/VnRGjxp5qSSW+BWnN0mbyrtQD/zqe
         19alQiSOd9m18oTRrbGCi7IGzTp/i791mNrGsxnMvwJxoqZPwgg/0SAGmzMwM2YDPZzx
         Luem4KRDu77FojBJBhQgwKC4z5aKVm9DsV7P6ZGBNYr2bYooKDUStsTcLJf7sbqUrQkN
         /Z7HKaKlpjhk6PPenn4XvuMlrFuHkN1HFT4+iIBxaYCZUxsQcibM3ikhqTo7+RQKQA6o
         SZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734628851; x=1735233651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff+DryC3F8b2bbubAwGiNOQv5h7iNKcJnTsSYM4t/00=;
        b=KIszp21+0l6eqglBtKOHaFYKWvNeHvcKu4KqnU65Oivv4gq44/XM6UH1hcOu1RKY9L
         Y/AqerX63805WQq1tTZQyvEpr1kkqXc7nM1lG4z2DuclCIsNvxjrKmnz2fgGUrwQr7uV
         luSllSEQ11bsKV8qpdnXQXhTd7iKh+ZUNW5fGMViOeaXq3CmTHjjUX3A4TMDHZFDQvp0
         0JXSV6KDZQTMBrV/xMkFPEa0alSoRynLHxt7Mvv2wwJ03z+3RL8PsB4etpTBAtGnyv5D
         5gy6b5y0ntN+6KRZopztt/o4Yadp7rDr38fj5J3DFin60Bvv80vbD2oEY9c09dlATtVt
         P7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj1h3heqNeX2Mx/cParzzYrf8TKraDRrGV+AqsElOWH23JNChZU3Ld2W923N6ZoF6Thu741NFhU2yAIVyK249i@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CvsRW7ailcuwglQYlsrmh5PbwmwS7QxwGu+mm/NqjHQe9NHX
	/iSW/iMXrbcF9KIzLO4UCOYHUwsYNhXF5vQtaTQUBej92sfBmrBYduYw98s1Ze6o++xSSW5JWn2
	0JRSp/gNQ8vSg8xqjbTRkyjs7lIsTCGSQnLDO
X-Gm-Gg: ASbGncsUM3jiYMDCRvhYpa52CDZkWxE//O+0K0OJhztnK6bD8qg73p1OqkhZcuydU6E
	SQKzsf5GKbgY4sU1cCgCmJelD+ELXyV5cHfOQumo=
X-Google-Smtp-Source: AGHT+IHqAlKRi+zPxPn3WrKiXg7xM0dTLcxXA6OmzRrDqhsnWQac1LZwxwEdESjSzmTJSaN/TYKZDNeTx1u1WOQED0U=
X-Received: by 2002:a05:6e02:3cc7:b0:3a7:6126:ca3 with SMTP id
 e9e14a558f8ab-3c05c1aa61bmr4392535ab.24.1734628850727; Thu, 19 Dec 2024
 09:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com> <20241216232459.427642-2-irogers@google.com>
 <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org> <CAP-5=fVeW+XARtWtdR=XX47w-ZznKiGdhxDBy=Le_QTS=R6SQA@mail.gmail.com>
 <Z2Ov2Gy99KOtctPT@google.com>
In-Reply-To: <Z2Ov2Gy99KOtctPT@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Dec 2024 09:20:39 -0800
Message-ID: <CAP-5=fUUUZcE8D3q3iNkrym=9g6UQxgfDihC24+1J879fj4kww@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf cpumap: If the die_id is missing use socket/physical_package_id
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 9:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Dec 18, 2024 at 09:42:27AM -0800, Ian Rogers wrote:
> > On Wed, Dec 18, 2024 at 4:04=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> > >
> > >
> > >
> > > On 16/12/2024 11:24 pm, Ian Rogers wrote:
> > > > An error value for a missing die_id may be written into things like
> > > > the cpu_topology_map. As the topology needs to be fully written out=
,
> > > > including the die_id, to allow perf.data file features to be aligne=
d
> > > > we can't allow error values to be written out. Instead base the
> > > > missing die_id value off of the socket/physical_package_id assuming
> > > > they correlate 1:1.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >   tools/perf/util/cpumap.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > > > index 27094211edd8..d362272f8466 100644
> > > > --- a/tools/perf/util/cpumap.c
> > > > +++ b/tools/perf/util/cpumap.c
> > > > @@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
> > > >   {
> > > >       int value, ret =3D cpu__get_topology_int(cpu.cpu, "die_id", &=
value);
> > > >
> > > > -     return ret ?: value;
> > > > +        /* If die_id is missing fallback on using the socket/physi=
cal_package_id. */
> > > > +     return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
> > > >   }
> > > >
> > > >   struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *da=
ta)
> > >
> > > Hi Ian,
> > >
> > > I sent a fix for the same or a similar problem here [1]. For this one
> > > I'm not sure why we'd want to use the socket ID for die when it's alw=
ays
> > > been 0 for not present. I wonder if this change is mingling two thing=
s:
> > > fixing the negative error value appearing and replacing die with sock=
et ID.
> > >
> > > Personally I would prefer to keep the 0 to fix the error value, that =
way
> > > nobody gets surprised by the change.
> > >
> > > Also it looks like cpu__get_cluster_id() can suffer from the same iss=
ue,
> > > and if we do it this way we should drop these as they aren't valid an=
ymore:
> > >
> > >         /* There is no die_id on legacy system. */
> > >         if (die < 0)
> > >                 die =3D 0;
> >
> > I think this breaks the assumption here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/expr.c?h=3Dperf-tools-next#n244
>
> Hmm.. I'm not sure how it worked before.  The code is already there and
> it just changed the condition from =3D=3D -1 to < 0, right?

You'd need to be testing on a multi-socket machine to see the issue.
If you had say a dual socket Ampere chip and the die_id was missing,
does it make sense for there to be two sockets/packages but only 1
die? I think it is best we assume 1 die per socket when the die_id is
missing, and to some crippled extent (because of the s390 workaround)
the expr test is doing the sanity check.

Thanks,
Ian
