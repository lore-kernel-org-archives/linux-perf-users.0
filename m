Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FC1E5726
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958534; cv=none; b=R/QSSPgoW1r2aozV7R376lCeKpg6TFnUWJqris9mcfHea5jLaSplZCPm1EY3ljCUMB1t6D8SiAPz/OYYQI4vIAEgg5TcoN7J322cX1lsPdiLkypLgk+Q94CXe9BL2mnZH9n1QH14uTT7czeqZPrqFg3Bkm+iO4g3QYxupZsA/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958534; c=relaxed/simple;
	bh=ra+w1/MP2G5alebeIthQ4/J2wLpzsIbuKQHCbw8psFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp3wR2wQD+5LzjhfPxpPI4s0Gsn6mNoJEwb0M0tva4yvlTB/CP6H6Og3TA1nOQDH1dkyUxcdvqrQ199BIg+myV3rCPN23dMdQWvRCPi0eD5EAg7yCT4F3WIR+wnwmszGRtcHZEgCHKU5uYha/nQloKL6/TgPVg2rhH6lVaaGugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RT32MSBE; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RT32MSBE"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a716d74c28so26865ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958531; x=1732563331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm/ACn3bQAERS2/RrHxqNIHo2LLFv3AIfLjTPVpRJsk=;
        b=RT32MSBEYhPbWE+8+qP3DrkqU5I+5oqal6hzlVe++kyExxLVHVYlPOYJeI8Dwk7/L1
         /BtgnS8gBIsAkl08Zqznzz/qbFNapzto0roB+sx2KqTnoRSqU46AdhUV3p6ztFrWreFp
         Jt6JGIBbOLc6pmZM0SPz8lrzBaEMZfA9CMNKNo8bsOaX/ezAnKpf+4NypJvvajZ0RHn8
         ly9VOAbOcJl6MgQ3U+ZeGdEsWdK1j78nTAE7nSdMXSxhx6+OrPChI4Rcsl51fWSKq1ga
         5AQ5F+AZRj/mozgwQWGC/80Ffr4GzF3bP9g1pgO2+TZe3gtCrKiwhdeLuWGJIydKy46s
         qa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958531; x=1732563331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm/ACn3bQAERS2/RrHxqNIHo2LLFv3AIfLjTPVpRJsk=;
        b=F5W2n/CNMEIP8e1EOVPYtry7yxfzTS5iHKYxqqMMzCZbBJnGu4zmg1DbLetDF3uFmU
         1WIIyTbm0HO19VWNYLedv7G0lZAjM2dnWkAaBwOSEQb/NTAddibYClenwtHuDbUYENV/
         /BoKXZrr2pFAZUvLacInOBUAwjFO613oDkS/+qkyinYbXvdY1U7BcjYCIT5mTjjmUAWN
         JIjH9Qz3XyKKzVQcymG/AdTUIRC3OQatNPfg6KIXQRibQXO0JJ8bH9Vgagob4D9lYc/A
         MYTx1c2kxD0PgV4rukyyaI4BlSLjavBkcHQlD1LhWoglCPPtUxE3jwFEsVvgIUMpqXZu
         RTqA==
X-Forwarded-Encrypted: i=1; AJvYcCWt/tlgRkFkPiP+mh+ot47lKRNj4AOdUKABKbZHMjzPHUtHNyywJqptVAnYQKvYpTGVPKTo1CCIQBUIM4N8zS0G@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7ABmtvqfY1RmIWsdZPm7PEj1am5bnVnVCJtsz7CUkYsLXR98
	4Z/z3mKRWWMzPc6n6YnuURNnWjI9luBy/X6LhRbmRQbpeocN5PHqiiQZC2Ev4Egh+6S3CJHsaAP
	eDFw3YqmfUu/2IhoEPZIR3Oek0lIfdOUzqMI3
X-Gm-Gg: ASbGncvgGcRL20V0al2/3Wb7FArinwYLSZwZQlFoFHs78Z+B7Igi3jArzO4CzQleFIx
	Js+BFrj71dg79DiQvhI7hVVkyqZ6iCUf3anXw3Fxkgv62Q+hFOm6LNzdqpmwl/fw=
