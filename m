Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105696;
	b=s3PlQL4jd483wItmr+ivtty9zvZkAM+zkJujmtcHC3GTutxhqAjH4maiz7isZ24XU+/y
	 j7+2XVqeLeeC3Vt5cabbNl61OEbIHt60e2xA4IT40io0lx7lx+bOoUxGAkZucmvbRv392
	 pSmOBV+NcL6CLgN5duP9I4/4iB7KC7yAauU71sZuWdy2U6qGm5LBn+cAm90SPM3rzmvEJ
	 BMpPAl9P9KJ5PcTO/TZjBg66zXgDIz3oEg1wecMHSiK/bX0gY1d1kuraWYkqsZg+HR/1v
	 bArMyKi5v3GAZuRrTR2Y9330y/K8lhzVfq9lnU3OWX3N3/HCE5G+/OPm8aVzFGcw+eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105696;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TznJpNICz/LIXq1AT7iwPZHDzdZFY1wF9Y26YwnLGGE=;
	b=mZrSOjK5RX8RXenL+a19v7ArT1LJHpIXm+C0raJZ+xbzS2d8RS9ydAWZv+noJtdc/5f8
	 9hWaJh85VMwzM2oUROkjmsVZt2oHgxCj/DmlsPHIS5yeDAHVdnU6bpdsBT0TWTZ0F+Y7c
	 Pb6qjWL0JRCaeo2Aat48PWq6I4oexdiENJ/zn8hD8ErZ+6jiAY/e/VyQL5IkI5/e8FWoT
	 cA040XSYs+c/nZup3L0452ae6kYeGCD7btnuR83O03WXdmHxzeG7NtqM5yKBKxRCH+nZm
	 Q/0AwHj//Uy/eGQH7GxlWBYeKu5J54D5+WOyVhQYClA2ES8/CqsfYl512F5HY0SK9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rf2twODo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F28606A31A
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rf2twODo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A45D1F008A1;
	Sun,  8 Nov 2026 02:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105696;
	bh=TznJpNICz/LIXq1AT7iwPZHDzdZFY1wF9Y26YwnLGGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rf2twODouX7b9MwgNziWRPHPVGPaBqamIg5vsbGkehiRUuNMRwe18X9F6lSBgvLhV
	 7SnfBuLHCMJ1acCPr7WyNUC3P6d+sXvY1ssV/avNusvmcmNYpnxo89Lq14uAOIjuiD
	 YUiQ6WWYxG0KNCtEg4GQFHOSEvsVHrH+46UFlB7nE5pGo15723jhpJVDGKPt1waZ/3
	 E1HbQH3Wo93RxFa05adIPj63OZ90cNTGsJH+cTezTwcTtkcjgLNa3FoSBNVU1w2Vjs
	 IenWdKgsZhnmAhc/wW9a18rCoNguzElSKq6AZRvio49KdOZsXCR8LnF2q4p47D3V87
	 qQfhF42dtx57g==
Message-ID: <sashiko-outbox-203523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] riscv: Add breakpoint and watchpoint test for
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Jesse Taube" <jtaubepe@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "Shuah Khan" <shuah@kernel.org>, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107023917.40606-3-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-3-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Medium] selftests/breakpoints: missing kselftest API and skip logic
  in setup_bp()
- [Medium] selftests/breakpoints: premature close(gfd) and dead store in
  trigger_wp()
- [Medium] selftests/breakpoints: non-volatile test_data in trigger_wp()
  can be optimized out
- [Low] selftests/breakpoints: forced -static CFLAGS and missing
  .gitignore entry
- [Low] selftests/breakpoints: commit message claims ptrace usage and
  .gitignore misses binary
- [Low] selftests/breakpoints: non-portable glibc macro
  __attribute_noinline__ in test_func()
- [Low] selftests/breakpoints: unhandled EINTR in wait_event()
  sem_timedwait()
--

commit 1561777f5a1538f9c1adcbe99231ade440297bf1
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: Add breakpoint and watchpoint test for riscv

This commit adds a RISC-V kselftest for hardware execute breakpoints and
write watchpoints using perf_event_open() and asynchronous signal delivery.

> Add self test for riscv architecture. It uses ptrace to ptrace framework
> to set/unset break/watchpoint and uses signals to check triggers.

[Severity: Low]
As reported by Jesse Taube on v5 [1], does this test use the perf_event_ope=
n()
interface rather than ptrace?  In addition, "ptrace to ptrace" is a typo in
this sentence, and the ptrace-based tests are only added later in commit
"selftests/breakpoints: extend riscv test for ptrace hw break/watchpoints".
Also, breakpoint_test_riscv is not added to
tools/testing/selftests/breakpoints/.gitignore.

> diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing=
/selftests/breakpoints/Makefile
> index 0b8f5acf7c78f..1f28f50e8f85f 100644
> --- a/tools/testing/selftests/breakpoints/Makefile
> +++ b/tools/testing/selftests/breakpoints/Makefile
> @@ -12,5 +12,13 @@ ifneq (,$(filter $(ARCH),aarch64 arm64))
>  TEST_GEN_PROGS +=3D breakpoint_test_arm64
>  endif
> =20
> +ifneq (,$(filter $(ARCH),riscv riscv64))
> +TEST_GEN_PROGS +=3D breakpoint_test_riscv
> +endif
> +
>  include ../lib.mk
> =20
> +ifneq (,$(filter $(ARCH),riscv riscv64))
> +$(OUTPUT)/breakpoint_test_riscv: CFLAGS +=3D -static $(KHDR_INCLUDES)
> +endif
> +

