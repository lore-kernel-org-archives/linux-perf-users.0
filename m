Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E9152E1C;
	Fri, 15 Nov 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695818; cv=none; b=Q6fd/udcGEQM6nxGIUAATqDgXiRsjow+XxbbAyA57Wf3zjqgjtRyngTPmdqXvBU3pTlVdpdjEjFXlUgi+dlVYhNIOvwWSEQX2Bahnf1o+jW/mALfHU/eNOSQKGhIYok694sSCYPPIlq1362usYpOB42KdmpAWjxzqT2Pa3ZFgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695818; c=relaxed/simple;
	bh=f769s2D4uCx6qFHiKay5YSvdFCmWcl8BtanEBvsJQ4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxNzCQ+DOpSOdImS/wXjV9YcQfPfbwwhsETMoqoumRwoHiyVq9JE9i87mdxmop+HC+L26HIsMXJzYdPYfHeTHSynGkbQPISGxk/T5ttKWIHXPPEHzgDTvuaUCHhzEOpDtpER5Om5ZBe9eZqQSvMfy624hyz/CxysZ/kU+5Xbvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6W20prJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6W20prJ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e9ed5e57a7so9136727b3.1;
        Fri, 15 Nov 2024 10:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731695816; x=1732300616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vVU0enV9vc8UmOxrUMveha9ZIT+KGhWwiESBs4Nru8=;
        b=Y6W20prJ5B+ynuCP/TID57uBKBFr/LfysAADYspKktTYea0N+Msx/z/LEwjI1rPykj
         1S4AoqUY05kNy5LyjLoDvwS4dodoLfrKLyfDkEQpFbG+KLyYuiHFVvgidNpM64us4wDd
         8X4lUGU3CxUUIKRk7fABbv7OqmR8fYtE3SdsUe9Y+R5Ly7vKYd8Pg0xqTyV3EKmXZpfN
         R7CbNwIyVSpSYk55qO6ctSmq91q7PJughnjJ1C1DGYEctclx7UdxGGXC4MUrtHpaW5uN
         m9v/fLV5BJ72Tv0aCU2oyYPNc38UYc2oDD/opiAyFCHYF0KaOG9DEgQSnw2ysGbm2Od3
         6cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695816; x=1732300616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vVU0enV9vc8UmOxrUMveha9ZIT+KGhWwiESBs4Nru8=;
        b=SLv1/ZogE5CI1+VnFhJQ6cV1MAHNTTk+e7ttMZegwJ042WtmpWNpOqXWASbYxoaR2g
         0YIamsGoMt4cUPIAc6TDOfTJUMxwWstdkoGatfS+Zgxq9fBmtlTA6QLfRB483BdAc+M/
         7vjh72/x3Y8Tay0J4tlMuaDyZLWi4KcWt3c9pSRfd51DW2R3Eo1TJz1kXtNKBnEmfcGF
         qdJ5yroarYGP+h/4jgOoBcn4rXNMa/rqymo+fnZUkpadVNaSKUFSxf0yGMnL8ALiEScK
         uQ9Vpe8i4HCTM8dbCBjUcTMUmzNkd/eZC0GA9nH9GUb0hZE2lNIO23of5WscOjWe3gG9
         Dkng==
X-Forwarded-Encrypted: i=1; AJvYcCU7UISunHczfO1VljC3BmOKm+y1iE5Ij/OhloPGe0sYsPZZghzGp9utSnRX4gyb5yoSYvbqbqxOp46OmipLIsAREA==@vger.kernel.org, AJvYcCUqYVBZsQGhClQtf8ZLVuB1VlzLSWKUj9tyBH1l6lFvDCPsaeXcwxBCp8UnPug47TPrpPKHyKKI02Wo/z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHTuk0XwO5MtL3Hz+AizNKARQf8gyzKhfUJPz0++e8fLR4v8+
	zC9MfNq8lwuj0HmP7gfGe8k8cvDJlJn1kt2IJRs9AZeciJtlDzqx0Un6Q72tmu5r+OOij1RCMhU
	bCciI8NbG4/L7/yzfx28wFtU1zBE=
