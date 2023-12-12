Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1WQxxcu"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577EBBC
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 10:10:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50d11bd3144so243e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404648; x=1703009448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7WErAa1svouJ5RTcfagEeGuPrLYcmmXJIIkL6H2OPU=;
        b=V1WQxxcuz17BnLaK4YJEOjJtw9DQ/Ivzswz5cBSt6e7iOjUvDsuWq/DFOYpyWV8SFd
         TzvTRzGieUzWCPjRIZum9Z8zNaD8MrfLMTOQ+RoiqLCFN2BtJElqcV6qWCwnZSGeNM9B
         l4/NSMAZQtIfzST4//xDq8fR4EKcGcXSrq5LWEUOM/wA9g58nERZKChz0ERK/YpGNY46
         920j9YpQ7GGADgpDC58b0Rzq2EiE/IQk3wkbYkShKafgj5HvuNixWHbT3jU5Ge4C2gga
         1Eyrg6ZpHMRE5lui5wIsXFifXmcB+5HK7Burz0TpmlCQ3Vtgw3jrGAFxCkPEsXbFBZnE
         MHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404648; x=1703009448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7WErAa1svouJ5RTcfagEeGuPrLYcmmXJIIkL6H2OPU=;
        b=S0PrdD0bmQk5OVl0Dr7phLiCb8rqQIFESqNhUrc6U7IKiRRKy2ewnrEb2hqnPNWZRf
         Uai6MGD7VWcqu1RfgsAsf5WNK6Eud6bkGTenYcgyidEKQ8tO6b94kqqQ6yTn72S/gNft
         TktaLkLFl4N8mE9JmntVyJ/LxrKB0clVzor9Rj0wIOLKMvIaPawSLryTmT3LRIuVYe2R
         ypEUpfycMgkHAF+S78I92abZM4OnQ6NtD6xe7+UY7IxVZvDlvr/nsaifJ9TBEfVxtE2x
         bFK4Xh9AJIszTb8v75FkV/SOG2MzMruHzKgV5gpDyD48Vc5HEqUJRwkEerFKQzLsZ10d
         uoMw==
X-Gm-Message-State: AOJu0Yw+8CdLNE5bbxr6G8DQheglCtndfNp9c2xzmAmMv11hvWkH7c6b
	HsysF8MXX3HvVzCGOUV2B3TnV5EhbHaCXuXfQKoxgQ==
X-Google-Smtp-Source: AGHT+IHzkQIK4cpQrOTv6o/7Dyk15G788Co/V3rqIA3FMQmcUowvHpCwakRVH5BeQ+agq+GfZTS6yVmJFBoT5Ci01fM=
X-Received: by 2002:a19:5e41:0:b0:50a:519d:5a8a with SMTP id
 z1-20020a195e41000000b0050a519d5a8amr278722lfi.5.1702404648263; Tue, 12 Dec
 2023 10:10:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org>
In-Reply-To: <20231212070547.612536-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 10:10:37 -0800
Message-ID: <CAP-5=fV5sA1ga5UfvHW_=Ep25b-TzsLJ8Atqk3KePKOx-fk9TQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, 
	Pablo Galindo <pablogsal@gmail.com>, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> I've found a couple of issues on the unwind code while I'm playing with
> the JIT-dump code for the CPython.  The code assumes normal DSOs mapped
> from the beginning of the file and aligned to the page size.  But it's
> not true for the JIT-dumped DSOs which are generated for each function.

We have a JIT test in:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/test_java_symbol.sh?h=3Dperf-tools-next

It'd be great if we could do similar for CPython.

Thanks,
Ian



> Depending on the JIT implementation, the code address and accompanied
> ELF info (like ELF file headers and unwind info) can be overlapped to
> adjacent (JIT-dumped) DSOs.  So it should take more care when it
> calculates the mapping address for the DSO.
>
> It seems these changes need to go to the stable trees but they are
> changed a lot since then so I'm not sure.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (3):
>   perf genelf: Set ELF program header addresses properly
>   perf unwind-libdw: Handle JIT-generated DSOs properly
>   perf unwind-libunwind: Fix base address for .eh_frame
>
>  tools/perf/util/genelf.c                 |  6 +++---
>  tools/perf/util/unwind-libdw.c           | 21 +++++++++++++++++----
>  tools/perf/util/unwind-libunwind-local.c |  2 +-
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> --
> 2.43.0.472.g3155946c3a-goog
>
