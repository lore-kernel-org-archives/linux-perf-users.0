Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46A34D90D
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894925; cv=pass; b=MLfv0d4Q8T0G6A74/6cOnxvichKJo+YQz8VaNpr/O/laTHkSA97Zg+ndr/mLcdZ3lgTSpb8+zZaoyvUJWpfStdU1DvVekyNce8iGy39gAWbasxHLJnZAuNi6Z6ARL7oZBM483DLwqu76sNkRtfTJ4ObE8X8BA1ZIiFhcDRPfauk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894925; c=relaxed/simple;
	bh=UofT5mRmM760GSuIfZ6U6mue9iONe0bEnw4zvcDNh4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q94U1sXiBnIuOe3twvLrsiezwtGBTzKACjLzE2bdtwtFwaN0gG4pEU0AvO46Mj1nHBot3KPFPOpjVTnZ7/xmPeaYl+gh9hG3nrKKLtkG0LZxKE+CoNLhwsQmD1/RRcSSVf+RqI8iikfzNH0qymJf9ia4flqvQF+Ng103yNZoPbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgfkNQ3q; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgfkNQ3q"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c10e86e52so112001cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 22:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787894923; cv=none;
        d=google.com; s=arc-20260327;
        b=pVT+2tpwou8kfAcQH1i5nsa2ZWAPLdZfPRZwVNo8FXJGnvJh7jHY1/czqTJugHvJds
         IHigomuOhTQnWMX0+rN276X22dCMiTvoaG2tW8NwiwwUaRM75GCJHKBVSiMQB9hGG7FQ
         x135AcPrhWoDELfxwN6wESP8Dp6oOdGHt/Ay82jO5EOhXkcUw/GsYKMLDEb4OMtym+VN
         2mNbQfWTz7PlqtTO7yYEQTItJ/y/XCrc2CHFjW7ynYXFpQHZoNn96F+wtIPNrQiqhRMq
         Ed1VdZ+Ma08m6PTkVLod0xstvpje6gDrGYGvC+G26YpNk+U50FKc+rkGGSDl8ZCTyBh5
         6zjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lHN/QltBvD1McrbA5b6sCOVj97NzYlG2hizEslR8/Uk=;
        fh=E00AeMcj7vyEdP5dtAW+BiclYU7lyr4UuWfe521ONm8=;
        b=Gr0lv+N1qS8PPN9qpT5n32Ao4yfcLItMlgNlITz4OFMa58ccBewLFafyM2tnXGkOZY
         aiaYgwlQgvFJUR7IkdlDUJVdSi6y3NkN1u30Ld77NVjCQms0Ga5a5b6WttEhC/lhKXXV
         w8oFwnRtth89nRXjqj5tjxwbg5jutsk+YdRejm83x0eC6V96be2yMF/sAeSI08HrKSuC
         dh5uVIVS2I35HWEl8XPXnVKJ+bfThjVeWHRExAwY2ZlexBPq1I1yRkSHd8acoH3L0F79
         0EYm+xMts4WZ0ztzGofxzkWV73oqEWHTFA06e42/Kwa0QfhqU6I4jbLRAZ7HDmJNo3Di
         tV9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787894923; x=1788499723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lHN/QltBvD1McrbA5b6sCOVj97NzYlG2hizEslR8/Uk=;
        b=rgfkNQ3qkunVkWWfdWEI3xLOy2pzpCCuCtN2uvbIerxsHQioe5ygksMflaP5cVQrzt
         vTk1EZjeqDy+guGFtnilX3p7gR95SmJ0FnB4htZkonNc2xm62mBgNm3i/mTYEU22Ldaw
         QCGoyuGVchzuyEEAN4haGaWKl/5aI809RkOZ2to0gYfkpMB0E739eeMFoyyrTmq0twEH
         LBfn/y08Nt0SshTIiDznXoFS5Bjx7I3eCwhyjFjtgft/4px3Vowke/Urfpe4HaS3O7Gu
         /EBpWb627CbEHw35HrcUhdFhOqHb4W5g4jXMXOa8Dh6f3+hTK/HJwSckmo4JzvFhtRtz
         pkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787894923; x=1788499723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHN/QltBvD1McrbA5b6sCOVj97NzYlG2hizEslR8/Uk=;
        b=oWkaj0pOpToUVpyzCbnESXf1GWHYaXc2oO4xaiBykesuH5OIE8NaWwMoMnMCli2xsl
         h5eCNuvHh/+asNC+vMiMwRXZOL8rA3lINCVDKnejTZxD0jSsGE61T39Uw5CmkXAz0dIH
         NUYU0RJ6qgdeEN3/NyPKR/UXhAAnbWvtIG+UMf/0IbJ99QyJc8PQcLzGagdQW1Nc5T1A
         g9RjAPwlLFFAQAjj40UW9lSIH1klmP46n5Afu5kbwoKiZRUdq8lVIiC1gBcR1XWYPHIx
         BMmTzslPZq/cYF0WC1tqF04SxBsFdh6JiVEsd50vcmfHeJv5V+QM2nXh07Bj7tk9NCMZ
         +a3w==
