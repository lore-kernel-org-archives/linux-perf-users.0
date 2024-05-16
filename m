Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE01156661
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880860; cv=none; b=O12Ps4qYxCi7Dhw6a2QVyOyD2BHlPKE+SMJJNhpc7hFZ0gHwXwx80E0qmWCijcfHgT+x7LJZi4yGTKiDtWtUEFiizXhWXZF1qrFTYyX0IlJmUqSKCbNH/6JR4u0cWnkyYce5rQ+VF/czXVoSS3DGRuBD3Lz1RyMWSV41nrCtG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880860; c=relaxed/simple;
	bh=DQzUrR+dgEZ4KhK9ztnpAP2CVSJ041lYtvQDEgYT9OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ftSZfj9c7Wfx+LxqtLoll3ZaqMcFmjfIbUnSR6WmIUvLeVqgYjFjmqeLzaEc/XSG7sABkh+fj6OeJMRHRWFMZ6aAYiRosrWp2mgtUkNdlmYMIwzG7uOvBNGWjTLS6mM278XNc5a6lM9giMuBwsGS0YPqfG6FojhNbs/no9CB0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOZ+7PC/; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOZ+7PC/"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36db863679bso6725ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715880858; x=1716485658; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5xOVdSKQxj3bC4Jw56jvdbDAorrHCwMBywGdman4qs=;
        b=iOZ+7PC/CpK9o+u00tUzrosnQbm/sm4DhuNKyk+8AUqz0k6gvAs9GslvPpMsJB+2RB
         RGT42GZixX6E5GN2yQRi6bCVjk+q0tMk6elqjjRPZDijZGV42pCBY4OkwvjTTlYGwS63
         4pEpK21zGvrJCPOguFFMNxz5fDfnlt4ssx3muFIxBDCjXwxjJyUcpbrJAhUla+6In2Kc
         FyUBu9Nw+tuRD2LezG8vUQajNWfToMms3hv9yGZqbaxRySlsXCFf0nRzk2nXRd78Z2wX
         NI0siX0P4XWtZZEsjWJlS9gH+R0Zh8n5guzAWspzSzGDVpbTbtziJWVsZYAt52qhq3EO
         WwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880858; x=1716485658;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5xOVdSKQxj3bC4Jw56jvdbDAorrHCwMBywGdman4qs=;
        b=Sdu7aiu5IdEy1ipdHR0GWQuw8O9ApQecS3/xZIX9zz0fgcJMetbGA9DzjAjjpyBsRQ
         RflVBsW97JEZTAeXBRqr5jvHOvqoZKwARaQYAqjhlB0I5Bgv0EC5yBGjSY7VX/ovA4eK
         RJEc6e6ET+GIb9DM4Rta4/JA/1VJS7+JfADnwQDR0Ys8z77HuX9FeHCNSlYXhTHzO1bE
         jqMkXeoVekF9TbbB1xiuu3iCyJaVvY1tx0suBc2ZvwyXnvyj22z7moHu5IhIW+emK9YX
         PX8fnK/FFrKmTiw3YcNWvdeH+TGepzZkHnBRba1jGIjD+CL+XmJ591NZs2thrFxBB9by
         Gk4g==
X-Forwarded-Encrypted: i=1; AJvYcCUKUixVFvzUwRhMtfPCi82WSeUe5Ss03SDisJuRziq55TQRFgEo7QxJLMGKUuW9sAq+WRzPJfScKCVdsbowJ3ZVC3/zSphBRInS+gsgWXlTfQ==
X-Gm-Message-State: AOJu0YxGK19xxClfLQMwtz2Vrm8+mjeoy5FoWR9WKvZLsB606VOIkMq7
	I3MeQyBrJWlcnis6TjoQk/4FcTS5arbA64zhPJ7QBY5iITtXaR41qsF7DxC5E/Dhwoxhv0nC7Ds
	xoipz1JeCUGLvXbiGXaSWDyUhWHYkEvUAn3Q0
X-Google-Smtp-Source: AGHT+IGQfiUsjFLcKTTVRbucdev7xcxK41O6PPY41Ymebz78KF0cs/kiMpgHjzowJxdaXfyke4gY1fFYB8ZvXJz9acE=
X-Received: by 2002:a92:c264:0:b0:36d:959b:fb5e with SMTP id
 e9e14a558f8ab-36d959bfc0bmr11900255ab.21.1715880857923; Thu, 16 May 2024
 10:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
In-Reply-To: <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 10:34:06 -0700
Message-ID: <CAP-5=fUBJOaE3Tp1NP4Urdt-r_kHEaR00aTKxMrvfe_0fyPxYA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:04=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Allow uid and gid to be terms in BPF filters by first breaking the
> > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > from a value in the sample. Allow filters to be passed to perf top, thi=
s allows:
> >
> > $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
> >
> > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > due to processes/threads terminating between the /proc scan and the
> > perf_event_open.
>
> Fwiw, something I noticed playing around with this (my workload was
> `perf test -w noploop 100000` as different users) is that old samples
> appeared to linger around making terminated processes still appear in
> the top list. My guess is that there aren't other samples showing up
> and pushing the old sample events out of the ring buffers due to the
> filter. This can look quite odd and I don't know if we have a way to
> improve upon it, flush the ring buffers, histograms, etc. It appears
> to be a latent `perf top` issue that you could encounter on other low
> frequency events, but I thought I'd mention it anyway.

Some other thoughts:

 - It is kind of annoying with the --filter option (either on top or
record) that there first needs to be an event to filter on. It'd be
nice if we could just filter the default event.

 - Should "perf top --uid=3D1234" be removed or turned into  an alias
for '--filter "uid =3D=3D $(id -u)"' given the --uid option generally
doesn't work?

 - What should happen to the perf top --pid and --tid options, should
they be filters? Should they fallback on /proc scanning if there
aren't sufficient BPF permissions? The plumbing for that is going to
be messy.

 - There should probably be a way to filter on cgroups.

 - Does the user care that there are 3 kinds of filter that will work
differently? Could we break them apart to make it more explicit, I may
want tracepoint events with a BPF filter. How can we ensure 1 syntax
for the 3 kinds of filter.

 - Filtering on register values could be potentially interesting, for
example, sampling on memcpy-s where the length is over a threshold. We
have a register capture test:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/record.sh#n81
Perhaps the filter could look something like 'perf record -g -e
mem:$ADDRESS_OF_MEMCPY:x --filter "reg:rdx > 1024"' -  this makes me
think we need to make a more convenient way to specify memory
addresses as symbols.

Thanks,
Ian

>
> > Ian Rogers (3):
> >   perf bpf filter: Give terms their own enum
> >   perf bpf filter: Add uid and gid terms
> >   perf top: Allow filters on events
> >
> >  tools/perf/Documentation/perf-record.txt     |  2 +-
> >  tools/perf/Documentation/perf-top.txt        |  4 ++
> >  tools/perf/builtin-top.c                     |  9 +++
> >  tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
> >  tools/perf/util/bpf-filter.h                 |  5 +-
> >  tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
> >  tools/perf/util/bpf-filter.y                 |  7 +-
> >  tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
> >  9 files changed, 172 insertions(+), 70 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
