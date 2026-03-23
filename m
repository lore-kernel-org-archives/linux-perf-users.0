Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582631B837
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297585; cv=pass; b=hRB3xR+eKENN3M6Hze+aubgkFTplDFONFTRzqBluci8PzRo3G9khpn7oIYmF3WuzvlWfNrSTRa/4r7TJFJY/x6PVX3KgSG2j1RM+X2ZUoTSEFGfk+/OOkl3pu22bWfF4d6BYvwuj0dka9rtgFi1cJIYCPyCJLZZDbzYzdRY2hHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297585; c=relaxed/simple;
	bh=5JOf2/fHsfp/ZaOuAnluvpXGwz7ca/WtqTlpq7AW8wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd6c55yIoOsgeLtdwvGyZIo23d8cBRJcnP9+R6aIJNgd8yfrqb/3X0kWuEiYlck8vAd3h4fc4LmYNuPs60NqgQcRRU565Ee3qg/NmiNMMkXWmZM8YUvL9weh51OH1PeQXGzvbcfFu+baea5JmWezm3U9oZtTv/g5W5tRLjjWAlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uauokwxb; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uauokwxb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so5975ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 13:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297583; cv=none;
        d=google.com; s=arc-20240605;
        b=OVMCJenpeUs00N3xkcElcGt9GpibLshKR0CbdojOwYT+/2xfgCGVjsSB2VU8cWM+QC
         UtZG3qlLu1ndNXN4kCMQE3HZ/4vU3wrUFHIQ9fxDvGPYe9e0d3OIJp0l5131l7fJYiNv
         aKzOZ45tX3a9zZxD116PHbfEZ1EjCD4cCFM0MjVqdgM6GbAaEHPk8y7UfkfSWVofCsLT
         C/4YOOtDnBaNXyfAoGBtebFFG9B8Zv5vA42XF6eoS0btqkS4EXjzfx+RExuW2MRgnhLQ
         Ki3dn85OgC8RMR9r1gDikJM/sn7cRZeI0eP7Zrc73iQUpG/9r95el9OtlO8c2TrQT1je
         WnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ss0OTKF4z14a/TGi7TTiDuFnXX64U8Y20beIGWGhwfI=;
        fh=QJ6EqR0AlkLGr28xS8DVJLekchvI5GKqWGbbft2eyhA=;
        b=Yc7w/l93+BG8302qRmtSfuzoEoika2wfTr82yBDKDS3HbPBvjRz8wVlikDNJcjEDLJ
         6tesyR1dda9WYRrT6My4nmySX/285GyE8kyak2P7Nc10Y1i35Vt9lgjLLKXQVCPXaDJB
         lsFtoNflgfEPbWOF839hJC8WTgV48/m7mDdVwsXl/o0wEZOgyxwVfc6oz3i3NDynwUBG
         8gEcb2d3q6odjYAVieN7y1qjOLpTXIhcWu1/c/8v6vZX9tk6Zt4/CApYC95Rb2vdGg4F
         5Ei+HcyuaQ8c+4FUWtGA8WCGr8Zh7/4c+71kvYT7XBTsFrffYq1WWZN7mkYstVRtYVEq
         WyUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297583; x=1774902383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss0OTKF4z14a/TGi7TTiDuFnXX64U8Y20beIGWGhwfI=;
        b=UauokwxbrI8eG4vB8edaf1TCVxMZvPXHT/T8zhX40SyoaTaFYQgiakW/kXvxjld9YH
         IpPfKmV39UjprWSGDEPveWQbsyShfWuR9M2+4OVnAPfj9sc2dPc+pcRl77PkGO02Tnkt
         jj6lINnr2zWQjx3hUmvMH2xwc130EhKwWFB2GAJBZCReTOqdraFdbjtnkPFw2JwPPYZ+
         b4ZKK9b4kI8hSxiz7iKzL1Hc3muZl4IQaz115v7IBxG56eGQA9sxLIFDuluRf7BRFgdr
         XRXNgvSavVwrcmhZwsLbolW1jtBtFyFtXUYU49kCveowdR44oSfDJziDmdFvnr5wW5Qm
         752g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297583; x=1774902383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ss0OTKF4z14a/TGi7TTiDuFnXX64U8Y20beIGWGhwfI=;
        b=W/0am4V5lDuFhcA8sWs5gTjZHTl3+f3xQ2QCc1ULTeyTNY2XbpLjQB4wvcMx66lEAr
         TRDYlI802dQzJNZwUXHDfbljpZAV2znuvLCxiZyMcO8/VbzLyDBSgJHctojbZY0oy5ov
         +KFI9y/Keaar4gr5tMh/pdspaJV4D5rklFoY52Do/xYvILTAMOfIDTaGnXuqS3UC3m1p
         wAngdPkezA4k8YykvxYvUDMfhyOyEQXuBqUgxyVb4g+JxKI6iQIlpzDa77JwcA/yJOIC
         Aezbt/Dz/ReYgDPAU+aTn8PrB8QOiuY3RDX0/tmpfllZjXDkGyZlW7uwS7Z/pZ9SCLh4
         lYcw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+XmjFJdTKdiU+9xCghPnzim9j2uo4dH7I7DOA/Z4guM4DWwAoAcCa7/WIqr+267/56AO1C3D18ZMB3cDB/4/@vger.kernel.org
