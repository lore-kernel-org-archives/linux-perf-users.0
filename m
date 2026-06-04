Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4972617
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612699; cv=pass; b=T/SHR3uYsNWBSy0Ow6ExsnGgvifmaZF9JGn9z7f8pby0cNePwyhtcqdl3Nq8Rz28WOAWnWoMKXvSRmxLzcI8S9DSxZFxLwutg/jnHKkBp04WtKGD6K0yxho+eVJXimaowjsUx9rMt21+7YFMbLZ9f6p+gDDOe0Sww/VSvFWvTgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612699; c=relaxed/simple;
	bh=iduvtvVMy7lSfrq4AIat7QgL57wNGiusw1Djrfu76zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+yefeHzTtM4U6gPAkddTK7KfTMhoUwfl6gRRRL25GHBfM7sA/yM3b+Az9O73IMtTpAt6KER2zXcEqMRvCbVpjHYPm7WYXQN5Nz+i2IUKfJ1Ni6mDuaEfiXR+It0zD/TOMRg/BAkinaL0wvNtHowoenA1ybtKn4uUuwnTcobHxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqRTzxBM; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqRTzxBM"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22c18ad3so53135ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 15:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780612697; cv=none;
        d=google.com; s=arc-20240605;
        b=cW+l4wQbxyycRc+DTeMCPWqwUqyPfJt0iT/MWKNBCCQl5ojo4IjZlT7EDXkx5fGwr8
         +d7QbWqOpWacYDAZ8wUAxz4PkMf4cCln1bKh562k9AbkrDc6w9BslEf8JCCj3zUxlEIY
         3ScAEJ2kzOa79n/b32IDQfUBC1+m2pbi79q7X8qGS/2allMwkuAodRfMrEFEbViDvZ3l
         upcL1avF3UJOuBaxrWJLawwCtnoVDFkiybUeKmGlp2zBZAbT11mFtIb3r5nodN3p4jz5
         7zSHvhX7ibaktT4q/qFb4dYI0tLsb/zX9wEApxnLmCxGNIvDniaAJTnVSOjl+LyFhtzl
         pT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UkoqK7P/CGPA3wHcQAmbRSctzHAFSMtPHBLzdELYgCI=;
        fh=XL0LhWZCqd9vqatFyenrxM+VCmnbJciQdX6eOVd2iYI=;
        b=HjtXh2QZ3XM23BuaG7XpZxXEX3gFI1K/ktMl2mzcsuJ46YAQyPHuSIZ8C/qx81dGZ+
         DMSvJ1wU5u9yvN9B9yFbPqLyr57g3ICcSOMD3+LZHjXevIZZQd7WoDfYmSykZBmlpOaV
         JGfUqkrIkoun4cQhtASJc5VXn57IT1fb/GR5Dic0PiNlVjUAyMdivGRw5hTCw4Bc5q+z
         AvfLuRd14akKkiOXQU9s5wMlcsK6iPwLMwRHVlDhOGtaWnak4jJYrcrhwA9iHdE8zvTV
         M2q35KLmYunlW6mchuYs/QxGNP7gbRl9KuHRYpBwH3tV+lqRT0kyVzgqWKFF1dUnI6fE
         1N/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780612697; x=1781217497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkoqK7P/CGPA3wHcQAmbRSctzHAFSMtPHBLzdELYgCI=;
        b=kqRTzxBMnzW6KlQgMWqQAsJVf1z1FfL0tK6R089FcEs6V8i2ctYo5cGsUpsy7YSEO2
         GVpcwXMS6szVCaxTaabEhy2Q/iY1hoeE1vxHMziCTW1m77Y+W1R/jnCcP0aRIIa3//XK
         hjP31ma4rYCCmRY3VDJDlw30zEP5O3/HOCevtFU1N5p2LbOo6AqC95dXtNMz6JJGB097
         DMpNwX1ySsKRqo4aUFyMt/7/GOgLJ8dmy4p87yT9D+2mEO8rhC7fuMkI8N/OrTZ3sWBZ
         ncxtdrQCHg1fXDi4UrGDdP+2MpinAeceiyWfNL/ZjKNsJft0Kdlqd5R2Uq/EAcfnf3xd
         PXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780612697; x=1781217497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UkoqK7P/CGPA3wHcQAmbRSctzHAFSMtPHBLzdELYgCI=;
        b=DvKTVKYk7BT4e6RO0/QFv4d4Pg5DUYd+yVJAteNBgGtc7IGsD4H3zZpIFvcbsEwsIG
         I8nIXwMFW5t+1JDbGbRWrPbDm/9lvbEvxfhkZHdP7j+1sp4Eegf46I9dp0uvxRqCDHHd
         GmxW3tahnIbhlq7XD5A7/0hkJrEI3nkKg98BRnP1TpwYEgXBQjLwQr9M3P2RYnY6xjDh
         XsucrYe+Y7H72sLhZIrGU1FYx2XSwO1KebUlEA9Cg68HuM5onvxzKba5XV50LpJ+zcTK
         nLpZjuHyFMMvQV2ly6ZurVH/fbQK5bdUHMd7xqUHChy5yTwVvI+GaALVipzJnLC2GSq8
         CFcw==
