Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAD18DB16
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115916; cv=none; b=QKx+b4Qbi5S/ceNP+KO45k2v23BrG5uWeYwsFsJPiq4AxU6u3hRa6kqdjYAddg8Zyw3JLsr4cgm3IMctllM3hnU6tfo+GwjFY3Fe77DztbZKaoIsqgVYunxU2Nc9lgtl9/zI55MxjbLwNkME1bE3aEPBeiSix2dZukwaolG0/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115916; c=relaxed/simple;
	bh=dd5x+Zla52OMiqgDfX4eQs/qllxAI/m4TSHlwyUxVqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWikUCWhFCYi02eB85Pk57SfkiTuM9pfyXkzZaGuMcOycb87RESsl+JuZO5MDsxAVz72e1HtnsU3lYIRrVakfMN7/x0bxc6YG9p/a0RyIqAsOhJzjTdAPNklIzekro7FnNdhEr9Iq8F2opBxgdvRkpXmkOyG6NwHI/+ew9hLEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRtVoKcs; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRtVoKcs"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so178765ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746115914; x=1746720714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2Ud6eTNp6ERtti4oEB8plIlcS/1i9l0/NlQRj/X6dU=;
        b=lRtVoKcsXq/NpUcKjANi1RSNUTyXPDcCgURhzerIuJpnQa+2JWOoTtSFdrRaoVj12H
         D/6aOYBZcDHIJI2fpoq9+TwYZVN3xo2CFvbD6KmerMgyXUezAKYlpf8Nrw3to8xmCtAL
         DLYua6UGrN640jS/Ge0uEcb1AQuaT/gBPXE9PIagJbXi7oOfcO6POfltDBRl/3FE7pIl
         xzRhYPxTPkOYPTK09ssBvlIm+O7zfXyrrlewH3xxtM7wnH73+KehEVZ8oHJa0dLIQmZJ
         zObefnCjnvR6u+qv08ttKaoTojCswD4Mkdl8lH3am1xmNcAWF2BvpabVtd4ENQU1Wtmv
         eD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746115914; x=1746720714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2Ud6eTNp6ERtti4oEB8plIlcS/1i9l0/NlQRj/X6dU=;
        b=Ix5YzI0XRmbgaZ+3fyOndXHundRCU6sEpzTKSAjLhOyupVKFaQCKK1olwOk7FP8xyS
         X0bT0wi9CcvbL6bKFD9FttWSDJJ26b/GBJsCNDmB5tthqiiwsBjRjJLpq3cmn1lI6onK
         sGAzZNnMNqEMsSt9YAkaTuz4+8NAXujRC5ESgHFG3UhRQk8LIhLY5e/C6BEjYzBsrdai
         Jk86GWvHVVl6MGszs7lKqb3u3POdq25pdymkMj0vXcI2oQj5vXwXh+yo+RyUM7VWciyg
         9Jr5wpvWP+YLmBGbfY0Gno5l3GnJihOcqRPRUFz6VaBk6bzUCVnjvtQZdVYMSxuLBNwt
         Zg4g==
X-Forwarded-Encrypted: i=1; AJvYcCU9CwX6gPr4jYxqVd0/Twg1h/nL+pGjd8FgPaUMUb7Fp/nFceQgvdrGq17GMN2Duo1W03+JZ9G89tYT3PztHqRP@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGjmqFKkHG+HNBZ2QK5BPGXz7KavHj29wixKiPRpcWYFbtp1+
	dqWTWXHHv9nsJebJF7+hjm8HbCD8nkwf9IEbQ5VMWtweWF9TabeYRELIoqVSg6M0CpRpevGij3w
	DImttsI6tJiFROf62XjmbUODA5zn0VfCCceyw
X-Gm-Gg: ASbGncuxS1Ho9RJB3Ehj/saP0DcdN+eG2cZp9vFGrA50GwtuYotBPPzgs77Tld5INlY
	za+fCP1lP1Nnz6qa9sv+ZNlAWx1ToQ05M1w8fVptcBnkjd0oNBCXu2InuCrUHUGmp5XGXqTS3n7
	KwfT+7uSMEcu0gsSK3hNhJiDfDLtbJz0RDtoZx649b6xY+qXXivBo=
