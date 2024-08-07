Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97319DF86;
	Wed,  7 Aug 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011186; cv=none; b=WhS7Hn/gTryBudZYs6eRw9Y94cPP8eEg9yvKht7cuYhyKxc0sJxjWIPftkghoeFgm+sT1bzuG5RqtZbJ0t1cthe6wCzCQ2UeCQ4yHtlM1o/4XaLtB6GUa35I7iJLflaVvsxFcCumvUOqmDjGthxEbq1mf40A46poY98tkZCNewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011186; c=relaxed/simple;
	bh=K+qxP4WWcgJDXI8X+yE8XSc+XD0JqKDQrr0AfKdv2PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDQILYM3+vf7Apn7O+uVo2XSLoSF3Dotq4Em0kYFEP1Usrn9Y6Wxn1cByegxq3BexHpFJYuqW6heyNF7siZrE3/NuE6RnsCaXymeEp6lolRAigPUlfALHT+lE07yXSZl/TNBNZm+hLkQnn/yg0ChaU+BDFFTJpUXIUAKKpqji0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso1088669b3a.2;
        Tue, 06 Aug 2024 23:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723011184; x=1723615984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n2OlsDXMc5wTadk3lzNRjAKDrY2Lrbi1VmKcvwH5VI=;
        b=rsWKYSX2dSnnJj+K+PIR3p6Uz7n/uGVgbR2QJaYrrRqx9TiYOIa942uC7gtZDD+GJ8
         TnhNr9xqvmRiDP+M+iGXqdgwSwcMqYqiRllr2yU2V8oNSR79ZD8XZNKMGEXz/nKrVQv/
         KPykqeuiRl/IQdrcyQk/jYAC3j1b/i+GoOnXmvpFdzYsHDxjp345ezF4uqmceu/iSFci
         JIGQ3uuiWgpPf6vBFXBpUk7WQ2YexnNMtDCJcsyLxgB4auZyLptrCCFyNNNJPLOeLulE
         ZcWmBl2vT4hZYYUH+uKZmr4FAGFJ5Lo9WOcEa+oPGN187PNC2nL4V+6fthrcGQJfSGTZ
         J73w==
X-Forwarded-Encrypted: i=1; AJvYcCV6ImzyJ3Xo0nnMJfAtK8kHJ6zELE9u2C6bKplX5D60j5JWarjAFKKq4GDajG667cKODkCa0dy/p6pVPe51l83r14sMrMmFh3jLgdR4SgYzftP8/bjPHOOSNwK9N5CFd023Y1UlaIXy/zCEZiEGtw==
X-Gm-Message-State: AOJu0YwNhwh6/moy0mY3/W1Kc4sEzIDmRzm/ns/mDb12Fo6oVxFVhJWb
	JyxILAsaDsSNkt1BM5YWp0ssFbvv5p3ALX+rJwJeA5TnBRcIb5c5Dor5/9tKd8/p1q9sXBE5DS6
	/lRO9KDDmblQXT7uUE/qT5aM8nJZ/weH2
X-Google-Smtp-Source: AGHT+IFRoyDWY1SSLyws+WoffESWAAm6uUnvONlx2YSA4nwdKDAwR3b0mkU1JbpJ1lxcuKyqBn4TebX3/xillaaVm4A=
X-Received: by 2002:a05:6a20:4d95:b0:1c6:ba8b:1e2e with SMTP id
 adf61e73a8af0-1c6ba8b1f23mr8369448637.1.1723011184117; Tue, 06 Aug 2024
 23:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803211332.1107222-1-namhyung@kernel.org> <20240803211332.1107222-6-namhyung@kernel.org>
 <ZrEmZLV0vgU6GUcN@x1> <ZrEyo4CSm6nKU20s@google.com> <ZrE011BLww0LQQha@x1>
 <ZrE7EWyFJ3hThopM@google.com> <ZrIhPuFee8R9ZvVi@x1>
