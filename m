Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171E157A5C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Oct 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453617; cv=none; b=p5mO0Pi/3pD0UtErregSuMIBkvQapRXYj7goNQmxbSCx05LSzmWPh5NdMzeQolfK8dkHtl3s/WMdJNn3rpe5iw97s8GV/OfdwJHIKF0ZD6OPI6qzDlQEaGocUdg4zlFO9Gci6ftd+eZaEzTKLEaq/2iUnCk/ucHaLQaEbdkTEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453617; c=relaxed/simple;
	bh=asfLAxTRlC3cvobna5DTLB9nS5fce0f+CgO4/yo72Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqMnkdzXLkcPxc3vyqdf6dwP9eoMpkDnLXV7fQzzIEavwfIndyF4Blmv6G3YkvmEktHJQlAAIuVKLugsEj2jGvA3ttJSbMSF0fcJwsKhErZD741rfp4Zow3r+Im8eQvO6ncuACciJsaFcdAFG40Nr6rn9qE8iYzR3w73stwZIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8WMYyfc; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8WMYyfc"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso186885ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Oct 2024 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728453613; x=1729058413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpHjahOhe44ljzpZmc/RFBRO2RSewAslIJugtIjKYKw=;
        b=o8WMYyfc1g34x7U+kp3zJ8LeTQzoPgfh7NKCWnR4QcN52giX4CIFqhhjJpreo90Ghx
         uSx9k7rl/p4UZ+yn6+3gxeI84inadduf5d/l5AaAsT4xNYcVTsbmiFnM4B+iNaLn4dh1
         rfzcyQoopqIBXJ0Lk+1HIjEdgnjeVrnVcKx7DLeLgDhp+Ffd/fnnfmfIrIz/rdi5l5W1
         6oAzMztwQ20LCIXy10PUTk2RdvJ+dAL4rz/mJoMxQ5XfPTkCFnFhbGgo0d42htfaTIYs
         emzhOYHRTgJ0JoulnjcPKmOwZDLnFzSnhREOt3acrLpAVzSlGj4nme+WJmcvZkrpKti2
         Lx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728453613; x=1729058413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpHjahOhe44ljzpZmc/RFBRO2RSewAslIJugtIjKYKw=;
        b=iMaqhICqAEepvaF0iUCmS0xD7o1HuYOlYfS/VLp7nO5uJv1Vfj6fN8w6K1YZuaS73R
         2nohy2t4uEVrwyFJYUmz0N0gE3xnISKFecYngMyZKcQ2Mvs9D6bjr9o9b9rA3FE8AKCD
         QrhwFA91ptjA0WTpM5S293KmKx55OtrtEOcoToJ+tFkO2l9K5R3ttC0MSafALFhJGWBe
         CkK7tMDXanwU5ayCo57aBGB3dKYpL9KS8TtMGpVg7ZARP/FrJua0v/CLdbl+uvcU38x0
         Pr/iu5Tuu0zFZG1GXX/PHrku3rnw9SrPMyvhIPcFGheGHhIK7OsCArBuzVuKYDcJAuXR
         4FCg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKYviWZMMdsQRNYukUXgSyqZRI2ZF6n56xkMQIlowqWxGNqvFXzCpx6YIU+QfWCZ7TUezL/YftBYSdVDsH2A1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2m74XzT1M1FcUQFJgJ6A+odg1wfjx3UW7NkMghzZJC2cHbG1y
	Xw1jLOHDSPBm3a5KdeF9SMn4ehsQs9qDM4XFqCYMb1l77/el11gP95n+lboZUVeaJouYrJnjytp
	9beKdexlLOdmCgMN+n19IYSuuoYsxyJkg0N7H
X-Google-Smtp-Source: AGHT+IEjzEJWcyZzTrRX8fXUseSsnm7TAu51kVqymrvMQvouqmphMtczHwwVgD1+IDekxcUn/FY8R1K8SrVF43QTzT4=
X-Received: by 2002:a05:6e02:1c44:b0:3a0:8dbf:8298 with SMTP id
 e9e14a558f8ab-3a396f5ddc7mr2921975ab.0.1728453612498; Tue, 08 Oct 2024
 23:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001171950.233723-1-irogers@google.com> <CAP-5=fWExR7ae=dgiAG8BCtDN0XDwnzy9=SBbE0cy5S1Luw-4A@mail.gmail.com>
 <ZwYW54gKOfnUboeZ@google.com>
In-Reply-To: <ZwYW54gKOfnUboeZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 22:59:59 -0700
Message-ID: <CAP-5=fUY8d4DN+ekpj5B58kvoksrPcWpZU=iZhs+=bFfpakK3Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Oct 08, 2024 at 11:55:29AM -0700, Ian Rogers wrote:
> > On Tue, Oct 1, 2024 at 10:19=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > The path detection for "Setup struct perf_event_attr" test is brittle
> > > and leads to the test frequently not running. Running shell tests is
> > > reasonably robust, so make the test a shell test. Move the test files
> > > to reflect this.
> >
> > Ping.
> >
> > I think this is worthwhile cleanup for the attributes test. It should
> > avoid problems like:
> > https://lore.kernel.org/lkml/ZroNTkdA8XDFaDks@x1/
>
> Sorry, it's not clear to me what was the problem.  Can you please say it
> again briefly?

If you build perf like:
make -C tools/perf O=3D/tmp/perf

Then run the built perf test for the "Setup struct perf_event_attr" it
skips (causing the tests to bitrot and fixes to be sent by Veronika):
```
$ sudo /tmp/perf/perf test -vv perf_event_attr
capget syscall failed (No such file or directory - 2) fall back on root che=
ck
17: Setup struct perf_event_attr:
17: Setup struct perf_event_attr:
--- start ---
test child forked, pid 806601
Using CPUID GenuineIntel-6-8D-1
---- end(-2) ----
17: Setup struct perf_event_attr                                    : Skip
```

