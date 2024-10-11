Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8161990C4
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663999; cv=none; b=lHeUBiyZw0YCdHbzLoZuLUQTCqT7IQAxNlrrcLwqTknDxK10Rse58Xd0UR0HTeEy2LYUbNmjEWioMfeuCeWK4kqM/dl7g7X30MItzwaVYDlFV5LK+nc7uqKajFKQonVfdzvXCZKtlCLo7S5DbgQUIQEK+/JhjqlO0o/79F3FzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663999; c=relaxed/simple;
	bh=JJfLcSJT6SUfxQIYKsr7yBThKwI/qs9OrJLzfzkQ++E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjJ6f5OGZaEr8pGuxlqVN58Z+zRtu+RZTTX/iiLTVUiaRO6KYERz+lXRbdRW2/BECt0T7irFOKYThNWEfLqPav8JDSXPI5EaIaH5lfXNsAZwiA673VCOCXva8Izuployn1AMmFBkFUvtUswM7AGk/pO3kBOfuDdimZMh0lrZuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnyqjGjI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnyqjGjI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c87b0332cso203995ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728663997; x=1729268797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgBi2CgoUh+yA9kfntiaJkcuQrlnuJ/H6QCxY+XAqP4=;
        b=JnyqjGjIJjxGLG6QIzwwVKp02T0FC0W1wHjDtvjOJPTep6yU3dvz3ihkskmgCH7Sly
         BlDvAzug4DjRRQ0ey8yjAlKG2hLtCdclv7yuMDpL22lxXOhp8kCL6wTDjq5OjRxipj16
         v88AmlPXz2hZMiepxGrj1nSRHzhc7Rd7f9sQDN7klG1awRKV11kC/ry28u2VtS+fpqSI
         eju5lyYIGLHRkBflOMtO8ou2427UP4H+8Zo5u59Iod7HgZSGgSN9tuBwQxsC9MuqwPTL
         NYBBK0NMwu51jCbpnC3FS7+7ssAy45a1xK4pfP4/SqGRfjIZ5lBVXxubh5TnQDALRv+a
         hk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663997; x=1729268797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgBi2CgoUh+yA9kfntiaJkcuQrlnuJ/H6QCxY+XAqP4=;
        b=aW5WJESHwlMVbU43jY/sIpn+fwJnWweZ+CyXex508WPwKJJz9KbLmFDM1o26D+v+Wh
         1fVNQy2/LcNvpJ7mxTJmYD9ymdMgBPSiP3PTd0VxlWCuZ38dAaxtY4oJLiUsakQrIGpM
         8lFBI2sIsm2abxaY1YSZRhu1SLn1NAe5IqRI6pr7EJ3pRHPkNxJUCpoNnACk17S4HNmz
         OmZGdhjwMYCBJOsl3sb6Mv7+nDPAZXRbFrqtRLMX/rc6JACQyW9/ipFofkicVj9NfpPP
         X3CKJ4v7SpTjtDnOK4PORyQBl1U0f/86+V4SyFIM6gzKJm2sKha0AlG3eahUqBowcHeF
         VQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUd7pE/VtinYbPAkqo9YODki8aIovg4fGKjGdmVdKKBifLBcSuz6V7Y487I9aKJavAiiiTKmmpuU11zuWiMsgqM@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLNlV5eB70uvl8fPGtNexj/g+cgHejEw0nC08OmVpcgKXWy8k
	VXUSG7niv8TFBV7L7+Xlz04l1P59P0OOualIZaI4eX+6mlu8bbmtk75XVs/Dv6G/iKuObN65822
	skW5pFakmi/aZ26hEkGXrHk2X4HN/ThocmcOG
X-Google-Smtp-Source: AGHT+IHqtIXHbgDwBWNWcYCygzM0IEEDf/gvIXxqhjoKQACQ+ujuHX041JX4SWBZXmd30WXWWV5AC5KXwn/M4cQNoc0=
X-Received: by 2002:a17:903:27cd:b0:20c:a97d:cc83 with SMTP id
 d9443c01a7336-20ca97dd06amr1662835ad.16.1728663996483; Fri, 11 Oct 2024
 09:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com> <231a275e-00db-499b-92a4-259dab8f9d80@linaro.org>
In-Reply-To: <231a275e-00db-499b-92a4-259dab8f9d80@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Oct 2024 09:26:19 -0700
Message-ID: <CAP-5=fULBYVqrgcQ1hHgou29HATOtXfZxR84r-Q2WTccT7SOBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Run tests in parallel showing number of tests running
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:03=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 11/10/2024 8:35 am, Ian Rogers wrote:
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
> > Ian Rogers (8):
> >    tools subcmd: Add non-waitpid check_if_command_finished()
> >    perf test: Display number of remaining tests
> >    perf test: Reduce scope of parallel variable
> >    perf test: Avoid list test blocking on writing to stdout
> >    perf test: Tag parallel failing shell tests with "(exclusive)"
> >    perf test: Add a signal handler around running a test
> >    perf test: Run parallel tests in two passes
> >    perf test: Make parallel testing the default
> >
> >   tools/lib/subcmd/run-command.c                |  33 +++
> >   tools/perf/tests/builtin-test.c               | 267 ++++++++++++-----=
-
> >   tools/perf/tests/shell/list.sh                |   5 +-
> >   .../tests/shell/perftool-testsuite_report.sh  |   2 +-
> >   tools/perf/tests/shell/record.sh              |   2 +-
> >   tools/perf/tests/shell/record_lbr.sh          |   2 +-
> >   tools/perf/tests/shell/record_offcpu.sh       |   2 +-
> >   tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
> >   tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
> >   .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
> >   tools/perf/tests/tests-scripts.c              |   5 +
> >   tools/perf/tests/tests.h                      |   1 +
> >   tools/perf/util/color.h                       |   1 +
> >   13 files changed, 226 insertions(+), 100 deletions(-)
> >
>
> Not really a big deal but remaining doesn't work when a subset of tests
> are run:
>
>   $ perf test 111 110
>   110: Check Arm64 callgraphs are complete in fp mode      : Ok
>   111: Check Arm CoreSight trace data recording and synthesized samples:
>     Running (150 remaining)

Thanks, I'd been so focussed on other issues that I'd missed testing
like this. v2 will fix the "remaining" but I've renamed it "active" as
the count doesn't reflect the remaining tests as exclusive tests will
be missing and they will show 1 test remaining which isn't accurate.

> Other than that:
>
> Tested-by: James Clark <james.clark@linaro.org>

Thanks,
Ian
