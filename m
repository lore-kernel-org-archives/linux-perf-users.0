Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4CEAC6
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616561; cv=none; b=gsURPmdxUE0gclJ0XnkrfOJmfR894CC9mqxiJYtBc6yY4Px6H6QdiUNB8Y2rn00WhcUlAxEFkMAGFm4C1DlwsNHMIAglwPmQC+XSUgFhXryEe3lfsYznTvCKMtB/DhQbeCPCc3Bbww9MifaXwqxU5KEshzKljR6xJtMX4xkp/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616561; c=relaxed/simple;
	bh=WzaDS0v3VjR+9WUQ0Wd1D2Dqw1tBVcZMZEY6llWltYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UY5Nk7vBQj5toMGNOXwheHPnB+ZDeBaJwYbFuvKqK44w+xW0qK6bhy/ufqQLA5CUvNYDxV/fiQMSQ7v2kl9NIRBo6iFa1UhCo5kymWExc6kY6YFFufLag7PwTpHHCN0z2Xd9NavJHi3pMiea6nM3dDs8QNgJu7UPkAl8gYI2QqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2r1F/mQ0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2r1F/mQ0"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so367039a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 16:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616558; x=1741221358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq2coKsqwNhQJVAZiBMjQqRmn/8k1hj82+/Tj1WMPak=;
        b=2r1F/mQ0hP4sFYbAtumAUePw2luwJH7tVzFABTDU4ZXOVsrFUYc5Cs7FSC/T5kcFRF
         47CFePtHLTlTWHrFIyhInF3xUCq7+YZSTlNiHc6OHksR12Kf/Zec1ZdGv+yWEJQwJARC
         LhJ5TCt8Ososp5mI+BOpJokKNbXOgTWwIvcsv2tYvAY8ygxhR2ZBOwtVy97o4s754mDQ
         MetcDz4Z0TyxpktY8c7B3kvJWCsxoSf/naN2jc+KhBfgaMuGN84I3cH8TVZR9QO/rp78
         FwcNFZJIgS5Itjr4G31sUixxxWfFglppNAoVFjscI3Hjo3G0egVw4S9qzy3cT1+PH4p3
         5hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616558; x=1741221358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq2coKsqwNhQJVAZiBMjQqRmn/8k1hj82+/Tj1WMPak=;
        b=Iz8ea4k0fdmpaj6jaC03POt4pDq27R4aVym3CIBrmwjYbfSp4jzhkhay0HO823KrVT
         +0yn0Zeb3ZkqFE7N836gHUpcq+kFlQsGyFXt4aKwKS6WRkFG0PY1d42yhdDIQIPvGt6S
         EmmIBUddyxM21ZWjoHKE33rKfxBu03gEvFenQCyYeiJvjyjfyvMQbtrd9Xf9baHh6uUR
         WFsuLaMXeeM2ssswxxIJ7lRoXoDVek+IkMfk3kpwJfzbi+mpc6yWYN2zIf13Ri6bPhp0
         ZyzBYZH+xaIOKXLY494OKnor86QPglr3/i07OKd8Y7iZHl91vzdmt5kuXcXuXy6QtGOa
         zH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVh9RFU+4gaQuI6wpfrVAGxICfShn233BX2VvRi0dp5M0VKiRZGxemllfEhLMlDG7WUZAr20GGkzGpx/y07LGnx@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNGx1Wzy5t8G/30b8CSW+xng9ArM8ZC3qSJphl+cdgFIfFbnk
	PVwec8zKu9RKx/thSgSoqQBmlSKhnTFZO3bUq6Ms4aIN02ZItJ2D+2qyNpE+o5RFKpyB2BmL11n
	a9Thzp3MNrKhQ/WcYdwRbSuErQA45FCPu6BH/
X-Gm-Gg: ASbGnctOQODazxvxzr26M1J/gAmPFXm+KVlDiLNM6db7H+61byphzxEcUA9VMbkvv0P
	D0/5P3Kr8PTnCuaurmxvbcFWfw9D4Qv/8LCdrwhuzdkvlC24dqEE6NeuJuGfXwJv8K9r0kctHwl
	v0s4VO1sdIPSxqciKs/nhbBS+8/KEDMI2IEeNK7ng=
