Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDE19F110;
	Tue, 22 Oct 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605389; cv=none; b=byqw8+0rgcVwyqAJJE56CpR3KywmDs+Bf+kZ5S7hfIc8BPeSIBW3dE1AfEPxWOJ0i+TZBL2K+w+MZMFYSMBaww8A8zpmFvumC4aWWq5BSDJjLOKsi45gRWNQsHNrM2x+qLfGZchd45ErHUGfoqOws17PlHdkXM7EhQKocF1f6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605389; c=relaxed/simple;
	bh=m5faiZiXH0sZfUD1f+n/MRgUq0jphIsF3zOVGC0qRY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uu/8noOtWgdmD3Zeb0ROmLaBnCQAmdqK1uVa1rRCMpj1bdXkvtFlrxX2ZGlERN3DYdtHM6HiQZKHc8bephEYr7EncSch9otnFHjId4pvN8nxzGJz7eQNZyblCWNVK0Ai7F0fwqGst0VZvmd8LlbEzVHCOtmi1hNRu5Ep8wxcDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/eq02AT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/eq02AT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729605387; x=1761141387;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=m5faiZiXH0sZfUD1f+n/MRgUq0jphIsF3zOVGC0qRY8=;
  b=c/eq02ATGTNQPbSJ0T90nphUhePTi7FgL9SPGRRJiqoudkIT1F1ANQL1
   XYPmWlUMCBdFW5oKxK7gp/B2fXF1dhLx68lrjcdgRVEWRs4viRx597cNU
   lTHNT8akl0iy9tDtsh/q2AUQRfFEzb6AnROS/36hLcZWO8xaqdTV060oV
   EAx16VtFyZ17XI9Ntuvbq3qaa96IjfvXCQn8Us72Shv/EoR5BZ7IiDrF5
   OfgqL+8gMOy6LNsdAEQIJZIy4BCTV8x+vYcyTV9yGqVsy+lVQTIfr4XqA
   cgggLzNkrt2UFcsdvWuEtF+2Rg22ePc+avWPe/8JbKJrK2NhjRZYtMeWn
   A==;
X-CSE-ConnectionGUID: 5eqf/PBuR8iZD2gocF6qkQ==
X-CSE-MsgGUID: JUS7Vy1MTX+JRdQwFmf0tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32834922"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32834922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:56:25 -0700
X-CSE-ConnectionGUID: ZAL3GuNATW+rpZakgcKwWg==
X-CSE-MsgGUID: np0gEmqqSymJ53nvWs0QAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80293549"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:56:20 -0700
Message-ID: <cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com>
Date: Tue, 22 Oct 2024 16:56:16 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf cap: Tidy up and improve capability testing
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 James Clark <james.clark@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Leo Yan <leo.yan@linux.dev>, Changbin Du <changbin.du@huawei.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806220614.831914-1-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240806220614.831914-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/08/24 01:06, Ian Rogers wrote:
> Remove dependence on libcap. libcap is only used to query whether a
> capability is supported, which is just 1 capget system call.
> 
> If the capget system call fails, fall back on root permission
> checking. Previously if libcap fails then the permission is assumed
> not present which may be pessimistic/wrong.
> 
> Add a used_root out argument to perf_cap__capable to say whether the
> fall back root check was used. This allows the correct error message,
> "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
> be selected.
> 
> Tidy uses of perf_cap__capable so that tests aren't repeated if capget
> isn't supported.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

I find I need to revert this.  E.g.

$ install-perf.sh
$ perf record -e intel_pt//k uname
WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
check /proc/sys/kernel/kptr_restrict and
/proc/sys/kernel/perf_event_paranoid.

Samples in kernel functions may not be resolved if a suitable vmlinux
file is not found in the buildid cache or in the vmlinux path.

Samples in kernel modules won't be resolved at all.

If some relocation was applied (e.g. kexec) symbols may be misresolved
even with a suitable vmlinux or kallsyms file.

Couldn't record kernel reference relocation symbol
Symbol resolution may be skewed if relocation was used (e.g. kexec).
Check /proc/kallsyms permission or run as root.
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB perf.data ]
$ git revert e25ebda78e230283bf707ae3e9655270ff40a7f9
Auto-merging tools/perf/Makefile.config
Auto-merging tools/perf/builtin-ftrace.c
Auto-merging tools/perf/util/Build
Auto-merging tools/perf/util/symbol.c
[master 752707588a700] Revert "perf cap: Tidy up and improve capability
testing"
 7 files changed, 70 insertions(+), 73 deletions(-)