X-Google-Smtp-Source: AGHT+IEAnkhom1cRk03NtPSuEL3n6KGN+05LKhjzp9E/P0jmB38QCf2u+AF6IEpXPD5nw6l0tCyzhKyU2reyrlW52ZQ=
X-Received: by 2002:a05:690c:610b:b0:6e3:2e4b:ad9a with SMTP id
 00721157ae682-6ee55a55864mr45399257b3.12.1731695815719; Fri, 15 Nov 2024
 10:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115153634.314742-1-acme@kernel.org> <20241115153634.314742-3-acme@kernel.org>
In-Reply-To: <20241115153634.314742-3-acme@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 15 Nov 2024 10:36:45 -0800
Message-ID: <CAH0uvog6oxyuQT4TOhGtbK6n0NhFc-JCDZmrK7JztPd4mE7cYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test shell trace_exit_race: Use --no-comm to
 avoid cases where COMM isn't resolved
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

perf $ ./perf test "perf trace exit race" -v

110: perf trace exit race                                            : Ok

Tested-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

On Fri, Nov 15, 2024 at 7:36=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The purpose of this test is to test for races in the exit of 'perf
> trace' missing the last events, it was failing when the COMM wasn't
> resolved either because we missed some PERF_RECORD_COMM or somehow
> raced on getting it from procfs.
>
> Add --no-comm to the 'perf trace' command line so that we get a
> consistent, pid only output, which allows the test to achieve its goal.
>
> This is the output from
> 'perf trace --no-comm -e syscalls:sys_enter_exit_group':
>
>      0.000 21953 syscalls:sys_enter_exit_group()
>      0.000 21955 syscalls:sys_enter_exit_group()
>      0.000 21957 syscalls:sys_enter_exit_group()
>      0.000 21959 syscalls:sys_enter_exit_group()
>      0.000 21961 syscalls:sys_enter_exit_group()
>      0.000 21963 syscalls:sys_enter_exit_group()
>      0.000 21965 syscalls:sys_enter_exit_group()
>      0.000 21967 syscalls:sys_enter_exit_group()
>      0.000 21969 syscalls:sys_enter_exit_group()
>      0.000 21971 syscalls:sys_enter_exit_group()
>
> Now it passes:
>
>   root@number:~# perf test "trace exit race"
>   110: perf trace exit race                                            : =
Ok
>   root@number:~#
>   root@number:~# perf test -v "trace exit race"
>   110: perf trace exit race                                            : =
Ok
>   root@number:~#
>
> If we artificially make it run just 9 times instead of the 10 it runs,
> i.e. by manually doing:
>
>         trace_shutdown_race() {
>                 for _ in $(seq 9); do
>
> that 9 is $iter, 10 in the patch, we get:
>
>   root@number:~# vim ~acme/libexec/perf-core/tests/shell/trace_exit_race.=
sh
>   root@number:~# perf test -v "trace exit race"
>   --- start ---
>   test child forked, pid 24629
>   Missing output, expected 10 but only got 9
>   ---- end(-1) ----
>   110: perf trace exit race                                            : =
FAILED!
>   root@number:~#
>
> I.e. 9 'perf trace' calls produced the expected output, the inverse grep
> didn't show anything, so the patch provided by Howard for the previous
> patch kicks in and shows a more informative message.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Benjamin Peterson <benjamin@engflow.com>
> Cc: Howard Chu <howardchu95@gmail.com>
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
>  tools/perf/tests/shell/trace_exit_race.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests=
/shell/trace_exit_race.sh
> index 8ea24f4256bc8f5e..fbb0adc33a889516 100755
> --- a/tools/perf/tests/shell/trace_exit_race.sh
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -16,11 +16,11 @@ if [ "$1" =3D "-v" ]; then
>  fi
>
>  iter=3D10
> -regexp=3D" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\=
)$"
> +regexp=3D" +[0-9]+\.[0-9]+ [0-9]+ syscalls:sys_enter_exit_group\(\)$"
>
>  trace_shutdown_race() {
>         for _ in $(seq $iter); do
> -               perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> +               perf trace --no-comm -e syscalls:sys_enter_exit_group tru=
e 2>>$file
>         done
>         result=3D"$(grep -c -E "$regexp" $file)"
>         [ $result =3D $iter ]
> --
> 2.47.0
>
