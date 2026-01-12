Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131D1DEFF5
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229394; cv=pass; b=LB2Bo8cp6IGyoTr0z35sqrAe2wqz1Nlg1SZUd4bVLjMhN++oJPF2qiFg9jyBSjxdO8kT80ZxgOdq79xI3uIqYcaiaZZRqLf6chz/77TcJ2tgs3vpaRU5ZHqTeLF0ey5Di+WSfRopt605eRvpk+/RmnZS3uuFk9wMEx9jYfGXV3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229394; c=relaxed/simple;
	bh=WRx3DNRuuCfs0qNnHNuJRb+5jZoQazxJJU8ZTwW9xrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7K0/hH432fcAxCiTifrREND2aAAP/UMOp8zJkuZU41P1h/OgFs168aPch/MGzHH4Z8aYAVisXl1U5myRVPkdkaMI/6ko3RQnBponYGY1s5tPmT/x5FEamVgx67N8EZnInAal0UouoovoQbgdQ7fekLfKE7O5UVC0M24X6w5/Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAqYKRxA; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAqYKRxA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a35ae38bdfso135025ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 06:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768229392; cv=none;
        d=google.com; s=arc-20240605;
        b=IfaVhoTLYuZRhBI5KsPJbZaJDEZfoEqRa6lEPDUbV+bCPXNTSuDojUo+8bX8dbH8JG
         XAOeyt1LK9k4b96/44XFqglw5YBxtin5YVCbr+wDPKuxQXQu2+CKvu4CW66E4Ev8K6Cv
         rLzEu2RllaVAa5gb4IV/16wAAJ/c2c5cHc6lhbU26b9sO/L/WcLQHXmHyJCQcJ43CGvV
         hMoWnb71A302Bo0HeuTB5AKMjXE5PwHSBtIwRgnaxIUQIa0br19pabpyvT+1vUnvwIaw
         x5gRcxWZJuR+vmgzUyqHGS3kL4lWfOX6hulj4qlAMllGm4bR0YsJ5s2ezMZjgTfvyJjg
         MAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Od2MhYIQXRU7KLcIJZcOJTc6UZ3SssP+EHps9oXLGIQ=;
        fh=Pa7Dgy2mTI29xy+RqPrtN3UiLxhkxsml/G1kU1psVos=;
        b=aCj4GFeexX/opf0X8iB79tvukdgl5dc4sKK5v51iY3kKfL+W8lUL7S3uxgeP/C1He0
         hPOl7kWMQnziEmhN01jNaHQpJrYWc92bmvpYBSY+GwZLh8QTawkXUwOLy2eXoOIoQYcS
         vJtBUZzmtOQcm3y17zCgZI/fLhDR94yqyqpUxVEPyHHimn1TU2B4zSxgpLmJxDK02rgD
         53/3dKWiq0f3bR0qJ+7EYLpYpBaLY01Nwjgun54sX3YENIVuWdpPn8AQPlrVVVu4fHSz
         cFnnfGHajZinIBkN30VNCEov93YxdmbjypoSiwBeVYPzLT4qiopgk9uTHR7GThW9c5kG
         kb1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768229392; x=1768834192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od2MhYIQXRU7KLcIJZcOJTc6UZ3SssP+EHps9oXLGIQ=;
        b=VAqYKRxAuZlrGVBADwZG/HvBpsoXFxXvn0MsSe5NurUDFB5aem5rJBwHrbqO58hzs+
         jjsnvshginjtudHfY9x/V2Pk4kOZfdsGz8/ENNvSizD/dLBS2pxZmhEVuNMIWzSw0M5L
         GJBsjp0te1aI40DNxO0shnCYN+uvpeQJwL131aApbTa5aYfNhPDcHHwZqjGQjLIy98Gk
         CPCWnUozXZ62A9yY1ZTE8mYe/uM+MeTc7jor2fVX/UpfKaXUcK26hr0Uiz9qOpscg7F+
         2Sn/HbxEA1wF1Sj0k8oUhhWYWWMLv3UVpBA8veCWP3ntmmyPOTZEs0nl+8gg+ss6s/l/
         27dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229392; x=1768834192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Od2MhYIQXRU7KLcIJZcOJTc6UZ3SssP+EHps9oXLGIQ=;
        b=dO9u+oUUSHRXXYadssAaaSixRy8oAUU17QAx3dEYRt6STdP4/mqu4qCYjHB90ExyZs
         ITvAg5l3WWQi1PVm9ELkw5kN1sf1LDc6JCJ7TI7/CR7MmTgLuQzaSJccdJ01S83M2pbg
         RAye/wPtZ1CwAtbtFAuKYI9HK/gco2PKjW/DsvU2KJx1E+NL1BWqGoLtK4vzbps22oDj
         FmqY6MnjLHH3x3CqyhNqHnrGU1Yg8odsyXvu/ax4Y2FULgWpklX2em6eQDjN8BYY5vmH
         AJ0aYPuYr8qhVfxaUF9QGPgeM8sqzBIQ27heX4tsI9AktpfvqCubn9w0yx+jrTTRu5Zu
         1F5A==
