Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DC2753E3;
	Thu, 13 Feb 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487864; cv=none; b=BK8WmkLsEk62+WMQEUrLWTUr6vLfsx1jHDBPTGTvhwV1usrdwVZzUeOj0Z72AOB57ghGHVL03JjlMyI3U0Q3ROhPY2IBXFdPzlk+EdUwctkgcCZRkOHeRfI/tCMNZ6YMmgAykXrb15AFuZJBCvoTuv+82fg7wyJGgsVFpttwQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487864; c=relaxed/simple;
	bh=tME1r3eb+npPg/cagYeysBtN5xwt6+HUGL9+C4YO+mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faHDPKjE/r9UWaOnJ0Zk+ycSbq+wgFrHJVwCNaAVxXzywPe9aCiow66WDv/1v3mqP/5RkoET0IycoehmJjdKzHZfXOuUv1nCf2NpeDs8WqeKD6N4kXO9HixVSCF6Kxa92JCPFr8xQa6Hti1L3yVWzKyJ87qdNlY41sYe4GZgAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK6/eUE5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK6/eUE5"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5dab3f37b1so1245684276.0;
        Thu, 13 Feb 2025 15:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487861; x=1740092661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAtgzun+5n0rcj2XnaUrKKmrlHyN6u/EkKA/VMQ6U98=;
        b=iK6/eUE5KnbmtCtQPJ8u4pUXNYvN4l3rbXKA96eBlVAJ44qpAnUS/i0GU+5gVv1dDC
         VN0yr2u0ty/iDNYM6kgDolUAx0y06nWCUr+5AeTCKuYh2HyLkaBLJPvnNqK7xGQGt31L
         x/1VEZx57KukYZLsLUiPyPrW/cXZW4+Ysv7Y3vvZWMWPuyaNkqrfP2G0ji4fkwEUcRvK
         PWo//4tp4ZNOXHkTYgsdvJuRC84du+l2K+3YtHGEMk/wbYIpLaLtWPZKRglNpxu8Tsr5
         dHM1CcFFyAV3kbzMQRuO7H8K3TtFL+SnoU8ThkpEV3klk4ooL5ymsQhyZWnXBWZWblJi
         LGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487861; x=1740092661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAtgzun+5n0rcj2XnaUrKKmrlHyN6u/EkKA/VMQ6U98=;
        b=ZPVWHtonTvQUe3pTAn99jKKOzsBtxsVCf7x2OJYgPW0H9eCb1JJyp+t2UkCsYpeP0h
         /QuoRNkbLDGNEwV/elSj7ch6bT/TMLI3YmQ/QKhROPfE2UWhWPbGDKd1gJnlcaYNU37h
         NuK7HL07lxXSXuh7ljTQ/BdntnmbW28xk7GAlkCdWg35YlcZj3Bm6+uLbzJ2Q5dYw3ph
         uwiItKUHjKjwzEYx4utY6e3i1KLt275rnFJmpZOHTWqmKlfM9sP5G1B/SeNrHpR55I82
         LIbkAJP0NzHAaLBMMShc5pjb5uFt8RWYTzLS9wD3AGkaWNb25IhWiVD1J1PavbZGvH6d
         TH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVURMlT8Wq/2tf9VlWWNF5X0otHmuZMGuUN9W2jMuv5Mmdygcs7sasK1HDkBGlIDyA6ITBa2pkDQAyJiyqGwEn6cQ==@vger.kernel.org, AJvYcCWp2pDq86f70ga+DoS/sxmTNne6UXpHjlap13kpc3Lw12VyQrpGmoJi6Sy9O5SGS8MSuo1JpuVgBTAFn38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMuaKmfYa97Ou5ImwCxyPS9wbqJ+iAJBYJVvw1ch+pcczDpwV
	LkmTz0RyGJcFj1PGoXiqvJQtKHBFWDDb0Rrs8X5SJysmOJv6/kX4AvgY5eQezbMGIlAQDyc7Pcz
	DR+Z6zvlzkbUQEBPxNDTEU2vIbW8=
X-Gm-Gg: ASbGnctvQwRgL06NzMTj3OnSng1BsVzxeMlso6ZTMhqzkWh+uJlNs4lU8LQIgNgvoSP
	I6u96GUcJAzqHIxgGpqx0eZ6qhyGKAiZuWhHGRJhZwT/93q6upBubV8eYDWXQ4Eo1rCkIZAg=
X-Google-Smtp-Source: AGHT+IFfEcuumnjY0wg8gMe/YN/sduK2x9y4CiNR9eS7oQNbPVerOrGlImvJU5L9JR6YWnmDFWO53VTEVNHTkaqbcvE=
X-Received: by 2002:a05:6902:2187:b0:e57:fb5c:7ae3 with SMTP id
 3f1490d57ef6-e5d9f0fa8damr9103494276.17.1739487861402; Thu, 13 Feb 2025
 15:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213230009.1450907-1-howardchu95@gmail.com> <20250213230009.1450907-11-howardchu95@gmail.com>
