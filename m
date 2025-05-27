Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCC1FCFF8
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378938; cv=none; b=q72RVUBbGYTfGZUqcEJ6JGBvdYTylnpeFaHKJVXxbmoVkpLJCGxSo2qcpwy9mmr93g8+YbxuOGUARzUnE2+kie14sOcarnViq0+m8HRSwCNsG49Nru4McQiu6l41CPjjD7Y+ZH4roQFLwAdwjBjTJSkqc3bKosRjGMidSJYm0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378938; c=relaxed/simple;
	bh=4XSwv2yKYu7R/w0hRhHlVyPwuKeq/p0kjgWu4s7+K7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PDX8zjYD/6b97iU6ibV15iULgLhKKyDmdE4cECOxJW9wqO8XM43IMv8uark0NaS3T3Ghpn9hbmVRYUafAVOTJM++28zgQVFL1XghqDqCsxoZyGXkUCc2Paz57WDQ8E1+p0U6ymYegFEnZG495mFQH+3Ro1GoeYsHRS+REI3Lsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7gqfDUL; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7gqfDUL"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dd745f8839so41545ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748378936; x=1748983736; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B4n5IVDUO4XVpcVPmHvo87l1OyobNo0J1FJgWaZLOc=;
        b=u7gqfDUL8Q19OZCcBnIn+gZ9bjmxY/qYNPHHanPTnz/DxsvIYJWFjn2haPpl0sfwm2
         ob4OEDrbdyuSgNnC8uRJVMncUVIrZ41aefhzrIOZoUzwSDEq4pkpAOYcnqsArO4xIhYL
         rY0bhQbWSutGVEWtEWab+KihFetvD/CUtFPlju6ZG07goWFc95e/13gD2m4qDBdugKPq
         mZe158CUESlQYAOoSjCYOVozrlf6doo4LxM8/dL2e8uIr2YxB4jAOrlAA4CXt/EMwgiG
         XEAn7xXit3N7MV7UAsSkUW/dagtwPYgRglc8ntWk/9FHhSclB+AjpOYdLcjJCDd5nIC+
         eapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378936; x=1748983736;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B4n5IVDUO4XVpcVPmHvo87l1OyobNo0J1FJgWaZLOc=;
        b=EdXTCIGEkDhXfQ+v4qS19cJS1cJ61B9vvsrPqB2cZbAC2xqB4AA+w3m+UsCxkHy6RH
         kTyuogA7bi3TEqKsw0pk+frH4gE3dF7Q9olaQ1SjMhqQkXElnjwnB0tkpSfxy+45ijKQ
         lr2/axlyipLnCcgmwK/BC2D5mXMnl/P7GRJV/EA9OEdXZrIlfUujmfmDtpiuHQK2hbXA
         EP9VrQlCa1EG3wc1tP1VVPxSyNEhwcT+JzztR/GX7rTxvnLTgewq9Z/7c9Sdk6Dz1/uJ
         Gegfw6qeHy2LLpqmrwk7XzGpQJUJhR9Madh544uEAKkC/GgYbC+oGbt7wF4vgZ0OQm9F
         tU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz8biWSKntg52LtchEt1/8SrgVyGivL2eDPkhgl7lMrl3Jis1jyVUhwoYRNct9gyfOYrlFgl1yw3PZkN4ZmpS2@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDogM+z9NuAFOk+t4QJNIf48qS/wUNJdgEmpSWwea5g/mT98W
	VA0xr3axM+lqmvzjwvTqfO3NDM6LfWVr0hcsWZsZsKaRRcvUySLt8timSME0PjAfE+IjV9rZSR2
	aWIQWKtpgbRpwN7J674UD2fnpGYzdwsXbGBDd5s+z
X-Gm-Gg: ASbGnctn1HSCwFS8a3A9gomwvpPlCviL/pGAjfHAbGOHC8IyYjiv8n6sudBkr/EIpT0
	7NnnAN83XkWVuourg6WWMf0hiM8aLfSvQcESF99aotY/Yqw381NMWoiRGtFbc7XC7cLQH5lr4yC
	qNzlUR2DCaHXvxbHcqXtyBZbRSb0/5Wqq2AD0U93ReEeUUDRRBFyOFs9PrMPYBnA8zWJZ1gh45
X-Google-Smtp-Source: AGHT+IFv3brN5hRLvSILTphcAkHHrz5Re777B6ZMLWKC/iJbQcm7Lyl+kiibW4DspFIYm5qMig57OufYs0XIU3DiMQg=
X-Received: by 2002:a05:6e02:1544:b0:3dc:5cb1:8f24 with SMTP id
 e9e14a558f8ab-3dd89c51cd1mr205295ab.9.1748378935727; Tue, 27 May 2025
 13:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com>
