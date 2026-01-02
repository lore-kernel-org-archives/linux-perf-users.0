Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA023EAB2
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367603; cv=pass; b=gImqxKvJALn2fgDe0systVsLaZFqzBD77Z2jCpkZHWMkSj1qWxHyx+q+hqtGIkD5spe/U0NZvAyW8S22bgyTrIlirXf3o1YX4+osQRWWysiQZrKsGOCnQPTyOLigTRuTcjWSa+k5jO7TpFRzQbuGrx1pWpLMc7GzT2wnmInuww4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367603; c=relaxed/simple;
	bh=Ns46H+wOPb7rzfATKl0oyBKOfdY5LopQu7nvcAFe+Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TTGQAaJ6KizIMShNTNuNmaPQZOgnDtDSFLnxz+C4NwCp2x0VPxiELHdW55qIwWpg3+oMJuhWE+X5PmD/XkYXio34Z3Eo5doVpGwMjeIWxQaqVqU1yymxpvJNy9V/4QLCBw3QM2rHIjb3A4gmK+Q5lq9+U0oOmfDh6RE/84DJ5mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FspvpTvH; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FspvpTvH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f02651fccso341265ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jan 2026 07:26:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767367601; cv=none;
        d=google.com; s=arc-20240605;
        b=PZfrahQfoa2j70Au8erq89s6d4d/BD48buP9gFbU2tlCdYufEKzRGR9Pa8z2eRQnd7
         n6ORU5/cuNBMrsKx9wv/UgoDj8EC6gdWco01a5xG/Gshsdd0HR7g9pALOw1ZedjsK4Jf
         nptShDa5alnVxkXu40Wcv/YyrAw7utLo/EVGV5F/lOBtVAyJtKLQfY+bQxevAZFO6H4j
         fMQFpRx0fcmtf6mIX5UwxGKEaWf3m+VLRpDBWhccDfXKqe4kRj/9YaOLcc7HWiyj+9Fy
         Jb03QL2KRQ8wZCfGdM0hRr6Runyf4lW7kbV+JyDZZG9BdzmjKxBams2wg+IRCrid54PG
         06dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KYF7wqZrysg/0UlMLYfdnApkPDSv9xM4Mak/A0rFhXg=;
        fh=VehshbIhybdqQMkDdmSWtXkpw1wDj1J2twT5Q8Oi0Vo=;
        b=DFFif93QySidiQib7Bb9qp0ZXzFeyqskEbGqBRJ6IXpbqlCJ/Rhc76JjTdZefVmXzP
         YKquSSwvE8FZvDZOZQvwtkvwrSun22b2JURfbSKEFjrA/19jmIgcoGP1vm2xnfFqcLQk
         nlWWwwsE6fjjve2F7GujHkYy/3Y4UnXKd+rIJNpzCemWtYdt6j6E5bmNqlrIsXupCoLa
         u6xbi2m7iEdWU9rbuGiR/yZFGAuTZUHtLGVmH1l/45WJrnLbzyCQ15Gm65YGaXrJf/hJ
         6lfI93fOWwdYFNZ60IVEJh7jP+1x4gyi9YSxn1wIu1RE7jPgvvD8s5kg1LC4rZhCnk4S
         UV5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767367601; x=1767972401; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYF7wqZrysg/0UlMLYfdnApkPDSv9xM4Mak/A0rFhXg=;
        b=FspvpTvHp0y8zdepke0YHomLvYimCTj46guh2Wxo7luzpGiROz/OPlATL2Wbqh9kto
         0Qu/pwSp4BPvMq7FnKXr0s81Vo7CIge9n0ThNztg/P//FDPmKMAsJ3q6BIEDyMns5FVY
         WXS7Pyz9J7HYgIp4vrFN+/JrlqKJZLY4eSUU8yq7Ai07dfsRtwqpAd1iG9ClTv2lpFkK
         /jdydUP3YD6tS2jTrBIgT95jKPdqOjUc8hUxcqx9hBd5FdzJx+eKL/LIHpz/dgcyJxYR
         aeWgo/pmIUt5BsKEthp+vG92q+noJqBxfEFoOzPK3p1Xix1hybABjyDteSHt0/+Ydo59
         1dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367601; x=1767972401;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KYF7wqZrysg/0UlMLYfdnApkPDSv9xM4Mak/A0rFhXg=;
        b=MgApF6zPRTHgn8A7V2bjAdj6amSjM/La2TjRjwHlP1L3zApOi3E7BXtR/XJXsXSKpL
         icTAAxETFLibvEnT8W9BYz620OSHNfIQZ8ZL1G64LknlFPG/E1nWE82/rEr2N6q7VFFZ
         AXu6dhWOFSSme6RjvqQ6STzTeknDBY94f+OINY9EvqG6AniOPZu3Qdwl8mvkGZsZWZoM
         8xFT+o3G8FK7EPAH8JG9QuYvuipiOHHJfr35ekCEN7sREXZIGTVPCpamiC4mR0jFBi8b
         oIzbiwr62DKf93SjAVefL2aUX7imqup6O8T03ZufGP/SRYss3iEfjj6+DQeODvf6Lbw5
         zVRw==
