Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FFA4C637;
	Thu,  4 Jul 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121524; cv=none; b=ueDxWyxxCVsKWdLj2N19QnsjAlWbJXA1IhVuXMy4EOfNHKwvM5CZSUVJ34i+iU7yMJvxi+PqXERm9HtGHCAlXOTtotPavGehajzeX5q+KgwLG+WnloTPw2MUTwuXnhSyZO6E4Dqzdr9UsGgy0BbB5yv4sXt+WN/yH3fccx6mM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121524; c=relaxed/simple;
	bh=M0uXPR9ycNgJf5jr/rA13njhPJWhWwUcDrjHugy4if4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lotm1NnqY4MZ1xLP72vSkJq2JlFC3UGtrDnGWwTnFur658qC7O3MJLDPX6dFcWYO0Kf2PPG3G4901aGQ90LlV+DalCM1yrClkpf/UluWlNkMjw7by9FPqGTOO9NmmxaKLOxPWpEe1N36k8Sg692zuXEavSsAEqcjlHNEE1LFz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3eyWKeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3eyWKeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6514C3277B;
	Thu,  4 Jul 2024 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121523;
	bh=M0uXPR9ycNgJf5jr/rA13njhPJWhWwUcDrjHugy4if4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3eyWKeVdYgaIApJ+6CAaV2f1JvStkcIV8bNu2+kCQT/e6Qv7y8iORlR3Np/4VPeO
	 dPRZtZVBPgA4mL3HaO32Di+D2zt/yT/tOErCUtOnH7v+69o4Ug1lVNt5UAkEWk2GBQ
	 UwU49bGhG/Xul+/DDLIjHv9XyP+mlTDSfvZzqDknpEIFyYazMIsJJtZR8FHsnefMZI
	 kM3IqLk29nxKfEBYUiKitNO68Xc1WkRVnewDPa5TVajGuuuh8CZ9Ow3tU1H8kGyv1s
	 ckyR8xXJFyB2oMGrUaFR3Pw++mCKGezjGyq17s7YaXBE4q9XUATThyF5ZHqQMZB4KJ
	 QE6vMH2mK69IQ==
Date: Thu, 4 Jul 2024 16:32:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v4 5/8] perf test: Add landlock workload
Message-ID: <Zob4sO8-D-hepgD2@x1>
References: <20240704124354.904540-1-howardchu95@gmail.com>
 <20240704124354.904540-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704124354.904540-6-howardchu95@gmail.com>

