Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197E3232;
	Tue, 22 Oct 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579467; cv=none; b=Zq13bnH/K23IdWr97EViALkjMdcs/bK+d+MUlBRmKBWnsyh8EgLQMfMtMVi9Yt+imNBAOVfGzR6cWy891VjtkoLBHuVh3FqYoTOyGHZFDodq0DwLvKpun2TrvWwoNRiF81nxH3xc3wj86Gv2V1FVr091+MtzWUAxezL4644591c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579467; c=relaxed/simple;
	bh=WHYtqEj6eKwKaQm6D/1FwTR37a31xmIR32wf+Ihmaz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0VSCvdv51SMZZmNgjfdNM+ukPpz1GbM/yyE5zoR4E2klv3f7FmlgWVRr472n6AvuY/90LQBQ/+o1+bC58RIo4PgkeCXw+hr6cbc2slwRnb9pYpwyNmWcI5wnwGLtNuR7sA5HyW5LFPuMrriH+uu7wi2z/SbpHSCmto/eAWkao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFnAsAeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFnAsAeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B39C4CEC3;
	Tue, 22 Oct 2024 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729579467;
	bh=WHYtqEj6eKwKaQm6D/1FwTR37a31xmIR32wf+Ihmaz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFnAsAeEdY6SyMiSAgYxoAoT9xjguXn1VTQ+mZRPDFcIhyxr2cqnp3IAHLeryjOuT
	 OEEQScV+pbQNH6bdn5UEgv+Oqn8XYHU3H+12DGOHjUXPiY8O1EmwPLHHGWNiOrjGVi
	 xH0+A5Puuxmtj4qo2EyxpU7awfwSUdBVTOaAqAZkg2ObAyb5epWtn4Du4w7pID89f1
	 X5dCclHvHbuF77Yel2iZ+g4KjMezOCAKqTGiaca5xXK0asrtcCbYRdtKrQaPdp87Up
	 Y2vUX8hEYgItEBR4BRkBF+sfgW7dZrmB3hBEFisCi8vtbbYujDlyz5rQm8mklxy8Ww
	 KDAUafJmv6XpA==
Date: Mon, 21 Oct 2024 23:44:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 13/16] perf bench: Remove reference to cmd_inject
Message-ID: <ZxdJyRpCv7dmmin9@google.com>
References: <20241016042415.7552-1-irogers@google.com>
 <20241016042415.7552-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016042415.7552-14-irogers@google.com>

On Tue, Oct 15, 2024 at 09:24:12PM -0700, Ian Rogers wrote:
> Avoid `perf bench internals inject-build-id` referencing the
> cmd_inject sub-command that requires perf-bench to backward reference
> internals of builtins. Replace the reference to cmd_inject with a call
> to main. To avoid python.c needing to link with something providing
> main, drop the libperf-bench library from the python shared object.

Looks like a clever trick!  But I guess by removing libperf-bench from
the python object, you can remove the reference to cmd_inject, right?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf          |  7 +++++--
>  tools/perf/bench/inject-buildid.c | 13 +++++++------
>  tools/perf/util/python.c          |  6 ------
>  3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 105f734b6820..e54c6953cf02 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -487,6 +487,9 @@ endif
>  EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
>  LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>  
> +PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
> +LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
> +
>  export INSTALL SHELL_PATH
>  
>  ### Build rules
> @@ -735,9 +738,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
>  # Create python binding output directory if not already present
>  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>  
> -$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS)
> +$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
>  	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> -        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
> +        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  --quiet build_ext; \
>  	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> index a759eb2328be..f55c07e4be94 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -52,7 +52,7 @@ struct bench_dso {
>  static int nr_dsos;
>  static struct bench_dso *dsos;
>  
> -extern int cmd_inject(int argc, const char *argv[]);
> +extern int main(int argc, const char **argv);
>  
>  static const struct option options[] = {
>  	OPT_UINTEGER('i', "iterations", &iterations,
> @@ -294,7 +294,7 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
>  
>  	if (data->pid == 0) {
>  		const char **inject_argv;
> -		int inject_argc = 2;
> +		int inject_argc = 3;
>  
>  		close(data->input_pipe[1]);
>  		close(data->output_pipe[0]);
> @@ -318,15 +318,16 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
>  		if (inject_argv == NULL)
>  			exit(1);
>  
> -		inject_argv[0] = strdup("inject");
> -		inject_argv[1] = strdup("-b");
> +		inject_argv[0] = strdup("perf");
> +		inject_argv[1] = strdup("inject");
> +		inject_argv[2] = strdup("-b");
>  		if (build_id_all)
> -			inject_argv[2] = strdup("--buildid-all");
> +			inject_argv[3] = strdup("--buildid-all");
>  
>  		/* signal that we're ready to go */
>  		close(ready_pipe[1]);
>  
> -		cmd_inject(inject_argc, inject_argv);
> +		main(inject_argc, inject_argv);
>  
>  		exit(0);
>  	}
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 91fd444615cd..c52da509ae58 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -19,7 +19,6 @@
>  #include "util/kwork.h"
>  #include "util/sample.h"
>  #include <internal/lib.h>
> -#include "../builtin.h"
>  
>  #define _PyUnicode_FromString(arg) \
>    PyUnicode_FromString(arg)
> @@ -1309,8 +1308,3 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
>  {
>  	return NULL;
>  }
> -
> -int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
> -{
> -	return -1;
> -}
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 
