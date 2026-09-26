Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CE377ABF
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790464336; cv=pass; b=afghmpOsH84jrjPztxTmgsgCy+UK2/JB3bZjjotZDJ8megjjFwOPxsyipwbIi3XItrR3dhEYz8Om6eRrcru6O5ICfTWs6YhbmhyHlq00XLgoXH43KgI+tx9SfOueJ112WCY0WRPlGCKACX+wNbYYsF2joIwmXX5qaEIqsAYXzAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790464336; c=relaxed/simple;
	bh=vcBWCJxRCBkOI0fu3YYDRBlsspXE7I5TKf52DaBxDT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQ1zkugzydYngMINzNaoOvBbKH3f4xiD7XG4Iuf+6KjeZDc9HJ14Wy+CeHL3Kvrh+vI3aqnDVYcY7mQivXrvGwMmUuntlvgrFHW9Bt2YkD2N+b0enLRsfCG5pjUaXJf8FuAb5A4BAtfDkHY+7rJmmWnm8jQjszsSNNFho6KvnmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDlJM8nM; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDlJM8nM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5333401e359so29071cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 16:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790464333; cv=none;
        d=google.com; s=arc-20260327;
        b=W5u2c+R/gOHSB9CEo1aqECrTb0rX8EZSp7pRyOzpklxp0hmDjKWOB52Q0DcnXlVDBl
         R6wU/6HESFhCN6+MqtN8H9y9xFlDh/ZcqmwivbUVchA9m1S5ONQiv/NeYy9W3BW6IcBx
         YxuSaPk9s5o0kmHJi6BAfXFyJwEE3PKXKwqvbLNsbxzbeQknAHe7R4DlFxjp97u9JIXP
         iFfGZYLr3ocqZ5nY3IK3/V42qHfe5wF/eB783uKemM/qZ9w/My1i22cLhJLQy2o2WY47
         YiafpjbNWxwq5PVKaOVHGSHfQz1RxNXHLJjCMY6NdmehFPoy+wzB2K2kGM9hwiOCrdkp
         auoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eDVjq6e9qHtHgOdz81PWcHYM3LUooF6QpX6TN4vA1tE=;
        fh=pSqju1vGtwxTFVU8NzxTB/uENAS3sUS4ILmmT3plEH8=;
        b=ZSvx794YzQY9Bt7JT/jJdvY8bAclBw/2U7sy/UIWbC4t2FDG9WYIhirmN5xglxz4U2
         G0zGbgdB4XPRphkUOZdt6qkSy23z4I7M0mspbgpNaii65PcokOwr6xZtC1KuiWYDi8uM
         YXxwCcEGDFOQk3NUiKITN+XCOX9XbKAJU/u5sWWGchZM/mSrmxrJg74vOXndTJ0Vm4bD
         PiPKMz55bUkJ6kAa+52QSwKcRHZWFvPJTHEmiClCv2nx8Y7p68zBSdLIRH+a3xKEA3Pv
         qknaOySvltBN3SzIo7+o5RQBnWQ0tjG6gxBl7nkmM/ioUWFU9X1LFPibbEV//OWfjA8p
         MvYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790464333; x=1791069133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eDVjq6e9qHtHgOdz81PWcHYM3LUooF6QpX6TN4vA1tE=;
        b=HDlJM8nMc65A/SSqljwT5bmxj/scV426YKXajnUppGJIPYDBEzY9JGiBpnN9QjjYp+
         HdkLnYuIAbG8VxwHR1b324fhUM/9/YZ09dHKq23OsPVtXOppJFZ5xs2tMFVWHHB9a+/m
         g5RY0s5QGIlrieRFWBcJXNsW2ExxJHCbouDCQyFl7xjFW+kGhBIu03tW/DltbyQFW0gL
         LOEZaQTVKdrKjK0d4eRu6tKW09ZQwoyf+4cn4ZNfRgmIo+i2nZqUUQKLdsqlBIIjGSzJ
         rO0cPAonBw2X5pNONCKC0bbrS5v5X4sAJUg25BniFPCPSNaPh3Nu8PEI7/wHY6f7Cc/v
         JS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790464333; x=1791069133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDVjq6e9qHtHgOdz81PWcHYM3LUooF6QpX6TN4vA1tE=;
        b=wLGOoh5e/yTbvgshlaspIDNTiyG4bj8BE7Ol9BbNigvvWFwl/PgKBwXMKeMItwnNeH
         Ep4xTCf0zwHataYCSlIDd6lL7s95NEtg50vJ0m7zTJTXlMSpA3XSaMSR/hqeqLFR3jO4
         WkGeokma7/4hJW+rDFodssz8MkAZrOI+rbFqZjgkYone8bdoD8nQ5YTufo4u3Y2lLsVY
         r9kTz1a5ccXhWLt82irZvSMGCTg0EQGjxROuv3Pk62fPx0kpPyL0qlVQvwrj22p3dVzy
         EmTfQJi1EyoJqLFeJlPuORoyzXpp4MPpYfQO+3cvMparAjCBVT0GAn222Kbr1eRQDoOn
         AWbw==
