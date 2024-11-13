Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E101FEFA0
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521188; cv=none; b=tX4USfNMQnyoaw0RpnFn6UzsDt2Ql/ZuHN15k3i2n0MdDQbFeLroJWHud1ZblHNVcNuUTT0Zld9jHHC9oJQi7E46bwBCfRLJGXSzEvkEmYqM0QvEriyJ3AFlvEv/znKQ5yb17RyUo+1kDn2vmpgKnR3XKh920s9oQSMsDuXCTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521188; c=relaxed/simple;
	bh=CJHUxmxs25a6vYzm94NNhSGlj8Opdn3ElqKMIEc/7jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8XKG0uqp1BffUnntFPJvv4F2km6c9KHNEXWebB+OHlxbGAyLxm3YyNopGt1EjiPLolSWmdQe3TaJHfCBPK4jXkI3ZMKR+rrki3Vc4UxzlV7N0//9kP6BVz7c52R6xaceB0gY+me5gQN7g9OHhrpAPacs2pbJdU+KTP63jHarUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ig1324Ga; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ig1324Ga"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460969c49f2so346861cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731521185; x=1732125985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugjfi/VEHgJeZuf11dqY5h/VxsS8rTgi4t/EU9nFi7Q=;
        b=Ig1324GabuFxG+GHcHd4K0ZKetuPTU7q7TLViV7+/F6F3gAhWx6e7ZFTOnU9UfhYhd
         4uYuwi6XAXvTbXlk2oiN7gtb4YvcJjV7V58wb5HqjbDaOwgmbVlY4VMPFvLcfDkubywQ
         JnbBBp4p/kK6BqYz7P7MXTFSInXe16rtoU+fix/G4RE6xOMTdIxA5OM/3kpEHLxyHBz0
         9RuIdgaQvsMg64Odc6swF0VpP1mVcEdmR32KmIZ2Y+1eOEuHRrM80yiDHNqF9b4I6hu8
         HweKrlbsyNRhhsSbA2I+uNuk/fzA0TIiG5w3VvvWOvWdVDD1QYzx53ggz5JCdqyNZMjj
         e75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521185; x=1732125985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugjfi/VEHgJeZuf11dqY5h/VxsS8rTgi4t/EU9nFi7Q=;
        b=orUgCyJfcvd995ha6mk2Z49UfaodhyfPj+kh2q7saVB/feKTGOxn3Ip39RoeZEHVjV
         5XP5H14a6W+yG9RatMaUhFVJwIlSgaWtsIOrjgabrjC8wIl0FJfR0ZDKItv+8RwmZFnI
         JXwOkpF3nGzNYcosonbTdlZe9jprm0OlAgvuK5UWr/WcwbP83g6QS+BAaM11RfVG8RqH
         sO+ywoHOc6W5E91IthpqnCWi5DnBh79WbNcB8x0h2xp1EDreTRI5W+Zg/TyoQ6/Eu6tq
         ASavl15nKxmrertOvDcbHtcpTTUPrxa14KJQwXN6NPRODhicfaj5tKnj7N8K4cK3Pon+
         n79Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSRSw9X+ptCtPTM+MsqPazDoIHj13zyP9ahATCrFSe5wxD6gTu5uDQLj336z2hxn7yjYAyBMy/LPCjWJ5zEDPa@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVlvLxwKYIJEw4A3Z75aKpruuFgfc3SUqjkCk9OUf3UVtOPpq
	cMZzrC5o+l4Gi6b2Qnbno4T4m1MZLi8rLATnyiv5GX7EgxK6cQjkIt1QRiU8FaUbBr7BZfdATF8
	o8RE5vGWVwZimZDXjaWDWKidtkWovYw1xEvTs
X-Gm-Gg: ASbGncsELmN/FR7y5IYAJW793e/cqe0iJ3QcrdExX46q2RzqKSXVH1B/SGiCX/mc2Z4
	5aZKv5kC1HSaUkcwfuVPA7G8NEQ6kJkxUry7EWfDSZsjDNVwYvVzeDRY0DjFOSA==
X-Google-Smtp-Source: AGHT+IENJEKkQ3TcmVD/lLqFfFIWVicBo3ZaDNnGZr04R67YSdyWqn8ysI4VGM57mnodiUoh+vVIWrMeiScSz9fKfLA=
X-Received: by 2002:ac8:58d4:0:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-4634bca2317mr4283231cf.26.1731521184814; Wed, 13 Nov 2024
 10:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com> <Zy8FIt2OMa5-GymZ@google.com>
 <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com> <Zy-WM779rMwczlj_@google.com>
In-Reply-To: <Zy-WM779rMwczlj_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 10:06:13 -0800
Message-ID: <CAP-5=fVKvDLUMw_HXBoRLK3FyPvUCWGOZNECer6_fyhbTZTM6A@mail.gmail.com>
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

