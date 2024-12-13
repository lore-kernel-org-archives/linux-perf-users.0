Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794057E1
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060677; cv=none; b=DoCEAtxdyP7ZNSeC+hgUzYOfefBkNWIL9ykYDFaXPcGCS7nBglVwwkKgMtu5x4DhpsO6NsFFhEsyXVthlmHfCiQqVB/zpijNI59dK5MtANMJTtlxuxg8Yxz4GCTks8dF9gKbLWCZ+XlQOq/hxoDMKxXBUUkFw1y4PGOHNikZJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060677; c=relaxed/simple;
	bh=qxhiYi6a2Ku5GEwakKPEn5VPWTIdoMp+zhe19IXXiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVS8uFAM3oKbkhWXE50fVQjBbVF8maZmzd5DOwIttkzPesKmlt0k1zxvRyGKLgb9Ls/mFWeTZ+KbGISANdOV02LQPtdPVgCKZcUv/TB2UFJI7URgG2nMn0fPi52P/KK/MZ1uwuYIkaAIaLc5tQyYimWZlb36PRsU6wzM12GpOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AlovSj4O; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlovSj4O"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a814c54742so61925ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 19:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734060675; x=1734665475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPZsHe+9d6UK2cKEY6UXv1myi2iXWNd+qR0B6b7kmr8=;
        b=AlovSj4OAY/9j+NrfwsnxUcfMyaVcCdioUN40Oe9JwbVWqQApsHADMd8NZ+wbfH07y
         GjdEL36wbOeJfg0/4AoL0wMyfC9Y9XNRzyrINT/1N9bJknvh1tpkggGDAbKCsjvnWYb9
         4FFfkvxLwmk2Id6BCElDbgr1qTrWWjDCanaRnkmIVhf7WNfSJo7Z1sRR3G4zCwSpB5UO
         HX4e281SBQ4nvDkuqz7XN2pVxwZzeQZWn+XJrOtud/NH1EPXylF5I8oyon+6i5xFAoMo
         A0ibOK8lYTy/o5iRCFISG3QLMx6WdzXKPHfB/cpCY7lD8CB5upN+GYJADytGXvLFAWan
         Wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060675; x=1734665475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPZsHe+9d6UK2cKEY6UXv1myi2iXWNd+qR0B6b7kmr8=;
        b=pmIxmZ/FRqDpYwBGmPtba/9jnETsPq0+QyBiFi0WVmLPx6cDeyYm35Jy1QgYZHCqp/
         U9lPfTZBQnFMX2nVBDnI5i3NJTmPiJWAGB0txeyOrMemP3/rkTfsUjwjFjETN3xCoBpq
         43ITij+QzYXJXOCaDHSZ3NJWt/jK9F+BfibTDt36/e2ut98EztqZ9wIe5SSi8IKTPUyd
         rf4smAItb2S54n2ZCfcbrmu/QytzXFYAv+jsG70hsPLobGD1lHJIYrqkVcaLBD6Y7V3t
         tM7L7ElrbzIYJhIomdEwxFysHR44fk/DQGXZjaEF3L9MXVQojblze8KmNHUxsiLgs9pT
         mHmg==
X-Forwarded-Encrypted: i=1; AJvYcCUjA+RFsJ0lvCD0xb5O5iMM8HB2AJYpbj8mg0UXdZeiCqm0vgltwgDzAp1a8UQqTMUQbuWbLVPGVxq7w4JGvnIW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7nP9z6gZdlje7qT7X65IMXs5c+nADmmYwjZllOGnp2uK0AA7
	ggEHCwFr1+ModdBW/HaSX5wrBHwnavHFsE4ZP28sIppht99eNaBJVrA8GMz/8Khjf9fs1aftFkY
	MxIFUiprpTEKjL7i9CRH4zGF1EsDlAzdubaZT
X-Gm-Gg: ASbGncsaeHzrAerCokL+5ZFCk9r98OXEyMkMOoSBoALhUQ9EyoApS+D+zpMBVBta2oL
	BgBNhaIbphkw3zp65bL1L4cX6DGdJ1jzSv4Ax1KY=
X-Google-Smtp-Source: AGHT+IFFhpPpvYV3XFLjAm84ti030wjvefcYWAzjKri6pk1s0NQhtAwpUKZ9uemzlhhem1eOp5LnQuUEMDAdHpKey5E=
X-Received: by 2002:a92:d084:0:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3b02674964bmr1044595ab.5.1734060675401; Thu, 12 Dec 2024
 19:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212173354.9860-1-irogers@google.com> <Z1uQWmq3KAQx1tA3@google.com>
In-Reply-To: <Z1uQWmq3KAQx1tA3@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Dec 2024 19:31:04 -0800
Message-ID: <CAP-5=fU+PSGyrB9HUYS3XECRdZHqU57xAOgKvyUyE90DpiUDVA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test stat: Avoid hybrid assumption when virtualized
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Dec 12, 2024 at 09:33:54AM -0800, Ian Rogers wrote:
> > The cycles event will fallback to task-clock in the hybrid test when
> > running virtualized. Change the test to not fail for this.
> >
> > Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat comma=
nd")
>
> I cannot find this commit.

Sorry, should have been:
Fixes: 65d11821910b ("perf test: Add a test for default perf stat command")

Thanks,
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Other than that,
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/tests/shell/stat.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 5a2ca2bcf94d..da42427bb077 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -163,7 +163,11 @@ test_hybrid() {
> >    # Run default Perf stat
> >    cycles_events=3D$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycle=
s  " | wc -l)
> >
> > -  if [ "$pmus" -ne "$cycles_events" ]
> > +  # The expectation is that default output will have a cycles events o=
n each
> > +  # hybrid PMU. In situations with no cycles PMU events, like virtuali=
zed, this
> > +  # can fall back to task-clock and so the end count may be 0. Fail if=
 neither
> > +  # condition holds.
> > +  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
> >    then
> >      echo "hybrid test [Found $pmus PMUs but $cycles_events cycles even=
ts. Failed]"
> >      err=3D1
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