X-Google-Smtp-Source: AGHT+IEsf5kCRSkT7VgH7fTP/og+zXTORpFByWGubby5toYnzm3HKaz2JTSIULHCNPGfdMpMCn//W2Gp4xXXIripslw=
X-Received: by 2002:a05:6402:350f:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5e44a256d6amr21492879a12.23.1740616557708; Wed, 26 Feb 2025
 16:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224184742.4144931-1-ctshao@google.com> <20250224184742.4144931-5-ctshao@google.com>
 <838FC998-5E85-4511-BA65-B32ADD1B817C@linux.ibm.com> <Z79SgFChhckow6Jf@google.com>
In-Reply-To: <Z79SgFChhckow6Jf@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 26 Feb 2025 16:35:46 -0800
X-Gm-Features: AQ5f1JrNSSUvFtnHsGrEqguoYWy0QpDLnJIBRcX6J_N_zZbkdqchBOGDjm7Wmkw
Message-ID: <CAJpZYjVE=Two_iSpbGeFHZDia+Y50XyviwYSmA=GK9Xeb-ph0A@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] perf lock: Report owner stack in usermode
To: Namhyung Kim <namhyung@kernel.org>, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, nick.forrington@arm.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung and Athira, thanks for your investigation! I fixed them
and submitted v8:
https://lore.kernel.org/20250227003359.732948-1-ctshao@google.com/

For `lock_contention_get_name `, I am not sure why the error is
revealed by me since I did not touch that part of code. Anyway I also
included the fix in my patchset.

Thank you,
CT



On Wed, Feb 26, 2025 at 9:42=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Feb 26, 2025 at 03:27:41PM +0530, Athira Rajeev wrote:
> >
> >
> > > On 25 Feb 2025, at 12:12=E2=80=AFAM, Chun-Tse Shao <ctshao@google.com=
> wrote:
> > >
> > > This patch parses `owner_lock_stat` into a RB tree, enabling ordered
> > > reporting of owner lock statistics with stack traces. It also updates
> > > the documentation for the `-o` option in contention mode, decouples `=
-o`
> > > from `-t`, and issues a warning to inform users about the new behavio=
r
> > > of `-ov`.
> > >
> > > Example output:
> > >  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E3 perf=
 bench sched pipe