X-Google-Smtp-Source: AGHT+IFPyeDI8MA2OYOfgRXYCzBuihXkzFlHRvbpZ0KKhlS+gdqpJHcPr95ZuVNrd0zQpSv4pYwycLyUzAG9j8684Zc=
X-Received: by 2002:a05:6e02:1a0e:b0:3d3:d4ed:bb37 with SMTP id
 e9e14a558f8ab-3d970180e4cmr2567215ab.29.1746115914117; Thu, 01 May 2025
 09:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501093633.578010-1-gautam@linux.ibm.com> <20250501093633.578010-5-gautam@linux.ibm.com>
 <CAP-5=fW2--aUG9=14R8fqSEJQN-D3PATTwU15czWVsQidA51bA@mail.gmail.com>
In-Reply-To: <CAP-5=fW2--aUG9=14R8fqSEJQN-D3PATTwU15czWVsQidA51bA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 May 2025 09:11:42 -0700
X-Gm-Features: ATxdqUHgDAH_d2amllbxS047LtIyRHk3xiWW8PXOWZtXwl_bgU0sYuKQ5jhvI3E
Message-ID: <CAP-5=fVqRrO2pQx6he9N2R1A11RzVTFb-0KBvg4ydK4Eh7qSFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf python: Add counting.py as example for counting
 perf events
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 9:04=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, May 1, 2025 at 2:37=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.=
com> wrote:
> >
> > Add counting.py - a python version of counting.c to demonstrate
> > measuring and reading of counts for given perf events.
> >
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  tools/perf/python/counting.py | 41 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100755 tools/perf/python/counting.py
> >
> > diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting=
.py
> > new file mode 100755
> > index 000000000000..0c58907bd8bf
> > --- /dev/null
> > +++ b/tools/perf/python/counting.py
> > @@ -0,0 +1,41 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +# -*- python -*-
> > +# -*- coding: utf-8 -*-
> > +
> > +import perf
> > +
> > +def main():
> > +        cpus =3D perf.cpu_map()
> > +        thread_map =3D perf.thread_map(-1)
> > +        evlist =3D perf.evlist(cpus, thread_map)
> > +
> > +        evsel1 =3D perf.evsel(type =3D perf.TYPE_SOFTWARE,
> > +                 config =3D perf.COUNT_SW_CPU_CLOCK,
> > +                 read_format =3D perf.FORMAT_TOTAL_TIME_ENABLED | perf=
.FORMAT_TOTAL_TIME_RUNNING,
> > +                 disabled=3D1)
> > +        evlist.add(evsel1)
> > +
> > +        evsel2 =3D perf.evsel(type =3D perf.TYPE_SOFTWARE,
> > +                 config =3D perf.COUNT_SW_TASK_CLOCK,
> > +                 read_format =3D perf.FORMAT_TOTAL_TIME_ENABLED | perf=
.FORMAT_TOTAL_TIME_RUNNING,
> > +                 disabled=3D1)
> > +        evlist.add(evsel2)
>
> Nice example! Would this be better as:
> ```
>     cpus    =3D perf.cpu_map()
>     threads =3D perf.thread_map(-1)
>     evlist =3D perf.parse_events("cpu-clock,task-clock", cpus, threads)
> ```
> If you run `perf stat -vv -e 'cpu-clock,task-clock' .. ` you can
> double check the perf event attribute bits. For example in
> tracepoint.py we remove the SAMPLE_IP:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/python/tracepoint.py?h=3Dperf-tools-next#n27
>
> > +
> > +        evlist.open()
> > +        evlist.enable()
> > +
> > +        count =3D 100000
> > +        while count > 0:
> > +            count -=3D 1
> > +
> > +        evlist.disable()
> > +        evsel =3D evlist.next(None)
> > +        while evsel !=3D None:
> > +            counts =3D evsel.read(0, 0)
>
> Rather than just reading on the first CPU and thread, perhaps change
> to iterate over the cpus and threads? Something like:
> ```
>     for evsel in evlist:
>         for cpu in cpus:
>             for thread in threads:
>                 counts =3D evsel.read(cpu, thread)
>                 print(f"For {evsel} read val=3D{counts.val}
> enable=3D{counts.ena} run =3D{counts.run}")
> ```

Oh note, it is easy to confuse a thread or a CPU with the index into
the thread_map or cpu_map. For CPUs the two values of CPU and index
are often the same making it very easy to write code that works only
on CPU events (not events on things like memory controllers that
typically list a CPU per-socket). We added a struct perf_cpu to try to
avoid this kind of issue in the C code but in the python code
everything is back to being ints :-(

Thanks,
Ian

> Thanks,
> Ian
>
> > +            print(counts.val, counts.ena, counts.run)
> > +            evsel =3D evlist.next(evsel)
> > +        evlist.close()
> > +
> > +if __name__ =3D=3D '__main__':
> > +    main()
> > --
> > 2.49.0
> >
