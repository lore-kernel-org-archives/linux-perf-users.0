Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411812DFA4A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419253; cv=pass; b=JuV2CVz5LkfZ5YPl5+cR+RtddPjFXNfJA3RjJPirEa4gF3X0yANgYrBvI7iKmmIvFjfkQ1IdBKIJnjxsKuT+y/1vUN9bw0S9yY8CfHuC1ZTpaKfcE1U3yNZs3ybJKWef2e6xZRkGe+vA5mP7oRTOS4Jy+v27OTji7ZQeTNHSTkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419253; c=relaxed/simple;
	bh=2w4NXTukq5ckCobRf/f5vq86E+/5WUfUOK2BJBCuErQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ej0BDnGRA7fYUMA/t5Jh7ftsBj4AlbO80hFIjSml8xiCJ6AiWW4Ems2PvCXWJ+hZ44q3TIt3MwKYTMW01iDJKi6IUSuhpV+fyhL3G6ysVftXIGAC/SY90xgswsNO/wAwsBbzq0DPk3k/tzXNX3AgNnPP3ekI8UQNnzk2AqJ3rZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQQeTUrj; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQQeTUrj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22c18ad3so3285ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 09:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780419251; cv=none;
        d=google.com; s=arc-20240605;
        b=fB//gGh/YMt88PTTKNIRQJvJDyMKzQjvQXhaTJeDz/I/0/Ghxw3+uYjDTTGKhpCxUr
         ZbbewKjalZiOWSnuHtcdo4RpRLF+SG860SMAxf8GNSbrzK87SADR7dcV2EdRzpUjGuI7
         BICrxPGroLQXHZFCJjYM4ECbN3TGtbAPcOM/e0StNPlEq8rxB4jt81YdQYNcqSxzci4v
         Rrrl1VO12OLYS8pbk5FF6msWoPICzfX/+jYSb3mhKF7sG5vWVvq8NI8fLfAx6zsmW3HZ
         MCTW0cFu+yB5L//x3S+YDEvYuw9eS2QaCT1oIhlw2cOigtW2eVYLH/tPFHVqLzXnE70C
         rQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Immf037yMWY3bmYTlq+R68PCYR0rAVdJ40kWnGQwG8o=;
        fh=3qr9GrEkc3wz/gOBTNnx+F1YUP3gd/wYEdH2ZWLN8CY=;
        b=Rjeab4dNUvsp6s0TTl8r0Ll9QbRi2NMJp38boad0KEqWy1urZruYS+waisCVtsPcy6
         rZ3I7qsiJO715X0maFCoHxo7lsy15YCUDsOl5pK/euiHzWaXM+2YnsDzEcikhMuQNB6Y
         eVzy4+TYFMwFYic8viRrR1AfZe1CoXLoP8OjJ+FVC3ltYRs2c8xbpIv0J3CC4bXGEiyl
         2bk0Z34qLxy/TOBBSGnDxxM30XHCZYStR8s4hBUka6DH1owWDCGByLslefT8ZXZFUjxU
         kmVbLBQf4GoPk3wPShUNG0dElz4+Xh9Wkdwu/42Ur6xED3i4/8rv/k39qRK23LeolbuV
         dORg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780419251; x=1781024051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Immf037yMWY3bmYTlq+R68PCYR0rAVdJ40kWnGQwG8o=;
        b=bQQeTUrjCBukb77+2vnRXDS5+UTooJDR9O2CirSxLYhsQ/r0bPP1WU99vBSRMiTTke
         n4RKdopl/HOyQdaXF9XwoSPwKMJvsrnKMXSesLR4S0EEAX9WZahImu/cXr5IEdpwIn91
         8//Btvn/qOcaA1SZxfsS6cEOd+ZKhdaRmVfE8LdEKHTPz9Ra4oK2QUNeaiC7tr267IvW
         HyRLKwcVRLDQCZnt3I/EmHgZCynZNym9QsmwCTMZR3XL59rszkidzX8+QqsRWDYDIRpe
         zkjBU0yNOfRy33XVzew0tNpiuTknlrvx6Ok5Dnw6eUVsxiJvjZE0YP2LkrREI1fqhgjY
         +1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419251; x=1781024051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Immf037yMWY3bmYTlq+R68PCYR0rAVdJ40kWnGQwG8o=;
        b=ILTiMnfgiuUufvMxkceEd4gHgGLRFpl+djyrOpvP8YlzHaWZRRXnAGxJUX16tGIjG+
         AjANG5HY5KN+eqqDBUvZp9tog5vJldMzsW6b/jzFBw/O4DIiTN3cNSzBmrKMZWMdoSmT
         joRiiz1zJeTOaG97UxSA2TQMFbbfJlMLZz6exq5/HOFjW040kD6UTG8n/htPCakenC+3
         OxGX2KTzYiAhDeGPJ9yZpMTnlu5+bO1zxxXj4/pA8naYvYN9/BfGMWkigKxjWVqquzVZ
         V/jWXrGRWgI6ok0SjB/8h1T2chuit9b7zuwuYvjw9iLy9GJ1ucyxLHNVPTcbamPRQ2Ff
         qRrw==