> > >  ...
> > >   contended   total wait     max wait     avg wait         type   cal=
ler
> > >
> > >         171      1.55 ms     20.26 us      9.06 us        mutex   pip=
e_read+0x57
> > >                          0xffffffffac6318e7  pipe_read+0x57
> > >                          0xffffffffac623862  vfs_read+0x332
> > >                          0xffffffffac62434b  ksys_read+0xbb
> > >                          0xfffffffface604b2  do_syscall_64+0x82
> > >                          0xffffffffad00012f  entry_SYSCALL_64_after_h=
wframe+0x76
> > >          36    193.71 us     15.27 us      5.38 us        mutex   pip=
e_write+0x50
> > >                          0xffffffffac631ee0  pipe_write+0x50
> > >                          0xffffffffac6241db  vfs_write+0x3bb
> > >                          0xffffffffac6244ab  ksys_write+0xbb
> > >                          0xfffffffface604b2  do_syscall_64+0x82
> > >                          0xffffffffad00012f  entry_SYSCALL_64_after_h=
wframe+0x76
> > >           4     51.22 us     16.47 us     12.80 us        mutex   do_=
epoll_wait+0x24d
> > >                          0xffffffffac691f0d  do_epoll_wait+0x24d
> > >                          0xffffffffac69249b  do_epoll_pwait.part.0+0x=
b
> > >                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x=
95
> > >                          0xfffffffface604b2  do_syscall_64+0x82
> > >                          0xffffffffad00012f  entry_SYSCALL_64_after_h=
wframe+0x76
> > >
> > >  =3D=3D=3D owner stack trace =3D=3D=3D
> > >
> > >           3     31.24 us     15.27 us     10.41 us        mutex   pip=
e_read+0x348
> > >                          0xffffffffac631bd8  pipe_read+0x348
> > >                          0xffffffffac623862  vfs_read+0x332
> > >                          0xffffffffac62434b  ksys_read+0xbb
> > >                          0xfffffffface604b2  do_syscall_64+0x82
> > >                          0xffffffffad00012f  entry_SYSCALL_64_after_h=
wframe+0x76
> > >  ...
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > ---
> > > tools/perf/Documentation/perf-lock.txt |  5 ++-
> > > tools/perf/builtin-lock.c              | 22 +++++++++-
> > > tools/perf/util/bpf_lock_contention.c  | 57 +++++++++++++++++++++++++=
+
> > > tools/perf/util/lock-contention.h      |  7 ++++
> > > 4 files changed, 87 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Docu=
mentation/perf-lock.txt
> > > index d3793054f7d3..859dc11a7372 100644
> > > --- a/tools/perf/Documentation/perf-lock.txt
> > > +++ b/tools/perf/Documentation/perf-lock.txt
> > > @@ -179,8 +179,9 @@ CONTENTION OPTIONS
> > >
> > > -o::
> > > --lock-owner::
> > > - Show lock contention stat by owners.  Implies --threads and
> > > - requires --use-bpf.
> > > + Show lock contention stat by owners. This option can be combined wi=
th -t,
> > > + which shows owner's per thread lock stats, or -v, which shows owner=
's
> > > + stacktrace. Requires --use-bpf.
> > >
> > > -Y::
> > > --type-filter=3D<value>::
> > > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > > index 9bebc186286f..05e7bc30488a 100644
> > > --- a/tools/perf/builtin-lock.c
> > > +++ b/tools/perf/builtin-lock.c
> > > @@ -1817,6 +1817,22 @@ static void print_contention_result(struct loc=
k_contention *con)
> > > break;
> > > }
> > >
> > > + if (con->owner && con->save_callstack && verbose > 0) {
> > > + struct rb_root root =3D RB_ROOT;
> > > +
> > > + if (symbol_conf.field_sep)
> > > + fprintf(lock_output, "# owner stack trace:\n");
> > > + else
> > > + fprintf(lock_output, "\n=3D=3D=3D owner stack trace =3D=3D=3D\n\n")=
;
> > > + while ((st =3D pop_owner_stack_trace(con)))
> > > + insert_to(&root, st, compare);
> > > +
> > > + while ((st =3D pop_from(&root))) {
> > > + print_lock_stat(con, st);
> > > + free(st);
> > > + }
> > > + }
> > > +
> > > if (print_nr_entries) {
> > > /* update the total/bad stats */
> > > while ((st =3D pop_from_result())) {
> > > @@ -1962,8 +1978,10 @@ static int check_lock_contention_options(const=
 struct option *options,
> > > }
> > > }
> > >
> > > - if (show_lock_owner)
> > > - show_thread_stats =3D true;
> > > + if (show_lock_owner && !show_thread_stats) {
> > > + pr_warning("Now -o try to show owner's callstack instead of pid and=
 comm.\n");
> > > + pr_warning("Please use -t option too to keep the old behavior.\n");
> > > + }
> > >
> > > return 0;
> > > }
> > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/=
bpf_lock_contention.c
> > > index 76542b86e83f..16f4deba69ec 100644
> > > --- a/tools/perf/util/bpf_lock_contention.c
> > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > @@ -549,6 +549,63 @@ static const char *lock_contention_get_name(stru=
ct lock_contention *con,
> > > return name_buf;
> > > }
> > >
> > > +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> > > +{
> > > + int stacks_fd, stat_fd;
> > > + u64 *stack_trace =3D NULL;
> > > + s32 stack_id;
> > > + struct contention_key ckey =3D {};
> > > + struct contention_data cdata =3D {};
> > > + size_t stack_size =3D con->max_stack * sizeof(*stack_trace);
> > > + struct lock_stat *st =3D NULL;
> > > +
> > > + stacks_fd =3D bpf_map__fd(skel->maps.owner_stacks);
> > > + stat_fd =3D bpf_map__fd(skel->maps.owner_stat);
> > > + if (!stacks_fd || !stat_fd)
> > > + goto out_err;
> > > +
> > > + stack_trace =3D zalloc(stack_size);
> > > + if (stack_trace =3D=3D NULL)
> > > + goto out_err;
> > > +
> > > + if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
> > > + goto out_err;
> > > +
> > > + bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
> > > + ckey.stack_id =3D stack_id;
> > > + bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
> > > +
> > > + st =3D zalloc(sizeof(struct lock_stat));
> > > + if (!st)
> > > + goto out_err;
> > > +
> > > + st->name =3D strdup(stack_trace[0] ? lock_contention_get_name(con, =
NULL, stack_trace, 0) :
> > > +   "unknown");
> >
> > Hi,
> >
> > I am hitting a compilation issue with this change. Sorry for responding=
 late. I tried with change from tmp.perf-tools-next and hit below issue:
> >
> >
> >   CC      util/bpf_lock_contention.o
> > util/bpf_lock_contention.c: In function =E2=80=98lock_contention_get_na=
me=E2=80=99:
> > cc1: error: function may return address of local variable [-Werror=3Dre=
turn-local-addr]
> > util/bpf_lock_contention.c:470:45: note: declared here
> >   470 |                 struct contention_task_data task;
> >       |                                             ^~~~
> > cc1: all warnings being treated as errors
> > make[4]: *** [/root/perf-tools-next/tools/build/Makefile.build:85: util=
/bpf_lock_contention.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >   LD      perf-in.o
> > make[3]: *** [/root/perf-tools-next/tools/build/Makefile.build:138: uti=
l] Error 2
> > make[2]: *** [Makefile.perf:822: perf-util-in.o] Error 2
> > make[1]: *** [Makefile.perf:321: sub-make] Error 2
> > make: *** [Makefile:76: all] Error 2
>
> Thanks for the report.  I've noticed that and also found this error:
>
>   In file included from util/lock-contention.c:4:0:
>   util/lock-contention.h:192:19: error: no previous prototype for 'pop_ow=
ner_stack_trace' [-Werror=3Dmissing-prototypes]
>    struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
>                      ^~~~~~~~~~~~~~~~~~~~~
>   util/lock-contention.h: In function 'pop_owner_stack_trace':
>   util/lock-contention.h:192:65: error: unused parameter 'con' [-Werror=
=3Dunused-parameter]
>    struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
>                                                                    ^~~
>
> Removed this series from tmp.perf-tools-next.
>
> Thanks,
> Namhyung
>
> >
> >
> > Code snippet:
> >
> > if (con->aggr_mode =3D=3D LOCK_AGGR_TASK) {
> >                 struct contention_task_data task;
> >                 int pid =3D key->pid;
> >                 int task_fd =3D bpf_map__fd(skel->maps.task_data);
> >
> >                 /* do not update idle comm which contains CPU number */
> >                 if (pid) {
> >                         struct thread *t =3D machine__findnew_thread(ma=
chine, /*pid=3D*/-1, pid);
> >
> >                         if (t =3D=3D NULL)
> >                                 return name;
> >                         if (!bpf_map_lookup_elem(task_fd, &pid, &task) =
&&
> >                             thread__set_comm(t, task.comm, /*timestamp=
=3D*/0))
> >                                 name =3D task.comm;
> >                 }
> >                 return name;
> >         }
> >
> >
> > We are calling lock_contention_get_name with second argument as NULL .
> > Though error above points to =E2=80=9Ccontention_task_data=E2=80=9D, I =
think the local variable here is for =E2=80=9Cname=E2=80=9D ?
> >
> >
> > Thanks
> > Athira
> >
> > > + if (!st->name)
> > > + goto out_err;
> > > +
> > > + st->flags =3D cdata.flags;
> > > + st->nr_contended =3D cdata.count;
> > > + st->wait_time_total =3D cdata.total_time;
> > > + st->wait_time_max =3D cdata.max_time;
> > > + st->wait_time_min =3D cdata.min_time;
> > > + st->callstack =3D stack_trace;
> > > +
> > > + if (cdata.count)
> > > + st->avg_wait_time =3D cdata.total_time / cdata.count;
> > > +
> > > + bpf_map_delete_elem(stacks_fd, stack_trace);
> > > + bpf_map_delete_elem(stat_fd, &ckey);
> > > +
> > > + return st;
> > > +
> > > +out_err:
> > > + free(stack_trace);
> > > + free(st);
> > > +
> > > + return NULL;
> > > +}
> > > +
> > > int lock_contention_read(struct lock_contention *con)
> > > {
> > > int fd, stack, err =3D 0;
> > > diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock=
-contention.h
> > > index a09f7fe877df..97fd33c57f17 100644
> > > --- a/tools/perf/util/lock-contention.h
> > > +++ b/tools/perf/util/lock-contention.h
> > > @@ -168,6 +168,8 @@ int lock_contention_stop(void);
> > > int lock_contention_read(struct lock_contention *con);
> > > int lock_contention_finish(struct lock_contention *con);
> > >
> > > +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)=
;
> > > +
> > > #else  /* !HAVE_BPF_SKEL */
> > >
> > > static inline int lock_contention_prepare(struct lock_contention *con=
 __maybe_unused)
> > > @@ -187,6 +189,11 @@ static inline int lock_contention_read(struct lo=
ck_contention *con __maybe_unuse
> > > return 0;
> > > }
> > >
> > > +struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
> > > +{
> > > + return NULL;
> > > +}
> > > +
> > > #endif  /* HAVE_BPF_SKEL */
> > >
> > > #endif  /* PERF_LOCK_CONTENTION_H */
> > > --
> > > 2.48.1.658.g4767266eb4-goog
> > >
> > >
> >