X-Gm-Message-State: AOJu0YykiGBnthioepSqCD6de6OD3nZTDUIbvrJYmmxdD5Pk3VZtSo1e
	LJV+qGuH2+KbPCggNH7kNeEf1tKXktqoJ1YglvjCjIPE7N0QpgpM8N8lv85+XkTypFNCJr/en7K
	+MZoBDEcPXzTv39JtjEoDSR0sLfAtGJdrIxjpJvJV
X-Gm-Gg: ATEYQzwS/hcMXmUwrxiESt3GOKBEx0gvhHwapYW88suQyxhsvIukFugv1TiarvwsRaw
	waPFwvhco4F3bmnPtWcKEpCWOSFtZPdfAqHnoGygXMhiIiuEM1tV9oNbecHn2wKSxza4ZKjGsMR
	TskumiKPKp7tGXPor46PePLNrcaimHCagRwtwa4tbd/GgiN4XnksSaNtRx/2YEHPZCtR/st4JyW
	fK/hLgEdXuNYlBkhMU81HVS2Nv/1EvUvI2dFVr7JCzJ8m9+LkwKlDD9wnLCGyqb8kP+2TzFQyij
	Bgoc5YaZS0iDd27cks1c5euWZ/3XcLAU0HqOhDqjgHrAtiVa
X-Received: by 2002:a17:902:fc4d:b0:2b0:5e19:1862 with SMTP id
 d9443c01a7336-2b0a67072a6mr137995ad.5.1774297582314; Mon, 23 Mar 2026
 13:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW5Cx-a0hm_PKNLDSmo=L0xu=LizKiAPyJF1YtH-coFdg@mail.gmail.com>
 <20260323202409.194123-1-irogers@google.com>
In-Reply-To: <20260323202409.194123-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 13:26:11 -0700
X-Gm-Features: AaiRm51sj4DGCa2d5arquhJLiaxWCEmjC3JseMCjCw4ej9K416ful2aViALEJTc
Message-ID: <CAP-5=fXwDgZ-+JT2c8y3sJLURGAz1njduLZRxTJ548xbW+H9Jg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf test: Fix perf stat --bpf-counters on hybrid machines
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:24=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Events on hardware PMUs may open on >1 hardware PMU on hybrid
> machines. Unfortunately multiplexing introduces a scaling issue as
> reported in:
> https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
>
> Switch to using task-clock which as a software event runs on all CPUs
> and has a single PMU.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

