Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE31D90BC;
	Fri, 15 Nov 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695226; cv=none; b=lNF6KkYrc80at/mL5a2jdDXYSyvFQWDo2ItE6s9Ax63fSApYYMg7No/Qi3rF8IspGjf/GrYGm94AspXxZ7/11TkKPb24ia8l+gYl5VwTXOIowNSq0+E/adUUOsfgeo8HLpuFvD2EdrVEIDjI3bBX+SfNuHFj1FHrhZeudIwbLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695226; c=relaxed/simple;
	bh=37wDxptUd4/5yVaP03X+reMs49cFNg7VOoxmxhutuLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdoPLnuhIXzp9+87cfgjhP5rKZf/h7Kr1awvmKSscc+OCY8CdvQx5txZ1k3X3XFkNDbObEyXgmzykGTGlhpLWZABa/EVodK7HCpkLvFIAH5Qr0lbuGCJ2L4xv6q+zkvTEJfIIYjuTNTApffMdGyeeO+IAApiNZXM+lz2OsnIr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwhQsNJB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwhQsNJB"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea85f7f445so9749187b3.0;
        Fri, 15 Nov 2024 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731695224; x=1732300024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiFolGHX93uFm2SRwMrirsYWIk5SIP9OdqEWi3N6o54=;
        b=JwhQsNJBPJV62HT969cTrfL52E55QsCY6nyjteSmTjd1R4oYe8jk3z31QolYluXS/6
         U2M/sc/TTPhSTQYM/DFQktopHM0hlhLpLORhCOU4XDO4M9R5k/h2nufLkjVDRrp11hKw
         FG1y1ubOlZ/p1+9aFOQSB/cbPMovwqXfEy5xlQOFcmtLKwsq2J3S1pVkXpFaxC9B1DSM
         t8L2YHXdQ5uYanxc+NOYr4kn8nhKNbMYsiDhQZvFJkqv2uVyD6rRw+LK8aW7Jt9wxeul
         rzZfKSdUjzKmaFtwomYu0kk++shmVe4Q2EmCnif+s+5WyTnpkHrxlRyAuwZ2wpDqdGMV
         2EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695224; x=1732300024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiFolGHX93uFm2SRwMrirsYWIk5SIP9OdqEWi3N6o54=;
        b=pI0feZoZm56/1bQptdgImF903HnGrq1Q5X54yN/H2e+ltQTM+2HpUbDq5Z5qIkLskB
         v5Y8qr5zUq3kJ7Gd7+FPNXeeG8vc8w47O2eavTeZSUICoJCZm80Qrkcj9V+mHPUIPeN9
         l9e3uYra1TRDrrI/nzmjw0IRF+Ocv+DxS/7cqw/Vt7AG7ZYQyvb8flJR/cdorERhU4eu
         knkKmlWgVT06DFK2ARl+jc672gQMYZZZypAp7Mln/3myl+c710fhnRaVqoXScUaWnokX
         vt2WkQtQojFiDmW7pDLTeOs4cwT+V4vDaMERFOb7C8aFtAyk0XYePJCNNx7dW+wOsbsO
         TsJg==
X-Forwarded-Encrypted: i=1; AJvYcCVhi2ynb39qeO1Hv/wYO9n6eS2x+9aF1OMRSVTPzGy/LgFk4NWkg3/1rog9IIwWnstXmpjTzOtCZtEBDpBU+HV8BQ==@vger.kernel.org, AJvYcCXqeWs/AsfPrm29YVU2uy1L9PDABvxeqN8sAjU0NL7iGNLWceg44cq52mNZIxHIsR9D0vCne4IL8gx1gJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBqwMhp8evwg3XS2bRl0ZI3z+wRj3Wxqyvi8hUKPek+Aeqplr
	700APJvU04xBP7bnfYc+HpNzcreZOZopGtLjZrQzbvWPRCeipiQnfYDUhmzcuN9buQAbm56cCfN
	Aq9I08evOqTvWDpJWKMc2fvHvXho=
