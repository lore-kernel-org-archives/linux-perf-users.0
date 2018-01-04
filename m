From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf-probe: Ensure debuginfo's build-id is correct
Date: Thu, 4 Jan 2018 13:17:28 -0300
Message-ID: <20180104161728.GC14721@kernel.org>
References: <151358211494.25261.16134489192749792799.stgit@devbox>
 <151358214328.25261.6660021248431426149.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <151358214328.25261.6660021248431426149.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Dec 18, 2017 at 04:29:03PM +0900, Masami Hiramatsu escreveu:
> Ensure that the build-id of debuginfo is correctly
> matched to target build-id, if not, it warns user
> to check the system debuginfo package is correctly
> installed.

So we look at a variety of files looking for one that has a matching
build-id, I think the warning message should state that the file with
the unmatched build-id is simply being skipped, no?

And why do this at 'perf probe -l' time? I.e. at that point whatever
probes that are in place already have all the needed debug info?

I.e. the warning should be done at probe creation time only?

- Arnaldo
 
> E.g. on such environment, you will see below warning.
>   ======
>   # perf probe -l
>   WARN: There is a build-id mismatch between
>    /usr/lib/debug/usr/lib64/libc-2.25.so.debug
>    and
>    /usr/lib64/libc-2.25.so
>   Please check your system's debuginfo files for mismatches, e.g. check
>   the versions for the target package and debuginfo package.
>     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /us
>   r/lib64/libc-2.25.so)
>   ======
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index a5731de0e5eb..5bb71e056b21 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -119,9 +119,11 @@ enum dso_binary_type distro_dwarf_types[] = {
>  
>  struct debuginfo *debuginfo__new(const char *path)
>  {
> +	u8 bid[BUILD_ID_SIZE], bid2[BUILD_ID_SIZE];
>  	enum dso_binary_type *type;
>  	char buf[PATH_MAX], nil = '\0';
>  	struct dso *dso;
> +	bool have_build_id = false;
>  	struct debuginfo *dinfo = NULL;
>  
>  	/* Try to open distro debuginfo files */
> @@ -129,12 +131,28 @@ struct debuginfo *debuginfo__new(const char *path)
>  	if (!dso)
>  		goto out;
>  
> +	if (filename__read_build_id(path, bid, BUILD_ID_SIZE) > 0)
> +		have_build_id = true;
> +
>  	for (type = distro_dwarf_types;
>  	     !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
>  	     type++) {
>  		if (dso__read_binary_type_filename(dso, *type, &nil,
>  						   buf, PATH_MAX) < 0)
>  			continue;
> +
> +		if (have_build_id) {
> +			/* This can be fail because the file doesn't exist */
> +			if (filename__read_build_id(buf, bid2,
> +						    BUILD_ID_SIZE) < 0)
> +				continue;
> +			if (memcmp(bid, bid2, BUILD_ID_SIZE)) {
> +				pr_warning("WARN: There is a build-id mismatch between\n %s\n and\n %s\n"
> +					"Please check your system's debuginfo files for mismatches, e.g. check the "
> +					"versions for the target package and debuginfo package.\n", buf, path);
> +				continue;
> +			}
> +		}
>  		dinfo = __debuginfo__new(buf);
>  	}
>  	dso__put(dso);
