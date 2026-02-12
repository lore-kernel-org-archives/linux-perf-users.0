Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AE31984E
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931648; cv=pass; b=Nj6cSjyeI8F01OkzXK9MIStDDS1+m20rjh6sXXxl2J+5twMSXdy+POfsAV5qVrMXvhthKChJpKRq//Wx2t91Cb/UAo7Ek0PPKjvM+BbPCP+6TTf/jWKpkcGf9bE2Mu3yzgORX7r6tt8f9DbcL8mQYw2QY5dUpg4Z8kPfGpcaNmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931648; c=relaxed/simple;
	bh=RqZDoM+KzCRMfPAL4J7lghDMSrM3SEh/2f36107mJWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbuPhF3zyLBRhbTIcQtf0M2+R1WO7oQu95OpzohcUd1sk3ZDYTvZ4EitYKcAXlRq3d4QvbBV0RLcDPGa9mGjHC7ClYr+wt4papDWx71xJ62TEr+ypI6yLlS6HLjuhBVf3XJxzAbVUP3fJQARqGUSwB1iCiUD3bv05nepQRNO0qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Feayby4h; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Feayby4h"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a964077671so7215ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 13:27:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770931647; cv=none;
        d=google.com; s=arc-20240605;
        b=IPlthTedHtazlsrTbrsABExmTMKiyNQfYVNnhG7eXoVQYjT3s8ecv/3V1qJ1P8PyFY
         QtS/98JgycOaE+olhx7R/uQ79mDBFn8VImpMIOBCsLaSUClvU/UVYruXFB0Z6FB6qq+S
         QmTxLN98Z3kVGgIP9AuHvZ4ylO07ZMs71OMAHIEhCbrLuH2Bzww8ub+tLYtl7ZI03/AR
         7qZxj47yG2FhG3GZcldWWgXN/GC2ZIJdpQ9ONYdSlM0P+5MiLjEcFT2BHoVYicwumgvz
         fm2lSnMi6YXEE/vllnzP4MuRlgsMmlBBXFIcIx6ZrtxMS4GM3Lw7Su8KHXX59FV2oS/b
         E0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i4Q2Gu/UFguxA8Fq4hwUfyO7IJPks+KO3F0TUWVH/9A=;
        fh=MCVjNX+9RqH9j57SqrfBcQIsC+Hp3PV0H7zv7y7Afoc=;
        b=H5ovgGw3YHVL1CIZPzbdBh8u3X/6qCzbPmxZOH5N/kM0u05bLIKhmgdneGxfoC0JoO
         ulK0TX/zB5kXq1Z+Xh79HaY30OXd2uOltk2vWT810csntz3oIn6D1Yf2/Z3x2QBItQTy
         MhkmwLx2jTKRwqKq8Ic6kyP7VckI9VRrI5zf1T0fCtb4puKXtmylvkWRyq7210ikqyq0
         m89NyvxfnpfVN0f4B5j2tCb3pbPUqi6GNG/hrqgwnjMIycRVwcFEAg89gyL5OQa5rNBb
         NFbidVGV7Yxwuw+3tDswiYz4CoZxBetKiVgylJmJ9y7M9YZ8cUi+/4moSuoINIsw7ln/
         0x7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770931647; x=1771536447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4Q2Gu/UFguxA8Fq4hwUfyO7IJPks+KO3F0TUWVH/9A=;
        b=Feayby4hns75w3knNoPvK0jWh+nTW3Mtz9YWgMEAm3N+ezBb+yx2Q8BIWl8AT54LN+
         AyIEscIO5m0lUBZbhmSszThM+ua1vJ4JLth2oJVbNcaTO1a3xa5/PwB5ijX0P9lDJI0A
         ok3jhSiEZpMPyGUNLqPOklWaeZHad8wQ8XXLqNXeBY7FlN/udTQLFjRkXpU9556trStc
         1/NgZCDmRoW2kBdzlkJ1LaQYxHxb6WJWjia6Gv0xJWm8dwU/hHi5K5104ze7aws1J1q5
         u//vmAzGFfRJ6Tfj25BjgpyT5PkfLnMCmtJs7Ps7pvN+qpGJ3yYYiODKsGrIwQs1ohYk
         p27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931647; x=1771536447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i4Q2Gu/UFguxA8Fq4hwUfyO7IJPks+KO3F0TUWVH/9A=;
        b=p5D4TUHzepN2aBo7svOrCUqlC/zvJ6/eMnt0YArzY97jMy1HluOnv6am8bLNo47GoY
         MdVIXtzgG9sdG2oafChhHgb7V/65GdvrJMWRUMiSjwVvD5Inabg+bKhlpPgXw+lQuxpU
         cug1BeGgJ4OvAAIWfVm36kERRfWCjD94I9w5JqdP+XVy0sT+r1fMlfpSdMGgk42aQRO1
         82duYSMxvwK71NZC2VqV7f2VmCpkMHVUudOX12b4l+GCPeqFYJJmndgj7zVNDU7AEvS1
         VhBK6DJyBo/tHhvwb6asME9f5jJEu7zyL0pK7aidrm52ubECYVP5Piwy3Mra/RwP6Y9b
         z6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjyVdO7BW1Sbi+InNQBU4s8ktMQ+hdsDUADO6lsndBfki9CV8GW/fXGHEnODVj/PzHKzGxiGqQswu//kjeqFej@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIHdX1PYEvi6chq+FJrDlOFTh1IH499y6rdHc96jU1zbDwhrV
	09EkYzoQP0vTf0QSs9OkuHowpk7m+1Qc2qOxB1LDTISXcveolR3sw2G3gS4hq/H9rPP6dH5ZCsC
	qdgiXZa4RnVa0NeMqVPxsIqcROX2goWN2Gfe1voou
