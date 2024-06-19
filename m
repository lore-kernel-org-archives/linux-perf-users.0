Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B614C581;
	Wed, 19 Jun 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805103; cv=none; b=QFHF350Z40yvTHfHhqT6Dl8TYUqKUQ6YvbWMFNGLNhQE2v1Mv5hz6ecYJC4IYP2LgreG1SVqEg2/0MOSqudTRuaPKIX2wPFDAU06T/8GX6X9P82q6Zo5NzV2brA9O7TKokI8Pju8A2CrVe+V8xnTYzs6hWHmQhPHvdf01A482Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805103; c=relaxed/simple;
	bh=zzpgsWo6tMSadzkSdZbgz/EogbJdNEbVvnPtoToCJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUR8QZJ9WuQgplIPZrqwpM5VW3Fe7EGe8ytjgT+8Hq921DyBtBveEaHxdGTPpVom2fXLyFi8zDXiyzuKF3P4kns9Nqk7WaMULJYcHQ3d8eEjKZkJL5BZj4bYNGj1GqHpop+IQeIWMxLZ4YyuaD6B61VDv1aUDNqR8f+q/4KKX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPfq55WT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPfq55WT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D43CC2BBFC;
	Wed, 19 Jun 2024 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805102;
	bh=zzpgsWo6tMSadzkSdZbgz/EogbJdNEbVvnPtoToCJ2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPfq55WTcKuMX7gPSvAl9i9PltoHebCJ5w3EoMzLet6C97wXyYTsW81PakejWbUI6
	 R/UMukAe6Y+IYB0lx7yH+r7S/WbbdK2feF2l/QtD8+MFyZCFvdiIz9DOST9sz5HZ8i
	 hJtsaG3YPnc29Klfs11n8Ybmwca4QyeHS8xd1fgPnRqo6kEqGq5vEUhWdNCNu5gUqJ
	 K1W6fupvvPVjIitEArjzzSX7tf/K3y0yzMKdD0r/0AynWcJ4AssZ6FJ3HPAnaA9AzD
	 gggTuZXTp5UZpvgsRVw4i0KEAS5PR+BWZiHVFQPgn30xtthMe3t2FaIfmGRCeFhbeW
	 IE1DnPxyz3N4Q==
Date: Wed, 19 Jun 2024 10:51:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 5/5] perf trace: Add test for enum augmentation
Message-ID: <ZnLianWCCEF6ydVO@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619082042.4173621-6-howardchu95@gmail.com>

On Wed, Jun 19, 2024 at 04:20:42PM +0800, Howard Chu wrote:
> Check for vmlinux's existence in sysfs as prerequisite.
> 
> Add landlock_add_rule.c workload. Trace landlock_add_rule syscall to see
> if the output is desirable.
> 
> Trace the non-syscall tracepoint 'timer:hrtimer_init' and
> 'timer:hrtimer_start', see if the 'mode' argument is augmented,
> the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
> in its name.
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/builtin-test.c               |  1 +
>  tools/perf/tests/shell/trace_btf_enum.sh      | 57 +++++++++++++++++++
>  tools/perf/tests/tests.h                      |  1 +
>  tools/perf/tests/workloads/Build              |  1 +
>  .../perf/tests/workloads/landlock_add_rule.c  | 32 +++++++++++
>  5 files changed, 92 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
>  create mode 100644 tools/perf/tests/workloads/landlock_add_rule.c
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index c3d84b67ca8e..e83200415ad1 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
>  	&workload__sqrtloop,
>  	&workload__brstack,
>  	&workload__datasym,
> +	&workload__landlock_add_rule,
>  };
>  
>  static int num_subtests(const struct test_suite *t)
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
> new file mode 100755
> index 000000000000..4861983553ab
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +# perf trace enum augmentation tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=0
> +set -e
> +
> +syscall="landlock_add_rule"
> +non_syscall="timer:hrtimer_init,timer:hrtimer_start"
> +
> +TESTPROG="perf test -w landlock_add_rule"
> +
> +. "$(dirname $0)"/lib/probe.sh
> +skip_if_no_perf_trace || exit 2
> +
> +check_vmlinux() {
> +  echo "Checking if vmlinux exists"
> +  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
> +  then
> +    echo "trace+enum test [Skipped missing vmlinux BTF support]"
> +    err=2
> +  fi
> +}
> +
> +trace_landlock() {
> +  echo "Tracing syscall ${syscall}"
> +  if perf trace -e $syscall $TESTPROG 2>&1 | \
> +     grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
> +  then
> +    err=0
> +  else
> +    err=1
> +  fi
> +}
> +
> +trace_non_syscall() {
> +  echo "Tracing non-syscall tracepoint ${non-syscall}"
> +  if perf trace -e $non_syscall --max-events=1 2>&1 | \
> +     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
> +  then
> +    err=0
> +  else
> +    err=1
> +  fi
> +}
> +
> +check_vmlinux
> +
> +if [ $err = 0 ]; then
> +  trace_landlock
> +fi
> +
> +if [ $err = 0 ]; then
> +  trace_non_syscall
> +fi
> +
> +exit $err
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 3aa7701ee0e9..69126299bb08 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
>  DECLARE_WORKLOAD(sqrtloop);
>  DECLARE_WORKLOAD(brstack);
>  DECLARE_WORKLOAD(datasym);
> +DECLARE_WORKLOAD(landlock_add_rule);
>  
>  extern const char *dso_to_test;
>  extern const char *test_objdump_path;
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index a1f34d5861e3..5b12b93ecffa 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -6,6 +6,7 @@ perf-y += leafloop.o
>  perf-y += sqrtloop.o
>  perf-y += brstack.o
>  perf-y += datasym.o
> +perf-y += landlock_add_rule.o
>  
>  CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/landlock_add_rule.c b/tools/perf/tests/workloads/landlock_add_rule.c
> new file mode 100644
> index 000000000000..529b5f1ea5a7
> --- /dev/null
> +++ b/tools/perf/tests/workloads/landlock_add_rule.c
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/compiler.h>
> +#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
> +#include <unistd.h>
> +#include <linux/landlock.h>

This file was introduced on linux in 2021, unsure if it will be present
in some of the older distros we test, I'll check with my container test
suite.

Maybe we'll have to just define those LANDLOCK_ACCESS_FS_READ_FILE,
LANDLOCK_ACCESS_NET_CONNECT_TCP, etc as plain #define to make sure it
builds ok with uCLibc, musl libc and older glibc.

- Arnaldo

> +#include "../tests.h"
> +
> +static int landlock_add_rule(int argc __maybe_unused, const char **argv __maybe_unused)
> +{
> +	int fd = 11;
> +	int flags = 45;
> +
> +	struct landlock_path_beneath_attr path_beneath_attr = {
> +	    .allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
> +	    .parent_fd = 14,
> +	};
> +
> +	struct landlock_net_port_attr net_port_attr = {
> +	    .port = 19,
> +	    .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	};
> +
> +	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
> +		&path_beneath_attr, flags);
> +
> +	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
> +		&net_port_attr, flags);
> +
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(landlock_add_rule);
> -- 
> 2.45.2
> 
