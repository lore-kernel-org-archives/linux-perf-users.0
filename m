Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326A41C89;
	Tue, 18 Jun 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733372; cv=none; b=GYJ7GJLuHoJLz/c4tij0STkdElABT5XqL4AeK39+bJ4jq9Kbsr/xVyx2tyvd8fQdv1dH4uqPU+O0O0PfVOa4w+LJpZ0Y2thsky4eLsCd0eA6+xKcTVvhtLiHBh98s40MAq48zwgiSEydwpPFUjY5H9dtZEw9dUHyn0Lh2vGGYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733372; c=relaxed/simple;
	bh=+ouZkMb6OPt6rOGE+OpfwKOpmrEq55LDoi2O71YHst0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1fOev8SuiEl9ruNmXE+t9tPDAXN9ATR9rGwn8T/OYvGfM2WcKhd/mOy/kmRr+iynS/Pqg2w9Y7LcM8iVs4mERVMPpsS5nqcA3OSa6sF/Mw7H6d/SOHtDlP6ohK/jC6VVX8Fq9p7rRtGBioExUVeBDvEAiUP/I/aD7SFbCt74/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECWHyF+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECWHyF+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A70AC3277B;
	Tue, 18 Jun 2024 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718733372;
	bh=+ouZkMb6OPt6rOGE+OpfwKOpmrEq55LDoi2O71YHst0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECWHyF+aIDHlNpn5pxzycRJ4y6nojDmXufqIRiH6LwfU1Kl5pZ04sOfXbcpoI7wk3
	 SM11dlJFdEvV27zxZmswP9ABFL5lHdYQKjHZtgz8a5fB0x7FoNWyyogEdzWyhvS56n
	 fel/7OKMHQfdff1awhpOEy51cKHtW40EOeOPDioMflBQ+qsLN+5Go99ny1ljOx+jJC
	 pgFP0YqwYjpjGTjjeqgkLAW3NrVwS28dxZaw1o1/+egnsxEYXdigGbf2M/EHYOWgvo
	 2h1FFVir73XM6guIUJkmJL8bYZS5PgYBjo7PGpWiZQlRaSS7Tu+szdGA2nOB34seYJ
	 vPUg7iRXxSbog==
Date: Tue, 18 Jun 2024 14:56:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 5/5] perf trace: Add test for enum augmentation
Message-ID: <ZnHKOKFgJSaJA9UI@x1>
References: <20240618152652.3446472-1-howardchu95@gmail.com>
 <20240618152652.3446472-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618152652.3446472-6-howardchu95@gmail.com>

On Tue, Jun 18, 2024 at 11:26:52PM +0800, Howard Chu wrote:
> Check for vmlinux's existence in sysfs as prerequisite.

That is good, well done, but then we need to check if gcc is installed,
and it may not be and we want to test this feature even so.

So please take a look at git log tools/perf/tests/workloads/, then add a
tools/perf/tests/workloads/landlock_add_rule.c and finally you'll be
able to replace the inline landlock .c file + gcc to build it and
instead use:

  perf test -w landlock_add_rule

As your workload.

Then you update the last patch in your series, test it all and resend
the whole series with a v2, with the description of v1 and v2 in the
cover letter.

Thanks,

- Arnaldo
 
> Compile and run a script which calls landlock_add_rule syscall,
> trace the syscall to judge if the output is desirable.
> 
> Trace the non-syscall tracepoint 'timer:hrtimer_init' and
> 'timer:hrtimer_start', see if the 'mode' argument is augmented,
> the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
> in its name.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_enum.sh | 104 +++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
> 
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
> new file mode 100755
> index 000000000000..14c73b0b594d
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -0,0 +1,104 @@
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
> +landlock_script=$(mktemp /tmp/landlock-XXXXX.c)
> +landlock_ex=$(echo $landlock_script | sed -E 's/(.*).c$/\1/g')
> +
> +landlock_fd=24
> +landlock_flags=25
> +
> +. "$(dirname $0)"/lib/probe.sh
> +skip_if_no_perf_trace || exit 2
> +
> +enum_aug_prereq() {
> +  echo "Checking perf trace enum augmentation prerequisites"
> +  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
> +  then
> +    echo "trace+enum test [Skipped missing vmlinux BTF support]"
> +    err=2
> +    return
> +  fi
> +}
> +
> +prepare_landlock_script() {
> +  echo "Preparing script for ${syscall} syscall"
> +
> +  cat > $landlock_script << EOF
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <linux/landlock.h>
> +#include <sys/syscall.h>
> +
> +int main()
> +{
> +	int fd = ${landlock_fd};
> +	int flags = ${landlock_flags};
> +	struct landlock_path_beneath_attr path_beneath_attr = {
> +	    .allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
> +	};
> +	struct landlock_net_port_attr net_port_attr = {
> +	    .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	    .port = 443,
> +	};
> +
> +	syscall(SYS_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
> +		&path_beneath_attr, flags);
> +
> +	syscall(SYS_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
> +		&net_port_attr, flags);
> +
> +	return 0;
> +}
> +EOF
> +
> +  gcc $landlock_script -o $landlock_ex
> +}
> +
> +trace_landlock() {
> +  echo "Tracing syscall ${syscall}"
> +  if perf trace -e $syscall $landlock_ex 2>&1 | \
> +     grep -q -E ".*landlock_add_rule\(ruleset_fd: ${landlock_fd}, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: ${landlock_flags}\) = -1.*"
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
> +cleanup() {
> +  rm -f $landlock_script $landlock_ex
> +}
> +
> +enum_aug_prereq
> +
> +prepare_landlock_script
> +
> +if [ $err = 0 ]; then
> +  trace_landlock
> +fi
> +
> +if [ $err = 0 ]; then
> +  trace_non_syscall
> +fi
> +
> +cleanup
> +
> +exit $err
> -- 
> 2.45.2
> 