X-Forwarded-Encrypted: i=1; AKwUvBzSIYFsWZkTmFxOJ5wh9erTTmn1BoJTGBc5rWT7ZCZzGwbnimAp0Nz+utTD25JnnLU80Ck4YAIGKwA+7cK6sb0a@vger.kernel.org
X-Gm-Message-State: AFuF++lfETqAnBTYh/Q8/3eIftBGouHmNX/gQhQ+mJxQ8jRDybXiaz47
	Wm9mI3ABDBoxuF8GvgceinIY1n/6h/YXXtm+516JbW5LQI3DDyLKGLLtBgoTCh3vVWZ0pzch1jb
	aj3vXwIMGw8HSf3LsItkf1ZdJgT0m0sCX+zHUy11ig/Rywbzvovznz53nH8Y=
X-Gm-Gg: AYBFou3iHd9WuUdoj+l0pW9Fu1YWTpC+pEFvROsjOlV5GRvjrc/wZAVLHFgCMajblqc
	PC45+ZlT/YAOwtPvxxuN13jCPqxzxgfG9sHoVoGZc3diXUPFCKX5AuUOkXp+Ib4vBCJKKFAucBM
	Dfump0pcwYz72HfCoMobne/1b3B7NTRZ9DaxlTSD60RRHrQn0m0h2PA6xMnjKZFTSO3MI/VhFQP
	yGjIljGpZtYULLQdnh284vc+uXLWQx8NYItCt7r6w+Z7z4R3MTc55aku4pNaxVzKZ+maPSt/iyg
	QCGgXGwD4gtz+IEJjmSRW2E3eKXIlUqgGIu+DrebWcFuPTrPWaDf/nE=
X-Received: by 2002:a05:622a:598c:b0:532:858d:e791 with SMTP id
 d75a77b69052e-533201552e2mr16816101cf.8.1790464332218; Sat, 26 Sep 2026
 16:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
 <argt6raEAmM4e9PI@x2> <CAP-5=fXvENrH1PrQvQmA22h_XRTB_f_ez_sFU9him6dU4uH0Ew@mail.gmail.com>
In-Reply-To: <CAP-5=fXvENrH1PrQvQmA22h_XRTB_f_ez_sFU9him6dU4uH0Ew@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 26 Sep 2026 16:11:59 -0700
X-Gm-Features: AclHuK-O3MFQHs4G5cM9DnMobIzdgtSjzHFYo5qRrntHk_NSBP0G7gxpBZrcg9I
Message-ID: <CAP-5=fWFef2eS0fk7wQ9zyiHZBNf=_4aAVXaXpyfSnr0thf2rw@mail.gmail.com>
Subject: Re: [PATCH v4 00/49] perf: Complete transition to standalone Python scripts
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: alice.mei.rogers@gmail.com, james.clark@linaro.org, leo.yan@linux.dev, 
	namhyung@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 3:46=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Sep 26, 2026 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Sep 25, 2026 at 11:19:27PM -0700, Ian Rogers wrote:
> > > The perf script command has historically supported running Python and=
 Perl
> > > scripts by embedding libpython and libperl. That approach has several
> > > drawbacks:
> > >  - high overhead from constructing Python dictionaries for every even=
t
> > >    (whether used by the script or not),
> > >  - complex build dependencies on specific Python/Perl libraries,
> > >  - threading and interpreter lifecycle complications from embedding t=
he
> > >    interpreter inside perf,
> > >  - no unified model for standalone scripts such as ilist.py, treport.=
py,
> > >    tracepoint.py, and twatch.py.
> >
> > So I applied it and tested on the containers, make -C tools/perf
> > build-test and 'perf test', that has some flakiness running the new
> > tests for these python scripts in parallel, nothing that prevents it
> > from being merged now tho:
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 146
> > Passed subtests   : 156
> > Skipped tests     : 28
> > Failed tests      : 13
> > List of failed tests:
> >    72: Test dwarf unwind
> >    88: daemon operations
> >   101: perf kvm tests
> >   111: perf record tests
> >   112: perf record sample filtering (by BPF) tests
> >   117: perf sched tests
> >   137: check-perf-trace python test
> >   138: compaction-times python test
> >   141: failed-syscalls-by-pid python test
> >   142: failed-syscalls python test
> >   144: futex-contention python test
> >   157: sctop python test
> >   159: stat-cpi python test
> > root@x2:~# perf test 72
> >  72: Test dwarf unwind                                                 =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > root@x2:~# perf test 88
> >  88: daemon operations                                                 =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > root@x2:~# perf test 101
> > 101: perf kvm tests                                                    =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > root@x2:~# perf test 112 ; perf test 117 ; perf test 137 ; perf test 14=
1 ; perf test 142 ; perf test 144 ; perf test 157; perf test 159
> > 112: perf record sample filtering (by BPF) tests                       =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 117: perf sched tests                                                  =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 137: check-perf-trace python test                                      =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 141: failed-syscalls-by-pid python test                                =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 142: failed-syscalls python test                                       =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 144: futex-contention python test                                      =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 157: sctop python test                                                 =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > 159: stat-cpi python test                                              =
                                        : Ok
