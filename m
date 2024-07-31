Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF45A10B
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439999; cv=none; b=YUUeLVA5ru+8Z3k61n5tUDCy9aIk7lzk9Aztfnj4iiCB5ney3zwkdaiCkkKM3YkYbgNlZ1U9CsMr0dOdqFHwxOP5uVCR4VrJqznlQnzT2r8yrW/fHN6DkUTsFNtyvTd5pERT9HmwhuT7RhNm65TfezPfqmnOLeIGqMTWZIzSX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439999; c=relaxed/simple;
	bh=vyEcUkkUMqSdSqGxulTicad8L3jfmlZgZTONV3Fc14U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXSOo4IqvRmZOgEDr2Zk8ogrTXw8ZOrdaqI/hRRJvYs+z6cHGkDJD64ZbKvBUu1dMNR+lUsgwsONJlzTHhq97f2YnDWRAxUV0riYQ5+KiciT/V3U75goKolhBCV1dX0R+0aZXB8PjTemakdtZEXrnop+GIe56wkPXmOGQP39Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MP0MS5K8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP0MS5K8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd7509397bso197055ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722439997; x=1723044797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkqElbAKwSbRLK95nttGEsxXQmUG7+IX8s48D5hRr1o=;
        b=MP0MS5K8epE+N4Y//qpib3DIXhLqH4CjOhtDZL8eBDelmSVM4sVkTgMIjYS6NxfAbM
         DsUnmsozbyQBL13+hsfZsnVNkQLrbmtZ+NF5nrVMBAbEkHK9t1JTtBoMN4GAPgl2kvj/
         v/YcGworXWDmXA0Vz2JcKxJrozSHOp+Q1pQJmcEkg/ukycclrSQL5rB23/S8+a2Geliv
         SG26LG9syk3mhzgX03PcoP4AcacSk28Te/LCgRJFrHLjZdEZYvJWYWPgMYixcc89B8ez
         UZFTUt8/MBA+ssjNb6ELuhL4CrEiuCpRtPzn8xsCGzIt9BD8UO3UhIIRuHB1+fP9Kf4T
         9MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439997; x=1723044797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkqElbAKwSbRLK95nttGEsxXQmUG7+IX8s48D5hRr1o=;
        b=n05uRS7VfwcBSS6jDvcM0Rzi/Xs0RDr15zs9/cgDcgPOHxn2BWAlJW7Obyy8BklNF1
         D/NMujnzNG63AAsCIebLUyPXWX9xBwJIUX+HvP0bEa6JOPHVgeGBNzKg8toDuZEycD2g
         +uAPFNX7aqMv4EsAWmEeEB3VaD7FBgOkr4U7kq19qp2jFf08jHqfsbwPyZBB6mnp/HF+
         cp0YSOWhg1yLyU42HTBkaVBetcXIUPzQ2fEn1GVOfxmjDPwhMGLTxwSY2N8BE98Nug1F
         4Fy9ad3l2p7qM6VP4O4JVycAsLVfJZb1pWBxtDT/c7pFC5vRXRaBBYf6lqznnYSBnnZg
         PopA==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ7fx6Ola7t0r0Iq/4AaCagwtb05sS+dFSirSBeqxBxA9EPU3oQ8Dr4sAaa0KLlDhifUn4NwVDuUil+fw6vcM+BCE+NG+vrJqSR4bmnD8bw==
X-Gm-Message-State: AOJu0Yx4Amli8XwZ4mjfKhe11ySeiL0P0ebS63U+ZwEPAdnDbeKIm5n1
	UZ9pbQkkw2YKuiFogNo43IiJxZ0pDBuIxuEpijG4yZgm8745j5Nv/it79GbuAC+HaEpHZ93Mbf8
	ODPub8CzNQjYlPlDB1LKGKd+v7w6kOQByjPlO
X-Google-Smtp-Source: AGHT+IE0bumBXqxIdUD9WWl0o3SNTSeQJNTPd+WHHEL1zuCpxQCa0EofdOVza2A+5TT4Ygm7vHMzZU3dAM/Amua9Q+o=
X-Received: by 2002:a17:903:2a84:b0:1f4:95dc:bc61 with SMTP id
 d9443c01a7336-1ff426314c0mr2581115ad.15.1722439996851; Wed, 31 Jul 2024
 08:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729004127.238611-1-namhyung@kernel.org> <Zqk8p-IxbMQBKjtE@x1>