X-Forwarded-Encrypted: i=1; AFNElJ8CtNWggBUYwycrrMcY7RxdSPHuRebOIetaetZWEkPmBpknglGu0SsD/Ir8NuH6tRFsXvE188leqRaJompNMlWO@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbqRnsJu8+iJDPdQy+eQ/9flT+DJZHHRU+eZlZu4ILN/IA1sW
	H3fLyK5S2uPJ7nVqjl0f7d+7IZd+ZOVdCqUP7KCgTy7fWzHcXtws1Sq4IVWAkbFphhdsSMAjY5/
	v30uM8Xf75uYElJDEx3GcavPa1q7YS0Ca427P1oZS
X-Gm-Gg: Acq92OG+/mcX6v39hKSF5hwanj7htdWxsw3zRMKGmJSQe/95HHYFmFWx9uv3keohEcJ
	5n4SMoNTN36mwRY71Q4sAzZ8Gc9/JcEb0wN8cN9PJq+FeYQDE/Ao1m36O73r1PIQx9oo9YZ4rtw
	Id7521K+rdlVWHsI9kV738nwhEOB90Ad9MXzGl6FXmUILwryYTPXHHs12CqMhi6+PeadD0oDQPG
	M4dpkN5T0fT0gzyRjXTej7a79V4GNAfh05tL2fLxgXGX9YSS3zsRxsNDWAklEfVBebNl3i+K+CE
	oTf7/63RK0ndrovm5/8sLsaJF99Av7ToW7Thtfgilneb7StSuxcn2QF9t7k=
X-Received: by 2002:a17:902:ecc3:b0:2c0:bf57:8746 with SMTP id
 d9443c01a7336-2c10eb100e7mr3521915ad.18.1780419250852; Tue, 02 Jun 2026
 09:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jun 2026 09:53:59 -0700
X-Gm-Features: AVHnY4JxpTAWoaKW7TN9u2Gp-5-dknXBRdSSDax8MAQ6G8yz2ciVwr9NCHDqDt0
Message-ID: <CAP-5=fWtc0xHfCeXfcPUkmWtHZO4EUriDrqovr5nXzb0GvSWxw@mail.gmail.com>
Subject: Re: [PATCH v12 00/19] perf: Use e_machine and lazily compute symbols
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 8:25=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add a helper to perf_env to compute the e_machine if it is EM_NONE.
> Derive the value from the arch string if available. Similarly derive
> the arch string from the ELF machine if available, for consistency.
> This means perf's arch (machine type) is no longer determined by uname
> but set to match that of the perf ELF executable.
>
> Migrate code away from strcmp on env->arch to using the e_machine
> comparisons that are more accurate and not prone to uname and other
> naming differences. While cleaning this up, also clean up the
> capstone initialization code to cover more architectures and to set
> the big endian flag based on ELF header information.
>
> Refactor perf_env__arch_strerrno to take an e_machine instead of an
> architecture string, removing the HAVE_LIBTRACEEVENT dependency
> entirely and making it unconditionally available. The generated errno
> table includes fallback definitions for newer ELF machine constants to
> ensure compatibility with older host glibc versions.
>
> Introduce a mutex in perf_env to safely protect lazy metadata setup,
> such as os_release or e_machine resolution, preventing concurrent
> initialization data races and memory leaks during multi-threaded
> profiling or symbol loading. Properly initialize stack-allocated
> perf_env instances to ensure safe mutex destruction.
>
> Switch the idle computation to the point of use and lazily compute it,
> rather than computing it for every symbol. The current only user is
> `perf top`. At the point of use the perf_env is available and this can
> be used to make sure the idle function computation correctly accounts
> for architecture-specific and kernel-version-specific patterns.
> To prevent concurrent updates to shared symbol bitfield flags, migrate
> bitfield variables in struct symbol to C11 atomic flags.

So I think this series is at the point where Sashiko [1] is giving
warnings only for out-of-scope things and pre-existing conditions. I
will give a detailed explanation below, but I'd appreciate help moving
this forward with human review and submission. Thanks!

> Ian Rogers (19):
>   perf env: Add perf_env__e_machine helper and use in perf_env__arch

1 critical 2 high issues.
The issues relate to existing data races, the inaccurate arch string,
and normalizing the arch string stored in the data file. The existing
data races don't bite us currently due to the single threaded nature
of most of perf - multithreading is on the TODO list. The arch string
is inaccurate and the e_machine in newer perf.data files resolves
this. If we were using the arch string without the e_machine then the
concerns over its use are valid, but this series is trying to remove
the use of the arch string and strongly prefer the e_machine.

>   perf tests topology: Switch env->arch use to env->e_machine

No regressions.

