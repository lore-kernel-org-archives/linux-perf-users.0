Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEE2E628;
	Fri, 16 May 2025 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421558; cv=none; b=YPjDC22Nh0zIWtuaF0xFJoySFbDht/ufU9ZMMGj1gL07nrUzWlDENetI1vOdTkcgcMXWurfL7GslUtldD2NmqHiisUZtkW7Eh00wQXWL52xOk7oxcAucSxEIuQRuBa8Vw3HRAarcEnNBFeN7aNb/OzgyhfysE2zoqbiyZjTvB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421558; c=relaxed/simple;
	bh=zXaFmKtYvxT1j0vntEjkNxw6Li9LE0OuJj+y7y/sOXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvlXBaL9OvTOUkYNkOXagmlJ+B9IkRAyFCfeyOmd33pCKL2fuOIf0KNlJe/xzBxmXdh5q6TnE+MSA4nSgZsssnGozXsvWKNnR57IJFav5x6j/Vu2VCuHnu3uXbpahYo3wVkdLzrnb8Aco1MF0QRU27ndHTd9R7u0n2xVHzn0fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVAaj7iG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVAaj7iG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5F7C4CEE4;
	Fri, 16 May 2025 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747421558;
	bh=zXaFmKtYvxT1j0vntEjkNxw6Li9LE0OuJj+y7y/sOXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVAaj7iGsctiE3WKPqwzDeYjR+rdu9/KJdURClx3ZFSRWPuuJ/Us+d3mgyHpYMqkD
	 8m/iNDkZYRoqzVE5B1fCnfmZSWUKRZeY+M59DOFEQJn0FwHlxo2OIyGvXEYkx+2SFn
	 qFAWKvFz3CDyC6p9X4GLBwAQrADgtjmbRNNbiFzESV4fAOENnRMTeyYjy9t20Y2j7u
	 keY/TsKD0EUYDPMWK6CYi6IMIe99GzZrCBFJFUfoFaWBbbzWa4SfXAkHYrtt+YJjQJ
	 ODSoHX+Xi7TkpLykzmFqi3Ka2tXt7onPwPPVZx6MTIvGXwepaynGGEADZW5kt8VbzK
	 kB0gunjVKT3Hg==
Date: Fri, 16 May 2025 15:52:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux390-list@tuxmaker.boeblingen.de.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf ftrace: Use process/session specific trace settings
Message-ID: <aCeJcsJnbi7jfVdK@x1>
References: <20250516131023.357458-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516131023.357458-1-tmricht@linux.ibm.com>

On Fri, May 16, 2025 at 03:10:23PM +0200, Thomas Richter wrote:
> Executing perf ftrace commands ftrace, profile and latency
> leave tracing disabled as can seen in this output:

You forgot to CC lkml and linux-perf-users mailing list, I'm doing it
now, noticed when b4 didn't manage to find it.

Thanks for working on this! From a quick glance it looks great, I'm
testing it now.

- Arnaldo
 