In-Reply-To: <Zqk8p-IxbMQBKjtE@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 08:33:03 -0700
Message-ID: <CAP-5=fU2RH-vcFvbc-Y3w+hDBCXH+pzawVa_N2mVF9+PVe2rAw@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf ftrace: Add 'profile' subcommand (v1)
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:19=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Jul 28, 2024 at 05:41:23PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > This is an attempt to extend perf ftrace command to show a kernel funct=
ion
> > profile using the function_graph tracer.  This is useful to see detaile=
d
> > info like total, average, max time (in usec) and number of calls for ea=
ch
> > function.
> >
> >   $ sudo perf ftrace profile -- sync | head
> >   # Total (us)   Avg (us)   Max (us)      Count   Function
> >       7638.372   7638.372   7638.372          1   __do_sys_sync
> >       7638.059   7638.059   7638.059          1   ksys_sync
> >       5893.959   1964.653   3747.963          3   iterate_supers
> >       5214.181    579.353   1688.752          9   schedule
> >       3585.773     44.269   3537.329         81   sync_inodes_one_sb
> >       3566.179     44.027   3537.078         81   sync_inodes_sb
> >       1976.901    247.113   1968.070          8   filemap_fdatawait_kee=
p_errors
> >       1974.367    246.796   1967.895          8   __filemap_fdatawait_r=
ange
> >       1935.407     37.219   1157.627         52   folio_wait_writeback
> >
> > While the kernel also provides the similar functionality IIRC under
> > CONFIG_FUNCTION_PROFILER, it's often not enabled on disto kernels so I
> > implemented it in user space.
>
> Great functionality, tested it all and applied to tmp.perf-tools-next,
> will be in perf-tools-next after one last round of container builds.
>
> The discussion about libcap seems to still be open, so I'm applying what
> is in this series as it is small and simple, we can go on from there.

Sgtm. I did the libcap cleanup on perf-tools-next, but
tmp.perf-tools-next hasn't been merged there for 3 weeks. It'd be nice
to rebase the patch on perf-tools-next, but should I just shift to
working on tmp.perf-tools-next?

Thanks,
Ian

> Thanks!
>
> - Arnaldo
>
> > Also it can support function filters like 'perf ftrace trace' so users
> > can focus on some target functions and change the buffer size if needed=
.
> >
> >   $ sudo perf ftrace profile -h
> >
> >    Usage: perf ftrace [<options>] [<command>]
> >       or: perf ftrace [<options>] -- [<command>] [<options>]
> >       or: perf ftrace {trace|latency|profile} [<options>] [<command>]
> >       or: perf ftrace {trace|latency|profile} [<options>] -- [<command>=
] [<options>]
> >
> >       -a, --all-cpus        System-wide collection from all CPUs
> >       -C, --cpu <cpu>       List of cpus to monitor
> >       -G, --graph-funcs <func>
> >                             Trace given functions using function_graph =
tracer
> >       -g, --nograph-funcs <func>
> >                             Set nograph filter on given functions
> >       -m, --buffer-size <size>
> >                             Size of per cpu buffer, needs to use a B, K=
, M or G suffix.
> >       -N, --notrace-funcs <func>
> >                             Do not trace given functions
> >       -p, --pid <pid>       Trace on existing process id
> >       -s, --sort <key>      Sort result by key: total (default), avg, m=
ax, count, name.
> >       -T, --trace-funcs <func>
> >                             Trace given functions using function tracer
> >       -v, --verbose         Be more verbose
> >           --tid <tid>       Trace on existing thread id (exclusive to -=
-pid)
> >
> >
> > The code is also available in 'perf/ftrace-profile-v1' branch at
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (4):
> >   perf ftrace: Add 'tail' option to --graph-opts
> >   perf ftrace: Factor out check_ftrace_capable()
> >   perf ftrace: Add 'profile' command
> >   perf ftrace: Add -s/--sort option to profile sub-command
> >
> >  tools/perf/Documentation/perf-ftrace.txt |  48 ++-
> >  tools/perf/builtin-ftrace.c              | 439 +++++++++++++++++++++--
> >  tools/perf/util/ftrace.h                 |   3 +
> >  3 files changed, 463 insertions(+), 27 deletions(-)
> >
> > --
> > 2.46.0.rc1.232.g9752f9e123-goog
