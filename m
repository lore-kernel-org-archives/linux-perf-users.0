Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6WVDhZd"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278911988
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 11:53:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso4945e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701201180; x=1701805980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJlmh/i6qVPUaDygU94gf+uv5HBKAGsVKHkcxOTWzPw=;
        b=D6WVDhZdyFuWFsItxe+rLnU+/h7OL9ScLjV3QoLEJS2zl/W4YKUN6vNSxM48Obl032
         BRpaGex874kNPRpSa7gLSOZ/xADTmAhyX/xkl9EXj94EKU3Hf7C81kMLl0P1ZKARfN3G
         OIfxN+NVNoApTKf5MZ7OOWewIuvc7TYlqQYVJs/0eCxmxVf3Tx9Qt5chvcEs2UlIFg0/
         ugqQ9kvHVDy5RBFr1K8BPoE5pQsdSQTlZoRGDQj+qiCb7QDLC6AhVDNWh4sywh3Mjs+v
         NOFCMElwm8+cd8OB302ThXEOSE1+Q3JPYfhKkjM/Dp2ZvS212qpHxQuoXkpeCqnpzTAb
         FG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701201180; x=1701805980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJlmh/i6qVPUaDygU94gf+uv5HBKAGsVKHkcxOTWzPw=;
        b=QFFz7b6+WqazdJNS/sF0VPlsUxzOswGNXnM4CF3gcg48bHE/zwtdzhNqH7kwNVQvkE
         8ulvZhdniL4KLavpnY3ri2+I/ZDoOYIlPtI8zQYmzhsahgFwI2Scqj85FtZAU7qwVnot
         bZlx06tU835dh5OSTSLtEuAUS0s9VO3gQ0lW4ay+vPnlv5yUEViLJNFucFQE40Z/R1ba
         KASAXlomFqW99velSSbd9xWhZ5OpAhdK9ChUpby/wFofA6GLS1rEnoq7GlwoIJO8kPg3
         q9OpRy0E+bgNyHP6q6h7UIYgG/utGBEDvA88NEO1i7gK33fk4oWjuiJUqZsngWrjwbbX
         ol0Q==
X-Gm-Message-State: AOJu0YzSWBsZfvlBB1Ssl9+DOPDup4VPsrMbxHW8mNu0Ihy19MZY4DfR
	4XPy4EnStRhDnfH/Wma0BEXXKy1Cu0t3NgNrll2IoQ==
X-Google-Smtp-Source: AGHT+IEQfi+QzKUnAqeWsz9lr40ibLF4p1ARvSOw+YdoP9hX2ZpiwRTrHllEGn3tRE77i+Up4Q8IBFCdLkQMafbwufs=
X-Received: by 2002:a05:600c:45cc:b0:40b:3d89:ba70 with SMTP id
 s12-20020a05600c45cc00b0040b3d89ba70mr504824wmo.7.1701201180449; Tue, 28 Nov
 2023 11:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123121851.10826-1-adrian.hunter@intel.com>
In-Reply-To: <20231123121851.10826-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Nov 2023 11:52:49 -0800
Message-ID: <CAP-5=fXXrfOyNKrP8xu8+c5Wq1L=YgiEGuv6qC5XP5m+8ie9_w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] perf/core: Add ability for an event to "pause" or
 "resume" AUX area tracing
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 4:19=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Hi
>
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstance=
s
> can be useful.
>
> The ability to pause or resume tracing when another event happens, can do
> that.
>
> These patches add such a facilty and show how it would work for Intel
> Processor Trace.
>
> Maintainers of other AUX area tracing implementations are requested to
> consider if this is something they might employ and then whether or not
> the ABI would work for them.
>
> Changes to perf tools are not fleshed out yet.

This looks good to me but the perf tools parsing changes I'm not sure
on. It would be nice to have a test case, likely a shell test or
change to the intel-pt shell test, to show how they work.

Thanks,
Ian

> Adrian Hunter (3):
>       perf/core: Add aux_pause, aux_resume, aux_start_paused
>       perf/x86/intel/pt: Add support for pause_resume()
>       perf tools: Add support for AUX area pause_resume()
>
>  arch/x86/events/intel/pt.c                | 12 ++++++
>  include/linux/perf_event.h                |  9 +++++
>  include/uapi/linux/perf_event.h           | 13 ++++++-
>  kernel/events/core.c                      | 65 +++++++++++++++++++++++++=
++++--
>  kernel/events/internal.h                  |  1 +
>  tools/include/uapi/linux/perf_event.h     | 13 ++++++-
>  tools/perf/util/auxtrace.c                |  4 ++
>  tools/perf/util/evsel.c                   |  9 +++++
>  tools/perf/util/evsel_config.h            |  6 +++
>  tools/perf/util/parse-events.c            | 33 ++++++++++++++++
>  tools/perf/util/parse-events.h            |  3 ++
>  tools/perf/util/parse-events.l            |  3 ++
>  tools/perf/util/perf_event_attr_fprintf.c |  3 ++
>  13 files changed, 167 insertions(+), 7 deletions(-)
>
>
> Regards
> Adrian