In-Reply-To: <ZrIhPuFee8R9ZvVi@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Aug 2024 23:12:51 -0700
Message-ID: <CAM9d7cjXmaMuidQR10PXrp9khZ4LhDZbLno1rN2JcCncaYyp7Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf annotate: Add --skip-empty option
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:12=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Aug 05, 2024 at 01:50:25PM -0700, Namhyung Kim wrote:
> > On Mon, Aug 05, 2024 at 05:23:51PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Mon, Aug 05, 2024 at 01:14:27PM -0700, Namhyung Kim wrote:
> > > > On Mon, Aug 05, 2024 at 04:22:12PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Sat, Aug 03, 2024 at 02:13:32PM -0700, Namhyung Kim wrote:
> > > > > > Like in perf report, we want to hide empty events in the perf a=
nnotate
> > > > > > output.  This is consistent when the option is set in perf repo=
rt.
> > > > > >
> > > > > > For example, the following command would use 3 events including=
 dummy.
> > > > > >
> > > > > >   $ perf mem record -a -- perf test -w noploop
> > > > > >
> > > > > >   $ perf evlist
> > > > > >   cpu/mem-loads,ldlat=3D30/P
> > > > > >   cpu/mem-stores/P
> > > > > >   dummy:u
> > > > > >
> > > > > > Just using perf annotate with --group will show the all 3 event=
s.
> > > > >
> > > > > Seems unrelated, just before compiling with this patch:
> > > > >
> > > > > root@x1:~# perf mem record -a -- perf test -w noploop
> > > > > Memory events are enabled on a subset of CPUs: 4-11
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 10.506 MB perf.data (2775 sampl=
es) ]
> > > > > root@x1:~#
> > > > >
> > > > > root@x1:~# perf annotate --group --stdio2 sched_clock
> > > > > root@x1:~# perf annotate --stdio2 sched_clock
> > > > > Samples: 178  of event 'cpu_atom/mem-stores/P', 4000 Hz, Event co=
unt (approx.): 565268, [percent: local period]
> > > > > sched_clock() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/v=
mlinux
> > > > > Percent      0xffffffff810511e0 <sched_clock>:
> > > > >                endbr64
> > > > >    5.76        incl    pcpu_hot+0x8
> > > > >    5.47      =E2=86=92 callq   sched_clock_noinstr
> > > > >   88.78        decl    pcpu_hot+0x8
> > > > >              =E2=86=93 je      1e
> > > > >              =E2=86=92 jmp     __x86_return_thunk
> > > > >          1e: =E2=86=92 callq   __SCT__preempt_schedule_notrace
> > > > >              =E2=86=92 jmp     __x86_return_thunk
> > > > > root@x1:~# perf annotate --group --stdio2 sched_clock
> > > > > root@x1:~# perf annotate --group --stdio sched_clock
> > > > > root@x1:~# perf annotate --group sched_clock
> > > > > root@x1:~#
> > > > >
> > > > > root@x1:~# perf evlist
> > > > > cpu_atom/mem-loads,ldlat=3D30/P
> > > > > cpu_atom/mem-stores/P
> > > > > dummy:u
> > > > > root@x1:~#
> > > > >
> > > > > root@x1:~# perf report --header-only | grep cmdline
> > > > > # cmdline : /home/acme/bin/perf mem record -a -- perf test -w nop=
loop
> > > > > root@x1:~#
> > > > >
> > > > > I thought it would be some hybrid oddity but seems to be just --g=
roup
> > > > > related, seems like it stops if the first event has no samples? B=
ecause
> > > > > it works with another symbol:
> > > >
> > > > Good catch.  Yeah I found it only checked the first event.  Somethi=
ng
> > > > like below should fix the issue.
> > >
> > > Nope, with the patch applied:
> > >
> > > root@x1:~# perf annotate --group --stdio sched_clock
> > > root@x1:~# perf annotate --stdio sched_clock
> > >  Percent |      Source code & Disassembly of vmlinux for cpu_atom/mem=
-stores/P (147 samples, percent: local period)
> > > ---------------------------------------------------------------------=
----------------------------------------------
> > >          : 0                0xffffffff810511e0 <sched_clock>:
> > >     0.00 :   ffffffff810511e0:       endbr64
> > >     5.11 :   ffffffff810511e4:       incl    %gs:0x7efe2d5d(%rip)    =
   # 33f48 <pcpu_hot+0x8>
