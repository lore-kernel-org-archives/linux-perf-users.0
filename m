Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A721353F4
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677168; cv=none; b=he+IJBw0UNi2MaZ7FkJEAmvSs1obiWrSFER6ng4XHPxFOjec2ZgHIME9FnfFcrM1s4k6Q5F3DL8IeY5h+ZZMs/Fxgho4wmDyeU6M/h0DbCbwZNv4QSghjgWXeNw0eeqlrqUXHlTCZqy4P0a1f6FT70FXEhU4/rCPcEQDlHh4nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677168; c=relaxed/simple;
	bh=TdZbbcvibKNEubySC1+cZnIcJaZJ5ysQzEMkQS6d5mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRzBxBJ6PcFPCcE/QeKJBtYxDilSJVccwPKwgEs42/pl4SyWCkbm3aCQTH3At1rSsgsklDHYZSyHjYVnM5MPBT14Kaj1QdpzMeTvR8rySyU6tjTBj0m9XvfhhX0O5/cye/jPaGkV6FHzCR/I3sfuW/QPomT9w+ioVxSHNZtQgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZT0NNfD; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZT0NNfD"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a2667fdaeso96605ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2024 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712677166; x=1713281966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D59yPPfuGSeOXa0T7H8XaawbruvNp5rSjLW+dQV/V4=;
        b=IZT0NNfDaCWRwnaTClnZvolAXzInxquSWWu5NKczC167BGmkKPkQslPiHETVPO+Zxi
         hRYrh1QzqkC3OLpPyXQIa0UkEWVb+7ifnFPIc4oPuS6zdLmw1rbET52jb0XtILke5+H9
         t0ap2jjFIM0zT6HrIyRpby24BeMcL/v9Kmv5BqOirmctXmLlXQuiXPuOLqmFr9PXvpiv
         y70018dZnhcbkoicxDHKbzdezRrT18c/ESkLO+ADvQeh0fmW2YwOOsbWT52AOAsx7oOl
         vRkZzXrfLHnJfC+mUp8K6EawEYz7GjDceEmibm/YhquclDvU1LHXw4yUIpuLL5GapqcX
         qL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677166; x=1713281966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2D59yPPfuGSeOXa0T7H8XaawbruvNp5rSjLW+dQV/V4=;
        b=wznphJ0UhMzfuE8BqKQ2GYonSQGRUZhzvGwKcP7y0qqKxitofn3SlC1ylZg0Eo7J+X
         bJxotAcpe+vwrRhCGumijrlCOCROugNDbriwd9+K2SpZaifBP+9sx1zRyf0aIz5Ok3gd
         /TobrrzWrVDjrn1luDbV+WEsyw1yumA7ASwTFJcsihR/clW/DBkEOAAyGphX9woJHMgW
         BoE2prJovRP1TN/4hgjJDsShl+u4mITy7QFbVVfV5F/J6jYc5J1P+CzkUjj8VFC+LB+l
         XCB8UPJe6uVSbTUnrsCJ22Gp9aMwDyVygxZ4j4T1CzURhapyXahpffgx69NlcACMlVDt
         dCtg==
X-Gm-Message-State: AOJu0YyvZZPQYQN3Hn3cPtogYZ7lJAusTzmS3fVvaluy+UDLXLoN3fr1
	FwoWNaU1mJYqnP7Zw5r46OlJ541w4AbHERfkU30hW3AIm3W+I8BRwWVsbE1inR7uw2JY3FnLko9
	AKV3PXrczwp0omESYkEbTzijoJcKowkxFzSbISkvZRpuTtqlHclcH+40=
X-Google-Smtp-Source: AGHT+IFkayyl+X2axDy+TRHXNNVTcPE8tGFRWfcc/gS5tKeuISFjOsFa6BTkf3xYxLseiI6nYyW/dAZrcZ0vJ7IdyJE=
X-Received: by 2002:a92:910:0:b0:368:8f9f:4066 with SMTP id
 y16-20020a920910000000b003688f9f4066mr177822ilg.9.1712677166065; Tue, 09 Apr
 2024 08:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409084741.405433-1-james.clark@arm.com> <20240409084741.405433-4-james.clark@arm.com>
In-Reply-To: <20240409084741.405433-4-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 08:39:10 -0700
Message-ID: <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tests: Skip "test data symbol" on Neoverse N1
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:48=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> To prevent anyone from seeing a test failure appear as a regression and
> thinking that it was caused by their code change, just skip the test on
> N1.
>
> It can be caused by any unrelated change that shifts the loop into an
> unfortunate position in the Perf binary which is almost impossible to
> debug as the root cause of the test failure. Ultimately it's caused by
> the referenced errata.
>
> Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testing=
")
> Signed-off-by: James Clark <james.clark@arm.com>

This change makes me sad :-( Is there no hope of aligning the loop? We
have little enough testing coverage for memory events and even precise
events on ARM that anything take away testing coverage feels like we
should try to do better.

Which models are we losing coverage for, presumably neoverse-n1 but
what about neoverse-v1 and neoverse-n2-v2?

If aligning the loop doesn't work, could we use objdump and check its
alignment skipping when it is off? Or run the test and turn fails to
skip on neoverse-n1 - so we get some coverage testing.

It would also be nice if the change didn't add a dependency on lscpu
for the sake of parsing /proc/cpuinfo, I see another arm test already
did this test_arm_callgraph_fp.sh - that case looks like it should be
using uname.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/test=
s/shell/test_data_symbol.sh
> index 3dfa91832aa8..ffc641d00aa4 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -16,6 +16,12 @@ skip_if_no_mem_event() {
>         return 2
>  }
>
> +# Skip on Arm N1 due to errata 1694299. Bias exists in SPE sampling
> +# which can cause the load and store instructions to be skipped
> +# entirely. This comes and goes randomly depending on the offset the
> +# linker places the datasym loop at in the Perf binary.
> +lscpu | grep -q "Neoverse-N1" && exit 2
> +
>  skip_if_no_mem_event || exit 2
>
>  skip_test_missing_symbol buf1
> --
> 2.34.1
>
