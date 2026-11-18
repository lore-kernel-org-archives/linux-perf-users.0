Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986183;
	b=Dfb+z2SUwGTDppFgzirQC7fdT/HlAkz9p6sxbyKRGcCck3zlfsLRl6rLbDkauhgwAuKB
	 jX71uCB7wkNhBiQvHpvCWkbvRuEFaaAQ7YvHpzdLSKnujVPmcHKQnoFlM/9YUgVeRKoQP
	 SRme5Opdxe+ry6nOvGwl8ycIEcIPdqVCuzTg4wkiswYilpjjczGC811Du27uGlzJ3q6Uy
	 14T/lnfp2/CMYF3ZrUpcEY7V2SYHsyBTGIpQFeKos3yBS1XJHZhvs3X+8Mt9wO8E+nVVy
	 42hkNQZMrwmpSjaCbw7JxRn8T/zl9y/CF6QULbwRVcS/ah0MKIs9KIcPAyqw1SIXvSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kaexjUtFicZ1cLfZvFYvCV6EhhBzE7PFQief6DawvLI=;
	b=dQsB/NWNlLAlyS7fUcOu36S/KNX4XzA67ATwDtOuNICgiCYViQAcRBYNWB/JRCJj640t
	 kkMriq+qrgQ3NUhO6lM7wFimWCrgWEPfsBTa/n0SxP5m8WMKx02Zo/N3ueuHgPUrDmDOm
	 Q+7x9XFC2H/3RU+njaSaGoPLo8qqC4y8JkC0eaMwiEzmfpdIA49k5QUJaHtwxOyfcEywQ
	 Rx8442neSRmGtrV1Q8lD0Ryya22GJdxDu82S3p/KRBv0NYrnHPPcuCHtAxKo9LQaJzZLi
	 UFAtLsWbcY47r/Hrg4G2UeLI8bQ0QzQNEw5ALsCETxQkGqEFI6Dnf5hSVlyuzj/zEcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8Z2dnHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2781606A31C;
	Wed, 18 Nov 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8Z2dnHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FCC1F000C4;
	Wed, 18 Nov 2026 07:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986182;
	bh=kaexjUtFicZ1cLfZvFYvCV6EhhBzE7PFQief6DawvLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T8Z2dnHwtv2C5A3iKD7OLr3STo58t9Jz/qzLWUpfFRAUB0g7c9P21KZZP0PynjDX+
	 xYMuln3xXjpJgmVnW5YrsaodRASHPK5WiEjH3XgCzX4hwltmuBe+vjlV82bUxK/XVd
	 GGPt4Z8buD7+Of0a4WotucsSqcr+Cnjq2dsaTEhHLCjO16kOY2atVY0G21S0d/TiUE
	 Q2ezdhnwoWgXeGy+haqQci+z/tI73lPXnmCVsy5QqN9inaUeAKQM6/2vjIlikFGRKz
	 MkNEHoBf0lJXz9C0X0Eteb9h3wiAQ6NqqmxsWIDXt7WMIRn7AVWvkk1NLBZBcqV15H
	 c/35BvefB6uEA==
Date: Tue, 17 Nov 2026 23:16:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 07/13] perf tests: Exercise data type resolution from
 a register
Message-ID: <av1QxJZA36xcbcEL@google.com>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-8-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117200433.45174-8-acme@kernel.org>

On Tue, Nov 17, 2026 at 05:04:25PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> At -O2 a struct pointer lives in a register (with DWARF describing it with
> a register location on register-argument ABIs), while the unoptimized
> workloads the data type tests profile keep their variables on the stack.
> 
> Add a regptr workload with a noinline function that takes the pointer from
> a volatile global, so the compiler cannot constant-propagate the object
> address, and check that its three member accesses are resolved from that
> register.

Thanks for adding the workloads for data type profiling.  I was unsure
if it's ok to add since it'd requires many test cases to cover various
aspect of binary patterns or compiler/language differences.  But having
a seperate repo for the test programs would be cumbersome too.

Thanks,
Namhyung

> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c              |  1 +
>  tools/perf/tests/shell/data_type_register.sh | 60 +++++++++++++++++++
>  tools/perf/tests/tests.h                     |  1 +
>  tools/perf/tests/workloads/Build             |  2 +
>  tools/perf/tests/workloads/regptr.c          | 61 ++++++++++++++++++++
>  5 files changed, 125 insertions(+)
>  create mode 100755 tools/perf/tests/shell/data_type_register.sh
>  create mode 100644 tools/perf/tests/workloads/regptr.c
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 8fc425d470c17dbf..fe4d4cd54f85d502 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -215,6 +215,7 @@ static struct test_workload *workloads[] = {
>  	&workload__false_sharing,
>  	&workload__global_data,
>  	&workload__flex_array,
> +	&workload__regptr,
>  
>  #ifdef HAVE_RUST_SUPPORT
>  	&workload__code_with_type,
> diff --git a/tools/perf/tests/shell/data_type_register.sh b/tools/perf/tests/shell/data_type_register.sh
> new file mode 100755
> index 0000000000000000..0d4a420cad9475cd
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_type_register.sh
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# perf data type profiling tests for register variables
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> +
> +cleanup()
> +{
> +	rm -f "$perfdata" "$perfout"
> +	trap - EXIT TERM INT
> +}
> +
> +trap_cleanup()
> +{
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +if ! perf check feature -q dwarf; then
> +	echo "Skip: no DWARF (libdw) support"
> +	cleanup
> +	exit 2
> +fi
> +
> +# No point in recording if the PMU cannot do memory events.
> +if ! perf mem record -o /dev/null -- true 2>/dev/null; then
> +	echo "Skip: cannot record memory events on this PMU"
> +	cleanup
> +	exit 2
> +fi
> +
> +if ! perf mem record -o "$perfdata" -- perf test -w regptr 1 > /dev/null 2>&1; then
> +	echo "FAIL: perf mem record"
> +	cleanup
> +	exit 1
> +fi
> +
> +if ! perf annotate --code-with-type -i "$perfdata" --stdio \
> +		--percent-limit 1 > "$perfout"; then
> +	echo "FAIL: perf annotate"
> +	cleanup
> +	exit 1
> +fi
> +
> +for member in "+0 (a)" "+0x8 (b)" "+0x10 (c)"; do
> +	if ! grep -Fq "# data-type: struct node ${member}" "$perfout"; then
> +		echo "FAIL: member ${member} not resolved from the register"
> +		tail -n 30 "$perfout"
> +		cleanup
> +		exit 1
> +	fi
> +done
> +
> +echo "register held access resolved"
> +cleanup
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 0cf33d91804f19c4..b03c56d5e4c98aaf 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -275,6 +275,7 @@ DECLARE_WORKLOAD(callchain);
>  DECLARE_WORKLOAD(false_sharing);
>  DECLARE_WORKLOAD(global_data);
>  DECLARE_WORKLOAD(flex_array);
> +DECLARE_WORKLOAD(regptr);
>  
>  #ifdef HAVE_RUST_SUPPORT
>  DECLARE_WORKLOAD(code_with_type);
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 74a0cbe49dc93533..17189458032c0a17 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -19,6 +19,7 @@ perf-test-y += callchain.o
>  perf-test-y += false_sharing.o
>  perf-test-y += global_data.o
>  perf-test-y += flex_array.o
> +perf-test-y += regptr.o
>  
>  ifeq ($(CONFIG_RUST_SUPPORT),y)
>      perf-test-y += code_with_type.o
> @@ -39,3 +40,4 @@ CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_flex_array.o       = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_regptr.o           = -g -O2
> diff --git a/tools/perf/tests/workloads/regptr.c b/tools/perf/tests/workloads/regptr.c
> new file mode 100644
> index 0000000000000000..441202b61ae7b2e6
> --- /dev/null
> +++ b/tools/perf/tests/workloads/regptr.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A struct pointer that -O2 keeps in a register, so the member accesses
> + * have to be resolved from the register's type state and not from a
> + * stack slot.
> + *
> + * See tests/shell/data_type_register.sh.
> + */
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +struct node {
> +	long long a;
> +	long long b;
> +	long long c;
> +};
> +
> +static struct node n;
> +static struct node *volatile vp;
> +static volatile unsigned long long reg_sink;
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
> +
> +static noinline long long touch(struct node *p)
> +{
> +	long long sum = 0;
> +
> +	sum += p->a;
> +	/* A load too, or a load-only PMU never resolves b. */
> +	p->b += sum;
> +	sum += p->c;
> +	return sum;
> +}
> +
> +static int regptr(int argc, const char **argv)
> +{
> +	unsigned long long sum = 0;
> +	int sec = 1;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	vp = &n;
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	while (!done)
> +		sum += touch(vp);
> +	reg_sink = sum;
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(regptr);
> -- 
> 2.56.0
> 
