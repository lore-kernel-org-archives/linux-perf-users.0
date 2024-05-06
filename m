Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A41E4A6
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021015; cv=none; b=JBZi0uotTqTmR1/jE8nPa1CnofLwTH6BbO4YCjcjIDqa9rCpUqwlNZ4QVgAfRFOybD9O5fdP8LkU2FtrOwykuQtewCPemALeB77rBlW2adCmS5U0s/mj/3F5NahQ9zRKbuQKWAQ2mjUaXSsZEU/krvdrh/rcYSHfmWmDzZDLsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021015; c=relaxed/simple;
	bh=sPMDL23QS9Xd7hIJCfVoH9uVk6HP1D83LxcnL9CKbhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnsDujq8skNArWaZ8ioVprh0y1mPC2/Q8GqObnypLXwEemBcG+Uu4PqVe2wfJICqcwbU32Zbwyn/uZnw0ep+4TWLQaDCoo4OEQRlsXWRTDKoZIPz/wee/OkEJW4in/4bTAH375wDyJGIvhwudu+S6dTDHx8dZQbZCitIWFIujS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWamJBOm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWamJBOm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec76185cb3so28735ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715021013; x=1715625813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMqIHyLa/gmjK+J+Bo0q9JLXeRdO7aoxpGEVpFxtErc=;
        b=QWamJBOm4/1TXFGAlwW2Wp7gFQIn4jOLbK8k/7TXtI6Kh/BdcgxPiBgf8NOsA42nAm
         uQiK29razQgTolKJ83t8GlWw/aWYiHnrKObkVwYk/yQjbnK9rBslQDGQhtZFLayX178G
         4OCpW+B+8JqGXHydmgVyA6NPi28sh+1m1G9q+TfOHJV7UFKThKdOApqV0YDJLTcH7F41
         bGN1X61cVCHyuYRiUdpYJyQrDOqp2+I3OCslH0/TnK0I0o7rIvQqLyY8PQ5IfFI4/+GX
         Do8PA1fFt4N5F6O/ozmCq7GZH3m1h5jv0Q5oEwTXYtr90EefNSITLAu0NHBOKZTcQgm6
         Kz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021013; x=1715625813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMqIHyLa/gmjK+J+Bo0q9JLXeRdO7aoxpGEVpFxtErc=;
        b=HdVcBmuTb+AZKfh7C3yvzyqfqGmuSmdHhfHg1P1ijkHlRmnRHXSUsefgS2kJnIODO2
         222ib81xa97ZS2pS3QoT+2Dbjsh810W+cIMShAMy/xOrgZxKF9qsBc0kdfS9DUYOKjWl
         n/tjKzKQwxa6FavjKagJkh+Q3SPQFD0Ujnr9pr1C4y4NcyIKmGF0yCQwi8YlKKfQRaNY
         FgsQ1gQDoMUGCYv+cNWBzS3Pwj2/b/JBmhMgNAr137MGSOLs2ttV+80KuDD3mfq4pxRa
         8Yqo9nmy+jJjoPXS4w7SnlSqmFEoSR8ev8l4unjpSsnjlDjSokvlacl/Jn1AQwBPZYri
         npng==
X-Forwarded-Encrypted: i=1; AJvYcCW13UyKbplo1TSKZ9quB/LJKqP0whcdPADiHc2+Jc2phNK0RJockcn7kCtU3ky4c8VdnsBHW+/YWRLrVNJCM/3HFkPrnbkcdhlSvXGvz9wcbA==
X-Gm-Message-State: AOJu0YwVKJ8Zr9uqowSTdOB869VZmvVlqoWGPlkf2JXT8liCp6RWjbAa
	H191KSU2IW/XbqirKLor4h5VSS4juRpObS8IzaJa5gN3FlC18/W3wS+YV9iz2I58McR6SFgYmmA
	sZ0sThOVdjDAimRFeEiuiLhlHY7Wg0oStLFlv387lbKtD9/z/39jI
X-Google-Smtp-Source: AGHT+IFulYHpYLHM1ZuESjR5oSmKrCpxfE2wIN5s61bSGDGu2zfJeu8lvWzNU0Er8XFXuAkgqi4DEDvGGFyMpu+7Ino=
X-Received: by 2002:a17:903:2003:b0:1e2:573:eecd with SMTP id
 d9443c01a7336-1ee6a6a8e32mr195735ad.3.1715021012487; Mon, 06 May 2024
 11:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh> <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
 <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com> <CAEf4Bzab+sRQ8pzNYxh1BOgjhDF4yCkqcHxy5YZAyT-jef7Acw@mail.gmail.com>
In-Reply-To: <CAEf4Bzab+sRQ8pzNYxh1BOgjhDF4yCkqcHxy5YZAyT-jef7Acw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 May 2024 11:43:21 -0700
Message-ID: <CAP-5=fXv59EmyM7FNnwAp0JjAZjtYhCj3b3FTH7KsHL=k8C6oQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:32=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, May 4, 2024 at 10:09=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > > >
> > > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > > > Implement a simple tool/benchmark for comparing address "resoluti=
on"
> > > > > logic based on textual /proc/<pid>/maps interface and new binary
> > > > > ioctl-based PROCFS_PROCMAP_QUERY command.
> > > >
> > > > Of course an artificial benchmark of "read a whole file" vs. "a tin=
y
> > > > ioctl" is going to be different, but step back and show how this is
> > > > going to be used in the real world overall.  Pounding on this file =
is
> > > > not a normal operation, right?
> > > >
> > >
> > > It's not artificial at all. It's *exactly* what, say, blazesym librar=
y
> > > is doing (see [0], it's Rust and part of the overall library API, I
> > > think C code in this patch is way easier to follow for someone not
> > > familiar with implementation of blazesym, but both implementations ar=
e
> > > doing exactly the same sequence of steps). You can do it even less
> > > efficiently by parsing the whole file, building an in-memory lookup
> > > table, then looking up addresses one by one. But that's even slower
> > > and more memory-hungry. So I didn't even bother implementing that, it
> > > would put /proc/<pid>/maps at even more disadvantage.
> > >
> > > Other applications that deal with stack traces (including perf) would
> > > be doing one of those two approaches, depending on circumstances and
> > > level of sophistication of code (and sensitivity to performance).
> >
> > The code in perf doing this is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/synthetic-events.c#n440
> > The code is using the api/io.h code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/lib/api/io.h
> > Using perf to profile perf it was observed time was spent allocating
> > buffers and locale related activities when using stdio, so io is a
> > lighter weight alternative, albeit with more verbose code than fscanf.
> > You could add this as an alternate /proc/<pid>/maps reader, we have a
> > similar benchmark in `perf bench internals synthesize`.
> >
>
> If I add a new implementation using this ioctl() into
> perf_event__synthesize_mmap_events(), will it be tested from this
> `perf bench internals synthesize`? I'm not too familiar with perf code
> organization, sorry if it's a stupid question. If not, where exactly
> is the code that would be triggered from benchmark?

Yes it would be triggered :-)

Thanks,
Ian

> > Thanks,
> > Ian
> >
> > >   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118a1e8=
e5d901cddb2b33ab1/src/normalize/user.rs#L193
> > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