>   perf env, dso, thread: Add _endian variants for e_machine helpers

1 high issue for a potential pre-existing SEGV if a thread lacks maps.
Let's hope that doesn't happen, the example given assumes a
multithreaded environment and multi-threading is on the TODO list.

>   perf capstone: Determine architecture from e_machine

1 low issue. A flag only present in capstone 4.0 is used. As capstone
4.0 was released in 2018, let's just assume the flag is there rather
than adding yet more complexity.

>   perf print_insn: Use e_machine for fallback IP length check

No regressions.

>   perf symbol: Avoid use of machine__is

1 high issue. Concerns over pre-existing cross-platform analysis
problems. Cross-platform analysis fully working is on the TODO list.

>   perf machine: Use perf_env e_machine rather than arch
>   perf sample-raw: Use perf_env e_machine rather than arch
>   perf sort: Use perf_env e_machine rather than arch
>   perf arch common: Use perf_env e_machine rather than arch
>   perf header: In print_pmu_caps use perf_env e_machine
>   perf c2c: Use perf_env e_machine rather than arch
>   perf lock-contention: Use perf_env e_machine rather than arch
>   perf env: Refactor perf_env__arch_strerrno
>   perf env: Remove unused perf_env__raw_arch

No regressions x9.

>   perf env: Add mutex to protect lazy environment initialization

1 medium issue requesting more locking on more bits of perf_env.
Multi-threading is on the TODO list and let's stop the feature creep
here.

>   perf env: Add helper to lazily compute the os_release

1 high issue. Concern over a perf data issue in pipe mode. Addressing
this would require a fairly major overhail of perf data, so let's add
fixing to the TODO list.

>   perf symbol: Add setters for bitfields sharing a byte to avoid
>     concurrent update issues
>   perf symbol: Lazily compute idle

No regressions x2.

Thanks,
Ian

[1] https://sashiko.dev/#/patchset/20260602152516.2831152-1-irogers%40googl=
e.com

>
>  tools/perf/arch/common.c                      |  92 +++--
>  tools/perf/builtin-c2c.c                      |  40 +-
>  tools/perf/builtin-inject.c                   |  10 +-
>  tools/perf/builtin-kwork.c                    |   2 +-
>  tools/perf/builtin-report.c                   |   2 +-
>  tools/perf/builtin-sched.c                    |   4 +-
>  tools/perf/builtin-top.c                      |   7 +-
>  tools/perf/builtin-trace.c                    |   7 +-
>  tools/perf/tests/symbols.c                    |   2 +-
>  tools/perf/tests/topology.c                   |   8 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   2 +-
>  tools/perf/trace/beauty/Build                 |   1 +
>  tools/perf/trace/beauty/arch_errno_names.sh   |  53 ++-
>  tools/perf/ui/browsers/annotate.c             |   2 +-
>  tools/perf/ui/browsers/map.c                  |   4 +-
>  tools/perf/util/annotate.c                    |   5 +-
>  tools/perf/util/auxtrace.c                    |   6 +-
>  tools/perf/util/callchain.c                   |   4 +-
>  tools/perf/util/capstone.c                    | 132 ++++--
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   6 +-
>  tools/perf/util/dlfilter.c                    |   2 +-
>  tools/perf/util/dso.c                         |  19 +-
>  tools/perf/util/dso.h                         |  14 +-
>  tools/perf/util/env.c                         | 376 ++++++++++++++----
>  tools/perf/util/env.h                         |  14 +-
>  tools/perf/util/evsel_fprintf.c               |   6 +-
>  tools/perf/util/header.c                      |  55 ++-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/libdw.c                       |   2 +-
>  tools/perf/util/lock-contention.c             |   6 +-
>  tools/perf/util/machine.c                     |  37 +-
>  tools/perf/util/machine.h                     |   2 -
>  tools/perf/util/print_insn.c                  |  23 +-
>  tools/perf/util/print_insn.h                  |   2 +
>  tools/perf/util/probe-event.c                 |   4 +-
>  tools/perf/util/sample-raw.c                  |  21 +-
>  tools/perf/util/sample-raw.h                  |   6 +-
>  .../util/scripting-engines/trace-event-perl.c |   2 +-
>  .../scripting-engines/trace-event-python.c    |   4 +-
>  tools/perf/util/session.c                     |  26 +-
>  tools/perf/util/sort.c                        |  66 +--
>  tools/perf/util/srcline.c                     |  10 +-
>  tools/perf/util/symbol-elf.c                  |   5 +-
>  tools/perf/util/symbol.c                      | 238 ++++++++---
>  tools/perf/util/symbol.h                      |  80 +++-
>  tools/perf/util/symbol_fprintf.c              |   4 +-
>  tools/perf/util/thread.c                      |  58 ++-
>  tools/perf/util/thread.h                      |  23 +-
>  49 files changed, 1078 insertions(+), 420 deletions(-)
>
> --
> 2.54.0.929.g9b7fa37559-goog
>