With hindsight, maybe the better thing to do is Namhyung's patch plus
the "--no-scale" option to `perf stat` to sidestep the scaling issue.
It'd be great to make this test not "(exclusive)", it shouldn't be
necessary. You can test for flakiness with the '-r' option to `perf
test` which takes a repeat count.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 35 +++++++++++----------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index f43e28a136d3..58f7dc9692ac 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -5,6 +5,7 @@
>  set -e
>
>  workload=3D"perf test -w sqrtloop"
> +event=3Dtask-clock
>
>  # check whether $2 is within +/- 20% of $1
>  compare_number()
> @@ -25,15 +26,15 @@ compare_number()
>
>  check_counts()
>  {
> -       base_instructions=3D$1
> -       bpf_instructions=3D$2
> +       base_count=3D$(echo "$1"|sed -e 's/[^0-9]*\([0-9]*\).*/\1/')
> +       bpf_count=3D$(echo "$2"|sed -e 's/[^0-9]*\([0-9]*\).*/\1/')
>
> -       if [ "$base_instructions" =3D "<not" ]; then
> -               echo "Skipping: instructions event not counted"
> +       if [ "$base_count" =3D "<not" ]; then
> +               echo "Skipping: $event event not counted"
>                 exit 2
>         fi
> -       if [ "$bpf_instructions" =3D "<not" ]; then
> -               echo "Failed: instructions not counted with --bpf-counter=
s"
> +       if [ "$bpf_count" =3D "<not" ]; then
> +               echo "Failed: $event not counted with --bpf-counters"
>                 exit 1
>         fi
>  }
> @@ -41,29 +42,29 @@ check_counts()
>  test_bpf_counters()
>  {
>         printf "Testing --bpf-counters "
> -       base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | awk '/instructions/ {print $1}')
> -       bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
> -       check_counts $base_instructions $bpf_instructions
> -       compare_number $base_instructions $bpf_instructions
> +       base_count=3D$(perf stat --no-big-num -e "$event" -- $workload 2>=
&1 | awk "/$event/ {print \$1}")
> +       bpf_count=3D$(perf stat --no-big-num --bpf-counters -e "$event" -=
- $workload  2>&1 | awk "/$event/ {print \$1}")
> +       check_counts "$base_count" "$bpf_count"
> +       compare_number "$base_count" "$bpf_count"
>         echo "[Success]"
>  }
>
>  test_bpf_modifier()
>  {
>         printf "Testing bpf event modifier "
> -       stat_output=3D$(perf stat --no-big-num -e instructions/name=3Dbas=
e_instructions/,instructions/name=3Dbpf_instructions/b -- $workload 2>&1)
> -       base_instructions=3D$(echo "$stat_output"| awk '/base_instruction=
s/ {print $1}')
> -       bpf_instructions=3D$(echo "$stat_output"| awk '/bpf_instructions/=
 {print $1}')
> -       check_counts $base_instructions $bpf_instructions
> -       compare_number $base_instructions $bpf_instructions
> +       stat_output=3D$(perf stat --no-big-num -e "$event/name=3Dbase_$ev=
ent/,$event/name=3Dbpf_$event/b" -- $workload 2>&1)
> +       base_count=3D$(echo "$stat_output"| awk "/base_$event/ {print \$1=
}")
> +       bpf_count=3D$(echo "$stat_output"| awk "/bpf_$event/ {print \$1}"=
)
> +       check_counts "$base_count" "$bpf_count"
> +       compare_number "$base_count" "$bpf_count"
>         echo "[Success]"
>  }
>
>  # skip if --bpf-counters is not supported
> -if ! perf stat -e instructions --bpf-counters true > /dev/null 2>&1; the=
n
> +if ! perf stat -e $event --bpf-counters true > /dev/null 2>&1; then
>         if [ "$1" =3D "-v" ]; then
>                 echo "Skipping: --bpf-counters not supported"
> -               perf --no-pager stat -e instructions --bpf-counters true =
|| true
> +               perf --no-pager stat -e $event --bpf-counters true || tru=
e
>         fi
>         exit 2
>  fi
> --
> 2.53.0.1018.g2bb0e51243-goog
>
