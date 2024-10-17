Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E41E4B0
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124918; cv=none; b=ib8jL3cOTJh/fjNo+DZJ63wu4DuM19ZC+nk0JJxw8RGu0wVg10EzHLs59UJT5oM6dEgRrZIQQIqE1dnRZam5v8UOWWJX0rT7V64AginVqVeXjzrne75cyw/6vO90/F6N566U2k6nOyzF5Ql1OFHsmNplSomfWSplpL1TzUtUwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124918; c=relaxed/simple;
	bh=Ij6D5mCxFViYNOZCyVBrXtjAhS5MQbJzMGYbiJbJvRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra7hCwjDkoL5g4+LfUL/7lsjhDssAOrKW6/ImjeNtc2q01GMZlQ9ERlItSUuOmUo3kDcnNfQmt6SsSt2BX8CZWyeIKMiQft90ZEjrql65v3TEnAFhbWZw+oTi7s/bdyvz/p6xzEZKIK+8817+kvJmjgZWS/9f4geDTyCJitmoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtT/iHxC; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtT/iHxC"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so60085ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124915; x=1729729715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW+swacrnZ0UL3GBvERjuGakj5+j4ErZJOApHuj0ufM=;
        b=YtT/iHxCSN5Joett2rCuzbBssOxSnajyvziUe3kthxHYc6d6Ib9o0keWiBdsyhJnZp
         w+yozxN/lqC0OSBmTUFvYr3aNtEIXyAymoQ0AA6dbOmpUPay9XaYetjaoMm+EoyFLCzZ
         YZNJr3NxLmHegFZr+fLJstHe19AvZgguB9e9NSEEQ+MByKo3IriTbQ38P+TrbAQBC+QX
         Rt4pzuPglQoPUje+u9ZKhMFOta0ypM76ANhxKfYewCkoH5totwB7prJoIdm49bpgWErv
         3WZjmAdtIMm89RpufMi50W+Xa62zZGE7RThzJPMxCMxIya8yaAvMJ8aYfqXdvbaHGewV
         pCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124915; x=1729729715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW+swacrnZ0UL3GBvERjuGakj5+j4ErZJOApHuj0ufM=;
        b=WQvy849PCpZFuxjVoJ92hlhFGPK18vlYUBnniDWpeeutX9lL1T16QLVsII0FyUnvoy
         f1B7cOzslKY3YOA9wVi+gA0bb0s2aMp8c3Y/fqFKHqc6Ya4hHT9fhD8HZ+zs8crHQLPv
         UQK9f1Jrik+SeBi5/S7ArYEUoedydbXif8SAIQsll9HiYVo5QifBB9vJOul6ApM+9cfu
         VIwigSBdsBNyJYetTJLI5YYBuY8MeJfV7sXAGeAEIiSOlb0bGy+N2AVI1RVLEy4CJL5r
         v3wCEeUsBAO47Mah3h72jHbpMenf+IRwvuo+uoTNpPJagSoMhygbX3u8u3IrpPOos8dJ
         QOxg==
X-Forwarded-Encrypted: i=1; AJvYcCWqALeqBafUVBu4lZy3Psvkz2uGJYUB1UVYqEhxSbJmYGC4k4hmU0vNUHKR4ZP0P1Z6USl0qV1R5BrAQlXNIko4@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0arH4tVj2bmD3Ntg5tu9memVbZRKSfyJUptAYvAMxdjHp5br
	Hq6n2YbK3QpoOid05U/AvgW8IkYGFi9QUti0/RgeuEqPmLdZRTHwOJUsx9znUEKm5Iwt6eqrzzB
	vq9FsqiLqZd8JgZc5mMJTRzXt2CV0aYhFDemi
X-Google-Smtp-Source: AGHT+IFf5pKKv6CnsP7+3IYeOqkHivPqYLICTnWPWzmH7cw51vk0QMKsEZMBZAqmZ5vTbjvIywigueV4F5q7Je6iqKs=
X-Received: by 2002:a05:6e02:1a49:b0:3a2:6d7a:73e0 with SMTP id
 e9e14a558f8ab-3a3e58ef125mr1912025ab.12.1729124914768; Wed, 16 Oct 2024
 17:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com> <ZxBQ6Z2dvxmQ9Vi0@google.com>
