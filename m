Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E419CC29
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284768; cv=none; b=Xz+mHfy9h70YveQR5C6AIz2GdqBEb5HTTLaVCpY6WpgngYV5SyttyTpruxOCuGTLuvKKFWUkSjy1WygEGI8QMpzLDF3tD9V0wrC/CxYq726JsRjaHq7hEQ7iKif5SJso7kGDDhxWs2s7vW7NGtrAZ94VcoRdjkbQ6WNTtVGBIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284768; c=relaxed/simple;
	bh=nr7TULJUkQGJrOuVQsjl/I5u3f9/RpcP/64xpbsoWgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QVbTFp2bSG1fMA+rUtHzURJdGa0zQc+kUfTIzpLFF0hnVrs/W1lTCa9fXToVlJYjy33/amoHdeSgoXwHHNzp20RnVnBjRdLFVQB4sIwd7BZTikXqHso1rOKrawosEibjtmOChHNNolhlNYYfAdekkorypz9VESJdUO+vQh4BPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcPewZ0x; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcPewZ0x"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so151155ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753284766; x=1753889566; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaAqCEsAjkmQzr7VENxBG51Twgph3dMOYa2qTVa6CyY=;
        b=XcPewZ0x1FlP5xy2rLV4CngkbMBhNZDiyQ8CezQ3Vcy+evRF5GrFn6BtB/BFxAwcyE
         sWPvBq3yCITfQqY7ummPXKuRmhY2Ul1XMDQ5C98cOwXQvAZdyRDbBSIoAFqS9enpXDQO
         x5yUdSdMRYruTODafJJz7s+YoOmL+XG54dSEGYwJm/NZOypVJWBpEte3lJ1FrA8ffu2Z
         NZk42CTYirxhswyprkLUefE0n3xa3ZrSLFwUYQZ45gFV+S4plwbNvhsjj6I9ZMtL1x5W
         GxYbqeWk6Gz72kGMhTIaBSJYoA9JFKfnnJP7BaMOuVB0/ZVbtgbxzLfF47pyeb7kkeNQ
         T8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753284766; x=1753889566;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaAqCEsAjkmQzr7VENxBG51Twgph3dMOYa2qTVa6CyY=;
        b=Zg5SRlMBaifeKbSTH7692aLIEgaxtsawyo9TGpT/KhAOHYIJx9TpG0kRM9ERe09ioV
         8wcDZJzaJdW0VU7ZqMbdlZqchB7oLyeXsMISOGxhueZOoc9fQAc9Q8rd4due6GgC7KVT
         gQ1mEYDSRkfDtaE9QTk6LbWeiTeanN9NxQYJk7A3elQDBIz2UpoYMNSfy22AfFYx7F+W
         cHKApZOXOiB8KXaKt4LlpssVeHt7aJVG16bse7va6rFlj083KubGh4zEkJJHvPaNMZub
         Hmw49/JkiVGh89oU19IXQ8O7nnS+QRqI/MiroHimbKJjE3UX9vakiTaqvAyKr2b/M5be
         cqSA==
X-Forwarded-Encrypted: i=1; AJvYcCVjYkTnSNgDvl+Jilg3GtY/mgBsw5wQk+PT1+8doWelj3++w2Lftq70cqeumVLv+CLZ6YlrPuh8I2/6i8yArnC6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6cAjXTi+jE94D9DvfBW5ph9Ji5wzRHy1qGOD1/q3MsatitzI
	LVmL9Ih7tojmgB3n+yNg8BiwGrB6WRG+xH/i54RurHWIL1sqF88Mp42c449kn1WFviZAhmQPnlr
	9m8Hp2kxbTO1lCNLjmabhbquCk4b1s6Zl/mcgvT0J
X-Gm-Gg: ASbGncvR7YM8wuatGv613FtNS5MXcT4xyRKqbyOee5g06I5z1ufY03QuKlR2m0Pc9vh
	cLnnSNcMQQ7luuCWVrHX0PNMyE9iaHgtoDIh2R9Ngw7L6SUVcHoxIKbGvolZp+u4n6Y9tC10EMA
	PGiyld5wl0gPumApHhMenJyBZD3JP21o1sdeW6ig4Wb/gdF2NH0AYa8hflOr0h/PdYe1/pxd09y
	YPsVAfw8lU6gbHziF32wQJatSiSnqKZ5bvG
X-Google-Smtp-Source: AGHT+IF5QKhsrn3+8oYvsbqw6dZwTwQRa+IA5NCzjoUghqtvYBDSJBFXjMOGu7kyKyj0/NIRuK6nQ4JeIMGT6I1Ua38=
X-Received: by 2002:a92:cd8c:0:b0:3e2:f7ef:ad1d with SMTP id
 e9e14a558f8ab-3e32991132bmr5423835ab.18.1753284765898; Wed, 23 Jul 2025
 08:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 08:32:33 -0700
X-Gm-Features: Ac12FXxkYblDM8jJvwPf1tvNA6UrYooACCiYgA3NMcwyVVRRGWUTq1zPtYJdnuM
Message-ID: <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] New perf ilist app
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:44=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
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

Hi,

Is there any more I can do to get this series landed? I appreciate having:

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

I think there is some follow up for "make install" for scripts like
these, but I'm keen for the python API to move forward.

Thanks,
Ian

>
>  tools/perf/builtin-list.c                     |  65 ++-
>  .../arch/common/common/software.json          |  92 ++++
>  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
>  tools/perf/pmu-events/jevents.py              |  15 +-
>  tools/perf/python/ilist.py                    | 491 +++++++++++++++++
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
>  tools/perf/util/python.c                      | 519 +++++++++++++++++-
>  tools/perf/util/tp_pmu.c                      | 209 +++++++
>  tools/perf/util/tp_pmu.h                      |  19 +
>  19 files changed, 1638 insertions(+), 441 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/software.jso=
n
>  create mode 100755 tools/perf/python/ilist.py
>  create mode 100644 tools/perf/util/tp_pmu.c
>  create mode 100644 tools/perf/util/tp_pmu.h
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