X-Google-Smtp-Source: AGHT+IGnp4tlcpbZ0qYyRZq/CNQnNkcaFIK7uvXNdTP2InvUyOWUk5hAOi/2qUubqsU5mqm07OiOI4jmZaDYsq1fzz0=
X-Received: by 2002:a05:6e02:194c:b0:3a7:6766:e401 with SMTP id
 e9e14a558f8ab-3a77862ca30mr225505ab.15.1731958531052; Mon, 18 Nov 2024
 11:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com> <Zy8FIt2OMa5-GymZ@google.com>
 <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>
 <Zy-WM779rMwczlj_@google.com> <CAP-5=fVKvDLUMw_HXBoRLK3FyPvUCWGOZNECer6_fyhbTZTM6A@mail.gmail.com>
 <ZzuH-8ZCa7BVt3ef@google.com>
In-Reply-To: <ZzuH-8ZCa7BVt3ef@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Nov 2024 11:35:19 -0800
Message-ID: <CAP-5=fUCtzhN75k8gWEVgb_+XoYXFf1VfNndimuHZOx814yAMQ@mail.gmail.com>
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

On Mon, Nov 18, 2024 at 10:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 13, 2024 at 10:06:13AM -0800, Ian Rogers wrote:
> > On Sat, Nov 9, 2024 at 9:04=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Sat, Nov 09, 2024 at 08:26:20AM -0800, Ian Rogers wrote:
> > > > On Fri, Nov 8, 2024 at 10:45=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > > On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > > > > > Ian Rogers (6):
> > > > > >   tool api fs: Correctly encode errno for read/write open failu=
res
> > > > > >   perf trace-event: Constify print arguments
> > > > > >   perf trace-event: Always build trace-event-info.c
> > > > > >   perf evsel: Add/use accessor for tp_format
> > > > > >   perf evsel: Allow evsel__newtp without libtraceevent
> > > > > >   perf tests: Enable tests disabled due to tracepoint parsing
> > > > >
> > > > > After applying this series, I'm seeing some test failures.  But I=
 don't