X-Forwarded-Encrypted: i=1; AJvYcCXTAgb99n7+QUFXDkBkTwMXzDP97KTiQPmhWhEOw60N9OfPL9E+pUGDRG9ruM3EG1XZs3mk55Sq4NXMUM+kN+v/@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0QciPtrVVOv9nCXQOKgCZDDhbxRix59WEhq4Av7+Ld5s8vzk
	Np5MqCOvO+w3XqExF9SziJjO9cIknKlnUUZnCq/aC4pkQUzELxw+JttBhdshSTquc/Mul+lHVt0
	XWfSE29TKpsX4lcFnb5fRrbOq2vDpDa0Nap1kVu3Y
X-Gm-Gg: AY/fxX5ZOPQShdO3XOUrreiSZRPnbBtjFwglBST+2zkokfVt6o6+VjVrTb+Hl59Ebr7
	rBRkLKA5i7P62kAmYPah00PMj3EMUpzMhDPpx3aSwkZrRbsY2D93oa9vltbnE0Al7XrbPTxf2Lo
	z3efPvlSwCk6GSzsPSwr6dtoNroEhuhHoS+4EzLQaDAezb/giMD4NjhMm0kPHbL2Q4IGDVTqBF2
	ybkcAyE2LeRdGk6c6+eO9OL4ecIuOm2rag4klSEEPLZuMQngoUfX4aMjjyoh0UFMTk4CgEq
X-Google-Smtp-Source: AGHT+IF85pwv4OCQlzxVXlMryt0brG7blCJ6Cs7yYrDymGieZo+/wGLtsVTitbRIcacgFZ7X0OFolHrtcJSnlGyOBug=
X-Received: by 2002:a17:902:ebc3:b0:298:45b1:6ef4 with SMTP id
 d9443c01a7336-2a3a3af13b7mr4063675ad.12.1767367600524; Fri, 02 Jan 2026
 07:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118211326.1840989-1-irogers@google.com>
In-Reply-To: <20251118211326.1840989-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Jan 2026 07:26:29 -0800
X-Gm-Features: AQt7F2p70pUha0L-utd0Zus7R8D8B8gN0sZ_k48dpj3GkUG0aURY7ciCmLMG4RU
Message-ID: <CAP-5=fXk=zaqgfqWQtJGyKj=6+14ZsxxsQra+eax4DzvKD2qeg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf stat affinity changes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:13=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The remnants of:
> https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
>
> Read tool events last so that counts shouldn't exceed theoretic
> maximums.
>
> Change how affinities work with evlist__for_each_cpu. Move the
> affinity code into the iterator to simplify setting it up. Detect when
> affinities will and won't be profitable, for example a tool event and
> a regular perf event (or read group) may face less delay from a single
> IPI for the event read than from a call to sched_setaffinity. Add a
>  --no-affinity flag to perf stat to allow affinities to be disabled.

Ping.

Thanks,
Ian

> v5: Drop merged changes. Move tool event reading to first
>     patch. Change --no-affinity flag to --affinity/--no-affinity flag.
>
> v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
>     the legacy metric code is no more. Minor tweak to the ru_stats
>     clean up.
> https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
>
> v3: Add affinity clean ups and read tool events last.
> https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/
>
> v2: Fixed an aggregation index issue:
> https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/
>
> v1:
> https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/
>
> Ian Rogers (3):
>   perf stat: Read tool events last
>   perf evlist: Reduce affinity use and move into iterator, fix no
>     affinity
>   perf stat: Add no-affinity flag
>
>  tools/perf/Documentation/perf-stat.txt |   4 +
>  tools/perf/builtin-stat.c              | 159 ++++++++++++++-----------
>  tools/perf/util/evlist.c               | 156 ++++++++++++++----------
>  tools/perf/util/evlist.h               |  27 +++--
>  tools/perf/util/pmu.c                  |  12 ++
>  tools/perf/util/pmu.h                  |   1 +
>  6 files changed, 222 insertions(+), 137 deletions(-)
>
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