>  # echo 1 > /sys/kernel/debug/tracing/tracing_on
>  # cat /sys/kernel/debug/tracing/tracing_on
>  1
>  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
>  # cat /sys/kernel/debug/tracing/tracing_on
>  0
>  #
> 
> The tracing_on file is not restored to its value before the command.
> Fix this behavior and restore the trace setting to what
> is was before the invocation of the command.
> On Fedora 41 and 42 tracing is turned on by default.
> 
> This patch use the .../tracing/instances/XXX subdirectory feature.
> Each perf ftrace invocation creates its own session/process
> specific subdirectory and does not change the global state
> in the .../tracing directory itself.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  tools/perf/builtin-ftrace.c | 79 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 7caa18d5ffc3..f523039c585f 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -38,6 +38,8 @@
>  #include "util/units.h"
>  #include "util/parse-sublevel-options.h"
>  
> +#include <sys/stat.h>
> +
>  #define DEFAULT_TRACER  "function_graph"
>  
>  static volatile sig_atomic_t workload_exec_errno;
> @@ -45,6 +47,8 @@ static volatile sig_atomic_t done;
>  
>  static struct stats latency_stats;  /* for tracepoints */
>  
> +static char tracing_instance[PATH_MAX];	/* Trace instance directory */
> +
>  static void sig_handler(int sig __maybe_unused)
>  {
>  	done = true;
> @@ -100,6 +104,34 @@ static bool is_ftrace_supported(void)
>  	return supported;
>  }
>  
> +/*
> + * Wrapper to test if a file in directory .../tracing/instances/XXX
> + * exists. If so return the .../tracing/instances/XXX file for use.
> + * Otherwise the file exists only in directory .../tracing and
> + * is applicable to all instances, for example file available_filter_functions.
> + * Return that file name in this case.
> + *
> + * This functions works similar to get_tracing_file() and expects its caller
> + * to free the returned file name.
> + *
> + * The global variable tracing_instance is set in init_tracing_instance()
> + * called a the  beginning to a process specific tracing subdirectory.
> + */
> +static char *get_tracing_instance_file(const char *name)
> +{
> +	char *file;
> +
> +	if (asprintf(&file, "%s/%s", tracing_instance, name) < 0)
> +		return NULL;
> +
> +	if (!access(file, F_OK))
> +		return file;
> +
> +	put_tracing_file(file);
> +	file = get_tracing_file(name);
> +	return file;
> +}
> +
>  static int __write_tracing_file(const char *name, const char *val, bool append)
>  {
>  	char *file;
> @@ -109,7 +141,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>  	char errbuf[512];
>  	char *val_copy;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -167,7 +199,7 @@ static int read_tracing_file_to_stdout(const char *name)
>  	int fd;
>  	int ret = -1;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -209,7 +241,7 @@ static int read_tracing_file_by_line(const char *name,
>  	char *file;
>  	FILE *fp;
>  
> -	file = get_tracing_file(name);
> +	file = get_tracing_instance_file(name);
>  	if (!file) {
>  		pr_debug("cannot get tracing file: %s\n", name);
>  		return -1;
> @@ -299,6 +331,36 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>  	return 0;
>  }
>  
> +/* Remove .../tracing/instances/XXX subdirectory created with
> + * init_tracing_instance().
> + */
> +static void exit_tracing_instance(void)
> +{
> +	rmdir(tracing_instance);
> +}
> +
> +/* Create subdirectory within .../tracing/instances/XXX to have session
> + * or process specific setup. To delete this setup, simply remove the
> + * subdirectory.
> + */
> +static int init_tracing_instance(void)
> +{
> +	char dirname[] = "instances/perf-ftrace-XXXXXX";
> +	char *path;
> +
> +	path = get_tracing_file(dirname);
> +	if (!path)
> +		return -1;
> +	strcpy(tracing_instance, path);
> +	put_tracing_file(path);
> +	path = mkdtemp(tracing_instance);
> +	if (!path) {
> +		pr_err("failed to create tracing/instances directory\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int set_tracing_pid(struct perf_ftrace *ftrace)
>  {
>  	int i;
> @@ -648,7 +710,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  
>  	setup_pager();
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
> @@ -942,7 +1004,7 @@ static int prepare_func_latency(struct perf_ftrace *ftrace)
>  		return -1;
>  	}
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		return -1;
> @@ -1323,7 +1385,7 @@ static int __cmd_profile(struct perf_ftrace *ftrace)
>  
>  	setup_pager();
>  
> -	trace_file = get_tracing_file("trace_pipe");
> +	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
> @@ -1740,6 +1802,9 @@ int cmd_ftrace(int argc, const char **argv)
>  	if (!argc && target__none(&ftrace.target))
>  		ftrace.target.system_wide = true;
>  
> +	if (init_tracing_instance())
> +		goto out_delete_filters;
> +
>  	switch (subcmd) {
>  	case PERF_FTRACE_TRACE:
>  		cmd_func = __cmd_ftrace;
> @@ -1839,5 +1904,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	delete_filter_func(&ftrace.graph_funcs);
>  	delete_filter_func(&ftrace.nograph_funcs);
>  
> +	exit_tracing_instance();
> +
>  	return ret;
>  }
> -- 
> 2.49.0
