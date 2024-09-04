Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B61E00A9
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467776; cv=none; b=shVuNGIQBR/1mqiVe0coO6ULy0QFLLNb40fFClPKrxED840R6UwYbvFfekbfW1MyO59EFDvA+xhGwP8vGncUtgOJ2sSFipbb/B19Fs5BHHnOgIFp03G72gb79OwE8UxkgrebjQND8jTtc9heR4GQ7qpgs04YFDxHJrQGgJMwbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467776; c=relaxed/simple;
	bh=L6XEXkNJRd4y6KXkIh4oL4wJKuij+lOT2rtj7cAEkw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7jFdNQjR1oGRY8gf/BFTcKJXuK6ZCWR2AHusi1AmIdOFsnn8TLpb8i3gtdDI4rzFQywqRxA6Sh09MApgQyOgDzByApc8vVjg6CinqDCS0Aadpdo/s9gcf8Hne635xm5yAnXd8zVXkJfOAhLfJ3rMFdiqVeaOJVENyDmkWYyVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFafO9gY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFafO9gY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20546b8e754so261555ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725467774; x=1726072574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27y3pr/AJ+flEZ8Byjy8LuimquCDi9sxoMTJ4wZPP5w=;
        b=uFafO9gYaXo1DFCzCfzXA4jME5Ohf39JmHp3SpkveXch5fR9+39bcAB9tRUnnBjvcc
         q1TR3AhbMpvUn3+PE0jQGtYKmAln5wCHQgQ15QlFoRtSobLMAKuwFBqu7knvdAgjJST9
         FL4n33OjiIMqivI/M63zqQ8+IlWGY+dr9Iel5RH3haVSjnsF7v8rnRjhDYRTHgZslOzd
         uLqff2P/azEtlZm7LyqskWnN+G1hgwDI1/FElGCII+AMF2vkk7055Od8TXAy36/bwdQL
         WpW4k+5ayr5YUa/aQRmcbU95GrICYpTB86V5Hwx8K5/AMN3GyVxGfjX+Kcvnml57/gGh
         SLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725467774; x=1726072574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27y3pr/AJ+flEZ8Byjy8LuimquCDi9sxoMTJ4wZPP5w=;
        b=QrsZzEiDYxu2DSPdxdlN69w+1j8Bwl79mPYC+mF7ABASQVoeZj+iNyNML32/QaooY9
         q/qMBD7Gq4AHfhtMX/igXp/ol1rVq0SVc+nY1sOHn6BmJxUJLeO/chNNg/eelz2Lc+8x
         pOmlb515oVr5MiNnCXeDTz9O8gq8JnPeLUWO0/710Lz3m2paIUKhZHnN2IPBp2lsTNZf
         4YOracZRnDSxUOioGTuYZYplXOlcR89FsWLiaW2hVfrAXytYUHnfUTtg/LpZXWgKKN9i
         Sj06ecvG2kFqY+5kZ9PQZyeatyyYEHj9/tH5B+acT6FinUO0YpBG+ZzhfSLwHZ20xfGr
         camw==
X-Forwarded-Encrypted: i=1; AJvYcCWvrk1ifZHoayQcIq16blhQNSV6uEdsXFiSYRrtlwsoq6Krqcgc0RfTaGSg4zR6LCPI/wZu+UT3Zid9VkzSWHo5@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAvriVH9JebdPClsnToD6ulpIFSzvr77h4klt/GSrGWc0LFIJ
	4a+FduVsl1TcL7qnDY1xjIZlbrb1B14NuHY57wsJptl6xCzcSx40OHe5i6kTIXCCGC1wcA+cAGK
	MRffKZw394RybGqTTFMxTB9enPaC6yt43RPj9
X-Google-Smtp-Source: AGHT+IFTp70FxkfaDqtFiVSMiVqkIMI0NuOieuMnCWS4sSzqRUxKc5Boc+7odICm2NuqZYLtBbyAuNRjLX9y854DU0U=
X-Received: by 2002:a17:902:d4ca:b0:206:ad19:c0fa with SMTP id
 d9443c01a7336-206b061c724mr4115145ad.0.1725467773561; Wed, 04 Sep 2024
 09:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904064131.2377873-1-namhyung@kernel.org>
In-Reply-To: <20240904064131.2377873-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Sep 2024 09:36:02 -0700
Message-ID: <CAP-5=fU5UeHER5hPAUhq_9_fSUR9okp_i0sOk_E7Q_aZkvo+DQ@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v2)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I found perf tools set exclude_guest bit inconsistently.  It used to
> set the bit but now the default event for perf record doesn't.  So I'm
> wondering why we want the bit in the first place.
>
> Actually it's not good for PMUs don't support any exclusion like AMD
> IBS because it disables new features after the exclude_guest due to
> the missing feature detection logic.

I think trying to clean this up is good but there's a wac-a-moie
problem whenever a default or fallback is changed - it can break a
hard to test platform in unthought of ways. I wonder if we can expand
PMU testing to at least capture the differences in behavior. For
example, pick an event that works, like legacy cycles, then increase
the precision to 3 and the event should either open again or fail with
EINVAL, if it opens then it should count. Similarly for the exclude_*
bits. I think some PMUs don't behave like they should and we can add
ifs to the test to capture these behaviours - for example an
exclude_.. is accepted for an event but then the event doesn't count
if the bit is set. There are many cases where a large group of events
will cause the group to stop counting, in metrics we work around this
with grouping flags for the metric:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/pmu-events.h?h=3Dperf-tools-next#n16
but these shouldn't be necessary as the PMU kernel driver should
reject the perf_event_open.

Thanks,
Ian

> v2 changes)
>  * update the missing feature detection logic
>  * separate exclude_hv fallback
>  * add new fallback for exclude_guest
>
> v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel=
.org/
>
> AFAIK it doesn't matter for the most cases but perf kvm.  If users
> need to set the bit, they can still use :H modifier.  For vPMU pass-
> through or Apple M1, it'd add the exclude_guest during the fallback
> logic.  Please let me know if it's ok for you.
>
> The code is available at 'perf/exclude-v2' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (8):
>   perf tools: Don't set attr.exclude_guest by default
>   perf tools: Simplify evsel__add_modifier()
>   perf stat: Add --exclude-guest option
>   perf tools: Do not set exclude_guest for precise_ip
>   perf tools: Detect missing kernel features properly
>   perf tools: Separate exclude_hv fallback
>   perf tools: Add fallback for exclude_guest
>   perf tools: Check fallback error and order
>
>  tools/perf/Documentation/perf-stat.txt      |   7 +
>  tools/perf/builtin-kvm.c                    |   1 +
>  tools/perf/builtin-stat.c                   |   2 +
>  tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
>  tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
>  tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
>  tools/perf/tests/parse-events.c             |  30 +-
>  tools/perf/util/evsel.c                     | 393 ++++++++++++++------
>  tools/perf/util/evsel.h                     |   1 -
>  tools/perf/util/parse-events.c              |   6 +-
>  tools/perf/util/util.c                      |  10 +-
>  tools/perf/util/util.h                      |   3 +
>  12 files changed, 322 insertions(+), 137 deletions(-)
>
> --
> 2.46.0.469.g59c65b2a67-goog
>