[Severity: Low]
Will forcing -static without -pthread fail to link on build environments
without static libc/libpthread archives or where sem_init(), sem_post(), and
sem_timedwait() require explicit pthread linkage?  Also, the $(ARCH) filter
omits riscv32 on 32-bit RISC-V hosts, and tools/testing/selftests/breakpoin=
ts/.gitignore
is not updated with breakpoint_test_riscv.  In breakpoint_test_riscv.c,
ib_mtx, wp_mtx, and setup_bp() can be static, and bp_triggered and
wp_triggered should be volatile sig_atomic_t since they are updated in sign=
al
handlers.

> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c =
b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
> new file mode 100644
> index 0000000000000..a8a94a788142d
> --- /dev/null
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c

[ ... ]

> +int setup_bp(bool is_x, void *addr, int sig)
> +{
> +	struct perf_event_attr pe;
> +	int fd;

[ ... ]

> +	fd =3D syscall(SYS_perf_event_open, &pe, 0, -1, -1, 0);
> +	if (fd < 0) {
> +		printf("Failed to open event: %llx\n", pe.config);
> +		return -1;
> +	}
> +
> +	fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
> +	fcntl(fd, F_SETSIG, sig);
> +	fcntl(fd, F_SETOWN, getpid());
> +
> +	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
> +
> +	return fd;
> +}

[Severity: Medium]
Should setup_bp() and main() use the kselftest.h helpers and skip via
ksft_exit_skip() when hardware breakpoints are unsupported or restricted?
On RISC-V platforms without SBI_EXT_DBTR / Sdtrig support or when perf even=
ts
are disabled or restricted, syscall(SYS_perf_event_open, ...) fails and cau=
ses
main() to fail the test run with exit code 255 instead of skipping, while
printing pe.config (which is always 0) instead of errno.  Also, the fcntl()
and ioctl() return values are unchecked, and in main(), if (bp_triggered) a=
nd
if (wp_triggered) only guard printf() calls, so main() still returns 0 if
wait_event() succeeds while either counter is 0.

[ ... ]

> +static __attribute_noinline__ void test_func(void)
> +{
> +	test_func_sink++;
> +	__asm__ __volatile__("" : : "g" (test_func_sink));
> +}

[Severity: Low]
Will __attribute_noinline__ fail to compile against non-glibc C libraries
such as musl?  __attribute_noinline__ is a glibc <sys/cdefs.h> macro; using
__attribute__((noinline)) avoids breaking musl builds.

> +
> +static int trigger_bp(void)
> +{

[ ... ]

> +	ioctl(gfd, PERF_EVENT_IOC_ENABLE, 0);
> +
> +	test_func();
> +
> +	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
> +
> +	close(gfd);
> +
> +	return 0;
> +}

[Severity: Medium]
Does closing gfd here before main() calls wait_event(&ib_mtx, "Breakpoint")
race with asynchronous signal delivery?

Because perf event O_ASYNC signals are queued via irq_work, if signal deliv=
ery
is delayed past test_func(), close(gfd) tears down the perf event and its
fasync registration before the signal is sent, or races with sig_handler_bp=
()
calling ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0) on a closed descriptor.  Also,
sig_handler_bp() and sig_handler_wp() call printf(), which is not
async-signal-safe, and trigger_wp() never closes gfd before returning (note
that commit "selftests/breakpoints: extend riscv test for ptrace hw
break/watchpoints" later in the series adds close(gfd) to trigger_wp(),
though still before wait_event()).

> +
> +static int trigger_wp(void)
> +{
> +	struct sigaction sa;
> +	unsigned long test_data;

[ ... ]

> +	gfd =3D setup_bp(0, &test_data, SIGUSR1);
> +
> +	if (gfd < 0) {
> +		printf("Failed to setup watchpoint\n");
> +		return -1;
> +	}
> +
> +	ioctl(gfd, PERF_EVENT_IOC_ENABLE, 0);
> +	test_data =3D 0xdeadbeef;
> +	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
> +
> +	return 0;
> +}

[Severity: Medium]
Can the compiler eliminate the store to test_data as a dead store?
test_data is a non-volatile local variable that is never read before
trigger_wp() returns, so under -O2 the store between the enable and disable
ioctl() calls can be optimized away and the watchpoint will never fire.
Qualifying test_data as volatile prevents this, and gfd also remains open on
the stack address &test_data when trigger_wp() returns in this patch
(close(gfd) is added later in commit "selftests/breakpoints: extend riscv
test for ptrace hw break/watchpoints").

> +
> +static int wait_event(sem_t *sem, const char *name)
> +{

[ ... ]

> +	ts.tv_sec +=3D wait_timeout_sec;
> +	if (!sem_timedwait(sem, &ts))
> +		return 0;
> +
> +	if (errno =3D=3D ETIMEDOUT)
> +		printf("%s: Timed out waiting for event\n", name);
> +	else
> +		printf("%s: sem_timedwait() failed with %d\n", name, errno);
> +
> +	return -1;
> +}

[Severity: Low]
Does sem_timedwait() fail with EINTR if SIGIO or SIGUSR1 is delivered while
wait_event() is blocked?  POSIX sem_timedwait() does not automatically rest=
art
when interrupted by a signal handler, so when the signal arrives during the
wait and the handler posts the semaphore, sem_timedwait() returns -1 with
errno =3D=3D EINTR unless retried in a loop.

[1] https://lore.kernel.org/r/CADRr4bdFr+cu-1L0cSAJUwN-ehHiyb=3D4WHmwh3xS2s=
6q33ZCVw@mail.gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D2
