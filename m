Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3E1C860F
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075694; cv=none; b=G291ZdkEfBWdf7W6DTMKrHzrLFZU+TBL1UqEipNGXmg/6ZTto2E/T1DiDUalTPTzHdRjPBW+mmN2HOJMS0mgPNfJbY0c+MRpLCSN9cFOh95XRKsfO7M9P0IupSt10+RUbypnY1GTGVEOulXlFztqItc8C0srAKxmQtioESmjCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075694; c=relaxed/simple;
	bh=Xmit7PAFU4uPpqTO+SjZ6NNtdOFDOcNlOas8nGvsAEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rVPBFiv5055t1BQRkfhtLB2iCywfAmZKc8DnrV4YdY8+wd/2qsHi5vdFdUz6DBZ9hdHpAGbxHtNoNrbwCn6BsQoGioWBjg/zn49VcumznBICrElt6lKtZWk6oKFcouwqB8QhNRvDhH6uocG/ZNDu87sOby7m47Et0Oor7Y90sSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KARi/7zn; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KARi/7zn"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df371e1d29so67635ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 18:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751075691; x=1751680491; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T13yrZPkm9B7si9lBWXzCrRMrh3WP7v1sQI5IZ/gcdI=;
        b=KARi/7znJnjEDtgrx2aWjQmpD4rsLgsYB4fBHu0SkcLAjUgQPV4a4ElYQ3vDK5VrPD
         /dAc4tperqLy7ZKxncjRIM+ZdyGCnIfOCzObDq149NkDhYL4oa+8bHbJ5GHxt9TDo+Mc
         e/LxsjIPPvImLZrtgL2+qeJmCz/hFaQn5fOZENdyKgTksKaARzvE5Duci9+Cw03OFLKm
         s6g24yEAlrQgJBtcxzfLl55laCAqPZmZxI+vZ7VLTr5As0S6H0J9LXTnLvkJhLM1RMbm
         WzjbUeqLGGATa6B8CL1rxIMXtzeTylXbbFIMwhPRPsFw6SVn3C8pyhZwXIsOhufQnyIe
         wj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075691; x=1751680491;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T13yrZPkm9B7si9lBWXzCrRMrh3WP7v1sQI5IZ/gcdI=;
        b=RCFPtXmR968z/lKbHrMiRBYJhuxvhbxmCfScXzEf4Pha8D7MexYOhfgR6WZatifiQc
         B2fU6QsjQOMNrVcj+yxl1MQR9TmuB+fvPzHK7kUA4fkaKdaHX2z4csn5xnMT7givvvUe
         o/qqLBDyxX5kVqn1idIfd5HfztljgF+lLvclQxCID6WqevD2eSpz0nue8MLJG++6XDMY
         BMjLEip+rIz07RBbsYif6kvBkf1tIXeBs+EW9oEbMJKVSixWKqLQ5KRGp12Kqwpvg7DF
         pN+WF5zNDfwsOEGqc1IHB0lfVASke/afixQTMa085boJiUjKtN95QU1rVM//9mVyiEn3
         I7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWh28qESQR4JxM8WtXXDd/P4e+ByCpXMi2sSdMi0Nl0eLtIGDdjN3zOXTpr8PUVtIR0m3037VA7jbbuejFH6dOb@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlkPyKyVpSfkOU/UabgTSeqP/6UqYkZcZ6WaCWhflPDV5LR4U
	au6p7eGxac8pMEgDwvwSn7YVNM6X6JBz741bjHJlB83RfTNqRaPLfqAcg3AlrryJpMnrQyOzdnW
	ng6tg1O0Dk5OZg8RWFTOJsmHYGY2ZKqrCnOOI9BE4
X-Gm-Gg: ASbGnctCYDjEgj0wOhfKQ4Ijp75cwesqjpyR69tDqCDKzXB+XcEb9uzOVPMZ2Oy91ia
	oIliuWKvLUazRE9ktbk1Pd21JlQeoGYTyrOiQfX/NwgSBFeB4dTAeUrV4XdRNJzE2aeYUR0ss+a
	UiN8QslQXNqGKCOQzatKyCbObUKdmDiAgKc9XxtVjYVR7EA4ylIRdU3rI=
X-Google-Smtp-Source: AGHT+IFpQQ4fOtIBLB86Wq7tv6JmCG4A85mmUdq9+I3p3BAvzDlK0Y/drt/JslpGaqJBeR4C9ceY4Pz6GjNFaZBPegc=
X-Received: by 2002:a05:6e02:1789:b0:3da:7c33:5099 with SMTP id
 e9e14a558f8ab-3df56cf19fcmr876005ab.13.1751075690548; Fri, 27 Jun 2025
 18:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628013543.1250435-1-irogers@google.com>
In-Reply-To: <20250628013543.1250435-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 18:54:39 -0700
X-Gm-Features: Ac12FXw8CFIJ61e5Aa7lUgvBQFltAnW9iM-4-Xw4P0Rrrmipm6VreOKcQ3T-ozE
Message-ID: <CAP-5=fVQEaxsfrCT4kaFu7Ke03fNwbhw8u1V6F045c90MDQ7Gw@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Add basic callgraph test to record testing
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 6:35=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Give some basic perf record callgraph coverage.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Pick up s390's needed "--call-graph dwarf" as spotted by James
>     Clark <james.clark@linaro.org>.

Sorry the version is wrong in the subject, I'll resend.

Ian

> ---
>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 2022a4f739be..b1ad24fb3b33 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -12,8 +12,10 @@ shelldir=3D$(dirname "$0")
>  . "${shelldir}"/lib/perf_has_symbol.sh
>
>  testsym=3D"test_loop"
> +testsym2=3D"brstack"
>
>  skip_test_missing_symbol ${testsym}
> +skip_test_missing_symbol ${testsym2}
>
>  err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> @@ -359,6 +361,33 @@ test_precise_max() {
>    fi
>  }
>
> +test_callgraph() {
> +  echo "Callgraph test"
> +
> +  case $(uname -m)
> +  in s390x)
> +       cmd_flags=3D"--call-graph dwarf -e cpu-clock";;
> +     *)
> +       cmd_flags=3D"-g";;
> +  esac
> +
> +  if ! perf record -o "${perfdata}" $cmd_flags perf test -w brstack
> +  then
> +    echo "Callgraph test [Failed missing output]"
> +    err=3D1
> +    return
> +  fi
> +
> +  if ! perf report -i "${perfdata}" 2>&1 | grep "${testsym2}"
> +  then
> +    echo "Callgraph test [Failed missing symbol]"
> +    err=3D1
> +    return
> +  fi
> +
> +  echo "Callgraph test [Success]"
> +}
> +
>  # raise the limit of file descriptors to minimum
>  if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>         ulimit -Sn $min_fd_limit
> @@ -374,6 +403,7 @@ test_uid
>  test_leader_sampling
>  test_topdown_leader_sampling
>  test_precise_max
> +test_callgraph
>
>  # restore the default value
>  ulimit -Sn $default_fd_limit
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