X-Forwarded-Encrypted: i=1; AFNElJ9ErOMWSnXpYbTroVnnHWx0FDDk+uAOM2o+EeeUjWsxV8xckfPDrL7+u/dIL12B8rgA2glwbNxMQntH18ouOg9X@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBG5SmFYB5UfMPWalYgVK03NksksvuwHahLz0Ai7pBI4Izlqz
	erOhBr0MA02YIXoXn+sG2+8cXWCCiAC5sR92VLTZNBXBl7JMsNc8/ITYEMSAwhG5ecNdUURnawH
	cMOf2uXt4IBvl7XqFdf7Nq9ZBZOs5rM2TiAt/8kry
X-Gm-Gg: Acq92OGXrug1cdIIhl81wCJ2G7YQGq6eIJF3n4A4Af0j8GxM0Izt6RUlZKmgTqNHGZw
	lOod5dhDV183ideW1D+N/JmY8XxDSg1h2ntxGyp108gy06BGc/rNflB2228UluXRAHML+vSw2oC
	iH+xufyXtEQgaa/SiEr2Wia+MAn0Hh5S/y0WO9Pdqui/mRZbMDmIotOAhfDLzFzPQVj+vRUVHwz
	2YbKJZbKx1VM1BvASb6lhbqO9uq+mKGRBEcjDHq+HR9MmGGSbCqkG8iY/Zqe30w00xfDdgYnwHy
	qIW5slNdXjKatcOu4q/VqzFi2tJ9npmoKLK2l40vw7hU9XFE
X-Received: by 2002:a17:903:46c7:b0:2bd:6dad:3dfb with SMTP id
 d9443c01a7336-2c1eb94ba47mr71055ad.25.1780612696677; Thu, 04 Jun 2026
 15:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604214931.2202322-1-namhyung@kernel.org>
In-Reply-To: <20260604214931.2202322-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jun 2026 15:38:05 -0700
X-Gm-Features: AVHnY4Jfkho7M4iefV80GSlY04ioANqgz8b13vAf9w0YHFl9Oxq4OizsnkJeXs4
Message-ID: <CAP-5=fU3JO3b+bPYzZd=TKoxDy4xYMgGXVtCZq6W3Lh3LNN8YA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf timechart: Small optimization for backtrace
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> I found an issue int timechart backtrace handling during the last review.
> The goal is to reduce unnecessary work in generating backtrace string.
>
> v2 changes)
>  * fix memory leaks when backtrace is not used
>  * copy backtrace when it's used twice

Hi Namhyung,

thanks for cleaning this up and the fixes! Running a build of:
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1
EXTRA_CFLAGS=3D"-fno-omit-frame-pointer -O0 -g -fsanitize=3Daddress" clean
all