X-Forwarded-Encrypted: i=1; AJvYcCWrhrTZgRydP6Z6q7PAOB/pDbnjDEozoBaT19xR2li121Eki43ej0NF3OX8ogXPv8xmUqJqOs7bRDxNkntF5yf6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Boms9aiEFJTlNa5R2tE20P/ptAz2khM+3Y1HpTkGxixESD8q
	yeKwQkjmRUcNXHN5DywK28RLWycPHn3qh13LddlLyzJsYZqBhWqMe/rae8fPr1HoE+AiLD5a4oE
	9QN6D8yBKkVeNbtts69H9Nz5nTExs6/bW1kgU/XQm
X-Gm-Gg: AY/fxX60tMdl1PZVXy2udXFW16AiMAPiC+xJHqVJFCf0465Q115p28m4W5anEYxWesz
	W/riWlGs/nYRqcZf9UPVBd8GWDIWVEh4qQJu+v1ARASARhRxHLI9i+1J5Bw6I3r4JugI7T4+xGQ
	ACifN1kYJzJRepETCYcIqnNnwjJ2IcYC8wbVMky9ZDEG8lAMY/o/9Sw1/dHFPnZV/W04mwE9N0F
	xTMk9KGu3k6rvnoCiFzQBo4SjRnhRZY8eXhHpcatKholhf5PSDN5Tj/7ni2cniMB0c8mhdRoApN
	RHWBiCA=
X-Received: by 2002:a17:903:1aae:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2a4147c332bmr4701165ad.2.1768229391645; Mon, 12 Jan 2026
 06:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com> <dbdd0541-0a67-4d61-9ae2-7820920e8f7a@linaro.org>
