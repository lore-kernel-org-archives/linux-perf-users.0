Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C9183CD1
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970005; cv=none; b=mOLtW/jgPVuaVq++sKdTByfLXvJppUPcqMhmkgMWiSoKM22za375YBSGz3S8GRv5emdYTC62AEYJXT+xe8pg9ObrtncN3qgUEYZlxyLLyjk8jGVjkkL/QDdo0WuoC60p7IuwjAVxhog1YDUNZ1HLPuYrT8GPlGBGpXPG3FY7jGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970005; c=relaxed/simple;
	bh=4CO64niUayQLVxADCud+OC5WxaLcJbeZhOVg6mPVpqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwLNwhkrtSYNo40Zo4DZ/1HLeFM1ZeJ7cKEqHZOSUBy3wq+OaL6dNri2Mz5WQ3xjcvEgQoS+XHcWaYmwq/lOz716narzExvt/Wkuh/QZzsoY88eu8DEanliHXDZsIstwou3GRNmjp+1JKoVTk9bvPEbGb1rqid9KVOFSRruCLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxcUIQDG; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxcUIQDG"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a716d74c28so26165ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970003; x=1732574803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3nLjE9bOINQMj0E9us4SgvLy+OlQkN1XVz15LzOb5Y=;
        b=OxcUIQDG8BF5dvZoOHzJUMywrgAT3eKJ6HAs7g3zSQAoa/8C7pFH0rqpyVU92137lT
         Cnun9vqNR98DFa0GREiwlZa1YvdQmzbUk9BE9FwGlNO0CxTDupFSvbt5+bMh9P463CEL
         MvW64hkojHgo/fIMt8MwJZvXfbka4tLYNRdR43j68NE2HUWcWJUEvEujQM8CL7pUEdco
         WHIs2cZnNDXNhng3viv3KlPtuIMvFUAociBBhBtP5+6dOSaAOL37CS1yj35Ckuf4QZ57
         DfXOXNtZDzMjMHhxLG2zIqruAOIz/h+EkgKxCrUY97rNoM4z7qG0tu4f7jD5/jbcIwo1
         jVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970003; x=1732574803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3nLjE9bOINQMj0E9us4SgvLy+OlQkN1XVz15LzOb5Y=;
        b=VLJISMpCcjq2cnSg/WOj4Xx8cFOLODDKChlnklVVrXWv7HMSEDWHOo4NVKfQ+m8t/i
         Mdlb5DsisH1SnszO701eG9RaR+VLjvJf15dE1G0eIcIIPy3Li79ktAUlGGoio4q/0swl
         UMgE3bCTdw16HEKx//bH/eXvPAypHjIuPXnFHjpI0dqCmLGvGf1/J8jSAPLgCled+aHO
         VxHE+CzHIEWrgZ1Gkova4WCuyfvvxNID2F1upVHkeBiG9Xp+XcPe909reyCn7gptHRr9
         De/O2VaCLdgeiUX0eSRWFgFEoc3fiiIzL70uh/ZnOQgXbm8vCpTkRqIu4U1gM7FuBFw2
         4b1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/1C5ijTFVCT6Kg3YHB80y6gM+E5i3wltK0Gna8z1ymmUor1GqJuyjdKYsbgUDqdEPk1VYA3BkoXAkzWQY85it@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXR7TgYfM4vPg5iFep7jja43IhGGtPXGLG2aBpW/IAPvg0/22
	Avq1qw4PxyRVULVPYZ4qFDtzjyKn2dISb4lHnzbg8Mu54e+ibLeMVnZKB8rMMJZRkNpdU0co+sL
	MvR2rxUFW31jj8HcdXa8ZmtuLqyx5bjxD6ICi
X-Gm-Gg: ASbGncuOrJUTg8T1+3jBbU2PPzF5Qnzi86z126q5ZDeic/b4uxBD+YkPX8UKKJHDqB8
	boNpLkTW1ST+mWUNw3VDZq/Eh6Rkqbi88ceF5/DpoFN0mkIJneGSPOUA9SX2RJD8=
X-Google-Smtp-Source: AGHT+IGUu130JVYqoWa+tEk6TtNLQHVfoGNcrYO1OMUtUbT0P2Bq4QTPVNXW0O36E0Lb9wBXNvzpaY1s+vk8o8s+Pwg=
X-Received: by 2002:a05:6e02:1b08:b0:3a5:e506:162b with SMTP id
 e9e14a558f8ab-3a779fb1038mr67405ab.11.1731970002705; Mon, 18 Nov 2024
 14:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com> <Zy8FIt2OMa5-GymZ@google.com>
 <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>
 <Zy-WM779rMwczlj_@google.com> <CAP-5=fVKvDLUMw_HXBoRLK3FyPvUCWGOZNECer6_fyhbTZTM6A@mail.gmail.com>
 <ZzuH-8ZCa7BVt3ef@google.com> <CAP-5=fUCtzhN75k8gWEVgb_+XoYXFf1VfNndimuHZOx814yAMQ@mail.gmail.com>
 <Zzu4Sdebve-NXEMX@google.com>
