Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E2217F2B;
	Thu,  7 Nov 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017226; cv=none; b=aS+TCVnvZNn+EQ7KuATDWOxLj4YGnjRW/U2W4gPozuDReHThcNlMP7oT90h+J+KMemLI31zACE6MdRSEx7e4wMRHoVA0osNDYNeKjToiIDPzZJSmz446wUoJCTGneKnZJMyJwNNXvxVpzkMrQfzR0jVIG9zr4Sse99mxfEMZlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017226; c=relaxed/simple;
	bh=DS4LSI8MX8xTpKtC/M7AHiTOETb5TbsaATxt5icYlLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwvSK2EhzEBXGoEwXo/MfxVFpMulfDV/WVHPnaT3qHFfxoDn5Ky+xSWbDD/7FwGpO1MKVjUBp78YzcFU4U6Hbi3FPgD/PUdF0jpMQ/4ppzrQwRW7qRtZmMCYZWe2evS/+/L42egGPxNquzFDg9kEzyCqfmY2+6d0wWLOjxzk6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaZb/Hy6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaZb/Hy6"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea15a72087so12302537b3.1;
        Thu, 07 Nov 2024 14:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731017224; x=1731622024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gcf154t7S2B8+qDVK1MBckgvLJDh5up0elW54RZAwQ=;
        b=DaZb/Hy65sajnHPrgNKkpWHFnfJPr8W+sOugOHBeSTh6SYEQu9qgivOkPrZuK3Ti1R
         1uHgIv9w5Tc80LLtY6qKeUjkXKsZwnD9nGtFYpoe23s/JdNHG+p7+wyMrEwsgFz/0/+R
         kIodAo2rGxRYAVlBqYwpZtCj40+GB+Qvk+L5Esd9VCO7x17KoR3WwA7Va05IX6RgDVOF
         fuibl01EOByEwK31YD+tsfOXJBgVjiq2dCeQDb5HHt33HyRl68ASsPrJZmWynldqHtuK
         o/9NNGN0A6eHnmo1Wqk6JPNOeLpqEgoYXnbTE4rHbXJI79BWEmpW64zLPhrLS/XnDOmi
         coqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731017224; x=1731622024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gcf154t7S2B8+qDVK1MBckgvLJDh5up0elW54RZAwQ=;
        b=DFpoGIDdqU6rvh4EQrAS1EGv4cimJCv4x2BOZf+tL6zwcm+v9oHW2jbfys+/nLmK5s
         rG0+hMbGtYqzhfTRWDhrWvyNpM1LUQMZjY2edKoG0whOrefCbi7yNtghEHfXyYRdFai/
         vrQCfJoozkyFi2KqkjdjXlZGY9bKl0GuIhIan2UQkBiqjazNcFpmXzzZACiODBI2BPxT
         IAuXYa3U7GsoWSzZJb3Ng5DtlPQLNQrfXIaIkluZiOSbdJn5lZcX+LhLWB5ek2DMBFK/
         Zi57w7u/bHyywvuIjaov3X3rbRm9P95ULxGVd2YCLesx7+ns6qr6NPFtHNF3v+mvUCvY
         YOhw==
X-Forwarded-Encrypted: i=1; AJvYcCUUAV2ZUcd3mjLyKFpIfPJV1ffnFFYXtWqn1X14qnqABzf43rZemjgBzx6cZfbZS2NqKB9k1NuNnfz0utC8VQNSUQ==@vger.kernel.org, AJvYcCUZ2JypW3y8/T7Wt3GBTR9m+Z5xK9l3+AWYjcbS5HxxQ/Mz8IIzySFAEAx2eEQbv8ZEJ8PNxlirRbNoZ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQa2kQwzF68SkIf+WLx/n9zlQj954jUgdUWHvfizX8U3uZVZp
	X2l/tfVe0iCh4B/UJd6M13O83E1e7TlR7gvwWY3e3ntPZ40hz+7KYKdowFJYfH4+9IF11x5SmpK
	rhA/+VIgzloYsATri73VEdNObvNw=
X-Google-Smtp-Source: AGHT+IH9B0TOVtXpIxp7xI/ISIs2B6w0IwFXFXxQBoQ2DvkokKjGvyMftjtn9UQ1ajpFt04AaAJkbR5507zrXvSPJ3U=
X-Received: by 2002:a05:690c:fd4:b0:6e5:de2d:39b1 with SMTP id
 00721157ae682-6eaddd79529mr8478057b3.5.1731017223506; Thu, 07 Nov 2024
 14:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
In-Reply-To: <20241106234518.115234-2-benjamin@engflow.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 7 Nov 2024 14:06:55 -0800
Message-ID: <CAH0uvohtu_XQochZ_nguXN4e65C_m88Chip1mm84uDRLBXagzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 6, 2024 at 3:46=E2=80=AFPM Benjamin Peterson <benjamin@engflow.=
com> wrote:
>
> Add a test that checks that trace output is not lost to races. This is
> accomplished by tracing the exit_group syscall of "true" multiple times a=
nd
> checking for correct output.
>
> Conveniently, this test also serves as a regression test for 5fb8e56542a3=
 ("perf
> trace: avoid garbage when not printing a trace event's arguments") becaus=
e
> exit_group triggers the previously buggy printing behavior.
>
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> ---
>  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
>
> diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests=
/shell/trace_exit_race.sh
> new file mode 100755
> index 000000000000..8b70324bc5b4
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# perf trace exit race
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Check that the last events of a perf trace'd subprocess are not
> +# lost. Specifically, trace the exiting syscall of "true" 100 times and =
ensure
> +# the output contains 100 correct lines.
> +
> +# shellcheck source=3Dlib/probe.sh
> +. "$(dirname $0)"/lib/probe.sh
> +
> +skip_if_no_perf_trace || exit 2
> +
> +trace_shutdown_race() {
> +       for i in $(seq 100); do
> +               perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> +       done
> +       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_=
exit_group\(\)$" $file) =3D "100" ]

The test failed due to regex mismatched, I think because of this:

     0.000 true/1526046 syscalls:sys_enter_exit_group( )
     0.000 true/1526212 syscalls:sys_enter_exit_group( )
     0.000 true/1526383 syscalls:sys_enter_exit_group(SSSSSSSSSSSSSSSS)

Ironically the junk buffer problem you fixed last time, thanks for
finding another printing problem in perf trace :), I'll figure out the
cause of this.

Another thing is this test takes a long time to finish

perf $ time ./perf test 109
109: perf trace exit race                                            : FAIL=
ED!

real    0m38.762s
user    0m15.090s
sys     0m21.794s

Is it really necessary to run it 100 times? To me it seems to be just
a wrong handling logic of draining samples, will there be coincidence?

Thanks,
Howard
> +}
> +
> +
> +file=3D$(mktemp /tmp/temporary_file.XXXXX)
> +
> +# Do not use whatever ~/.perfconfig file, it may change the output
> +# via trace.{show_timestamp,show_prefix,etc}
> +export PERF_CONFIG=3D/dev/null
> +
> +trace_shutdown_race
> +err=3D$?
> +rm -f ${file}
> +exit $err
> --
> 2.39.5
>
>
