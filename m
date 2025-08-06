Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFA43AA1;
	Wed,  6 Aug 2025 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450132; cv=none; b=gskWVqPYdExK03oe9N3UNGnfETiDxqYMAgJF+uho866LF7xo0BEcVAjQnWF86KYA+OK11Qsn2zxy3oRisGXsik1qlFAVUDmYnrnR+m68eL+Afns7ebwB6KHZgLxSyBCe1z6fYUAHnk/MvdQmczrrsstqUCLTLxz/X8iVPRCdKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450132; c=relaxed/simple;
	bh=NKdCNHb108qQnd1QGnALnGQH9ylkt35GdQv1IAtTR20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZxonVSzYVybuPXkbs7sik5EIWjDYyxVMOfAxmRHid+9tRmLtjJGOgU+9MtIdSAkiUr50vY/BsnVuFwQmt+YKer5TfAuFOIUQo5n48c1DRGTPDLpvKbudgfup7P59Q9YUYTpGSknZ/SkuejqYcCv6mO+ZxhsEcVEja7DkT4Z0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWjT5QIM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWjT5QIM"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71b73225060so52976917b3.3;
        Tue, 05 Aug 2025 20:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754450127; x=1755054927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep9VdFX0YAfEIDgF8SIP6REhyb3v3cmA/i5zA1fUvKE=;
        b=KWjT5QIM3Flxi5TvUEO6njQfCIUZfXfshSHyTHYtKh3wD5vlfP0lcKDLZ78nRD/6rw
         fQ78UnRbCD5uftxHwlABfnr+0e/9RETrH7WK80QpRRGjj/ESg3CMp6L9EDxPsLlFzntl
         YofHp9IFpr9a0ZB7OVD9rKxfVO72IVIlZ6pRHK8C4PrgJCZ0Dn0lu2gOvLcHMWLP7H8b
         MwfzUitnERTtTlNaljNqn1ppg8QJGkwBN8s5Vb3Few4LG6C2eNDR9FqtF7koa7/v7rpF
         /rHKTPevh66NS4k2PtuIqqpZvlorUZKY0St9HPNDFsoTfj5V8Gbw6nTBB8RZodQBFW1i
         ZDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754450127; x=1755054927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep9VdFX0YAfEIDgF8SIP6REhyb3v3cmA/i5zA1fUvKE=;
        b=fKTkv/jYvuB+yZyT/pzEkaO1AS6jGvsaQJ/PXTa/ubs1pFyZiqMZrPjv/4S+6+1IRI
         Hnw9TDZcnkcsX/5INK+vyQOUCZzq3uLZZAqf8WxwKQeBwCTz+wKPz+t75bWwF9pdiHE1
         ++CnWKJMnC08WIy39KnnZGhYkKjcvU9Ql+4eQ7VkKhRgerJippJ6WI+QdCTw4S12NbDo
         mYjAapEAycE0jyh2IVj/FKS1M2UNGahjnBiDMwEv1S7W1mCnXUWC233YPGjnlgdLNm34
         28K3QKXZkuHsE9zIeR+9+Zv0W2+VbOPQ2hlbXjSrG/fJkbaSo/UoPaXviBmUGNe6/SCl
         gXMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8hqP81te77nrwV2EitHR7W4gU8B5G4tF1LdiphnvUz4mlmN4nRYMMvcyLWuM+gXcJYY2DWDDFo8fvK8BCdvpd7g==@vger.kernel.org, AJvYcCXWjy/2jdJd8qG9XTAepXOxb4bpHlRgGtUx7MwVFuaVNUPGxuM1bvUs/PB6P21mRvcP8yO4mWR6zQO/Hmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KgXYCttP7OSNuDLVfUMSa2B3v5KxEv+Ms7aJj0/F6BdmQbxX
	CSnO354XfwEG2QeLk68TKnccIv5wj3dlPk5a7syv8Z8zn2mN9ey70NV7ga3XDy7mmL2jwKJKuov
	rC2b05uE6BfI/4n4OQi9+fdUFHyobQT4=
X-Gm-Gg: ASbGncuKTZ9GNi9AaVmcAbOrjX3NtGX3mTqOR7uRJflXvGEH5KtCiK1W3Xyk2T7ga+J
	P6GzrbtgUMPOgXEv8Qc27aptRFRHtpC289g9N89sLwCHxb0uDjmscL3rOOhMuXIaWdpJGQQ9wms
	NAi/+7hx08asrRFPC7omm2E4fDnBH1W/4la398GTBzcGAX6OPQ11i8VsGxzuhgdNbszNVzijh81
	gWSUw==
X-Google-Smtp-Source: AGHT+IH3BTUtrfw3RdVPFAq+CVU58RHJ3ZIni3j/vq5G1SrYS3Mrsl8eoYwkEPqVmHjsaQUW8g9TiUy6J3UtAgEEnx4=
X-Received: by 2002:a05:690c:c92:b0:71a:275e:a74a with SMTP id
 00721157ae682-71bc98a9925mr20086397b3.34.1754450127286; Tue, 05 Aug 2025
 20:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 5 Aug 2025 20:15:16 -0700