In-Reply-To: <ZxBQ6Z2dvxmQ9Vi0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 17:28:21 -0700
Message-ID: <CAP-5=fUpYZWGU_vDrDekwJu-n-Dw-aymaFsbohnZtqjYG1rDRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Run tests in parallel showing number of tests running
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Oct 11, 2024 at 03:03:46PM -0700, Ian Rogers wrote:
> > Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> > to read them for display. When running on a color terminal, display
> > the number of running tests (1 if sequential). To avoid previous
> > flicker, only delete and refresh the display line when it changes. An
> > earlier version of this code is here:
> > https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com=
/
> >
> > Add a signal handler for perf tests so that unexpected signals are
> > displayed and test clean up is possible.
> >
> > In perf test add an "exclusive" flag that causes a test to be run with
> > no other test. Set this flag manually for C tests and via a
> > "(exclusive)" in the test description for shell tests. Add the flag to
> > shell tests that may fail when run with other tests.
> >
> > Change the perf test loop to run in two passes. For parallel
> > execution, the first pass runs all tests that can be run in parallel
> > then the 2nd runs remaining tests sequentially. This causes the
> > "exclusive" tests to be run last and with test numbers moderately out
> > of alignment.
> >
> > Change the default to be to run tests in parallel. Running tests in
> > parallel brings the execution time down to less than half.
> >
> > v2: Fix inaccurate remaining counts when running specific
> >     tests. Rename "remaining" to "active" to better reflect the
> >     testing behavior. Move the exclusive flag to test cases and not
> >     entire suites. Add more "(exclusive)" flags to test as
> >     suggested-by James Clark. Remove "(exclusive)" flag from test
> >     descriptions to keep the command line output more concise. Add
> >     James Clark's tested-by.
> >
> > Ian Rogers (8):
> >   tools subcmd: Add non-waitpid check_if_command_finished()
> >   perf test: Display number of active running tests
> >   perf test: Reduce scope of parallel variable
> >   perf test: Avoid list test blocking on writing to stdout
> >   perf test: Tag parallel failing shell tests with "(exclusive)"
> >   perf test: Add a signal handler around running a test
> >   perf test: Run parallel tests in two passes
> >   perf test: Make parallel testing the default
>
> Nice work!  It looks much better now.
>
> But I'm seeing more failures in parallel mode.  Maybe we want to
> keep the default serial mode for a little more.

As you say, I think we should be conservative and mark all tests that
need to serial/sequential/exclusive with the exclusive tag. If you
tell me the failing tests I can add them to 'perf test: Tag parallel
failing shell tests with "(exclusive)"' as I did for James Clark with
the ARM tests. I'd prefer we did the tagging rather than not enabling
parallel testing as otherwise I may never learn which tests fail for
people when run in parallel.

Thanks,
Ian

> >
> >  tools/lib/subcmd/run-command.c                |  33 +++
> >  tools/perf/tests/builtin-test.c               | 274 ++++++++++++------
> >  .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
> >  .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
> >  .../coresight/thread_loop_check_tid_10.sh     |   2 +-
> >  .../coresight/thread_loop_check_tid_2.sh      |   2 +-
> >  .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
> >  tools/perf/tests/shell/list.sh                |   5 +-
> >  .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> >  tools/perf/tests/shell/record.sh              |   2 +-
> >  tools/perf/tests/shell/record_lbr.sh          |   2 +-
> >  tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> >  tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> >  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
> >  .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
> >  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
> >  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> >  .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> >  tools/perf/tests/task-exit.c                  |   9 +-
> >  tools/perf/tests/tests-scripts.c              |   7 +-
> >  tools/perf/tests/tests.h                      |   9 +
> >  tools/perf/util/color.h                       |   1 +
> >  22 files changed, 258 insertions(+), 110 deletions(-)
> >
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >
