Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F424C067
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945947; cv=none; b=rrRlD787ZHzufioCaLLtfIRl13PvRhrhBOXpTg8YeiHC9fRWIUb62m2r7YG236SJ9XE0kRDFVg5/6olFLkTbvaDzRAIhJ2KOlH4yrwGYuUc89kjZWiVALk0FaLKFD4Q7Axjxx2LHmumKfhd0C0uHpFUDgbqJCoHtOCWMVn+u+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945947; c=relaxed/simple;
	bh=W/4zpcUVilN5uIQEY4rs28RgSKNIxSITgSABsCrtPEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AobiGL7JIuIceE9HuCxG5uiEq7ovp6j2maJFbuh0eLM6b+nqGL7RP5FzOTpHMAsJBcJiz+zu+l7cYxYueVjCsBi43h5rd7x3Fq8G6ZI6g4szFu23Xzf3pqvdOy0zFNahTJKm0FGa7NrfpVmBDHmqHmvci4XLihdLKH7d9agFZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKvAah0q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKvAah0q"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so10951569a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745945944; x=1746550744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn+5ZgmCVf2M5vltNK1wOsGuf2phvT5CTFIIIiCVMc0=;
        b=ZKvAah0qmtK9g93FubxjU+IL3KCB5p69oVL+n68GJfQQuIlhm3hB60sG50XyqsZrF7
         5c1GHpIS/wbUlvTvyue1HNfHI7qYLy9t3QXUpnVMcbhXXyoewjFCeSAmnitoKAhNVW7p
         vJi3LkxFp8TDpmLJYq427mj/1bZy4yCMKYjZX4mghwi7OyhpAj52OzOOAJu9I3IkdxHQ
         Rz7O326duywBtix00Etx3tReUQzecMUVxWKf0IdrFZHvzbB9lSU4wkttVJ/bkFd0UdZf
         9b2X/VAeJknbBon2wtWDoCsAvciO8wAI/iXCxwYycvlxXZXlZNspQaEcQ6HFnyGEaIH4
         W0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745945944; x=1746550744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn+5ZgmCVf2M5vltNK1wOsGuf2phvT5CTFIIIiCVMc0=;
        b=me2svhQBgco9xeWi4Xpch7Se4Cb+X/p6Yay2sCii6qhwLYDygR6qGscyht132U4Luc
         U7QzZyfn6bsNqegRugYUu7n6HaS5t1x6HcwPbcqltxzne76zyzMQSuQHpVPIMgBfgfff
         ubIacY1QE/pheq7IGTKZajusT/ekSRXnxGoKRkDXZr4UIEXOKRTcO5Xp1f55kKTHSBy0
         HDO4oBJTbrerzrICREM11nd3yIT6drCLMXMaVZ6MpjqNWKhkHgn79gHcVmDAAFhKRNf0
         zayOwImJXJ5QbM+qOANdXoPbRpcWE6/GRa2/f9Wkm5cQyKYJbom8ACYp1TUn/d/1JXhO
         trdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsnRMP7mD8Z1WRHU8rtkWj8DdVG4Pr8FqlSRw9g3JmpLyfYrDTjlfiUPlR0uvID7fHpfMmLS9lxJzDrnSv6R+r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UOMN+wz9ktGrrMmsvuDmrzvzvN/7RQW+KxN087A8JOimROMX
	l6ExzZJVoisVPOrlqQ/WxL2PNeFEbXKJUurndP3W8CvxnTqCKaIoLftj1zwSDPYWZkOPBCdWRTu
	F58XYA/5TcFbeWCzs3048r14ostMvr7gsLcNK
X-Gm-Gg: ASbGncsPNxk8F5MNdGUdiq3692NvnxuBgF3jI534Kry3ZTQY4/y5PfDywg0C7a1zpdH
	wMyFFQmotO4BDNJXlufh3FGIAbGsA2Gu1Sqh69SuqdIwUZ97fc0YOE98mtsuHb2cYofRRy9uAt1
	zccfpotEoMjjC36xXcvfjIsNZX5C3/YjN7MfyIT2UFrPfWdDoGYUry31lyL+a9