In-Reply-To: <dbdd0541-0a67-4d61-9ae2-7820920e8f7a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 06:49:39 -0800
X-Gm-Features: AZwV_Qh4i_zi-5Nu7oBY8qKOe6FprAvnUQPVQjyKt-rPfKpMJ9CHIqkcsN_Fx10
Message-ID: <CAP-5=fWWHHioXCsZhxL=ooEPD_qZyd78t0Qjj1ieZYSB-Z_fsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add a libdw addr2line implementation
To: James Clark <james.clark@linaro.org>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 3:18=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 11/01/2026 4:13 am, Ian Rogers wrote:
> > addr2line is a performance bottleneck in perf, add a libdw based
> > implementation that avoids forking addr2line and caches the decoded
> > debug information.
> >
> > Allow the addr2line implementation to be picked via the configuration
> > file or --addr2line-style with `perf report`.
> >
> > Test/fix that inline callchains are properly displayed by perf script.
> >
> > An example:
> > ```
> > $ perf record --call-graph dwarf -e cycles:u -- perf test -w inlineloop=
 1
> > [ perf record: Woken up 132 times to write data ]
> > [ perf record: Captured and wrote 32.814 MB perf.data (4074 samples) ]
> > $ perf script --fields +srcline
> > ...
> > perf-inlineloop 1814670 293100.228871:     640004 cpu_core/cycles/u:
> >              55a11d6e61ee leaf+0x2e
> >    inlineloop.c:21 (inlined)
> >              55a11d6e61ee middle+0x2e
> >    inlineloop.c:27 (inlined)
> >              55a11d6e61ee parent+0x2e (perf)
> >    inlineloop.c:32
> >              55a11d6e629b inlineloop+0x8b (perf)
> >    inlineloop.c:47
> >              55a11d69a3bc run_workload+0x5a (perf)
> >    builtin-test.c:715
> >              55a11d69aa9f cmd_test+0x417 (perf)
> >    builtin-test.c:825
> >              55a11d6155f5 run_builtin+0xd4 (perf)
> >    perf.c:349
> >              55a11d61588d handle_internal_command+0xdd (perf)
> >    perf.c:401
> >              55a11d6159e6 run_argv+0x35 (perf)
> >    perf.c:445
> >              55a11d615d2f main+0x2cb (perf)
> >    perf.c:553
> >              7fae3d233ca7 __libc_start_call_main+0x77 (libc.so.6)
> >    libc_start_call_main.h:58
> >              7fae3d233d64 __libc_start_main_impl+0x84
> >    libc-start.c:360 (inlined)
> >              55a11d565f80 _start+0x20 (perf)
> >    ??:0
> > ...
> > ```
> >
> > v3: Make the caller inline file and line number accurate in the libdw
> >      addr2line, rather than using the function's declared location.
> >      Fix reference counts in unwind-libdw. Add fixes tag for srcline
> >      inline printing.
> >
> > v2: Fix bias issue with libdwfl functions. Use cu_walk_functions_at
> >      from perf's dwarf-aux to fully walk inline functions. Add testing
> >      that inlined functions are shown in the perf script srcline
> >      callchain information. Add configurability as to which addr2line
> >      style to use.
> >      https://lore.kernel.org/lkml/20260110082647.1487574-1-irogers@goog=
le.com/
> >
> > v1: https://lore.kernel.org/lkml/20251122093934.94971-1-irogers@google.=
com/
> >
> > Ian Rogers (7):
> >    perf unwind-libdw: Fix invalid reference counts
> >    perf addr2line: Add a libdw implementation
> >    perf addr2line.c: Rename a2l_style to cmd_a2l_style
> >    perf srcline: Add configuration support for the addr2line style
> >    perf callchain: Fix srcline printing with inlines
> >    perf test workload: Add inlineloop test workload
> >    perf test: Test addr2line unwinding works with inline functions
> >
> >   tools/perf/builtin-report.c                 |  10 ++
> >   tools/perf/tests/builtin-test.c             |   1 +
> >   tools/perf/tests/shell/addr2line_inlines.sh |  47 ++++++
> >   tools/perf/tests/tests.h                    |   1 +
> >   tools/perf/tests/workloads/Build            |   2 +
> >   tools/perf/tests/workloads/inlineloop.c     |  52 +++++++
> >   tools/perf/util/Build                       |   1 +
> >   tools/perf/util/addr2line.c                 |  20 +--
> >   tools/perf/util/config.c                    |   4 +
> >   tools/perf/util/dso.c                       |   2 +
> >   tools/perf/util/dso.h                       |  11 ++
> >   tools/perf/util/evsel_fprintf.c             |   8 +-
> >   tools/perf/util/libdw.c                     | 153 +++++++++++++++++++=
+
> >   tools/perf/util/libdw.h                     |  60 ++++++++
> >   tools/perf/util/srcline.c                   | 116 ++++++++++++++-
> >   tools/perf/util/srcline.h                   |   3 +
> >   tools/perf/util/symbol_conf.h               |  10 ++
> >   tools/perf/util/unwind-libdw.c              |   7 +-
> >   18 files changed, 486 insertions(+), 22 deletions(-)
> >   create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
> >   create mode 100644 tools/perf/tests/workloads/inlineloop.c
> >   create mode 100644 tools/perf/util/libdw.c
> >   create mode 100644 tools/perf/util/libdw.h
> >
>
> I don't see the differences to the other addr2line implementations
> anymore, but only because it falls through to the old ones when libdw
> fails now.
>
> For example when building Perf with LLVM it can't get the line in the
> inlineloop workload, and there's still a few things in libc and other
> system libraries it fails on.

Hmm.. I wonder what the issue is. I was looking at the dwarf output
from my gcc builds with llvm-dwarfdump. I wonder if LLVM builds are
doing something to confuse libdw? I'll try to investigate. There are
quite a few levels of libdw: there's the raw libdw, libdwfl (frontend
to libdw) that does the parsing and tries to give things like nested
debug scopes (libdwfl is the one needing addresses with a module bias
rather than raw file offsets), and then there is the dwarf-aux.c that
is in perf and is used by things like probe finding (I believe this
doesn't need biases addresses). Anyway, with the biases there are
things I can screw up (like in the v1 patch) but maybe the LLVM issue
is just a libdw and dwarf-5 kind of thing. Maybe it is ARM specific
:-/

> But I think it's fine because it doesn't give the wrong line anymore, it
> just falls through to another working addr2line implementation.

Just to confirm that with gcc builds it isn't failing now? ie it isn't
just an addr2line implementation that falls through all the time? I
was seeing things working/testing on x86 with gcc.

> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks,
Ian
