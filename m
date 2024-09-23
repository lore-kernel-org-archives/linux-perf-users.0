Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D01FA5
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117529; cv=none; b=MlR9TGVye7qfy21Y91fe3xjW4Mtb2O5tqbZ+uqErIW13ikIkBI4NWUPb1YcGTB+pkP5Xrx3MJWEhnXKo8JkCCMZcQGFdDyDHVfcxTbn0F+ZV1Pfb7yTCsJMaLb2r1f1FyWTEttLndf0mtrQnIvaC1k1BhJJis/LG/KF1lvtSXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117529; c=relaxed/simple;
	bh=zLpUr1SxnEAF71ZZ0b+lxYmH+BbaNSeMXUJA3JUB1Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Cv4yzJu+9MlfvVl2cd92NZ/iyyuHIzLTpmN248BXTjv2VWVWhHk8QHarf26v1dzlRsWJBrpk8W4KkB4PnNT8LXPsIG5DalG/w+8WKAZzTEfqy6QcYvKecFLNufwIjLFhqd9BVzSedlmuNYqZ8acRA10oPGN6HKOg/0Jpe7d2XAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUKWUStb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUKWUStb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2056aa5cefcso27155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727117527; x=1727722327; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXmMrEY65D+AePLk+PY6S5yXHIk7WNDJcw3IWnzcWek=;
        b=hUKWUStbPz0/lVAoVSGzHiy8Xw3nsjdBIHN3lF00Cg4P1/pfze4uFEX+EhZQoLviWj
         ZEuhaLaUCNr1WXkv2VPjrpnnpMeem+OeY5wffs9f5zBbZohsIMxvyw8GmPwtlIGfOvlP
         jLKhwfGPJTJa0qDft/kALSDiaepz6/lHU2FgpXVetxFNp+N+OpCeuNG1sFxWUSmR4uyM
         Ycx1WH05KVP3tUtyFk21heqF44lfiWMmhOtKc/0gDz0QLxXp8gTgsHhV13lCLfh3BsWc
         hKH5EJ7QvNSmqYMEQc9/gZtjb1i3VOHP+b3ynydIUzoVbBE0ny2Ou78olOrYVCuBxrpW
         BtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117527; x=1727722327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXmMrEY65D+AePLk+PY6S5yXHIk7WNDJcw3IWnzcWek=;
        b=cZW5SRKFy4kEIEDkF0VrLUpjgBSYEixKIWpPzJuDZ37u+/+XTZUYnZBJXmoHHgaF/V
         F2YkKp2sIZV8IbtMyUeJzUKRGswxtmoZLeF3CewONVSp4vXguRU6iVgYosAvvASWs8fv
         AlaPQD+gOu7mMuPQp5pHOgbG4USS/p0ol5+L9s4UB1aWN+EPufVzCqPxYogmoEWOJBaG
         PSktsgR2nb8SKEswbp0y0SiJ4nV02BFuVRroMFhtPqYcZqch3H+IcYSuQRZmvhdZKCeM
         UE23mD3g7mIi9MjkNZpLMZja45b25HR5lg489oPgw6jdgPDJuXvCFdtSLsUJHCJ1kW6z
         w/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXgTNHA80GdRX5k217WwEI1zBC6IaHg8g+JKWbIQqtxEBoeNb5zh019VghUEhSuCWS2hu+vYLjY6ADWTmknD5i3@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOuFyHqMM8LhLQbBkYXy7XREX2WqIZD2Uo+WOu2x0eE0S3m+Q
	Usc2EmxE7IX839TXNUUF9HikrlGvszS9GjWaAybOwFrYP3xJtl3yTkVb6LMuZpgavE3sggC+SD1
	NrWYfqLMhXJUjyE4Wo5lVSg854YAzFpbMOPsj
X-Google-Smtp-Source: AGHT+IHhtTzu2ptbvGN+YZHo5PJz5j6+4vOkPRlt/xchM9K51k7a14RCaGHYbGk/xjJ2jQV3gdSH2Vc/n3mWPlU1B1Q=
X-Received: by 2002:a17:902:db02:b0:206:aa47:adc6 with SMTP id
 d9443c01a7336-20aef38cb7emr254245ad.11.1727117527029; Mon, 23 Sep 2024
 11:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502223115.2357499-1-irogers@google.com>
In-Reply-To: <20240502223115.2357499-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Sep 2024 11:51:53 -0700
Message-ID: <CAP-5=fXGaLsnqd2DdEx-+9V8tO6Wi_HNFgzrGdhdFo5nFSCb9w@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Be more tolerant of metricgroup failures
To: Veronika Molnarova <vmolnaro@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:31=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Previously "set -e" meant any non-zero exit code from perf stat would
> cause a test failure. As a non-zero exit happens when there aren't
> sufficient permissions, check for this case and make the exit code
> 2/skip for it.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2. Add skip if event mode isn't valid in per-thread mode. Suggested
>     by Veronika Molnarova <vmolnaro@redhat.com>.

Ping.

Thanks,
Ian

> ---
>  .../perf/tests/shell/stat_all_metricgroups.sh | 36 +++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf=
/tests/shell/stat_all_metricgroups.sh
> index 55ef9c9ded2d..c6d61a4ac3e7 100755
> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -1,9 +1,7 @@
> -#!/bin/sh
> +#!/bin/bash
>  # perf all metricgroups test
>  # SPDX-License-Identifier: GPL-2.0
>
> -set -e
> -
>  ParanoidAndNotRoot()
>  {
>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid=
)" -gt $1 ]
> @@ -14,11 +12,37 @@ if ParanoidAndNotRoot 0
>  then
>    system_wide_flag=3D""
>  fi
> -
> +err=3D0
>  for m in $(perf list --raw-dump metricgroups)
>  do
>    echo "Testing $m"
> -  perf stat -M "$m" $system_wide_flag sleep 0.01
> +  result=3D$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
> +  result_err=3D$?
> +  if [[ $result_err -gt 0 ]]
> +  then
> +    if [[ "$result" =3D~ \
> +          "Access to performance monitoring and observability operations=
 is limited" ]]
> +    then
> +      echo "Permission failure"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +    elif [[ "$result" =3D~ "in per-thread mode, enable system wide" ]]
> +    then
> +      echo "Permissions - need system wide mode"
> +      echo $result
> +      if [[ $err -eq 0 ]]
> +      then
> +        err=3D2 # Skip
> +      fi
> +    else
> +      echo "Metric group $m failed"
> +      echo $result
> +      err=3D1 # Fail
> +    fi
> +  fi
>  done
>
> -exit 0
> +exit $err
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