In-Reply-To: <20250213230009.1450907-11-howardchu95@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 13 Feb 2025 15:04:10 -0800
X-Gm-Features: AWEUYZnjqMUN_SQ7AaTKaqUzSczx-HzzLpHHCUzqwStvuo6rz9p2P8e7_2YWOv4
Message-ID: <CAH0uvohY6fBaJvMZNi-fcHEW1Dw7Zp5Q_+ZxNgcaaFary-3sWw@mail.gmail.com>
Subject: Re: [PATCH v15 10/10] perf test: Add direct off-cpu test
To: acme@kernel.org
Cc: namhyung@kernel.org, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 13, 2025 at 3:00=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Why is there a --off-cpu-thresh 2000?
>
> We collect an off-cpu period __ONLY ONCE__, either in direct sample form,
> or in accumulated form (in BPF stack trace map).
>
> If I don't add --off-cpu-thresh 2000, the sample in the original test
> goes into the ring buffer instead of the BPF stack trace map.
>
> Additionally, when using -e dummy, the ring buffer is not open, causing
> us to lose a sample.

Just noticed that this commit message is wrong, should be:
"""
Add tests for direct off-cpu samples and --off-cpu-thresh option.
"""

Sorry.

Thanks,
Howard

>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-11-howardchu95@gma=
il.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/shell/record_offcpu.sh | 71 +++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/s=
hell/record_offcpu.sh
> index 678947fe69ee..c5d6cae94c65 100755
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -7,6 +7,9 @@ set -e
>  err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>
> +ts=3D$(printf "%u" $((~0 << 32))) # OFF_CPU_TIMESTAMP
> +dummy_timestamp=3D${ts%???} # remove the last 3 digits to match perf scr=
ipt
> +
>  cleanup() {
>    rm -f ${perfdata}
>    rm -f ${perfdata}.old
> @@ -19,6 +22,9 @@ trap_cleanup() {
>  }
>  trap trap_cleanup EXIT TERM INT
>
> +test_over_thresh=3D"Threshold test (over threshold)"
> +test_below_thresh=3D"Threshold test (below threshold)"
> +
>  test_offcpu_priv() {
>    echo "Checking off-cpu privilege"
>
> @@ -88,6 +94,63 @@ test_offcpu_child() {
>    echo "Child task off-cpu test [Success]"
>  }
>
> +# task blocks longer than the --off-cpu-thresh, perf should collect a di=
rect sample
> +test_offcpu_over_thresh() {
> +  echo "${test_over_thresh}"
> +
> +  # collect direct off-cpu samples for tasks blocked for more than 999ms
> +  if ! perf record -e dummy --off-cpu --off-cpu-thresh 999 -o ${perfdata=
} -- sleep 1 2> /dev/null
> +  then
> +    echo "${test_over_thresh} [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +  # direct sample's timestamp should be lower than the dummy_timestamp o=
f the at-the-end sample
> +  # check if a direct sample exists
> +  if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F even=
t | grep -q "offcpu-time"
> +  then
> +    echo "${test_over_thresh} [Failed missing direct samples]"
> +    err=3D1
> +    return
> +  fi
> +  # there should only be one direct sample, and its period should be hig=
her than off-cpu-thresh
> +  if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F peri=
od | \
> +       awk '{ if (int($1) > 999000000) exit 0; else exit 1; }'
> +  then
> +    echo "${test_over_thresh} [Failed off-cpu time too short]"
> +    err=3D1
> +    return
> +  fi
> +  echo "${test_over_thresh} [Success]"
> +}
> +
> +# task blocks shorter than the --off-cpu-thresh, perf should collect an =
at-the-end sample
> +test_offcpu_below_thresh() {
> +  echo "${test_below_thresh}"
> +
> +  # collect direct off-cpu samples for tasks blocked for more than 1.2s
> +  if ! perf record -e dummy --off-cpu --off-cpu-thresh 12000 -o ${perfda=
ta} -- sleep 1 2> /dev/null
> +  then
> +    echo "${test_below_thresh} [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +  # see if there's an at-the-end sample
> +  if ! perf script --time "${dummy_timestamp}," -i ${perfdata} -F event =
| grep -q 'offcpu-time'
> +  then
> +    echo "${test_below_thresh} [Failed at-the-end samples cannot be foun=
d]"
> +    err=3D1
> +    return
> +  fi
> +  # plus there shouldn't be any direct samples
> +  if perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F event =
| grep -q 'offcpu-time'
> +  then
> +    echo "${test_below_thresh} [Failed direct samples are found when the=
y shouldn't be]"
> +    err=3D1
> +    return
> +  fi
> +  echo "${test_below_thresh} [Success]"
> +}
>
>  test_offcpu_priv
>
> @@ -99,5 +162,13 @@ if [ $err =3D 0 ]; then
>    test_offcpu_child
>  fi
>
> +if [ $err =3D 0 ]; then
> +  test_offcpu_over_thresh
> +fi
> +
> +if [ $err =3D 0 ]; then
> +  test_offcpu_below_thresh
> +fi
> +
>  cleanup
>  exit $err
> --
> 2.45.2
>
