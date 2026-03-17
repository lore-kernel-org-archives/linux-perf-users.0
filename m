Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13262DA756
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763083; cv=pass; b=nVYa/uJDWfVB+reS9vopfN4sR6cn5aaiXGXN8/GEnyftzo4wONtgu6X/mPw0eaeiKbWyYrhlwv2RAx+Bu69AOpcBEF5FhaveoaGjpaOnVM16FwTvd6rY+acbDbbRJjOTEcM8zF3nAzJHXOUK2RbA0Cl1AcPyorlLkJ8MlaZ6XZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763083; c=relaxed/simple;
	bh=FpVJKWoAP8Q+O3yUtt7eVFUQooIj80V1twyl9biRNBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5KOJ8il1Rd0gyOPV2jWgRP2zuPpFDHGvScxz5tal+IGMA1H51udXV4NtGfaBctJ0tkP58IMHLwfLX8D+Cpq7kga5UBlRku+Ydpop83/B7zPF7T3nFEA+HQ6C9+asYvDyb8mGSY9gG1hcyTs4rKuu+VmmHJd5HsF/Az80ON/ZMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlInDSSS; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlInDSSS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so94635ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 08:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763080; cv=none;
        d=google.com; s=arc-20240605;
        b=PHD+CCYS4leXB3qiwaM0WhSaQhpLg0r0+nizf8bvbKinBNT6G8f3rEVKEOrm9+Wc3l
         i4cmrBJtW4rGf5V0aVxDgt8fyT/7epjrQscEkwm99ICMsSH8rbJwxv6r/FFEUsMWhYbl
         t4MXUHqPq10wiezM8ia7esApild8hi6RXFDO3ahW4kCwIBfH33sLZjU2Pi8qKn2PVUWH
         Q+QB737qXOHUbcVRdzSj6cix8j+pGYJw7iJXkffKYLxk4QD7KZEtPDtRt5b5DaEUA1YA
         3gadz+fCVtj4ERz+PmnnLFu4jYKdmr5ny+xbi2Hy/BaGGhDOpyoKZAM2z9g2oMR8A1+m
         MiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nJlQgXhNC6o+XDgLnffDGT6DTW23Wmbf2a7EXFBYx9Y=;
        fh=Gx9hZ2kK/6Oc3oWzcf8R83Sz8fN+9r/LOV7yBeFj7Z4=;
        b=gY4YMgKXP4ucwwXaz5PAIeezJv9YZfxteg/b2MaU//ExtXYzsCAEW5MAl2Vi1gcVtg
         zbhkC3Hd+FSG1hD+pBCWfTLlVqUjJf8YlJ6CHDC8Xg2Q2nZdopq16tLHKjxfErbbYS/q
         IQp6uppQa4UAv0Cdpy3CYttDQtVt7MyNaCOzQ7AF3h1ARV/3Ost0UtLkJWuxyKp8CDHW
         8u9AzOGQ8zHo57fUqoTfNxIWz6RYtchoaTknBcGD618NKkgR/IsL6C1ppy1bMFObgpsU
         J9702usIcXBYezNM5TL/ICJlvjAwL1beBv/d8w20bGb8r1qoZc8ZBiwexsOiQn585Sqx
         UDoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763080; x=1774367880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJlQgXhNC6o+XDgLnffDGT6DTW23Wmbf2a7EXFBYx9Y=;
        b=dlInDSSSgt6t/wEOUeHUFLvZ4RYzw0FFwp9IHmf2ufD+vkCjUmxcb+U9LWULOqiGfQ
         PwiObmgQ1v1AkXixcZM68IPYlDpoUIL+JRI3ZC28EhfpFz10M5JxB7IYZm6Q1rMumE8G
         uwEiLCZABnc9h43UeGDkw5T0YeNM4r4dBjGmtavC+4ovjhQg+pBo2IGK7ZhGJTzBPecQ
         +54vs7qlLiLg+8Mbvn5v2sv34Uoz1xYdla50b8m1NVUp8qDXT2W5hS7zF6CEM6MTkbFr
         cImBsgWLhGu4oeC4HTMiv3r1Q9O3KPJx6MBCHWXxywRIGEdPGiDa0G4BsQHxcGjcWyoC
         378w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763080; x=1774367880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJlQgXhNC6o+XDgLnffDGT6DTW23Wmbf2a7EXFBYx9Y=;
        b=UHbG3Onm+QY5Zbjpj+6z17b055W0+08tonutq+2X59zWek3/xj30HPR4a8MZ2Yjas1
         oy1bDQr2hATsIQZNlswBk4bbU0n6dZLVtCNvmDyeqwJgmdVr1SRRGq7xdldz0HsURRvx
         SE/lAZXSdEFP5zzh78ALFvL4Oct1EkmhotouDDlCmLQnRGyX7mywR7cNActdwXp8b1p5
         V6YJefsldyIVZvzzGQGaPKN3gN3O0k/87kf4+fXr1mL60Fl6ixCEQBESTtnVJtrEEwcH
         ftV7Ff1Ka7u4Fx9lDY3RlOBHrVnHdERw31PmQKhWxs8IljjzO1rCmm+rXDjKJ6Ym9JDZ
         9GEg==