X-Google-Smtp-Source: AGHT+IHlYsGdt+lKsFw09PJNfhuQhzmhzMRAuDq59dV5aojdMEnYbfZBvnVPEapBVjly9gvEwhgKl1oMPwAAc+ZlJRE=
X-Received: by 2002:a17:907:94d1:b0:ac7:95b3:fbe2 with SMTP id
 a640c23a62f3a-acedc767e1fmr8597466b.56.1745945944207; Tue, 29 Apr 2025
 09:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com> <CAP-5=fWv4=8Uq8jDbqNR3O+JAw-T0OUGoj5o=pMHxyFKsbEDyw@mail.gmail.com>
In-Reply-To: <CAP-5=fWv4=8Uq8jDbqNR3O+JAw-T0OUGoj5o=pMHxyFKsbEDyw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 29 Apr 2025 09:58:52 -0700
X-Gm-Features: ATxdqUHUP32Wbv51hq_UWyC165E5uyVyyGJjwTBzdrWCa2_ytyIaLVOfds3bh-8
Message-ID: <CAJpZYjUWSkoXhoZDvLwgJcWqJvXAi8AmDmvsehJEJS6WOczF4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix incorrect counts when count the same uncore
 event multiple times
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	yeoreum.yun@arm.com, linux@treblig.org, ak@linux.intel.com, 
	weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Thanks,
CT

On Thu, Mar 27, 2025 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 27, 2025 at 3:56=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Let's take a look an example, the machine is SKX with 6 IMC devices.
> >
> >   perf stat -e clockticks,clockticks -I 1000
> >   #           time             counts unit events
> >        1.001127430      6,901,503,174      uncore_imc_0/clockticks/
> >        1.001127430      3,940,896,301      uncore_imc_0/clockticks/
> >        2.002649722        988,376,876      uncore_imc_0/clockticks/
> >        2.002649722        988,376,141      uncore_imc_0/clockticks/
> >        3.004071319      1,000,292,675      uncore_imc_0/clockticks/
> >        3.004071319      1,000,294,160      uncore_imc_0/clockticks/
> >
> > 1) The events name should not be uniquified.
> > 2) The initial count for the first `clockticks` is doubled.
> > 3) Subsequent count only report for the first IMC device.
> >
> > The first patch fixes 1) and 3), and the second patch fixes 2).
> >
> > After these fix:
> >
> >   perf stat -e clockticks,clockticks -I 1000
> >   #           time             counts unit events
> >        1.001127586      4,126,938,857      clockticks
> >        1.001127586      4,121,564,277      clockticks
> >        2.001686014      3,953,806,350      clockticks
> >        2.001686014      3,953,809,541      clockticks
> >        3.003121403      4,137,750,252      clockticks
> >        3.003121403      4,137,749,048      clockticks
> >
> > I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
> > looks good.
> >
> > Ian tested `hybrid-merge` and `hwmon`, all looks good as well.
> >
> > Chun-Tse Shao (1):
> >   perf test: Add stat uniquifying test
> >
> > Ian Rogers (2):
> >   perf evlist: Make uniquifying counter names consistent
> >   perf parse-events: Use wildcard processing to set an event to merge
> >     into
>
> Tested-by: Ian Rogers <irogers@google.com>
>
> There could be minor conflict with this unreviewed series:
> https://lore.kernel.org/lkml/20250318041442.321230-1-irogers@google.com/
>
> Thanks,
> Ian
>
> >  tools/perf/builtin-record.c                   |   7 +-
> >  tools/perf/builtin-top.c                      |   7 +-
> >  .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
> >  tools/perf/util/evlist.c                      |  66 +++++---
> >  tools/perf/util/evlist.h                      |   3 +-
> >  tools/perf/util/evsel.c                       | 119 ++++++++++++-
> >  tools/perf/util/evsel.h                       |  11 +-
> >  tools/perf/util/parse-events.c                |  86 +++++++---
> >  tools/perf/util/stat-display.c                | 160 ++----------------
> >  tools/perf/util/stat.c                        |  40 +----
> >  10 files changed, 329 insertions(+), 239 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
> >
> > --
> > v2:
> >   - Fixes for `hwmon` and `--hybrid-merge`.
> >   - Add a test for event uniquifying.
> >
> > v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com
> > 2.49.0.472.ge94155a9ec-goog
> >
