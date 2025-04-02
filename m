Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C0155382
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631034; cv=none; b=bbBRaCLjT4b2A9MJSEeRcf7oHg78fWWoREi/OC8KI3k9KLipVjDa0LkKKF6kO0DPvNGgU84WlFN3QIQ+bitdSJIqqfu3TLJHNUdgR+/A9dXuZUtkS8OP/1M98qvfdNLbYx67JrJ8HDHpX5KopgrJR2UiKA9YVdOv0tNo0Dq/WJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631034; c=relaxed/simple;
	bh=sZgJaFM/GPh2oWYGpowCLzvx3H4iO+SVj2cRVqudPM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P7bsiBnk2Pg08Q9X1Zn/XyzP/vK2i0NLOahvp2VGxE7qwdEinYpIxFbqLsbsxAIDjTpnaBI+hqHl537xBTbYqkj7KHxa7x+L7aX2rCJgsdxUWaMHBBYC1KfL8lKP4zOUcC546+UIKmCMti7ElLf2v/eoMUB2LhO3TGpFtVLduS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcVUN/8E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcVUN/8E"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264c9d0295so315345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743631032; x=1744235832; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM+jWPv3K/nQ3Kg9TjMXv9TDh1L/e0CE47ZwZvq6Tz4=;
        b=dcVUN/8ERLw9QPPeW3py0f6mwyzOzVVlt4IrnJ4l0MUHkaYEY0hMf3bzWuWvqj5vxf
         w3UaukXNRPw/MDEejiy90u9tWWKELc7yETD2N5a6buLHHnr5nLYOsmg5Kmcsik0UMi6q
         /SappQOJ0Z8Jqjkj+NKlf0rt1OTHu/gsOBeITKUWIMq+6c4gZ3agKXlh2IU0TCah1hrl
         uavPGxKWXcduCR8lxk+ZnNrPyZJkSgeCz3UPpj0Vp9Wn81D7B/rn4efJYJt4xbEZ5MTr
         oAo6BzN1K+8Ct1sP/Nz+CqqOZ2ocNvmKOaNi6OWjOaoy6klhY/65B5D3hSCkIO8X/HZw
         VHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743631032; x=1744235832;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM+jWPv3K/nQ3Kg9TjMXv9TDh1L/e0CE47ZwZvq6Tz4=;
        b=PdbLSBuJtpoL/5L9WQZnJEKsYKR6HpBxOJIXZaoreRs/x5LvqLSIa+acLceWdv9HN7
         AALWTMFPW2QtY83JlfC4gf5NytgvJlOp+gwHsQm979LYOJ6AJmJO8JJoCDXBRSqirrs0
         +PM1iT3E11Xm+qtWB9hFxO5Ogg008seeRIciLwegqlFzkCBpC3sXSNX31oRiGPX5rDdJ
         a3TuL5jT+pGuVNeoyd/GWzWCVJdjIPbp+2uRZcN7u/+DN3UmSdoAWfrTB0JFKk1hTMSl
         1Q1s2v0iTBJHLphxR6oAqqI9U734PhmuWVr8rwj78PxB2l+/NVHCKA/4edvpGO49mQ3x
         F0yw==
X-Forwarded-Encrypted: i=1; AJvYcCVSNSsBnRTYju1t5XxCH04MEBYtqPeoCK6fg7Zbyf3B6VWfj+9hX1ko7pZ/ZVLaW4az6OIyGq782bevl2W6yo5x@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUcOhllRL4cYEXndrcB/WcOA9Ds+Sk1Ml2rNtmgxzhz2TqXb1
	CqJf2IQtlayo8jdG4wKrR1Au0vh8esXO1stfW0uQFVfA3ZNYps4fanEADZMJlkDzJHa8wiR2OXx
	SV9LsPjYWPPIPvFfeptwGQIHFTMSJm1hQrkY8
X-Gm-Gg: ASbGnctj7x9t9zusCGV3JVNzGsZPzldmDC5p2oKSU4gYO0JiZ2T+JKc8H045ULGAAQI
	FDpG93o7QLDn/d7k8ZbvuxRiyFb7XdrJL4GydjBSSKxkLW8R8hwOkQ77zYZ8DRaTehuG6qsoRuo
	9AMZiJfpzFTyVzMujUbSmeq70osztHip6pR82H93guh9MhZ+mZGtkJ
X-Google-Smtp-Source: AGHT+IE92yLS2/+wWqwy+hrbq/Bh0anK7D+XCgmIjXlBWutUA0gRV5fpkslAccNPdlX4RoPmf+df/LPNM+h6N9E9QiA=
X-Received: by 2002:a17:902:d4cb:b0:212:26e:1b46 with SMTP id
 d9443c01a7336-22978360b83mr313565ad.23.1743631032305; Wed, 02 Apr 2025
 14:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com> <CAP-5=fVH=HN0csS6cXLPAYdk7Vn-g8FSdKWkaHcjfYKRA1o1Ag@mail.gmail.com>
In-Reply-To: <CAP-5=fVH=HN0csS6cXLPAYdk7Vn-g8FSdKWkaHcjfYKRA1o1Ag@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Apr 2025 14:57:01 -0700
X-Gm-Features: AQ5f1Jq5oNxocL07Mtb5IgaU2Z7YnKdJ71A4Y8TJl5HHO52uIhvurX3QuDcsvNI
Message-ID: <CAP-5=fW1cJRnU73udpXC9ayN8j-cAyjJK_ZOp97Z=LsagQcevg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support for cpu event term
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:22=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Feb 10, 2025 at 10:38=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Being able to set the cpu mask per event was discussed in the context
> > of a sysfs event.cpus file is discussed here:
> > https://lore.kernel.org/lkml/CAP-5=3DfXXuWchzUK0n5KTH8kamr=3DDQoEni+bUo=
o8f-4j8Y+eMBg@mail.gmail.com/
> > Ultimately Kan preferred to have multiple PMUs with a cpumask each
> > rather than an event.cpus file per event. It is still useful to have
> > the cpu event term and so the sysfs part of the original patch series
> > is dropped.
> >
> > v5: Purely a rebase.
> > v4: Add the stat-display output change for zero counters Namhyung
> >     requested as part of the series:
> >     https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
> >     This skips zero values for CPUs not in the evsel's cpumask rather
> >     than the evsel's PMU's cpumask.
> > v3: Drop sysfs event.cpus file support patch from series.  Reference
> >     to using cpu to modify uncore events is dropped from the commit
> >     message. Reference counting issues on the cpumap are addressed.
> > v2: Add support for multiple cpu terms on an event that are
> >     merged. For example, an event of "l1d-misses/cpu=3D4,cpu=3D5/" will
> >     now be opened on both CPU 4 and 5 rather than just CPU 4.
> >
> > Ian Rogers (4):
> >   libperf cpumap: Add ability to create CPU from a single CPU number
> >   perf stat: Use counter cpumask to skip zero values
> >   perf parse-events: Set is_pmu_core for legacy hardware events
> >   perf parse-events: Add "cpu" term to set the CPU an event is recorded
>
> Ping.

Ping.

Thanks,
Ian

> Thanks,
> Ian
