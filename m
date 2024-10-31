Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049251CB320;
	Thu, 31 Oct 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403298; cv=none; b=c/lazZDNwF2QD/X68/tdK29H5wGkEDT+fZOzRYAqVHIP73/iT5dpn4brXbeGQXbuUqB0W35Z96Q8Q8+MjZI372imOZEq9HcpKP6VjNm5vQZkFlgzhZpoaI1GcHhzcF0MCH0VryjugnTDyYYDIzsyFZ6YamVkHf5ybJMBzvKbXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403298; c=relaxed/simple;
	bh=KZV72x+uPb/4NWiZ+qO56AMv3VJRMCWlj/lK/kggwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5/wXeJ4A92YBM6fyGkr4x/5fr9ceLqEIp4BAdyXUYBJ79z+ejz1xfNKJv3ITeCO1zaCS2H2aGn5wylrke2rIicNvSAmovL+6afJCJwdS4GpXZGbRaiNy07a/2VWOuB3fO+G+kdcXUN1VLOaPB13N5fEA4/wj1YVCeVcE1Au5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPjKOWLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPjKOWLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52E7C4CEC3;
	Thu, 31 Oct 2024 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730403297;
	bh=KZV72x+uPb/4NWiZ+qO56AMv3VJRMCWlj/lK/kggwCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPjKOWLu32tupKE1j2UGTyYe0bkI0cG0tJ/AhgDZbZdHXjnUSBg2hrWP93XIZ0LEU
	 DJb8dUUrcaseVlz0fqUOUqoQG56I4tSxhQJNd39h646WM0FG/dDAjCcpo6BK56/Hhw
	 YdsGej0v3/ER/AzSTjOZPVZB3LA6YJXycY+xS2fJdbQ+t8CTNzhgQZakktAtuUn6s+
	 tI1X4pEpALPI45dqo4uUoBoN4RdfmxsicwnonDpC9iZlTHxzGmVRoUQD0UuGXlTTUl
	 9HJxxbO0J4OLGbIL7DGGIxyWNq+M/YSF7ivu0B4V4Vnavs5kPLMFUOjVQkyHDEE1Yf
	 jURp0tk0MD9sw==
Date: Thu, 31 Oct 2024 16:34:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 13/21] perf env: Move arch errno function to only use
 in env
Message-ID: <ZyPb3ckI9-wRA1hE@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-14-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:44PM -0700, Ian Rogers wrote:
> Move arch_syscalls__strerrno_function out of builtin-trace.c to env.c
> so that there isn't a util to builtin function call. This allows the
> python.c stub to be removed. Also, remove declaration/prototype from
> env.h and make static to reduce scope. The include is moved inside
> ifdefs to avoid, "defined but unused warnings".

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c                  | 1 -
>  tools/perf/trace/beauty/arch_errno_names.sh | 3 ++-
>  tools/perf/util/env.c                       | 4 ++++
>  tools/perf/util/env.h                       | 2 --
>  tools/perf/util/python.c                    | 6 ------
>  5 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 748b061f8678..5d0345480140 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1108,7 +1108,6 @@ static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size _
>  	    .strtoul	= STUL_STRARRAY_FLAGS, \
>  	    .parm	= &strarray__##array, }
>  
> -#include "trace/beauty/arch_errno_names.c"
>  #include "trace/beauty/eventfd.c"
>  #include "trace/beauty/futex_op.c"
>  #include "trace/beauty/futex_val3.c"
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> index 30d3889b2957..b22890b8d272 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -57,7 +57,8 @@ create_arch_errno_table_func()
>  	archlist="$1"
>  	default="$2"
>  
> -	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
> +	printf 'static arch_syscalls__strerrno_t *\n'
> +	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
>  	printf '{\n'
>  	for arch in $archlist; do
>  		arch_str=$(arch_string "$arch")
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index ccb464026642..e58f56412fbb 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -470,6 +470,10 @@ const char *perf_env__arch(struct perf_env *env)
>  	return normalize_arch(arch_name);
>  }
>  
> +#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> +#include "trace/beauty/arch_errno_names.c"
> +#endif
> +
>  const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
>  {
>  #if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index ae604c4edbb7..e9db89395dab 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -56,8 +56,6 @@ struct pmu_caps {
>  
>  typedef const char *(arch_syscalls__strerrno_t)(int err);
>  
> -arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
> -
>  struct perf_env {
>  	char			*hostname;
>  	char			*os_release;
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 77e02fcc51dd..35d84a96dbec 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -16,7 +16,6 @@
>  #include "thread_map.h"
>  #include "trace-event.h"
>  #include "mmap.h"
> -#include "util/env.h"
>  #include "util/kwork.h"
>  #include "util/sample.h"
>  #include "util/lock-contention.h"
> @@ -1305,11 +1304,6 @@ PyMODINIT_FUNC PyInit_perf(void)
>  /* The following are stubs to avoid dragging in builtin-* objects. */
>  /* TODO: move the code out of the builtin-* file into util. */
>  
> -arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
> -{
> -	return NULL;
> -}
> -
>  struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
>  				       struct kwork_class *class __maybe_unused,
>  				       struct kwork_work *key  __maybe_unused)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