In-Reply-To: <Zzu4Sdebve-NXEMX@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Nov 2024 14:46:30 -0800
Message-ID: <CAP-5=fW67Boau8jRfSPKHHXz+RJO15TKXYEx-kWK7iqJmYbyeQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Yang Jihong <yangjihong@bytedance.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Zixian Cai <fzczx123@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 18, 2024 at 11:35:19AM -0800, Ian Rogers wrote:
> > On Mon, Nov 18, 2024 at 10:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 10:06:13AM -0800, Ian Rogers wrote:
> > > > On Sat, Nov 9, 2024 at 9:04=E2=80=AFAM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > On Sat, Nov 09, 2024 at 08:26:20AM -0800, Ian Rogers wrote:
> > > > > > On Fri, Nov 8, 2024 at 10:45=E2=80=AFPM Namhyung Kim <namhyung@=
kernel.org> wrote:
> > > > > > > On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > > > > > > > Ian Rogers (6):
> > > > > > > >   tool api fs: Correctly encode errno for read/write open f=
ailures
> > > > > > > >   perf trace-event: Constify print arguments
> > > > > > > >   perf trace-event: Always build trace-event-info.c
> > > > > > > >   perf evsel: Add/use accessor for tp_format
> > > > > > > >   perf evsel: Allow evsel__newtp without libtraceevent
> > > > > > > >   perf tests: Enable tests disabled due to tracepoint parsi=
ng
> > > > > > >
> > > > > > > After applying this series, I'm seeing some test failures.  B=
ut I don't
> > > > > > > understand why it affects non-tracepoint events though.
> > > > > > >
> > > > > > >   $ sudo ./perf test -v pipe
> > > > > > >   --- start ---
> > > > > > >   test child forked, pid 3036123
> > > > > > >    1bde35-1bdecc l noploop
> > > > > > >   perf does have symbol 'noploop'
> > > > > > >
> > > > > > >   Record+report pipe test
> > > > > > >   [ perf record: Woken up 1 times to write data ]
> > > > > > >   [ perf record: Captured and wrote 0.210 MB - ]
> > > > > > >   [ perf record: Woken up 2 times to write data ]
> > > > > > >   [ perf record: Captured and wrote 0.517 MB - ]
> > > > > > >   [ perf record: Woken up 2 times to write data ]
> > > > > > >   [ perf record: Captured and wrote 0.516 MB - ]
> > > > > > >   Record+report pipe test [Success]
> > > > > > >
> > > > > > >   Inject -B build-ids test
> > > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > > >   Error:
> > > > > > >   failed to process sample
> > > > > > >   Inject build-ids test [Failed - cannot find noploop functio=
n in pipe #1]
> > > > > > >
> > > > > > >   Inject -b build-ids test
> > > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > > >   Error:
> > > > > > >   failed to process sample
> > > > > > >   Inject build-ids test [Failed - cannot find noploop functio=
n in pipe #1]
> > > > > > >
> > > > > > >   Inject --buildid-all build-ids test
> > > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > > >   Error:
> > > > > > >   failed to process sample
> > > > > > >   Inject build-ids test [Failed - cannot find noploop functio=
n in pipe #1]
> > > > > > >
> > > > > > >   Inject --mmap2-buildid-all build-ids test
> > > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > > >   Error:
> > > > > > >   failed to process sample
> > > > > > >   Inject build-ids test [Failed - cannot find noploop functio=
n in pipe #1]
> > > > > > >   ---- end(-1) ----
> > > > > > >    84: perf pipe recording and injection test                =
          : FAILED!
> > > > > > >
> > > > > > >   $ sudo ./perf test -v Zstd
> > > > > > >   --- start ---
> > > > > > >   test child forked, pid 3036097
> > > > > > >   Collecting compressed record file:
> > > > > > >   500+0 records in
> > > > > > >   500+0 records out
> > > > > > >   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB=
/s
> > > > > > >   [ perf record: Woken up 1 times to write data ]
> > > > > > >   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.K=
Bo, compressed (original 0.004 MB, ratio is 3.324) ]
> > > > > > >   Checking compressed events stats:
> > > > > > >   Couldn't decompress data
> > > > > > >   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not p=
ermitted]
> > > > > > >   Error:
> > > > > > >   failed to process sample
> > > > > > >   ---- end(-1) ----
> > > > > > >    86: Zstd perf.data compression/decompression              =
          : FAILED!
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Namhyung
> > > > > >
> > > > > > I'm not able to reproduce:
> > > > > > ```
> > > > > > $ git log --oneline |head
> > > > > > a59bca6eb0a6 perf test: Add a runs-per-test flag
> > > > > > 0d0c002eb45c perf tests: Enable tests disabled due to tracepoin=
t parsing
> > > > > > 4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceeve=
nt
> > > > > > 7f57057c7884 perf evsel: Add/use accessor for tp_format
> > > > > > c27d357d2d4c perf trace-event: Always build trace-event-info.c
> > > > > > 20bf7a2cd68a perf trace-event: Constify print arguments
> > > > > > f18b07ee2af1 tool api fs: Correctly encode errno for read/write=
 open failures
> > > > > > ...
> > > > > > $ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 84: perf pipe recording and injection test                     =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > 86: Zstd perf.data compression/decompression                   =
     : Ok
> > > > > > ```
> > > > > > Similarly not as root or if runs-per-test is 100.
> > > > > >
> > > > > > Agreed that the changes are for tracepoints and these tests are=
n't for
> > > > > > tracepoints, so an interaction wouldn't be expected. If you hav=
e a
> > > > > > reliable reproduction perhaps you can bisect it.
> > > > >
> > > > > it says:
> > > > >
> > > > > 9c10de391840a35ab095b65e9a5c4fad0ac52068 is the first bad commit
> > > > > commit 9c10de391840a35ab095b65e9a5c4fad0ac52068 (HEAD)
> > > > > Author: Ian Rogers <irogers@google.com>
> > > > > Date:   Fri Nov 8 10:47:46 2024 -0800
> > > > >
> > > > >     tool api fs: Correctly encode errno for read/write open failu=
res
> > > > >
> > > > >     Switch from returning -1 to -errno so that callers can determ=
ine types
> > > > >     of failure.
> > > > >
> > > > >     Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >     Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > >
> > > > >  tools/lib/api/fs/fs.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > So I tried to eye-ball/grep all callers to spot assumptions on the
> > > > return value like:
> > > > ```
> > > > err =3D ...__read_int
> > > > if (err =3D=3D -1)
> > > > ```
> > > > Didn't spot anything.
> > > >
> > > > It seems in the test log the record is failing so I ran this under
> > > > gdb, set breakpoints on the 3 modified functions and then looked up
> > > > the call stack to spot bad return value assumptions. Everything loo=
ks
> > > > good.
> > > > I then tried inject and report, the only file read by these functio=
ns
> > > > is /proc/sys/kernel/perf_event_paranoid as part of symbol
> > > > initialization (nit, this should probably be read lazily and the
> > > > restriction should really come from the perf.data file, not the
> > > > running system) and those calls look good.
> > > >
> > > > The change is small and not critical for the series. It improves th=
e
> > > > error message when reading the tracepoint id fails. So we could mov=
e
> > > > forward with the rest of the series, but that could be annoying for
> > > > tracepoint users.
> > > >
> > > > If I had a reproducer I'd revert the 1 line change on each function=
 to
> > > > find out which is causing the regression. Once you have that then y=
ou
> > > > can binary search to find the bad call by using some global counter
> > > > where the first 'n' calls use the new return value and the later us=
e
> > > > the old value. You can then vary 'n' to binary search and find the =
bad
> > > > caller.
> > > >
> > > > Is there any chance you can help diagnose this or help me to find t=
he
> > > > reproducer?
> > >
> > > I think this depends on the system configuration.  I've debugged it
> > > failed when it gets cpu topology:
> > >
> > >   ...
> > >   read int failed: /sys/devices/system/cpu/cpu112/topology/core_id (e=
rrno=3D2)
> > >   read int failed: /sys/devices/system/cpu/cpu112/topology/physical_p=
ackage_id (errno=3D2)
> > >   read int failed: /sys/devices/system/cpu/cpu112/topology/die_id (er=
rno=3D2)
> > >   ...
> > >
> > > Maybe it's because # online CPUs !=3D # possible CPUs.
> > >
> > >   $ cat /sys/devices/system/cpu/online
> > >   0-63
> > >   $ cat /sys/devices/system/cpu/possible
> > >   0-127
> > >
> > > There's a code like cpu__get_socket_id() to use the return value of
> > > sysfs__read_int() directly.  And it saves the value to aggr_cpu_id wh=
ich
> > > requires exact match like in aggr_cpu_id__equal().
> >
> > So this is a latent bug. Are you working on the fix or asking me to do
> > it? I'm not sure why we should fail to describe the topology for
> > offline cores, but if this is a kernel restriction we should probably
> > purge those logical CPUs from the topology.
>
> It doesn't have the topology directory for the offline CPUs.
>
>   $ ls /sys/devices/system/cpu/cpu112/
>   acpi_cppc  cpufreq  cpuidle  crash_notes  crash_notes_size  driver  fir=
mware_node  hotplug  node0  online  power  subsystem  uevent
>
>   $ ls /sys/devices/system/cpu/cpu112/topology
>   ls: cannot access '/sys/devices/system/cpu/cpu112/topology': No such fi=
le or directory
>
> Anyway, I'm not sure if it's really needed for this change.  Maybe you
> can drop the patch 1 from the series for now and tackle it later.

So this would be a regression. Currently in add_tracepoint the calls look l=
ike:

add_tracepoint
|->evsel__new_tp_idx
  |-> tp_format
    |->filename__read_str

The filename__read_str error is passed in add_tracepoint for errors to
tracepoint_error that handles EACCES, ENOENT and default as separate
cases:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c#n466
The code changes filename__read_str to filename__read_int but if that
can only return -1 on error then that'll make all tracepoint open
errors look like EPERM.

Based on your instructions I was able to reproduce the problem and
have a fix to just force the error value to always be -1. I'll add
that to the series and send as v5.

Thanks,
Ian