On Thu, Jul 04, 2024 at 08:43:51PM +0800, Howard Chu wrote:
> We'll use it to add a regression test for the BTF augmentation of enum
> arguments for tracepoints in 'perf trace':
> 
>   root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
>        0.000 ( 0.009 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd8e258594, flags: 45) = -1 EINVAL (Invalid argument)
>        0.011 ( 0.002 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd8e2585a0, flags: 45) = -1 EINVAL (Invalid argument)
>   root@x1:~#
> 
> Committer notes:
> 
> It was agreed on the discussion (see Link1 below) to shorten then name of
> the workload from 'landlock_add_rule' to 'landlock', and I moved it to a
> separate patch.
> 
> Howard fixed the build error found by Namhyung (see Link2 below),
> changing the landlock.h header to the one in source tree, and including
> syscall.h for the '__NR_landlock_add_rule' syscall number.
> 
> However, there is another problem. Because of this line in Makefile.config:
> INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi ,
> we'll include 'tools/arch/x86/include/uapi/asm/unistd_64.h' in the source
> tree. But what we want is '/usr/include/asm/unistd_64.h'.
> This hardcoded unistd_64.h in the source tree is not cool for the landlock
> workload because it is a simplified list of syscall numbers for particular
> use cases, we need to discard this search path if we want the
> __NR_landlock_add_rule macro. To solve this problem, Howard added a
> CFLAGS_REMOVE_landlock.o to remove the flag of
> -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi.
> 
> The problem above will not occur in some arch, say arm64
> and riscv because they include asm-generic/unistd.h instead. The arch
> that it really affects is the ones that include asm/unistd_32.h and
> asm/unistd_64.h.
> 
> linux $ find . -regex './arch/.*/include/uapi/asm/unistd.h' | xargs grep -H --color=auto 'include <asm'
> ./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_32.h>
> ./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_x32.h>
> ./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_64.h>
> ./arch/parisc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> ./arch/parisc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/nios2/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/mips/include/uapi/asm/unistd.h:#include <asm/sgidefs.h>
> ./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_o32.h>
> ./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_n64.h>
> ./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_n32.h>
> ./arch/s390/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> ./arch/s390/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/arm64/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/riscv/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/sparc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> ./arch/sparc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/xtensa/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/hexagon/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/openrisc/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/arm/include/uapi/asm/unistd.h:#include <asm/unistd-eabi.h>
> ./arch/arm/include/uapi/asm/unistd.h:#include <asm/unistd-oabi.h>
> ./arch/alpha/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/sh/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/m68k/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/microblaze/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/arc/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/powerpc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> ./arch/powerpc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> ./arch/csky/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> ./arch/loongarch/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> 
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202406250302.E4WaX9Ud-lkp@intel.com/
> Closes: https://lore.kernel.org/linux-perf-users/Zn8TfuQi0iq7bMVD@google.com/
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link1: https://lore.kernel.org/lkml/CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com
> Link2: https://lore.kernel.org/linux-perf-users/Zn8TfuQi0iq7bMVD@google.com/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c       |  1 +
>  tools/perf/tests/tests.h              |  1 +
>  tools/perf/tests/workloads/Build      |  2 ++
>  tools/perf/tests/workloads/landlock.c | 38 +++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+)
>  create mode 100644 tools/perf/tests/workloads/landlock.c
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index c3d84b67ca8e..470a9709427d 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
>  	&workload__sqrtloop,
>  	&workload__brstack,
>  	&workload__datasym,
> +	&workload__landlock,
>  };
>  
>  static int num_subtests(const struct test_suite *t)
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 3aa7701ee0e9..6ea2be86b7bf 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
>  DECLARE_WORKLOAD(sqrtloop);
>  DECLARE_WORKLOAD(brstack);
>  DECLARE_WORKLOAD(datasym);
> +DECLARE_WORKLOAD(landlock);
>  
>  extern const char *dso_to_test;
>  extern const char *test_objdump_path;
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 48bf0d3b0f3d..e132d5d95983 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -6,8 +6,10 @@ perf-test-y += leafloop.o
>  perf-test-y += sqrtloop.o
>  perf-test-y += brstack.o
>  perf-test-y += datasym.o
> +perf-test-y += landlock.o
>  
>  CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
>  CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_REMOVE_landlock.o  = -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
> diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
> new file mode 100644
> index 000000000000..c4f29b17f2a7
> --- /dev/null
> +++ b/tools/perf/tests/workloads/landlock.c
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <sys/syscall.h> // for __NR_landlock_add_rule
> +#include <linux/compiler.h>
> +#include <unistd.h>
> +#include "../tests.h"
> +#ifdef __NR_landlock_add_rule
> +#include "../../../../include/uapi/linux/landlock.h"

We can't access files outside tools/

⬢[acme@toolbox linux]$ cd tools/perf/tests/workloads
⬢[acme@toolbox workloads]$ ls -la ../../../../include/uapi/linux/landlock.h
-rw-r--r--. 1 acme acme 9309 Dec  8  2023 ../../../../include/uapi/linux/landlock.h
⬢[acme@toolbox workloads]$ realpath ../../../../include/uapi/linux/landlock.h
/home/acme/git/linux/include/uapi/linux/landlock.h
⬢[acme@toolbox workloads]$

Take a look at the alternative patch I just sent, this was a real "mid
air collision" :-)

- Arnaldo