> >
> > =3D=3D=3D Test Summary =3D=3D=3D
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > root@x2:~# uname -a
> > Linux x2 7.2.5-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep 11 15:11:=
05 UTC 2026 x86_64 GNU/Linux
> > root@x2:~# cat /etc/os-release
> > NAME=3D"Fedora Linux"
> > VERSION=3D"44 (Workstation Edition)"
> > RELEASE_TYPE=3Dstable
> > ID=3Dfedora
> > VERSION_ID=3D44
> > VERSION_CODENAME=3D""
> > PRETTY_NAME=3D"Fedora Linux 44 (Workstation Edition)"
> > ANSI_COLOR=3D"0;38;2;60;110;180"
> > LOGO=3Dfedora-logo-icon
> > CPE_NAME=3D"cpe:/o:fedoraproject:fedora:44"
> > DEFAULT_HOSTNAME=3D"fedora"
> > HOME_URL=3D"https://fedoraproject.org/"
> > DOCUMENTATION_URL=3D"https://docs.fedoraproject.org/en-US/fedora/f44/"
> > SUPPORT_URL=3D"https://ask.fedoraproject.org/"
> > BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
> > REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
> > REDHAT_BUGZILLA_PRODUCT_VERSION=3D44
> > REDHAT_SUPPORT_PRODUCT=3D"Fedora"
> > REDHAT_SUPPORT_PRODUCT_VERSION=3D44
> > SUPPORT_END=3D2027-05-19
> > VARIANT=3D"Workstation Edition"
> > VARIANT_ID=3Dworkstation
> > root@x2:~#
>
> That's great! I'll dig into the flakes.

Just to add, testing with perf-tools-next:
```
$ make -C tools/perf O=3D/tmp/perf DESTDIR=3D/tmp/perf-install DEBUG=3D1 in=
stall
...
$ PERF_EXEC_PATH=3D/tmp/perf-install/libexec/perf-core
/tmp/perf-install/bin/perf script -l
List of available scripts:
  arm-cs-trace-disasm                  arm-cs-trace-disasm.py: ARM
CoreSight Trace Dump With Disassembler
  check-perf-trace                     Basic test of Python scripting
support for perf.
  compaction-times                     Report time spent in memory compacti=
on.
  counting                             Example for counting perf events.
  event_analyzing_sample               General event handler in
Python, using SQLite to analyze events.
  export-to-postgresql                 Export perf data to a
postgresql database.
  export-to-sqlite                     Export perf data to a sqlite3 databa=
se.
  exported-sql-viewer                  exported-sql-viewer.py: view
data from sql database.
  failed-syscalls                      Failed system call counts.
  failed-syscalls-by-pid               Displays system-wide failed
system call totals, broken down by pid.
  flamegraph                           flamegraph.py - create flame
graphs from perf samples using perf python module
  futex-contention                     Measures futex contention.
  gecko                                gecko.py - Convert perf record
output to Firefox's gecko profile format
  ilist                                Interactive perf list.
  intel-pt-events                      Print Intel PT Events including
Power Events and PTWRITE.
  libxed                               Python wrapper for libxed.so
  mem-phys-addr                        mem-phys-addr.py: Resolve
physical address samples
  net_dropmonitor                      Monitor the system for dropped
packets and produce a report of drop locations and counts.
  netdev-times                         Display a process of packets
and processed time.
  parallel-perf                        Parallel perf script.
  perf_live                            Live event session helper using
perf.evlist.
  powerpc-hcalls                       Hypervisor call statistics
  rw-by-file                           Display r/w activity for files
read/written to for a given program.
  rw-by-pid                            Display r/w activity for all process=
es.
  rwtop                                Periodically displays
system-wide r/w call activity, broken down by pid.
  sched-migration                      Cpu task migration overview toy
  SchedGui                             SchedGui.py - Python extension
for perf script, basic GUI code for traces drawing and overview.
  sctop                                System call top
  stackcollapse                        stackcollapse.py - format perf
samples with one line per distinct call stack
  stat-cpi                             Calculate CPI from perf stat
data or live.
  syscall-counts                       Displays system-wide system
call totals, broken down by syscall.
  syscall-counts-by-pid                Displays system-wide system
call totals, broken down by syscall.
  task-analyzer                        Comprehensive perf tasks analysis.
  tracepoint                           Example showing how to enable a
tracepoint and access its fields.
  treport                              treport.py - perf report like
tool written using textual.
  twatch                               Example to show how to enable a
software event and track context switches.
  wakeup-latency                       Display avg/min/max wakeup latency.
$ sudo bash -c "PERF_EXEC_PATH=3D/tmp/perf-install/libexec/perf-core
/tmp/perf-install/bin/perf script ilist"
...
```
:-D

Thanks!
Ian