In-Reply-To: <20250428213409.1417584-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:48:43 -0700
X-Gm-Features: AX0GCFtffY6-oR3vQzViXR5IGtBkGRIu7tvuSZ_wxK33JWK-i0gC42dhBzQBYvk
Message-ID: <CAP-5=fVy6J+d1aoQwv6TMuybXWAhpeaJOvMmr3-jbsz5ig66kg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] perf: Default use of build IDs and improvements
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 2:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Build ID mmap2 events have been available since Linux v5.12 and avoid
> certain races. Enable these by default as discussed in:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfXP7jN_QrGUcd55_QH5J-Y-F=
CaJ6=3DNaHVtyx0oyNh8_-Q@mail.gmail.com/
>
> The dso_id is used to indentify a DSO that may change by being
> overwritten. The inode generation isn't present in /proc/pid/maps and
> so was already only optionally filled in. With build ID mmap events
> the other major, minor and inode varialbes aren't filled in. Change
> the dso_id implementation to make optional values explicit, rather
> than injecting a dso_id we want to improve it during find operations,
> add the buildid to the dso_id for sorting and so that matching fails
> when build IDs vary between DSOs.
>
> Mark the callchain for buildids and not just the sample IP, fixing
> missing DSOs.
>
> Fix sample__for_each_callchain_node to populate the map even when
> symbols aren't computed.
>
> Other minor bits of build_id clean up.
>
> v3: Ensure the struct build_id is initialized empty prior to use as
>     read paths may fail (Namhyung).
>
> v2: Make marking DSOs still the default even with the defaulted build
>     ID mmap. The command line option still disables this to avoid
>     regressions. Add callchain patches and jitdump fix.

Ping. Thanks,
Ian

> Ian Rogers (9):
>   perf callchain: Always populate the addr_location map when adding IP
>   perf build-id: Reduce size of "size" variable
>   perf build-id: Truncate to avoid overflowing the build_id data
>   perf build-id: Change sprintf functions to snprintf
>   perf build-id: Mark DSO in sample callchains
>   perf build-id: Ensure struct build_id is empty before use
>   perf dso: Move build_id to dso_id
>   perf jitdump: Directly mark the jitdump DSO
>   perf record: Make --buildid-mmap the default
>
>  tools/perf/bench/inject-buildid.c             |   2 +-
>  tools/perf/builtin-buildid-cache.c            |  20 ++--
>  tools/perf/builtin-buildid-list.c             |   6 +-
>  tools/perf/builtin-inject.c                   |  36 +++---
>  tools/perf/builtin-record.c                   |  33 ++++--
>  tools/perf/builtin-report.c                   |  11 +-
>  tools/perf/include/perf/perf_dlfilter.h       |   2 +-
>  tools/perf/tests/pe-file-parsing.c            |   2 +-
>  tools/perf/tests/sdt.c                        |   2 +-
>  tools/perf/tests/symbols.c                    |   4 +-
>  tools/perf/util/build-id.c                    |  63 ++++++----
>  tools/perf/util/build-id.h                    |   8 +-
>  tools/perf/util/debuginfo.c                   |   2 +-
>  tools/perf/util/disasm.c                      |   2 +-
>  tools/perf/util/dso.c                         | 111 ++++++++++--------
>  tools/perf/util/dso.h                         |  75 ++++++------
>  tools/perf/util/dsos.c                        |  20 ++--
>  tools/perf/util/event.c                       |   2 +-
>  tools/perf/util/header.c                      |   2 +-
>  tools/perf/util/jitdump.c                     |  21 +++-
>  tools/perf/util/machine.c                     |  34 +++---
>  tools/perf/util/map.c                         |  15 ++-
>  tools/perf/util/map.h                         |   5 +-
>  tools/perf/util/probe-event.c                 |   3 +-
>  tools/perf/util/probe-file.c                  |   4 +-
>  tools/perf/util/probe-finder.c                |   3 +-
>  .../scripting-engines/trace-event-python.c    |   7 +-
>  tools/perf/util/sort.c                        |  27 +++--
>  tools/perf/util/symbol-minimal.c              |   2 +-
>  tools/perf/util/symbol.c                      |   7 +-
>  tools/perf/util/symbol_conf.h                 |   2 +-
>  tools/perf/util/synthetic-events.c            |  44 ++++---
>  tools/perf/util/thread.c                      |   8 +-
>  tools/perf/util/thread.h                      |   2 +-
>  34 files changed, 337 insertions(+), 250 deletions(-)
>
> --
> 2.49.0.901.g37484f566f-goog
>