X-Gm-Gg: AZuq6aK+GqhMPC9pT4StTEdrRlQT21YkE34rPXjWZguI6UUUzicTNo9RDMfVbPY2oxM
	T4iFgTqRym7pAT4/EOWiPbhKrYiDRc3hWn2fBWbUPDfPBzmci9CDpQn3jkPhLP24W2o7wS3x+TL
	aW7n+qwYWYtMly4xI8kFeVcYFW03lUJEVvQNujrFWsAhF3yf5BhuXACHmsR6JlfYMIiya5pNXQa
	85ZggNSLpqXeHjyaDBG+lXjgt132jO0qS+Q3pHsbJKqaGaKi4pFB14YLS80ySVhGYfFHa31anZC
	kcessz427mK+akfJkznRJ7lDwoWrV8Cytl+X
X-Received: by 2002:a17:902:ce8c:b0:2a0:867c:60e2 with SMTP id
 d9443c01a7336-2ab4e010779mr140235ad.19.1770931645453; Thu, 12 Feb 2026
 13:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYx8HIerWMAQguUs@x1>
In-Reply-To: <aYx8HIerWMAQguUs@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Feb 2026 13:27:13 -0800
X-Gm-Features: AZwV_QjmnxqmF6xqgDP1cjBY56aTed-EUiRMRpQQAJ_6qqWy4-Ihq56txrQ5NZQ
Message-ID: <CAP-5=fWzqvY3FZENqM8hw6kLxsajfu7vKOZnNaGR9k3sACS79Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf test data_type_profiling.sh: Skip just the Rust
 tests if code_with_type workload is missing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 4:54=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Namhyung suggested skipping only the rust tests when the code_with_type
> 'perf test' workload is not built into perf, do it so that we can
> continue to test the C based workloads:
>
> With rust:
>
>   root@number:/# perf test -vv "data type"
>    83: perf data type profiling tests:
>   --- start ---
>   test child forked, pid 2645245
>   Basic Rust perf annotate test
>   Basic annotate test [Success]
>   Pipe Rust perf annotate test
>   Pipe annotate test [Success]
>   Basic C perf annotate test
>   Basic annotate test [Success]
>   Pipe C perf annotate test
>   Pipe annotate test [Success]
>   ---- end(0) ----
>    83: perf data type profiling tests                                  : =
Ok
>   root@number:/#
>
> Without:
>
>   root@number:/# perf test "data type"
>    83: perf data type profiling tests                                  : =
Ok
>   root@number:/# perf test -vv "data type"
>    83: perf data type profiling tests:
>   --- start ---
>   test child forked, pid 2634759
>   Basic Rust perf annotate test
>   Skip: code_with_type workload not built in 'perf test'
>   Pipe Rust perf annotate test
>   Skip: code_with_type workload not built in 'perf test'
>   Basic C perf annotate test
>   Basic annotate test [Success]
>   Pipe C perf annotate test
>   Pipe annotate test [Success]
>   ---- end(0) ----
>    83: perf data type profiling tests                                  : =
Ok
>   root@number:/#
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/t=
ests/shell/data_type_profiling.sh
> index 3ef72a10850d0734..2a7f8f7c42d094a2 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -4,11 +4,6 @@
>
>  set -e
>
> -if ! perf test --list-workloads | grep -qw code_with_type ; then
> -       echo "Skip: code_with_type workload not built in 'perf test'"
> -       exit 2
> -fi
> -
>  # The logic below follows the same line as the annotate test, but looks =
for a
>  # data type profiling manifestation
>
> @@ -42,6 +37,11 @@ test_basic_annotate() {
>
>    case "x${runtime}" in
>      "xRust")
> +    if ! perf check feature -q rust
> +    then
> +      echo "Skip: code_with_type workload not built in 'perf test'"
> +      return
> +    fi
>      index=3D0 ;;
>
>      "xC")
> --
> 2.53.0
>