X-Google-Smtp-Source: AGHT+IG59upkrBsEgAbt+Sw3jAsNFe/t7cthDEippLl83w3JOZckc4vMpWvy7h3S3AocZVh1PRnmMyDMXFJZ7WvnnpI=
X-Received: by 2002:a05:690c:7013:b0:6e2:5d2:3421 with SMTP id
 00721157ae682-6ee55a628aemr44973617b3.10.1731695224049; Fri, 15 Nov 2024
 10:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115153634.314742-1-acme@kernel.org> <20241115153634.314742-2-acme@kernel.org>
In-Reply-To: <20241115153634.314742-2-acme@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 15 Nov 2024 10:26:53 -0800
Message-ID: <CAH0uvog__5b4PC8MEk_GL2Ek0pYU7fJ1XfdHyDiwFTBYN0tuxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test shell trace_exit_race: Show what went wrong
 in verbose mode
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Peterson <benjamin@engflow.com>, Namhyung Kim <namhyung@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Fri, Nov 15, 2024 at 7:36=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> If it fails we need to check what was the reason, what were the lines
> that didn't match the expected format, so:
>
>   root@number:~# perf test -v "trace exit race"
>   --- start ---
>   test child forked, pid 2028724
>   Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ =
syscalls:sys_enter_exit_group\(\)$':
>        0.000 :2028750/2028750 syscalls:sys_enter_exit_group()
>   ---- end(-1) ----
>   110: perf trace exit race                                            : =
FAILED!
>   root@number:~#
>
> In this case we're not resolving the process COMM for some reason and
> fallback to printing just the pid/tid, this will be fixed in a followup
> patch.
>
> Howard Chu spotted a problem with single code surrounding a regexp, that
> made the test always fail, but since there were some failures when I
> tested (COMM not being resolved in some of the results) the end inverse
> grep would show some lines and thus didn't notice the single quote
> problem.
>
> He also provided a patch to test if less than the number of expected
> matches took place but all of them with the expected output, in which
> case the inverse grep wouldn't show anything, confusing the tester.
>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Benjamin Peterson <benjamin@engflow.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/ZzdknoHqrJbojb6P@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/shell/trace_exit_race.sh | 24 +++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests=
/shell/trace_exit_race.sh
> index 3cf2d71a5c3b9278..8ea24f4256bc8f5e 100755
> --- a/tools/perf/tests/shell/trace_exit_race.sh
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -11,11 +11,19 @@
>
>  skip_if_no_perf_trace || exit 2
>
> +if [ "$1" =3D "-v" ]; then
> +       verbose=3D"1"
> +fi
> +
> +iter=3D10
> +regexp=3D" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\=
)$"
> +
>  trace_shutdown_race() {
> -       for _ in $(seq 10); do
> +       for _ in $(seq $iter); do
>                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
>         done
> -       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter=
_exit_group\(\)$' $file)" =3D "10" ]
> +       result=3D"$(grep -c -E "$regexp" $file)"
> +       [ $result =3D $iter ]
>  }
>
>
> @@ -27,5 +35,17 @@ export PERF_CONFIG=3D/dev/null
>
>  trace_shutdown_race
>  err=3D$?
> +
> +if [ $err !=3D 0 ] && [ "${verbose}" =3D "1" ]; then
> +       lines_not_matching=3D$(mktemp /tmp/temporary_file.XXXXX)
> +       if grep -v -E "$regexp" $file > $lines_not_matching ; then
> +               echo "Lines not matching the expected regexp: '$regexp':"
> +               cat $lines_not_matching
> +       else
> +               echo "Missing output, expected $iter but only got $result=
"
> +       fi
> +       rm -f $lines_not_matching
> +fi
> +
>  rm -f ${file}
>  exit $err

LGTM.

Thanks,
Howard

> --
> 2.47.0
>
