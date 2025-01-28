Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC531DEFE1
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087192; cv=none; b=gWCT67Xa34FV4c6l0KD0MJ3cp50UY/Gs9S6JWXd7krTsOzfPzds9bYOX7scKbds7+1Kj4XAqzOgqFtSpctS24pzauHtInJ61sFZr8z2xQulg7RYPWR7007772gx6dxeY62awxt4I6JNiGh2KZDpE6UqTA625vumWgeaLs1aHq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087192; c=relaxed/simple;
	bh=sYmqDoN8q0fWwhw9eUHrMkC0JGm8cBbadNZ0DdPCCgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHnW7z9+WaN3aTpOix2r6q+s1dPt0dPpLSnl34tRVjpaQXCmrYPEHcHgspLvMe5YhnyOBkEZFDh4PhMGjZqHAXJXIqCadnZZCge7ELgIYGNi8k5Dq9aIIMzT2AuarhfTIBVB2CAEoIXaWo4w5k4JQDBizIMMlCFYoUPwcFgNx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=no37j5Tr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="no37j5Tr"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a814c54742so185685ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738087189; x=1738691989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02rlJzubk6yMvT1SXq41RuotrGdPS4bPXZs2MEEuGp0=;
        b=no37j5TrRZLhb4w5cZ4OCq5D7wyfnMrrB6L+3Yz9u+KA6vKwoS61FiSh5EKmT4Yn0i
         v6R6OrVvA3g2XWgeNKB3z/yohUA6M/4IZ8+n2ld5DFo024aXFkgxh2J10rix1T209okO
         rIRcaybY6/eRrLHWuNa0QehsFS7PksIqbVSV5kJoatDH9Webr0uzaPcjixeMjxLskMN8
         P4MUNM9rKhdCMvYN7M89yAt46qJL1mOP5cCaFYlX9iEY14+4CR4ZK/fQG/77jcVMxzRQ
         xeqLLdKa0rnfIYSXgdj27+2MLOVEWlHhQti1rgZaYNfY6MtlNrEfsqOJC9iMDG4S78Mg
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738087189; x=1738691989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02rlJzubk6yMvT1SXq41RuotrGdPS4bPXZs2MEEuGp0=;
        b=jYwRA1bhqSKaPQ8XHvxEUavyiUqZ5dgWZMsnKp2rmkb02zPqkPrEw3SHoe2uDAIqXg
         m9OafZnI+UFoMLc2qvBsyPXcSIAW/mIjeUpTo6fArY/yhOlaiZ+cUZQksakVNg885JSJ
         hDDnKCMeEyFialCdI9GFfcrFiJYwhdWTfhemlj/HqOFCQ1wpE+/RvRlID38lr92/B7L3
         Y3UHX7NPZvsnEOpwcKdmxunUq61sxJivbex8t87wZhKJsGbZpBm87oBiX8kuBkgO6QkD
         8u9IZNzvuqRKgyMPx+pLal0LBhz0hba03mBGYAvtyVrMKUNQ2xWQ8Xc6cNiMTVhky88y
         QXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlfsqhSeJOpO8OgtlT52WJRUHK+tEiMNSRCs8JGWrc6jvnZU+86xIxc8O+czqH59/dqunGH9mBTDMiHw55a40B@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsrWt56N4QPoZJRRuoQQaDbceXZLvg1G7I7paM6N9zolc75fB
	EFIadxQdnXaHMIPq/OnKgO3U23y0PKKloxs+VKFWvP0Fx5SNb/6RQVttxTm0INBPSds6eDG9NO3
	mE5Louzm8yEowI9i7Bsqwgb/LZSHh77fGlLud
X-Gm-Gg: ASbGnct1nyjQMREcCUZthu7UcChWcDleAkSl3IbjjgRwWbuXzuqHOe5GIZzrQ8HxFLl
	erpzaCNzCIN4dcdWJOAtiuYnRRvvqW/1DQycxHJg32OiQXyxiZ6juDOoA7SsCSyOAF8JA4QKEXh
	ZJMhBjlsZC21VTFR2J/aYqJqJ+
X-Google-Smtp-Source: AGHT+IGF1Pkac0UrR+rTiU2rTzjCBfNIk9UPopagwZflmHzWS7FzFNiphzw7CO8zeGt/sy5DMM8jNsAxk4ED3qBjXEc=
X-Received: by 2002:a92:d383:0:b0:3cf:faab:fc5c with SMTP id
 e9e14a558f8ab-3cffaabfe00mr1605635ab.15.1738087189295; Tue, 28 Jan 2025
 09:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128043739.256305-1-irogers@google.com> <Z5kW69biAERrAFxe@google.com>
In-Reply-To: <Z5kW69biAERrAFxe@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Jan 2025 09:59:38 -0800
X-Gm-Features: AWEUYZnjtxmPYWzgzUK2OmqyikoKV-q-hCnIKghOwj_QjLQGLQBijWTGOznm5Kw
Message-ID: <CAP-5=fUw2v9+Ufai3HQBUB8LcHNDL=88w+J2SZtunn_B4iLGiw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Skip Intel TPEBS under hypervisor
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 9:42=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jan 27, 2025 at 08:37:39PM -0800, Ian Rogers wrote:
> > Intel TPEBS test skips on non-Intel CPUs. On Intel CPUs under a
> > hypervisor the cache-misses event may not be present. Skip the test
> > under this condition.
> >
> > Refactor the output code to be placed in a file so that on a signal
> > the file can be dumped. This was necessary to catch the issue above as
> > the failing perf record command would fail without output.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Fix lost :R and use :p with record as it is ignored by perf stat.
> > ---
> >  .../perf/tests/shell/test_stat_intel_tpebs.sh | 36 +++++++++++--------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/pe=
rf/tests/shell/test_stat_intel_tpebs.sh
> > index 695dcb93bb5e..a330ecdb7ba5 100755
> > --- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > @@ -20,31 +20,39 @@ then
> >    exit 2
> >  fi
> >
> > +stat_output=3D$(mktemp /tmp/__perf_stat_tpebs_output.XXXXX)
> > +
> >  cleanup() {
> > +  rm -rf "${stat_output}"
> >    trap - EXIT TERM INT
> >  }
> >
> >  trap_cleanup() {
> >    echo "Unexpected signal in ${FUNCNAME[1]}"
> > +  cat "${stat_output}"
> >    cleanup
> >    exit 1
> >  }
> >  trap trap_cleanup EXIT TERM INT
> >
> > -# Use this event for testing because it should exist in all platforms
> > -event=3Dcache-misses:R
> > -
> > -# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than =
as above
> > -alt_name=3D/cache-misses/R
> > +# Event to be used in tests
> > +event=3Dcache-misses
> >
> > -# Without this cmd option, default value or zero is returned
> > -#echo "Testing without --record-tpebs"
> > -#result=3D$(perf stat -e "$event" true 2>&1)
> > -#[[ "$result" =3D~ $event || "$result" =3D~ $alt_name ]] || exit 1
> > +if ! perf record -e "${event}:p" -a -o /dev/null sleep 0.01 > "${stat_=
output}" 2>&1
>
> Shouldn't it simply be
>
>   if ! perf list hw | grep -q cache-misses

No, because that would succeed even if precise events weren't supported.

> ?  Doesn't it work on hybrid?

Untested, but I don't see a difference between grepping an event from
a file to using a match in a bash line. Neither specify a PMU so it is
unclear to me why you'd think this would break.

Thanks,
Ian