> > >     0.13 :   ffffffff810511eb:       callq   0xffffffff821350d0
> > >    94.76 :   ffffffff810511f0:       decl    %gs:0x7efe2d51(%rip)    =
   # 33f48 <pcpu_hot+0x8>
> > >     0.00 :   ffffffff810511f7:       je      0xffffffff810511fe
> > >     0.00 :   ffffffff810511f9:       jmp     0xffffffff82153320
> > >     0.00 :   ffffffff810511fe:       callq   0xffffffff82153990
> > >     0.00 :   ffffffff81051203:       jmp     0xffffffff82153320
> > > root@x1:~# perf annotate --group --stdio sched_clock
> > > root@x1:~# perf annotate --group --stdio2 sched_clock
> > > root@x1:~# perf annotate --group sched_clock
> > > root@x1:~#
> >
> > Oh ok, it was not enough.  It should call evsel__output_resort() after
> > hists__match() and hists__link().  Use this instead.
>
> Ok, this works:
>
> Before this patch:
>
> root@x1:~# perf annotate --stdio sched_clock
>  Percent |      Source code & Disassembly of vmlinux for cpu_atom/mem-sto=
res/P (147 samples, percent: local period)
> -------------------------------------------------------------------------=
------------------------------------------
>          : 0                0xffffffff810511e0 <sched_clock>:
>     0.00 :   ffffffff810511e0:       endbr64
>     5.11 :   ffffffff810511e4:       incl    %gs:0x7efe2d5d(%rip)       #=
 33f48 <pcpu_hot+0x8>
>     0.13 :   ffffffff810511eb:       callq   0xffffffff821350d0
>    94.76 :   ffffffff810511f0:       decl    %gs:0x7efe2d51(%rip)       #=
 33f48 <pcpu_hot+0x8>
