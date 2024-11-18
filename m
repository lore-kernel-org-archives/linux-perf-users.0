Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEE150981;
	Mon, 18 Nov 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967052; cv=none; b=s/Cu3inwI1DpPgaVLhn0WouTCq06BwIyU2MCbov0QQ+CkvXaFiLNFS1/mvqFkAD8b0bDEV0MyCnUdMV76cjTxiVRIjMHOXKMpyefsaahtv9D6U+6Kxsxm6mKI50Kk9kDIC5JpAjWQ+Mci5hbZpHkjA0Nd0anY5NklK26xA2ZWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967052; c=relaxed/simple;
	bh=Dla+R32ok4wTwYIuQlAVhjXzYybXhfCM9m5QRpkVQ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJsabrCt+vxB+vVUo4QJBmuKD+qn98uJ0YryZrtoZ4905kjQ7aXzAkdifye2lWpEO6p2cKyTZZX9uJhH1Oe3eh8/iScgZZJcujcCQC3NFnSr/ml8c0oPoLFINHvIn0sFoUieZ6+UlaXRgz4ZRMJVY67AaBQ68sZlYoje4DNVwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL+vWk89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL+vWk89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE21C4CECC;
	Mon, 18 Nov 2024 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731967051;
	bh=Dla+R32ok4wTwYIuQlAVhjXzYybXhfCM9m5QRpkVQ6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dL+vWk89PXIcZRxke+UQ/Rn7ZrXZgguAgOy2tZDcWvZTF1ycMMYeAmatFX7boILFk
	 +B/0NfZoRaWlfLOx/BDPYsSaCMSKLiwG37OeLjHNfP9kr+30LOiqAxXoJC94vpSquX
	 qtqpEVBqoa4KaY9Swa3aACpkX8USjGTMg716PWgVMMNTjyPUSD8hM0rLckNYtG+/mc
	 X1fpXp1BcQMIW4iXqfRaTPsSozL8XxINRqZD/WS43zxPAvmX+Jh0SwAxV1+gV14D+m
	 iKDUPs86338PqkPFddRaNVmlnCVzvcrNlFVbZmY6KLajEHmTIgzh8zVHA3EVHXm3s5
	 IqD9nB037he1A==
Date: Mon, 18 Nov 2024 13:57:29 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
Message-ID: <Zzu4Sdebve-NXEMX@google.com>
References: <20241108184751.359237-1-irogers@google.com>
 <Zy8FIt2OMa5-GymZ@google.com>
 <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>
 <Zy-WM779rMwczlj_@google.com>
 <CAP-5=fVKvDLUMw_HXBoRLK3FyPvUCWGOZNECer6_fyhbTZTM6A@mail.gmail.com>
 <ZzuH-8ZCa7BVt3ef@google.com>
 <CAP-5=fUCtzhN75k8gWEVgb_+XoYXFf1VfNndimuHZOx814yAMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUCtzhN75k8gWEVgb_+XoYXFf1VfNndimuHZOx814yAMQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 11:35:19AM -0800, Ian Rogers wrote:
> On Mon, Nov 18, 2024 at 10:31 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Nov 13, 2024 at 10:06:13AM -0800, Ian Rogers wrote:
> > > On Sat, Nov 9, 2024 at 9:04 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Sat, Nov 09, 2024 at 08:26:20AM -0800, Ian Rogers wrote:
> > > > > On Fri, Nov 8, 2024 at 10:45 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > > > > > > Ian Rogers (6):
> > > > > > >   tool api fs: Correctly encode errno for read/write open failures
> > > > > > >   perf trace-event: Constify print arguments
> > > > > > >   perf trace-event: Always build trace-event-info.c
> > > > > > >   perf evsel: Add/use accessor for tp_format
> > > > > > >   perf evsel: Allow evsel__newtp without libtraceevent
> > > > > > >   perf tests: Enable tests disabled due to tracepoint parsing
> > > > > >
> > > > > > After applying this series, I'm seeing some test failures.  But I don't
> > > > > > understand why it affects non-tracepoint events though.
> > > > > >
> > > > > >   $ sudo ./perf test -v pipe
> > > > > >   --- start ---
> > > > > >   test child forked, pid 3036123
> > > > > >    1bde35-1bdecc l noploop
> > > > > >   perf does have symbol 'noploop'
> > > > > >
> > > > > >   Record+report pipe test
> > > > > >   [ perf record: Woken up 1 times to write data ]
> > > > > >   [ perf record: Captured and wrote 0.210 MB - ]
> > > > > >   [ perf record: Woken up 2 times to write data ]
> > > > > >   [ perf record: Captured and wrote 0.517 MB - ]
> > > > > >   [ perf record: Woken up 2 times to write data ]
> > > > > >   [ perf record: Captured and wrote 0.516 MB - ]
> > > > > >   Record+report pipe test [Success]
> > > > > >
> > > > > >   Inject -B build-ids test
> > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > >   Error:
> > > > > >   failed to process sample
> > > > > >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> > > > > >
> > > > > >   Inject -b build-ids test
> > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > >   Error:
> > > > > >   failed to process sample
> > > > > >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> > > > > >
> > > > > >   Inject --buildid-all build-ids test
> > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > >   Error:
> > > > > >   failed to process sample
> > > > > >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> > > > > >
> > > > > >   Inject --mmap2-buildid-all build-ids test
> > > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > > >   Error:
> > > > > >   failed to process sample
> > > > > >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> > > > > >   ---- end(-1) ----
> > > > > >    84: perf pipe recording and injection test                          : FAILED!
> > > > > >
> > > > > >   $ sudo ./perf test -v Zstd
> > > > > >   --- start ---
> > > > > >   test child forked, pid 3036097
> > > > > >   Collecting compressed record file:
> > > > > >   500+0 records in
> > > > > >   500+0 records out
> > > > > >   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
> > > > > >   [ perf record: Woken up 1 times to write data ]
> > > > > >   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, compressed (original 0.004 MB, ratio is 3.324) ]
> > > > > >   Checking compressed events stats:
> > > > > >   Couldn't decompress data
> > > > > >   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permitted]
> > > > > >   Error:
> > > > > >   failed to process sample
> > > > > >   ---- end(-1) ----
> > > > > >    86: Zstd perf.data compression/decompression                        : FAILED!
> > > > > >
> > > > > > Thanks,
> > > > > > Namhyung
> > > > >
> > > > > I'm not able to reproduce:
> > > > > ```
> > > > > $ git log --oneline |head
> > > > > a59bca6eb0a6 perf test: Add a runs-per-test flag
> > > > > 0d0c002eb45c perf tests: Enable tests disabled due to tracepoint parsing
> > > > > 4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceevent
> > > > > 7f57057c7884 perf evsel: Add/use accessor for tp_format
> > > > > c27d357d2d4c perf trace-event: Always build trace-event-info.c
> > > > > 20bf7a2cd68a perf trace-event: Constify print arguments
> > > > > f18b07ee2af1 tool api fs: Correctly encode errno for read/write open failures
> > > > > ...
> > > > > $ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 84: perf pipe recording and injection test                          : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > 86: Zstd perf.data compression/decompression                        : Ok
> > > > > ```
> > > > > Similarly not as root or if runs-per-test is 100.
> > > > >
> > > > > Agreed that the changes are for tracepoints and these tests aren't for
> > > > > tracepoints, so an interaction wouldn't be expected. If you have a
> > > > > reliable reproduction perhaps you can bisect it.
> > > >
> > > > it says:
> > > >
> > > > 9c10de391840a35ab095b65e9a5c4fad0ac52068 is the first bad commit
> > > > commit 9c10de391840a35ab095b65e9a5c4fad0ac52068 (HEAD)
> > > > Author: Ian Rogers <irogers@google.com>
> > > > Date:   Fri Nov 8 10:47:46 2024 -0800
> > > >
> > > >     tool api fs: Correctly encode errno for read/write open failures
> > > >
> > > >     Switch from returning -1 to -errno so that callers can determine types
> > > >     of failure.
> > > >
> > > >     Signed-off-by: Ian Rogers <irogers@google.com>
> > > >     Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > >
> > > >  tools/lib/api/fs/fs.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > So I tried to eye-ball/grep all callers to spot assumptions on the
> > > return value like:
> > > ```
> > > err = ...__read_int
> > > if (err == -1)
> > > ```
> > > Didn't spot anything.
> > >
> > > It seems in the test log the record is failing so I ran this under
> > > gdb, set breakpoints on the 3 modified functions and then looked up
> > > the call stack to spot bad return value assumptions. Everything looks
> > > good.
> > > I then tried inject and report, the only file read by these functions
> > > is /proc/sys/kernel/perf_event_paranoid as part of symbol
> > > initialization (nit, this should probably be read lazily and the
> > > restriction should really come from the perf.data file, not the
> > > running system) and those calls look good.
> > >
> > > The change is small and not critical for the series. It improves the
> > > error message when reading the tracepoint id fails. So we could move
> > > forward with the rest of the series, but that could be annoying for
> > > tracepoint users.
> > >
> > > If I had a reproducer I'd revert the 1 line change on each function to
> > > find out which is causing the regression. Once you have that then you
> > > can binary search to find the bad call by using some global counter
> > > where the first 'n' calls use the new return value and the later use
> > > the old value. You can then vary 'n' to binary search and find the bad
> > > caller.
> > >
> > > Is there any chance you can help diagnose this or help me to find the
> > > reproducer?
> >
> > I think this depends on the system configuration.  I've debugged it
> > failed when it gets cpu topology:
> >
> >   ...
> >   read int failed: /sys/devices/system/cpu/cpu112/topology/core_id (errno=2)
> >   read int failed: /sys/devices/system/cpu/cpu112/topology/physical_package_id (errno=2)
> >   read int failed: /sys/devices/system/cpu/cpu112/topology/die_id (errno=2)
> >   ...
> >
> > Maybe it's because # online CPUs != # possible CPUs.
> >
> >   $ cat /sys/devices/system/cpu/online
> >   0-63
> >   $ cat /sys/devices/system/cpu/possible
> >   0-127
> >
> > There's a code like cpu__get_socket_id() to use the return value of
> > sysfs__read_int() directly.  And it saves the value to aggr_cpu_id which
> > requires exact match like in aggr_cpu_id__equal().
> 
> So this is a latent bug. Are you working on the fix or asking me to do
> it? I'm not sure why we should fail to describe the topology for
> offline cores, but if this is a kernel restriction we should probably
> purge those logical CPUs from the topology.

It doesn't have the topology directory for the offline CPUs.

  $ ls /sys/devices/system/cpu/cpu112/
  acpi_cppc  cpufreq  cpuidle  crash_notes  crash_notes_size  driver  firmware_node  hotplug  node0  online  power  subsystem  uevent

  $ ls /sys/devices/system/cpu/cpu112/topology
  ls: cannot access '/sys/devices/system/cpu/cpu112/topology': No such file or directory

Anyway, I'm not sure if it's really needed for this change.  Maybe you
can drop the patch 1 from the series for now and tackle it later.

Thanks,
Namhyung