$ install-perf.sh
$ perf record -e intel_pt//k uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.065 MB perf.data ]





> ---
> v3: rebase resolving builtin-ftrace.c conflicts and incorporating
>     change in:
> https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.org/
> v2: fix syscall number and '>' should have been '>='.
> ---
>  tools/perf/Makefile.config  | 11 -------
>  tools/perf/builtin-ftrace.c | 28 ++++++++---------
>  tools/perf/util/Build       |  2 +-
>  tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
>  tools/perf/util/cap.h       | 23 ++------------
>  tools/perf/util/symbol.c    |  8 ++---
>  tools/perf/util/util.c      | 12 +++++--
>  7 files changed, 75 insertions(+), 72 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fa679db61f62..4eb1fc897baf 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1031,17 +1031,6 @@ ifndef NO_LIBZSTD
>    endif
>  endif
>  
> -ifndef NO_LIBCAP
> -  ifeq ($(feature-libcap), 1)
> -    CFLAGS += -DHAVE_LIBCAP_SUPPORT
> -    EXTLIBS += -lcap
> -    $(call detected,CONFIG_LIBCAP)
> -  else
> -    $(warning No libcap found, disables capability support, please install libcap-devel/libcap-dev)
> -    NO_LIBCAP := 1
> -  endif
> -endif
> -
>  ifndef NO_BACKTRACE
>    ifeq ($(feature-backtrace), 1)
>      CFLAGS += -DHAVE_BACKTRACE_SUPPORT
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index a615c405d98f..88a87bf387d2 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -63,20 +63,21 @@ static void ftrace__workload_exec_failed_signal(int signo __maybe_unused,
>  	done = true;
>  }
>  
> -static int check_ftrace_capable(void)
> +static bool check_ftrace_capable(void)
>  {
> -	if (!(perf_cap__capable(CAP_PERFMON) ||
> -	      perf_cap__capable(CAP_SYS_ADMIN))) {
> -		pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -		"root"
> -#endif
> +	bool used_root;
> +
> +	if (perf_cap__capable(CAP_PERFMON, &used_root))
> +		return true;
> +
> +	if (!used_root && perf_cap__capable(CAP_SYS_ADMIN, &used_root))
> +		return true;
> +
> +	pr_err("ftrace only works for %s!\n",
> +		used_root ? "root"
> +			  : "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
>  		);
> -		return -1;
> -	}
> -	return 0;
> +	return false;
>  }
>  
>  static int __write_tracing_file(const char *name, const char *val, bool append)
> @@ -1579,8 +1580,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
>  
> -	ret = check_ftrace_capable();
> -	if (ret < 0)
> +	if (!check_ftrace_capable())
>  		return -1;
>  
>  	ret = perf_config(perf_ftrace_config, &ftrace);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index b24360c04aae..adbaf7748019 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -221,7 +221,7 @@ perf-util-$(CONFIG_ZLIB) += zlib.o
>  perf-util-$(CONFIG_LZMA) += lzma.o
>  perf-util-$(CONFIG_ZSTD) += zstd.o
>  
> -perf-util-$(CONFIG_LIBCAP) += cap.o
> +perf-util-y += cap.o
>  
>  perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
>  perf-util-y += demangle-ocaml.o
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index c3ba841bbf37..7574a67651bc 100644
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c
> @@ -3,27 +3,52 @@
>   * Capability utilities
>   */
>  
> -#ifdef HAVE_LIBCAP_SUPPORT
> -
>  #include "cap.h"
> -#include <stdbool.h>
> -#include <sys/capability.h>
> -
> -bool perf_cap__capable(cap_value_t cap)
> -{
> -	cap_flag_value_t val;
> -	cap_t caps = cap_get_proc();
> +#include "debug.h"
> +#include <errno.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/capability.h>
> +#include <sys/syscall.h>
>  
> -	if (!caps)
> -		return false;
> +#ifndef SYS_capget
> +#define SYS_capget 90
> +#endif
>  
> -	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)
> -		val = CAP_CLEAR;
> +#define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
>  
> -	if (cap_free(caps) != 0)
> -		return false;
> -
> -	return val == CAP_SET;
> +bool perf_cap__capable(int cap, bool *used_root)
> +{
> +	struct __user_cap_header_struct header = {
> +		.version = _LINUX_CAPABILITY_VERSION_3,
> +		.pid = getpid(),
> +	};
> +	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> +	__u32 cap_val;
> +
> +	*used_root = false;
> +	while (syscall(SYS_capget, &header, &data[0]) == -1) {
> +		/* Retry, first attempt has set the header.version correctly. */
> +		if (errno == EINVAL && header.version != _LINUX_CAPABILITY_VERSION_3 &&
> +		    header.version == _LINUX_CAPABILITY_VERSION_1)
> +			continue;
> +
> +		pr_debug2("capget syscall failed (%s - %d) fall back on root check\n",
> +			  strerror(errno), errno);
> +		*used_root = true;
> +		return geteuid() == 0;
> +	}
> +
> +	/* Extract the relevant capability bit. */
> +	if (cap >= 32) {
> +		if (header.version == _LINUX_CAPABILITY_VERSION_3) {
> +			cap_val = data[1].effective;
> +		} else {
> +			/* Capability beyond 32 is requested but only 32 are supported. */
> +			return false;
> +		}
> +	} else {
> +		cap_val = data[0].effective;
> +	}
> +	return (cap_val & (1 << (cap & 0x1f))) != 0;
>  }
> -
> -#endif  /* HAVE_LIBCAP_SUPPORT */
> diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
> index ae52878c0b2e..0c6a1ff55f07 100644
> --- a/tools/perf/util/cap.h
> +++ b/tools/perf/util/cap.h
> @@ -3,26 +3,6 @@
>  #define __PERF_CAP_H
>  
>  #include <stdbool.h>
> -#include <linux/capability.h>
> -#include <linux/compiler.h>
> -
> -#ifdef HAVE_LIBCAP_SUPPORT
> -
> -#include <sys/capability.h>
> -
> -bool perf_cap__capable(cap_value_t cap);
> -
> -#else
> -
> -#include <unistd.h>
> -#include <sys/types.h>
> -
> -static inline bool perf_cap__capable(int cap __maybe_unused)
> -{
> -	return geteuid() == 0;
> -}
> -
> -#endif /* HAVE_LIBCAP_SUPPORT */
>  
>  /* For older systems */
>  #ifndef CAP_SYSLOG
> @@ -33,4 +13,7 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
>  #define CAP_PERFMON	38
>  #endif
>  
> +/* Query if a capability is supported, used_root is set if the fallback root check was used. */
> +bool perf_cap__capable(int cap, bool *used_root);
> +
>  #endif /* __PERF_CAP_H */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 19eb623e0826..a18927d792af 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2425,14 +2425,14 @@ static bool symbol__read_kptr_restrict(void)
>  {
>  	bool value = false;
>  	FILE *fp = fopen("/proc/sys/kernel/kptr_restrict", "r");
> +	bool used_root;
> +	bool cap_syslog = perf_cap__capable(CAP_SYSLOG, &used_root);
>  
>  	if (fp != NULL) {
>  		char line[8];
>  
>  		if (fgets(line, sizeof(line), fp) != NULL)
> -			value = perf_cap__capable(CAP_SYSLOG) ?
> -					(atoi(line) >= 2) :
> -					(atoi(line) != 0);
> +			value = cap_syslog ? (atoi(line) >= 2) : (atoi(line) != 0);
>  
>  		fclose(fp);
>  	}
> @@ -2440,7 +2440,7 @@ static bool symbol__read_kptr_restrict(void)
>  	/* Per kernel/kallsyms.c:
>  	 * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
>  	 */
> -	if (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))
> +	if (perf_event_paranoid() > 1 && !cap_syslog)
>  		value = true;
>  
>  	return value;
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 4f561e5e4162..9d55a13787ce 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -325,9 +325,15 @@ int perf_event_paranoid(void)
>  
>  bool perf_event_paranoid_check(int max_level)
>  {
> -	return perf_cap__capable(CAP_SYS_ADMIN) ||
> -			perf_cap__capable(CAP_PERFMON) ||
> -			perf_event_paranoid() <= max_level;
> +	bool used_root;
> +
> +	if (perf_cap__capable(CAP_SYS_ADMIN, &used_root))
> +		return true;
> +
> +	if (!used_root && perf_cap__capable(CAP_PERFMON, &used_root))
> +		return true;
> +
> +	return perf_event_paranoid() <= max_level;
>  }
>  
>  static int