On Sat, Nov 9, 2024 at 9:04=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Sat, Nov 09, 2024 at 08:26:20AM -0800, Ian Rogers wrote:
> > On Fri, Nov 8, 2024 at 10:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > > > Ian Rogers (6):
> > > >   tool api fs: Correctly encode errno for read/write open failures
> > > >   perf trace-event: Constify print arguments
> > > >   perf trace-event: Always build trace-event-info.c
> > > >   perf evsel: Add/use accessor for tp_format
> > > >   perf evsel: Allow evsel__newtp without libtraceevent
> > > >   perf tests: Enable tests disabled due to tracepoint parsing
> > >
> > > After applying this series, I'm seeing some test failures.  But I don=
't
> > > understand why it affects non-tracepoint events though.
> > >
> > >   $ sudo ./perf test -v pipe
> > >   --- start ---
> > >   test child forked, pid 3036123
> > >    1bde35-1bdecc l noploop
> > >   perf does have symbol 'noploop'
> > >
> > >   Record+report pipe test
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.210 MB - ]
> > >   [ perf record: Woken up 2 times to write data ]
> > >   [ perf record: Captured and wrote 0.517 MB - ]
> > >   [ perf record: Woken up 2 times to write data ]
> > >   [ perf record: Captured and wrote 0.516 MB - ]
> > >   Record+report pipe test [Success]
> > >
> > >   Inject -B build-ids test
> > >   0xa5c [0x17a4]: failed to process type: 80
> > >   Error:
> > >   failed to process sample
> > >   Inject build-ids test [Failed - cannot find noploop function in pip=
e #1]
> > >
> > >   Inject -b build-ids test
> > >   0xa5c [0x17a4]: failed to process type: 80
> > >   Error:
> > >   failed to process sample
> > >   Inject build-ids test [Failed - cannot find noploop function in pip=
e #1]
> > >
> > >   Inject --buildid-all build-ids test
> > >   0xa5c [0x17a4]: failed to process type: 80
> > >   Error:
> > >   failed to process sample
> > >   Inject build-ids test [Failed - cannot find noploop function in pip=
e #1]
> > >
> > >   Inject --mmap2-buildid-all build-ids test
> > >   0xa5c [0x17a4]: failed to process type: 80
> > >   Error:
> > >   failed to process sample
> > >   Inject build-ids test [Failed - cannot find noploop function in pip=
e #1]
> > >   ---- end(-1) ----
> > >    84: perf pipe recording and injection test                        =
  : FAILED!
> > >
> > >   $ sudo ./perf test -v Zstd
> > >   --- start ---
> > >   test child forked, pid 3036097
> > >   Collecting compressed record file:
> > >   500+0 records in
> > >   500+0 records out
> > >   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, comp=
ressed (original 0.004 MB, ratio is 3.324) ]
> > >   Checking compressed events stats:
> > >   Couldn't decompress data
> > >   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permitted=
]
> > >   Error:
> > >   failed to process sample
> > >   ---- end(-1) ----
> > >    86: Zstd perf.data compression/decompression                      =
  : FAILED!
> > >
> > > Thanks,
> > > Namhyung
> >
> > I'm not able to reproduce:
> > ```
> > $ git log --oneline |head
> > a59bca6eb0a6 perf test: Add a runs-per-test flag
> > 0d0c002eb45c perf tests: Enable tests disabled due to tracepoint parsin=
g
> > 4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceevent
> > 7f57057c7884 perf evsel: Add/use accessor for tp_format
> > c27d357d2d4c perf trace-event: Always build trace-event-info.c
> > 20bf7a2cd68a perf trace-event: Constify print arguments
> > f18b07ee2af1 tool api fs: Correctly encode errno for read/write open fa=
ilures
> > ...
> > $ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 84: perf pipe recording and injection test                          : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > 86: Zstd perf.data compression/decompression                        : O=
k
> > ```
> > Similarly not as root or if runs-per-test is 100.
> >
> > Agreed that the changes are for tracepoints and these tests aren't for
> > tracepoints, so an interaction wouldn't be expected. If you have a
> > reliable reproduction perhaps you can bisect it.
>
> it says:
>
> 9c10de391840a35ab095b65e9a5c4fad0ac52068 is the first bad commit
> commit 9c10de391840a35ab095b65e9a5c4fad0ac52068 (HEAD)
> Author: Ian Rogers <irogers@google.com>
> Date:   Fri Nov 8 10:47:46 2024 -0800
>
>     tool api fs: Correctly encode errno for read/write open failures
>
>     Switch from returning -1 to -errno so that callers can determine type=
s
>     of failure.
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
>  tools/lib/api/fs/fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

So I tried to eye-ball/grep all callers to spot assumptions on the
return value like:
```
err =3D ...__read_int
if (err =3D=3D -1)
```
Didn't spot anything.

It seems in the test log the record is failing so I ran this under
gdb, set breakpoints on the 3 modified functions and then looked up
the call stack to spot bad return value assumptions. Everything looks
good.
I then tried inject and report, the only file read by these functions
is /proc/sys/kernel/perf_event_paranoid as part of symbol
initialization (nit, this should probably be read lazily and the
restriction should really come from the perf.data file, not the
running system) and those calls look good.

The change is small and not critical for the series. It improves the
error message when reading the tracepoint id fails. So we could move
forward with the rest of the series, but that could be annoying for
tracepoint users.

If I had a reproducer I'd revert the 1 line change on each function to
find out which is causing the regression. Once you have that then you
can binary search to find the bad call by using some global counter
where the first 'n' calls use the new return value and the later use
the old value. You can then vary 'n' to binary search and find the bad
caller.

Is there any chance you can help diagnose this or help me to find the
reproducer?

Thanks,
Ian