> > > > > understand why it affects non-tracepoint events though.
> > > > >
> > > > >   $ sudo ./perf test -v pipe
> > > > >   --- start ---
> > > > >   test child forked, pid 3036123
> > > > >    1bde35-1bdecc l noploop
> > > > >   perf does have symbol 'noploop'
> > > > >
> > > > >   Record+report pipe test
> > > > >   [ perf record: Woken up 1 times to write data ]
> > > > >   [ perf record: Captured and wrote 0.210 MB - ]
> > > > >   [ perf record: Woken up 2 times to write data ]
> > > > >   [ perf record: Captured and wrote 0.517 MB - ]
> > > > >   [ perf record: Woken up 2 times to write data ]
> > > > >   [ perf record: Captured and wrote 0.516 MB - ]
> > > > >   Record+report pipe test [Success]
> > > > >
> > > > >   Inject -B build-ids test
> > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > >   Error:
> > > > >   failed to process sample
> > > > >   Inject build-ids test [Failed - cannot find noploop function in=
 pipe #1]
> > > > >
> > > > >   Inject -b build-ids test
> > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > >   Error:
> > > > >   failed to process sample
> > > > >   Inject build-ids test [Failed - cannot find noploop function in=
 pipe #1]
> > > > >
> > > > >   Inject --buildid-all build-ids test
> > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > >   Error:
> > > > >   failed to process sample
> > > > >   Inject build-ids test [Failed - cannot find noploop function in=
 pipe #1]
> > > > >
> > > > >   Inject --mmap2-buildid-all build-ids test
> > > > >   0xa5c [0x17a4]: failed to process type: 80
> > > > >   Error:
> > > > >   failed to process sample
> > > > >   Inject build-ids test [Failed - cannot find noploop function in=
 pipe #1]
> > > > >   ---- end(-1) ----
> > > > >    84: perf pipe recording and injection test                    =
      : FAILED!
> > > > >
> > > > >   $ sudo ./perf test -v Zstd
> > > > >   --- start ---
> > > > >   test child forked, pid 3036097
> > > > >   Collecting compressed record file:
> > > > >   500+0 records in
> > > > >   500+0 records out
> > > > >   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
> > > > >   [ perf record: Woken up 1 times to write data ]
> > > > >   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, =
compressed (original 0.004 MB, ratio is 3.324) ]
> > > > >   Checking compressed events stats:
> > > > >   Couldn't decompress data
> > > > >   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permi=
tted]
> > > > >   Error:
> > > > >   failed to process sample
> > > > >   ---- end(-1) ----
> > > > >    86: Zstd perf.data compression/decompression                  =
      : FAILED!
> > > > >
> > > > > Thanks,
> > > > > Namhyung
> > > >
> > > > I'm not able to reproduce:
> > > > ```
> > > > $ git log --oneline |head
> > > > a59bca6eb0a6 perf test: Add a runs-per-test flag
> > > > 0d0c002eb45c perf tests: Enable tests disabled due to tracepoint pa=
rsing
> > > > 4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceevent
> > > > 7f57057c7884 perf evsel: Add/use accessor for tp_format
> > > > c27d357d2d4c perf trace-event: Always build trace-event-info.c
> > > > 20bf7a2cd68a perf trace-event: Constify print arguments
> > > > f18b07ee2af1 tool api fs: Correctly encode errno for read/write ope=
n failures
> > > > ...
> > > > $ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 84: perf pipe recording and injection test                         =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > 86: Zstd perf.data compression/decompression                       =
 : Ok
> > > > ```
> > > > Similarly not as root or if runs-per-test is 100.
> > > >
> > > > Agreed that the changes are for tracepoints and these tests aren't =
for
> > > > tracepoints, so an interaction wouldn't be expected. If you have a
> > > > reliable reproduction perhaps you can bisect it.
> > >
> > > it says:
> > >
> > > 9c10de391840a35ab095b65e9a5c4fad0ac52068 is the first bad commit
> > > commit 9c10de391840a35ab095b65e9a5c4fad0ac52068 (HEAD)
> > > Author: Ian Rogers <irogers@google.com>
> > > Date:   Fri Nov 8 10:47:46 2024 -0800
> > >
> > >     tool api fs: Correctly encode errno for read/write open failures
> > >
> > >     Switch from returning -1 to -errno so that callers can determine =
types
> > >     of failure.
> > >
> > >     Signed-off-by: Ian Rogers <irogers@google.com>
> > >     Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > >  tools/lib/api/fs/fs.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > So I tried to eye-ball/grep all callers to spot assumptions on the
> > return value like:
> > ```
> > err =3D ...__read_int
> > if (err =3D=3D -1)
> > ```
> > Didn't spot anything.
> >
> > It seems in the test log the record is failing so I ran this under
> > gdb, set breakpoints on the 3 modified functions and then looked up
> > the call stack to spot bad return value assumptions. Everything looks
> > good.
> > I then tried inject and report, the only file read by these functions
> > is /proc/sys/kernel/perf_event_paranoid as part of symbol
> > initialization (nit, this should probably be read lazily and the
> > restriction should really come from the perf.data file, not the
> > running system) and those calls look good.
> >
> > The change is small and not critical for the series. It improves the
> > error message when reading the tracepoint id fails. So we could move
> > forward with the rest of the series, but that could be annoying for
> > tracepoint users.
> >
> > If I had a reproducer I'd revert the 1 line change on each function to
> > find out which is causing the regression. Once you have that then you
> > can binary search to find the bad call by using some global counter
> > where the first 'n' calls use the new return value and the later use
> > the old value. You can then vary 'n' to binary search and find the bad
> > caller.
> >
> > Is there any chance you can help diagnose this or help me to find the
> > reproducer?
>
> I think this depends on the system configuration.  I've debugged it
> failed when it gets cpu topology:
>
>   ...
>   read int failed: /sys/devices/system/cpu/cpu112/topology/core_id (errno=
=3D2)
>   read int failed: /sys/devices/system/cpu/cpu112/topology/physical_packa=
ge_id (errno=3D2)
>   read int failed: /sys/devices/system/cpu/cpu112/topology/die_id (errno=
=3D2)
>   ...
>
> Maybe it's because # online CPUs !=3D # possible CPUs.
>
>   $ cat /sys/devices/system/cpu/online
>   0-63
>   $ cat /sys/devices/system/cpu/possible
>   0-127
>
> There's a code like cpu__get_socket_id() to use the return value of
> sysfs__read_int() directly.  And it saves the value to aggr_cpu_id which
> requires exact match like in aggr_cpu_id__equal().

So this is a latent bug. Are you working on the fix or asking me to do
it? I'm not sure why we should fail to describe the topology for
offline cores, but if this is a kernel restriction we should probably
purge those logical CPUs from the topology.

Thanks,
Ian