X-Forwarded-Encrypted: i=1; AHgh+RpzFW9+iyy3LYHZz11dfjbj1UU2JEF9i38bX6jXSfyFzLuNCOxlBcYkPV8yKm1fk5Ph9dcLz0d8HneDYqIRXMXA@vger.kernel.org
X-Gm-Message-State: AFuF++nadS8w3C1aaxZhmk/THJAy4t0VdDGIMpspMiDRpwIYiBbIZrtO
	D6eMbf7fzgE4mCo2RIH9LnyjufrOcdfyx4k+Fi4KpDT9GKdckHfV0hMfKGnmDSt/3JlQfbxCM7M
	T61hUaKZKHN0qzGRcllP4SWOgeYcNG96AC77swwUy
X-Gm-Gg: AR+sD10uRq+Qs4qlK2XBvh8MLrYjQlzI3ZZyEAN5HPGHkNL+BVg9/wvILgurHl+15C2
	71s8/7gXIsQ02KttB1+lDnyjpY9sKzmi0F3ex+leJECtLIl11SQmGuXCtgxtimQQe6BOPPeYG7r
	O7QTbcTeEU8ql/tSgvCkCq8FvD0eNNRKUPADtg8xn4RGnoP0gUlC2ZLTglIyjldwv0U+DrisorC
	5iMs9MyV1TtPHRTsonFeKr0lN5P+qtQrYMCVGZ94/Zd+KkZeotNm90rLuQeW/IqCjS/D/6nR3wy
	xGHSlfCsooqtewSu5rmrsdo3RK3D0ASz/BGcHn6mMVEbfw==
X-Received: by 2002:a05:622a:4c89:b0:52f:6e06:89ac with SMTP id
 d75a77b69052e-52fbc9cdef7mr8352721cf.13.1787894921905; Thu, 27 Aug 2026
 22:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527221934.3830896-1-ctshao@google.com> <20260528001117.3BBF11F00A3A@smtp.kernel.org>
 <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com> <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
In-Reply-To: <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Aug 2026 22:28:30 -0700
X-Gm-Features: AcwNN1VmxtjaqiJtU04BwRwhshiUh2oD2ByScKUOA-7C4gmoRH7Q6VHbWd_zlJU
Message-ID: <CAP-5=fVAckZihxg4djQn7iTGbNNT1vFLXt2En8mm8+COSs3GcQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
To: Chun-Tse Shao <ctshao@google.com>, Zide Chen <zide.chen@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 11:44=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Ping for attention.

I suspect Arnaldo and Namhyung are waiting for feedback from Intel on
these patches. If someone could check them it would be appreciated.

Thanks,
Ian

> Thanks,
> CT
>
> On Thu, May 28, 2026 at 2:31=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > On Wed, May 27, 2026 at 5:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > >
> > > Pre-existing issues:
> > > - [Critical] An integer overflow in `uncore_cha_snc()` can result in =
a negative Sub-NUMA Clustering (SNC) node index. This bypasses the upper-bo=
und check against `MAX_SNCS` and causes subsequent out-of-bounds array acce=
sses.
> > > --
> > >
> > > commit be394e8b7ddbe730c3fc40fb608337fe19c7b33b
> > > Author: Chun-Tse Shao <ctshao@google.com>
> > >
> > > perf pmu intel: Generalize SNC cpumask adjustment for multiple platfo=
rms
> > >
> > > This commit generalizes the Sub-NUMA Clustering (SNC) logic previousl=
y
> > > specific to Granite Rapids to support multiple Intel platforms. It us=
es
> > > CPUID to determine SNC support and caches various PMU configurations
> > > to improve thread safety.
> > >
> > > > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/u=
til/pmu.c
> > > > index 7c9d238922a6c..9b00d5720fb7a 100644
> > > > --- a/tools/perf/arch/x86/util/pmu.c
> > > > +++ b/tools/perf/arch/x86/util/pmu.c
> > >
> > > [ ... ]
> > >
> > > > @@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pm=
u)
> > > >               return 0;
> > > >       }
> > > >       chas_per_node =3D num_cha / snc_nodes;
> > > > +     if (chas_per_node =3D=3D 0) {
> > > > +             pr_warning("Unexpected: chas_per_node is 0 (num_cha=
=3D%d, snc_nodes=3D%d)\n",
> > > > +                        num_cha, snc_nodes);
> > > > +             return 0;
> > > > +     }
> > > >       cha_snc =3D cha_num / chas_per_node;
> > > >
> > > >       /* Range check cha_snc. for unexpected out of bounds. */
> > > >       return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;
> > >
> > > [Severity: Critical]
> > > This is a pre-existing issue, but does this range check safely handle=
 very
> > > large values for cha_num?
> > >
> > > Since cha_num is parsed as an unsigned int via sscanf() from the PMU =
name,
> > > and cha_snc is a signed int, a sufficiently large cha_num could cause=
 the
> > > division result to overflow into a negative value.
> >
> > I think it is very unlikely we would see cha_num > INT_MAX.
> > Since that is a pre-existing issue, I prefer to fix it separately.
> >
> > Thanks,
> > CT
> >
> > >
> > > If cha_snc becomes negative, the cha_snc >=3D MAX_SNCS check evaluate=
s to
> > > false, allowing the function to return a negative index.
> > >
> > > Could this negative index then cause out-of-bounds array accesses whe=
n used
> > > later in uncore_cha_imc_compute_cpu_adjust()?
> > >
> > > uncore_cha_imc_compute_cpu_adjust() {
> > >     static bool checked_cpu_adjust[MAX_SNCS];
> > >     ...
> > >     if (checked_cpu_adjust[pmu_snc])
> > >     ...
> > > }
> > >
> > > --
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026052722193=
4.3830896-1-ctshao@google.com?part=3D1