X-Gm-Features: Ac12FXyYN8XzRGjlOY5iYdK0wZLtXpFbNDyXSqf25uTfe8d2odJU0xgQOv2F848
Message-ID: <CAH0uvogtte7FnMnnrWkYv9ZNz6LHs_egTaGockt-1s9AQ7eaTA@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] New perf ilist app
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> This patch series builds up to the addition of a new ilist app written
> in python using textual [1] for the UI. The app presents perf PMUs and
> events, displays the event information as in `perf list` while at the
> bottom of the console showing recent activity of the event in total
> and across all CPUs. It also displays metrics, placed in a tree
> through their metric group, again with counts being displayed in the
> bottom panel.
>
> The first ground work patches of fixes, cleanup and refactoring were
> separated into their own series here:
> https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/
>
> The second part of the patches adds event json for the software PMU
> and makes the tracepoint PMU support iteration of events and the
> like. Without these improvements the tracepoint and software PMUs will
> appear to have no events in the ilist app. As the software PMU moves
> parsing to json, the legacy hard coded parsing is removed. This has
> proven controversial for hardware events and so that cleanup isn't
> done here.
>
> The final patches expand the perf python APIs and add the ilist
> command. To run it you need the updated perf.cpython.so in your
> PYTHONPATH and then execute the script. Expanding PMUs and then
> selecting events will cause event informatin to be displayed in the
> top-right and the counters values to be displayed as sparklines and
> counts in the bottom half of the screen.
>
> [1] https://textual.textualize.io/
>
> v9: sys metric support and pep8 clean up suggested by Xu Yang
>     <xu.yang_2@nxp.com>.
>
> v8: nit fixing of issues caught by Arnaldo and Namhyung. Add Arnaldo's
>     tested-by. Fail to repro issue reported by Thomas Falcon but
>     encounter textual rendering and DOM query race, add an exception
>     handling path to avoid the race being fatal. The change is minor
>     in patch 16, so Arnaldo's tested-by is kept.
>
> v7: Better handle errors in the python code and ignore errors when
>     scanning PMU/events in ilist.py, improving the behavior when not
>     root. Add a tp_pmu/python clean up. Minor kernel coding style
>     clean up. Fix behavior of ilist if a search result isn't found but
>     then next is chosen.
>
> v6: For metrics on hybrid systems don't purely match by name, also
>     match the CPU and thread so that if the same metric exists for
>     different PMUs the appropriate one is selected and counters may be
>     read. Likewise use evsel maps and not the evlists.
>
> v5: Split the series in two. Add metric support. Various clean ups and
>     tweaks to the app in particular around the handling of searches.
>
> v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
>     displays as expected.
>
> v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
>     keys. No changes in the ground work first 14 patches.
>
> v2: In the jevents event description duplication, some minor changes
>     accidentally missed from v1 meaning that in v1 the descriptions
>     were still duplicated. Expand the cover letter with some thoughts
>     on the series.
>
> Ian Rogers (16):
>   perf python: Add more exceptions on error paths
>   perf jevents: Add common software event json
>   perf parse-events: Remove non-json software events
>   perf tp_pmu: Factor existing tracepoint logic to new file
>   perf tp_pmu: Add event APIs
>   perf list: Remove tracepoint printing code
>   perf list: Skip ABI PMUs when printing pmu values
>   perf python: Improve the tracepoint function if no libtraceevent
>   perf python: Add basic PMU abstraction and pmus sequence
>   perf python: Add function returning dictionary of all events on a PMU
>   perf ilist: Add new python ilist command
>   perf python: Add parse_metrics function
>   perf python: Add evlist metrics function
>   perf python: Add evlist compute_metric
>   perf python: Add metrics function
>   perf ilist: Add support for metrics
>
>  tools/perf/builtin-list.c                     |  65 ++-
>  .../arch/common/common/software.json          |  92 +++
>  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
>  tools/perf/pmu-events/jevents.py              |  15 +-
>  tools/perf/python/ilist.py                    | 495 +++++++++++++++++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/evsel.c                       |  21 +-
>  tools/perf/util/parse-events.c                | 198 ++-----
>  tools/perf/util/parse-events.h                |   1 -
>  tools/perf/util/parse-events.l                |  38 +-
>  tools/perf/util/parse-events.y                |  29 +-
>  tools/perf/util/pfm.c                         |   2 +
>  tools/perf/util/pmu.c                         |   7 +
>  tools/perf/util/pmus.c                        |   2 +
>  tools/perf/util/print-events.c                | 100 +---
>  tools/perf/util/print-events.h                |   4 +-
>  tools/perf/util/python.c                      | 522 +++++++++++++++++-
>  tools/perf/util/tp_pmu.c                      | 210 +++++++
>  tools/perf/util/tp_pmu.h                      |  19 +
>  19 files changed, 1646 insertions(+), 441 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/software.jso=
n
>  create mode 100755 tools/perf/python/ilist.py
>  create mode 100644 tools/perf/util/tp_pmu.c
>  create mode 100644 tools/perf/util/tp_pmu.h

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks a lot,
Howard

>
> --
> 2.50.1.552.g942d659e1b-goog
>
