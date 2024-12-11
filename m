Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB51D6DA4
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939909; cv=none; b=n5qv70mNtGcKUWcp3yaOUKCp96Sj8HMqFumTyPqfpJSBM1t6vPia09XdiLSbCtLKAuwXyy0BliT2VMduA50CWHprz0gXqOFulSUx/xuyXUixgwbed4YkcgMwdqQldd1xuvUbuAQMPEHQsQGvDiwuI4ITNcDjRSJd66FAyHT6Z3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939909; c=relaxed/simple;
	bh=R3T11l8xt1aGZ6P9H11qj4eLnK8r2GPCU6lVevf41bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaFEZAKGE0LQY4+qKAbir9MzIZhXKjvxxGQ0jjy8OuQYBRXdLltEGPlq4yH0AggLbFkZlG/74D5r1zJyMeFXYKmwvpOeboA1qZgob7NMFeX4joy6fO8jAroOHANj+/+wAD8JD5USXQ6TWToZi2/wm3ArsJuvrVbwkfMZk4f6Kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsHXVk/g; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsHXVk/g"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a814c54742so2835ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733939906; x=1734544706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFoTN4ef6tsaYaPXHrZT3l6uMHwk3tr1FxPfQlIdTqE=;
        b=XsHXVk/gUp1n/P2qs5daDpxWxsG/EDXYUkHfMPzT+XQkmw4Y/VXn1h5eA8cMZ2Ie3D
         pM5hWtm36M43FDhMEm+nZBmMuC6hO+wtZIEDzPryVM4OHxLiEUMGZ1BZWlbZWKWihNHr
         5v/mtHiQu9kCyrxVGsIkYKD7qRt2p5uedf6aNrPzcX8YgpVNZg6fiATzQ4nN5DCayluD
         cmRSXa4EDvqy4uKmHZxUni5DTQYd25EdYn8hp/1dS1P3ZXwerJ+lVnDyZAYC8L4GCdAC
         lhv/IIaHk3afC1c+9JfE3fchSzYQMYud0dUYn1qNwuMlOK58bE5eDA72rRJJGRt0OlMc
         djVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939906; x=1734544706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFoTN4ef6tsaYaPXHrZT3l6uMHwk3tr1FxPfQlIdTqE=;
        b=iv0dCX+bnmXR6244Pq0gfEkimICF0JsI+lUFlqHC2X+5tnDIRc+RJnPdU5U2O2OyqM
         zxPTkTy/JIghH6U+VFnXF59pYKTSHkJ47SfDB2jQpEwY3/O0S1KT2I48UIuRRQzi4zpf
         BqPpDEiOwAOA9bnfY6yc1QmScey46Vk7FRpCLgJRC56cETXQ7MKjXeHgFobKS/gSVJEK
         DiWKE6fXgFVpzteRc96ueh+azLgiDAB6kGhcYWQ3f5+j2tE0M+Xl2cKYNahz5rCjSAwk
         IR5cz5PBGrJ9dAti2zWpjk/7PIo8nZCHzoHBXOecCcI28EOouWnVaE3sMQ5xv7OEjDgP
         T3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdMFK8Nxb4D6ob94GviHWiffehh315NqfmgX1aw3A7eJyekjcKLP3LuLw2P5QoV5efspmsfiHHl0tKQv+6potS@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlNt537M0s1HNfg04PnXP6m40K/DtS59BwVSij1qnZP5TPHEd
	NJ1AsjIV8JN21J+NeiE9emCG+RJxrucP2+U+sIY4FZ/31rrNN8e2bxghGjOHFok73/OkuXG8t6N
	5TTusabDKPT0sRvHXnQQ9ITwlQZGYxI4X0nk2
X-Gm-Gg: ASbGncujLCP4c8WReUP0TJrIFB5Hk1qT/3WF3pm6p94L90iiA6c6ZMuxvEe5CN4Bz+2
	ow4XIrhSR0F6TtiTpRMh1Y0msTCdvjjofEzZR
X-Google-Smtp-Source: AGHT+IHDUGLYwHXig3aPIIAKQG3r40UaPaRtA3rpSGtI44vdk6Im5yMjdEylYcZQsSBzcdLJC2Q34UzaQjz94xGLGt4=
X-Received: by 2002:a05:6e02:3388:b0:3a7:d85a:b1bd with SMTP id
 e9e14a558f8ab-3ac42aa9446mr488505ab.4.1733939904140; Wed, 11 Dec 2024
 09:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211061010.806868-1-irogers@google.com> <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
In-Reply-To: <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 09:58:11 -0800
Message-ID: <CAP-5=fVxPaSYtB62ZqcLOG1F9Va-0rwBWUCiVNdaBpmsGXUVaA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test stat: Avoid hybrid assumption when virtualized
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:50=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 11/12/2024 6:10 am, Ian Rogers wrote:
> > The cycles event will fallback to task-clock in the hybrid test when
> > running virtualized. Change the test to not fail for this.
> >
> > Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat comma=
nd")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/shell/stat.sh | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 5a2ca2bcf94d..60cea07350e1 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -165,9 +165,13 @@ test_hybrid() {
> >
> >     if [ "$pmus" -ne "$cycles_events" ]
> >     then
> > -    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles even=
ts. Failed]"
> > -    err=3D1
> > -    return
> > +     # If virtualized the software task-clock event will be used.
> > +     if ! perf stat -- true 2>&1 | grep -q "task-clock"
> > +     then
> > +       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles e=
vents. Failed]"
> > +       err=3D1
> > +       return
> > +     fi
> >     fi
> >     echo "hybrid test [Success]"
> >   }
>
> Hi Ian,
>
> Isn't the distinction between task-clock and cpu-clock whether the event
> is per-cpu or not?
>
> $ perf stat -C 1 -- true 2>&1 | grep cpu-clock
>                1.49 msec cpu-clock       #    0.917 CPUs utilized
>
> $ perf stat -- true 2>&1 | grep task-clock
>                0.30 msec task-clock      #    0.366 CPUs utilized
>
> The test uses per-task mode so this change makes it always pass, even
> when the number of cycles events doesn't match the PMUs.

So I'm confused by the test, but it has caused a passing test to be
broken for me when I run virtualized. The test is checking a cycles
event is opened on each hybrid PMU, but this is conflated with
checking perf stat's "default" output. The cycles event will fall back
to task-clock in per-task mode but we also open a task-clock in
default mode. Should:
```
if [ "$pmus" -ne "$cycles_events" ]
```
be something like this then:
```
# The expectation is that default output will have a cycles events on
each hybrid
# PMU, but in situations with no cycles PMU events, like
virtualized,this can fall
# back to task-clock and so the end count may be 0. Fail if neither
condition holds.
if [ "$pmus" -ne "$cycles_events" ] && [ "$pmus" -ne "0" ]
```

Thanks,
Ian