>     0.00 :   ffffffff810511f7:       je      0xffffffff810511fe
>     0.00 :   ffffffff810511f9:       jmp     0xffffffff82153320
>     0.00 :   ffffffff810511fe:       callq   0xffffffff82153990
>     0.00 :   ffffffff81051203:       jmp     0xffffffff82153320
> root@x1:~# perf annotate --group --stdio sched_clock
> root@x1:~#
>
> After:
>
> root@x1:~# perf annotate --group --stdio sched_clock
>  Percent                 |      Source code & Disassembly of vmlinux for =
cpu_atom/mem-loads,ldlat=3D30/P, cpu_atom/mem-stores/P, dummy:u (0 samples,=
 percent: local period)
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------
>                          : 0                0xffffffff810511e0 <sched_clo=
ck>:
>     0.00    0.00    0.00 :   ffffffff810511e0:       endbr64
>     0.00    5.11    0.00 :   ffffffff810511e4:       incl    %gs:0x7efe2d=
5d(%rip)       # 33f48 <pcpu_hot+0x8>
>     0.00    0.13    0.00 :   ffffffff810511eb:       callq   0xffffffff82=
1350d0
>     0.00   94.76    0.00 :   ffffffff810511f0:       decl    %gs:0x7efe2d=
51(%rip)       # 33f48 <pcpu_hot+0x8>
>     0.00    0.00    0.00 :   ffffffff810511f7:       je      0xffffffff81=
0511fe
>     0.00    0.00    0.00 :   ffffffff810511f9:       jmp     0xffffffff82=
153320
>     0.00    0.00    0.00 :   ffffffff810511fe:       callq   0xffffffff82=
153990
>     0.00    0.00    0.00 :   ffffffff81051203:       jmp     0xffffffff82=
153320
> root@x1:~#
>
> One example with samples for the first two events:
>
> root@x1:~# perf annotate --group --stdio2
> Samples: 2K of events 'cpu_atom/mem-loads,ldlat=3D30/P, cpu_atom/mem-stor=
es/P, dummy:u', 4000 Hz, Event count (approx.): 22892183, [percent: local p=
eriod]
> cgroup_rstat_updated() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/=
vmlinux
> Percent                       0xffffffff8124e080 <cgroup_rstat_updated>:
>    0.00    0.24    0.00         endbr64
>                               =E2=86=92 callq   __fentry__
>    0.00   99.76    0.00         pushq   %r15
>                                 movq    $0x251d4,%rcx
>                                 pushq   %r14
>                                 movq    %rdi,%r14
>                                 pushq   %r13
>                                 movslq  %esi,%r13
>                                 pushq   %r12
>                                 pushq   %rbp
>                                 pushq   %rbx
>                                 subq    $0x10,%rsp
>                                 cmpq    $0x2000,%r13
>                               =E2=86=93 jae     17f
>                           31:   movq    0x3d0(%r14),%rbx
>                                 movq    -0x7d3fb360(, %r13, 8),%r12
>                                 cmpq    $0x2000,%r13
>                               =E2=86=93 jae     19b
>   25.00    0.00    0.00   4d:   cmpq    $0,0x88(%r12, %rbx)
>                               =E2=86=93 je      6b
>                                 addq    $0x10,%rsp
>                                 popq    %rbx
>                                 popq    %rbp
>                                 popq    %r12
>   75.00    0.00    0.00         popq    %r13
>                                 popq    %r14
>                                 popq    %r15
>                               =E2=86=92 jmp     __x86_return_thunk
> <SNIP>
>
> And then skipping "empty" events:
>
> root@x1:~# perf annotate --group --skip-empty --stdio2 cgroup_rstat_updat=
ed | head -35
> Samples: 4  of events 'cpu_atom/mem-loads,ldlat=3D30/P, cpu_atom/mem-stor=
es/P', 4000 Hz, Event count (approx.): 31851, [percent: local period]
> cgroup_rstat_updated() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/=
vmlinux
> Percent               0xffffffff8124e080 <cgroup_rstat_updated>:
>    0.00    0.24         endbr64
>                       =E2=86=92 callq   __fentry__
>    0.00   99.76         pushq   %r15
>                         movq    $0x251d4,%rcx
>                         pushq   %r14
>                         movq    %rdi,%r14
>                         pushq   %r13
>                         movslq  %esi,%r13
>                         pushq   %r12
>                         pushq   %rbp
>                         pushq   %rbx
>                         subq    $0x10,%rsp
>                         cmpq    $0x2000,%r13
>                       =E2=86=93 jae     17f
>                   31:   movq    0x3d0(%r14),%rbx
>                         movq    -0x7d3fb360(, %r13, 8),%r12
>                         cmpq    $0x2000,%r13
>                       =E2=86=93 jae     19b
>   25.00    0.00   4d:   cmpq    $0,0x88(%r12, %rbx)
>                       =E2=86=93 je      6b
>                         addq    $0x10,%rsp
>                         popq    %rbx
>                         popq    %rbp
>                         popq    %r12
>   75.00    0.00         popq    %r13
>                         popq    %r14
>                         popq    %r15
>                       =E2=86=92 jmp     __x86_return_thunk
>                   6b:   addq    %r12,%rcx
>                         movq    %rcx,%rdi
>                         movq    %rcx,(%rsp)
>                       =E2=86=92 callq   *ffffffff82151500
> root@x1:~#
>
> So, I haven't done further analysis but I think this is a separate
> issue, right?

Yep, it's not related to --skip-empty.

>
> Thanks for the fix!
>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Will send a fix with your tags.

Thanks,
Namhyung