I get an error but the test harness makes it look like the test is
passing (I added set -x to the test and removed the "> /dev/null
2>&1"):
```
$ sudo /tmp/perf/perf test -vv timechart
136: perf timechart tests
136: perf timechart tests:
---- start ----
test child forked, pid 937043
+ err=3D0
++ mktemp /tmp/__perf_timechart_test.perf.data.XXXXX
+ perfdata=3D/tmp/__perf_timechart_test.perf.data.cXMvK
++ mktemp /tmp/__perf_timechart_test.output.XXXXX.svg
+ output=3D/tmp/__perf_timechart_test.output.xZXfy.svg
+ trap trap_cleanup EXIT TERM INT
+ perf check feature -q libtraceevent
+ test_timechart
+ echo 'Basic perf timechart test'
Basic perf timechart test
+ perf timechart record -o /tmp/__perf_timechart_test.perf.data.cXMvK true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.135 MB
/tmp/__perf_timechart_test.perf.data.cXMvK (748 samples) ]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D937049=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 136 byte(s) in 1 object(s) allocated from:
   #0 0x7fd211119a23 in calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:74
   #1 0x555c44044416 in timechart__record ~/linux/tools/perf/builtin-timech
art.c:1895
   #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
c:2073
   #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
   #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
98
   #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
   #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
   #7 0x7fd206e29f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7fffcf8a352a  ([stack]+0x2052a)

Direct leak of 10 byte(s) in 2 object(s) allocated from:
   #0 0x7fd211113e20 in strdup
../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
   #1 0x555c440444a1 in timechart__record ~/linux/tools/perf/builtin-timech
art.c:1902
   #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
c:2073
   #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
   #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
98
   #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
   #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
   #7 0x7fd206e29f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7fffcf8a352a  ([stack]+0x2052a)

Indirect leak of 44 byte(s) in 4 object(s) allocated from:
   #0 0x7fd211113e20 in strdup
../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
   #1 0x555c440445ef in timechart__record ~/linux/tools/perf/builtin-timech
art.c:1908
   #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
c:2073
   #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
   #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
98
   #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
   #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
   #7 0x7fd206e29f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7fffcf8a352a  ([stack]+0x2052a)

Indirect leak of 41 byte(s) in 4 object(s) allocated from:
   #0 0x7fd211113e20 in strdup
../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
   #1 0x555c44044696 in timechart__record ~/linux/tools/perf/builtin-timech
art.c:1911
   #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
c:2073
   #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
   #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
98
   #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
   #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
   #7 0x7fd206e29f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7fffcf8a352a  ([stack]+0x2052a)

Indirect leak of 11 byte(s) in 4 object(s) allocated from:
   #0 0x7fd211113e20 in strdup
../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
   #1 0x555c440444a1 in timechart__record ~/linux/tools/perf/builtin-timech
art.c:1902
   #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
c:2073
   #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
   #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
98
   #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
   #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
   #7 0x7fd206e29f76 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
   #8 0x7fffcf8a352a  ([stack]+0x2052a)

SUMMARY: AddressSanitizer: 242 byte(s) leaked in 15 allocation(s).
+ echo 'Basic perf timechart test [Skipped: perf timechart record
failed (permissions/events?)]'
Basic perf timechart test [Skipped: perf timechart record failed
(permissions/events?)]
+ return
+ cleanup
+ rm -f /tmp/__perf_timechart_test.perf.data.cXMvK
+ rm -f /tmp/__perf_timechart_test.output.xZXfy.svg
+ trap - EXIT TERM INT
+ exit 0
---- end(0) ----
136: perf timechart tests
: Ok
```

It was this test that I was trying to make leak sanitizer clean when
doing my fixes.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf timechart: Don't pass @event to cat_backtrace()
>   perf timechart: Generate backtrace only if needed
>   perf timechart: Remove unused backtrace in trace_handler
>   perf timechart: Remove unnecessary copy of backtrace
>
>  tools/perf/builtin-timechart.c | 107 ++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 55 deletions(-)
>
> --
> 2.54.0.1032.g2f8565e1d1-goog
>
