Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8A29CF4;
	Sat,  9 Nov 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731171894; cv=none; b=jXxVHf4V4E0ZucJlxt7RrxQ4MVOYif7sOIzTEcjhj0KXLrrNK/zk++3plSnjVsrWDajK4yxYB3FIpuhjcnWORZfCPh99gp88lOxSmFeu2vcvKT6aj1w+R0xpBZ05q1spVhJuBsG1KthOcM7wdXKSEWgU//HFyr/U/P5jQLB8Ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731171894; c=relaxed/simple;
	bh=jIIcJdMDTRWg/VujUC+a3gs5D8TA9fUtDPUZT3NPVA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3blX2F8LWkoZFMUjUd5wMmmO4Xvu2eLXPYNmbRQFieeoWlByPEs1J1B4aN35YYguKVXKXxJI8CQAfuKiGgclaGjUY2JUfaR7uTBkQIaWBLZrbHw7O9SsRNCNOPUmFqJM33Fl+cUv9qhGdWE4z0BcmGgea81saq4dkn42H1IO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eks3It7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eks3It7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30879C4CECE;
	Sat,  9 Nov 2024 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731171894;
	bh=jIIcJdMDTRWg/VujUC+a3gs5D8TA9fUtDPUZT3NPVA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eks3It7moRXYZn3pw/1X94qov6q9PelwZhlteOZkShcf3fm51SOy3ZfqlyTDAcuAY
	 GtxY9hlwozdLhcMPXsTwKHqzDx9gWa636I9Ac6sEs2YSxRE3Qw1t+FvaUUJzAbz0h/
	 Vd6s1NsLzfaHYHEhL0jsFTlUtRDpwD/BSvuGx8RbMweOXSZCuF8BzrfICaSt3t+SJ2
	 ZZhcDHdbmWoH7JHu+AIHdV6SgGj80Vgoa7c7tWcgGX1et37jQxiogNCJo7RsAZkXpY
	 4NOLsBinuEQsbXHIi/4nRKBaRwvSoEqxgnU1RSvBtiA3SGn1RDIX5IR9SziVwLxUe1
	 lK/3fnqlVrXgg==
Date: Sat, 9 Nov 2024 09:04:51 -0800
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
Message-ID: <Zy-WM779rMwczlj_@google.com>
References: <20241108184751.359237-1-irogers@google.com>
 <Zy8FIt2OMa5-GymZ@google.com>
 <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>

On Sat, Nov 09, 2024 at 08:26:20AM -0800, Ian Rogers wrote:
> On Fri, Nov 8, 2024 at 10:45 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > > Ian Rogers (6):
> > >   tool api fs: Correctly encode errno for read/write open failures
> > >   perf trace-event: Constify print arguments
> > >   perf trace-event: Always build trace-event-info.c
> > >   perf evsel: Add/use accessor for tp_format
> > >   perf evsel: Allow evsel__newtp without libtraceevent
> > >   perf tests: Enable tests disabled due to tracepoint parsing
> >
> > After applying this series, I'm seeing some test failures.  But I don't
> > understand why it affects non-tracepoint events though.
> >
> >   $ sudo ./perf test -v pipe
> >   --- start ---
> >   test child forked, pid 3036123
> >    1bde35-1bdecc l noploop
> >   perf does have symbol 'noploop'
> >
> >   Record+report pipe test
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.210 MB - ]
> >   [ perf record: Woken up 2 times to write data ]
> >   [ perf record: Captured and wrote 0.517 MB - ]
> >   [ perf record: Woken up 2 times to write data ]
> >   [ perf record: Captured and wrote 0.516 MB - ]
> >   Record+report pipe test [Success]
> >
> >   Inject -B build-ids test
> >   0xa5c [0x17a4]: failed to process type: 80
> >   Error:
> >   failed to process sample
> >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> >
> >   Inject -b build-ids test
> >   0xa5c [0x17a4]: failed to process type: 80
> >   Error:
> >   failed to process sample
> >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> >
> >   Inject --buildid-all build-ids test
> >   0xa5c [0x17a4]: failed to process type: 80
> >   Error:
> >   failed to process sample
> >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> >
> >   Inject --mmap2-buildid-all build-ids test
> >   0xa5c [0x17a4]: failed to process type: 80
> >   Error:
> >   failed to process sample
> >   Inject build-ids test [Failed - cannot find noploop function in pipe #1]
> >   ---- end(-1) ----
> >    84: perf pipe recording and injection test                          : FAILED!
> >
> >   $ sudo ./perf test -v Zstd
> >   --- start ---
> >   test child forked, pid 3036097
> >   Collecting compressed record file:
> >   500+0 records in
> >   500+0 records out
> >   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, compressed (original 0.004 MB, ratio is 3.324) ]
> >   Checking compressed events stats:
> >   Couldn't decompress data
> >   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permitted]
> >   Error:
> >   failed to process sample
> >   ---- end(-1) ----
> >    86: Zstd perf.data compression/decompression                        : FAILED!
> >
> > Thanks,
> > Namhyung
> 
> I'm not able to reproduce:
> ```
> $ git log --oneline |head
> a59bca6eb0a6 perf test: Add a runs-per-test flag
> 0d0c002eb45c perf tests: Enable tests disabled due to tracepoint parsing
> 4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceevent
> 7f57057c7884 perf evsel: Add/use accessor for tp_format
> c27d357d2d4c perf trace-event: Always build trace-event-info.c
> 20bf7a2cd68a perf trace-event: Constify print arguments
> f18b07ee2af1 tool api fs: Correctly encode errno for read/write open failures
> ...
> $ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 84: perf pipe recording and injection test                          : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> 86: Zstd perf.data compression/decompression                        : Ok
> ```
> Similarly not as root or if runs-per-test is 100.
> 
> Agreed that the changes are for tracepoints and these tests aren't for
> tracepoints, so an interaction wouldn't be expected. If you have a
> reliable reproduction perhaps you can bisect it.

it says:

9c10de391840a35ab095b65e9a5c4fad0ac52068 is the first bad commit
commit 9c10de391840a35ab095b65e9a5c4fad0ac52068 (HEAD)
Author: Ian Rogers <irogers@google.com>
Date:   Fri Nov 8 10:47:46 2024 -0800

    tool api fs: Correctly encode errno for read/write open failures
    
    Switch from returning -1 to -errno so that callers can determine types
    of failure.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/lib/api/fs/fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Thanks,
Namhyung