X-Forwarded-Encrypted: i=1; AJvYcCUEfDSKpBGouQzHhFjFOR6LLyHkzxMRZObL12ddkCLzYuvKFbDM6HCfUQ98v9wrKnCOWAXLIovwhwCuWucdqKPt@vger.kernel.org
X-Gm-Message-State: AOJu0YyI56PgHCQokGfRIhiY8wrk0oGXk8DTD/2hVmhtWzhcpdEMpxtZ
	13jjdaBSp118VfQUV5TqBYdmh2Rm27jkaSisMD4NG8yNl2iZdaHX9cclYZc51UQRICZddPMKS64
	5iiZ0zydC+Lksi6TQJS2aArbjFfhjIllqiPWuIHzn
X-Gm-Gg: ATEYQzxWIlp4UyOuUwwOeRzNwmLkmX6mRjKyYzoiDvmxd5mbM4S7J1rOX3ygeh7fH4r
	QfImvBDxjJjgc39xdZA+p8s07BQcyl2l9dSm22DDfa+x620qRKckFMttDfJ7kg9zZEwOA5y2IyS
	huaHlLl8hLYE32GJcMzMtwQ2rs7oT7u6yoQdOXH3TmeWbQnSN3jqp/hnJHNUxNFnN6dWXPpcNiM
	tpUAVhkIKFFCH2cyzDeMc72bH0wjkv539IXm1GNDZOHGA7oAuYOIR2FttlrQAxj10x7Kc1bOC3p
	h1Qo8qqp
X-Received: by 2002:a17:903:32cd:b0:2ae:c358:bb9f with SMTP id
 d9443c01a7336-2b063f0b355mr3286165ad.10.1773763079537; Tue, 17 Mar 2026
 08:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317070032.41934-1-namhyung@kernel.org>
In-Reply-To: <20260317070032.41934-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 08:57:47 -0700
X-Gm-Features: AaiRm52mlxH7ugoAvbqhwxncus-wr_xj_dtmYlhwklkgyvOEXWtLveK99qSH_hQ
Message-ID: <CAP-5=fWsjTbwjzcv6Lj4Byzy-h19qQx4-hWVGofRj6dnwH3a5A@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix perf stat --bpf-counters on hybrid machines
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 12:00=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The test constantly fails on my Intel hybrid machine.  The issue was it
> has two events in the output even if I only gave it one event.
>
>   $ perf stat -e instructions -- perf test -w sqrtloop
>
>    Performance counter stats for 'perf test -w sqrtloop':
>
>          910,856,421      cpu_atom/instructions/                         =
                         (28.05%)
>       14,852,865,997      cpu_core/instructions/                         =
                         (96.79%)
>
>          1.014313341 seconds time elapsed
>
>          1.004114000 seconds user
>          0.008174000 seconds sys
>
> Let's modify the awk script to add the values for each line and print
> the total.  That way it should work on any platforms.

Thanks Namhyung! Sashiko noted a regression in the "not
counted/supported" logic caused by this change:
https://sashiko.dev/#/patchset/20260317070032.41934-1-namhyung%40kernel.org

Does this modification to the awk script prevent the detection of unsupport=
ed
or uncounted events?

When perf stat outputs strings like "<not counted>" or "<not supported>",
the first field is "<not". In awk arithmetic, adding a non-numeric string
evaluates to 0. The script will output 0 instead of the string.

The check_counts() function explicitly checks for these uncounted events:

  check_counts()
  {
    if [ "$1" =3D "<not" ]; then
    printf "[Skipped]\n"

Since awk now returns 0, it seems the test will bypass the skip logic,
proceed to compare the numbers (0 and 0), and falsely report success. Can t=
he
awk script be adjusted to preserve non-numeric strings?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index f43e28a136d3c9bc..e04808ed871e3f08 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -41,8 +41,10 @@ check_counts()
>  test_bpf_counters()
>  {
>         printf "Testing --bpf-counters "
> -       base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | awk '/instructions/ {print $1}')
> -       bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
> +       base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | \
> +                               awk -v i=3D0 '/instructions/ {i +=3D $1} =
END {print i}')
> +       bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | \
> +                              awk -v i=3D0 '/instructions/ {i +=3D $1} E=
ND {print i}')
>         check_counts $base_instructions $bpf_instructions
>         compare_number $base_instructions $bpf_instructions
>         echo "[Success]"
> @@ -52,8 +54,8 @@ test_bpf_modifier()
>  {
>         printf "Testing bpf event modifier "
>         stat_output=3D$(perf stat --no-big-num -e instructions/name=3Dbas=
e_instructions/,instructions/name=3Dbpf_instructions/b -- $workload 2>&1)
> -       base_instructions=3D$(echo "$stat_output"| awk '/base_instruction=
s/ {print $1}')
> -       bpf_instructions=3D$(echo "$stat_output"| awk '/bpf_instructions/=
 {print $1}')
> +       base_instructions=3D$(echo "$stat_output"| awk -v i=3D0 '/base_in=
structions/ {i +=3D $1} END {print i}')
> +       bpf_instructions=3D$(echo "$stat_output"| awk -v i=3D0 '/bpf_inst=
ructions/ {i +=3D $1} END {print i}')
>         check_counts $base_instructions $bpf_instructions
>         compare_number $base_instructions $bpf_instructions
>         echo "[Success]"
> --
> 2.53.0
>