The issue is around the path set up, the test has a few path
expectations but they are brittle as shown above. While we could
endeavour to set up the path in C code, it makes sense to migrate the
test to a shell test due to the tests smaller size, ease of
environment variable manipulation, existing perf test support for
better path setup, etc. Ie let's not reinvent the shell test
infrastructure that handles python tests for the sake of one C test.
After this change:
```
$ sudo /tmp/perf/perf test attribute
76: Perf attribute expectations test                                : Ok
```

Thanks,
Ian

> >
> > > Ian Rogers (3):
> > >   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
> > >   perf test: Remove C test wrapper for attr.py
> > >   perf test: Move attr files into shell directory where they are used
> > >
> > >  tools/perf/Makefile.perf                      |   5 +-
> > >  tools/perf/perf.c                             |   2 -
> > >  tools/perf/tests/Build                        |   1 -
> > >  tools/perf/tests/attr.c                       | 218 ----------------=
--
> > >  tools/perf/tests/builtin-test.c               |   1 -
> > >  tools/perf/tests/shell/attr.sh                |  22 ++
> > >  tools/perf/tests/{ =3D> shell}/attr/README      |   0
> > >  tools/perf/tests/{ =3D> shell}/attr/base-record |   0
> > >  .../tests/{ =3D> shell}/attr/base-record-spe    |   0
> > >  tools/perf/tests/{ =3D> shell}/attr/base-stat   |   0
> > >  .../tests/{ =3D> shell}/attr/system-wide-dummy  |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-C0     |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-basic  |   0
> > >  .../{ =3D> shell}/attr/test-record-branch-any   |   0
> > >  .../attr/test-record-branch-filter-any        |   0
> > >  .../attr/test-record-branch-filter-any_call   |   0
> > >  .../attr/test-record-branch-filter-any_ret    |   0
> > >  .../attr/test-record-branch-filter-hv         |   0
> > >  .../attr/test-record-branch-filter-ind_call   |   0
> > >  .../attr/test-record-branch-filter-k          |   0
> > >  .../attr/test-record-branch-filter-u          |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-count  |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-data   |   0
> > >  .../{ =3D> shell}/attr/test-record-dummy-C0     |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-freq   |   0
> > >  .../attr/test-record-graph-default            |   0
> > >  .../attr/test-record-graph-default-aarch64    |   0
> > >  .../{ =3D> shell}/attr/test-record-graph-dwarf  |   0
> > >  .../{ =3D> shell}/attr/test-record-graph-fp     |   0
> > >  .../attr/test-record-graph-fp-aarch64         |   0
> > >  .../attr/test-record-group-sampling           |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-group1 |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-group2 |   0
> > >  .../{ =3D> shell}/attr/test-record-no-buffering |   0
> > >  .../{ =3D> shell}/attr/test-record-no-inherit   |   0
> > >  .../{ =3D> shell}/attr/test-record-no-samples   |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-period |   0
> > >  .../{ =3D> shell}/attr/test-record-pfm-period   |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-raw    |   0
> > >  .../{ =3D> shell}/attr/test-record-spe-period   |   0
> > >  .../attr/test-record-spe-period-term          |   0
> > >  .../attr/test-record-spe-physical-address     |   0
> > >  .../attr/test-record-user-regs-no-sve-aarch64 |   0
> > >  .../test-record-user-regs-old-sve-aarch64     |   0
> > >  .../attr/test-record-user-regs-sve-aarch64    |   0
> > >  .../perf/tests/{ =3D> shell}/attr/test-stat-C0  |   0
> > >  .../tests/{ =3D> shell}/attr/test-stat-basic    |   0
> > >  .../tests/{ =3D> shell}/attr/test-stat-default  |   0
> > >  .../{ =3D> shell}/attr/test-stat-detailed-1     |   0
> > >  .../{ =3D> shell}/attr/test-stat-detailed-2     |   0
> > >  .../{ =3D> shell}/attr/test-stat-detailed-3     |   0
> > >  .../tests/{ =3D> shell}/attr/test-stat-group1   |   0
> > >  .../{ =3D> shell}/attr/test-stat-no-inherit     |   0
> > >  tools/perf/tests/{ =3D> shell/lib}/attr.py      |   0
> > >  tools/perf/tests/tests.h                      |   1 -
> > >  tools/perf/util/evsel.c                       | 122 +++++++++-
> > >  tools/perf/util/util.h                        |   7 -
> > >  57 files changed, 142 insertions(+), 237 deletions(-)
> > >  delete mode 100644 tools/perf/tests/attr.c
> > >  create mode 100755 tools/perf/tests/shell/attr.sh
> > >  rename tools/perf/tests/{ =3D> shell}/attr/README (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/base-record (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/base-record-spe (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/base-stat (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/system-wide-dummy (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-C0 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-basic (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-any (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-any (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-any_call (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-any_ret (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-hv (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-ind_call (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-k (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-u (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-count (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-data (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-dummy-C0 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-freq (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-default=
 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-default=
-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-dwarf (=
100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-fp (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-fp-aarc=
h64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group-samplin=
g (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group1 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group2 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-buffering =
(100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-inherit (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-samples (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-period (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-pfm-period (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-raw (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-period (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-period-te=
rm (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-physical-=
address (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-no-=
sve-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-old=
-sve-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-sve=
-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-C0 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-basic (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-default (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-1 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-2 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-3 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-group1 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-no-inherit (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell/lib}/attr.py (100%)
> > >
> > > --
> > > 2.46.1.824.gd892dcdcdd-goog
> > >
