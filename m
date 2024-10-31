Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A574C80;
	Thu, 31 Oct 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403209; cv=none; b=S0XK111eSM2bJLtvsSIuNB5gk5E3K87/6CRUAPi8uAwVN9Km8laNk4xFlZV1ZqP5zpTTZUeuE93jod2cSv168mEp7Y4iSVXkkkqzeZzgLGIKt9SEEIas3j4khhxS3vxLuIQ/QRsiWFerP0JPsWdA6XJ5JxRAXhLZepL7d4fnPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403209; c=relaxed/simple;
	bh=8T4Zv392sdQH71AUU0geXyuXvlgzntF7zrArxAKPUfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULW5Y3xHUDPVnxFVbxsbz757g8nVud49bcZmNBDoDwsp+HdeuwyYwRy3D/asIJPkTAHCPJLagqQQ18fpoON6lwNtZAslz9ej4zPcN21vbUTYhfCSjkyJpEu5lK0sQZvkclqSOtv4uds4ZJeOMzDHsGGcVTW568e9Tz2xY6egQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X03OYFeu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X03OYFeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDD6C4CEC3;
	Thu, 31 Oct 2024 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730403206;
	bh=8T4Zv392sdQH71AUU0geXyuXvlgzntF7zrArxAKPUfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X03OYFeujB4MzKIvqJph5AhTd7SB0UIqDqi9P9t88hS1T2+kuuWz2U10fxZLYZIYd
	 7BODMvzj6+VtqCAYbIkY97Sdj1BDTxBq7k7davVsZGaLIYnNZY7xc/LE70O33u7k/j
	 qKMRt3h0nzjIPyZ1FNZ5D6cuKYmtWFrm7+B/JeEAsvG1iDP2FF1tQxDSgzKEQfutdL
	 GiWu5JPQqK1k25elra46Ex5tOJBgT8pNpKR1kWZonYCj++/YUkh6QDk5wkgnow25SA
	 l13oCeAn6KWEpDZbHsfImHQYXBMz5zpDbixKVkTCkroon732+TMsK14yRnFybGPe3W
	 n3/MOeT8zoHTQ==
Date: Thu, 31 Oct 2024 16:33:22 -0300
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
Subject: Re: [PATCH v5 09/21] perf script: Move script_fetch_insn to
 trace-event-scripting.c
Message-ID: <ZyPbggG8jC9MYQbo@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-10-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:40PM -0700, Ian Rogers wrote:
> Add native_arch as a parameter to script_fetch_insn rather than
> relying on the builtin-script value that won't be initialized for the
> dlfilter and python Context use cases. Assume both of those cases are
> running natively.

Adrian, can you take a look? Maybe have some machine__native_arch() that
would use the perf_env struct, uname, etc?

So, as you noticed builtin-script.c does it, sets a global variable

        uname(&uts);
        if (data.is_pipe) { /* Assume pipe_mode indicates native_arch */
                native_arch = true;
        } else if (session->header.env.arch) {
                if (!strcmp(uts.machine, session->header.env.arch))
                        native_arch = true;
                else if (!strcmp(uts.machine, "x86_64") &&
                         !strcmp(session->header.env.arch, "i386"))
                        native_arch = true;
        }

So instead of doing it we should move that global variable to
env->native_arch and then use it?

Your patch doesn't introduce problems and shows this is a limitation, so
no problem with it being merged:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

But maybe this would be the time to try to fix this? Adrian,
cross-platform use of dlfilter seems not to be something you would be
interested on, but using a python script to process something from
another arch is interesting, as we advertise cross-platorm perf.data
file analysis as a feature for perf.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c                       | 15 +--------------
>  .../perf/scripts/python/Perf-Trace-Util/Context.c |  2 +-
>  tools/perf/util/dlfilter.c                        |  3 ++-
>  tools/perf/util/python.c                          |  6 ------
>  tools/perf/util/trace-event-scripting.c           | 14 ++++++++++++++
>  tools/perf/util/trace-event.h                     |  2 +-
>  6 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 11c0ee8c1afc..22d78a9d8f27 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1586,19 +1586,6 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  	return len + dlen;
>  }
>  
> -__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
> -			    struct thread *thread __maybe_unused,
> -			    struct machine *machine __maybe_unused)
> -{
> -}
> -
> -void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
> -		       struct machine *machine)
> -{
> -	if (sample->insn_len == 0 && native_arch)
> -		arch_fetch_insn(sample, thread, machine);
> -}
> -
>  static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  				     struct evsel *evsel,
>  				     struct perf_event_attr *attr,
> @@ -1608,7 +1595,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  {
>  	int printed = 0;
>  
> -	script_fetch_insn(sample, thread, machine);
> +	script_fetch_insn(sample, thread, machine, native_arch);
>  
>  	if (PRINT_FIELD(INSNLEN))
>  		printed += fprintf(fp, " ilen: %d", sample->insn_len);
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> index d742daaa5d5a..60dcfe56d4d9 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> @@ -93,7 +93,7 @@ static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
>  	if (c->sample->ip && !c->sample->insn_len && thread__maps(c->al->thread)) {
>  		struct machine *machine =  maps__machine(thread__maps(c->al->thread));
>  
> -		script_fetch_insn(c->sample, c->al->thread, machine);
> +		script_fetch_insn(c->sample, c->al->thread, machine, /*native_arch=*/true);
>  	}
>  	if (!c->sample->insn_len)
>  		Py_RETURN_NONE; /* N.B. This is a return statement */
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 7d180bdaedbc..ddacef881af2 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -234,7 +234,8 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
>  			struct machine *machine = maps__machine(thread__maps(al->thread));
>  
>  			if (machine)
> -				script_fetch_insn(d->sample, al->thread, machine);
> +				script_fetch_insn(d->sample, al->thread, machine,
> +						  /*native_arch=*/true);
>  		}
>  	}
>  
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 3d938fe2de6a..22edadd64e5f 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1317,12 +1317,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
>  	return NULL;
>  }
>  
> -void script_fetch_insn(struct perf_sample *sample __maybe_unused,
> -		struct thread *thread __maybe_unused,
> -		struct machine *machine __maybe_unused)
> -{
> -}
> -
>  int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
>  			size_t sz __maybe_unused)
>  {
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index ad62d8e5a368..beac456260ae 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -13,6 +13,7 @@
>  #include <traceevent/event-parse.h>
>  #endif
>  
> +#include "archinsn.h"
>  #include "debug.h"
>  #include "trace-event.h"
>  #include "evsel.h"
> @@ -269,3 +270,16 @@ void setup_perl_scripting(void)
>  }
>  #endif
>  #endif
> +
> +__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
> +		     struct thread *thread __maybe_unused,
> +		     struct machine *machine __maybe_unused)
> +{
> +}
> +
> +void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
> +		       struct machine *machine, bool native_arch)
> +{
> +	if (sample->insn_len == 0 && native_arch)
> +		arch_fetch_insn(sample, thread, machine);
> +}
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index 81fceaf297ba..e0bb42e6509e 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -120,7 +120,7 @@ struct scripting_ops *script_spec__lookup(const char *spec);
>  int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
>  
>  void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
> -		       struct machine *machine);
> +		       struct machine *machine, bool native_arch);
>  
>  void setup_perl_scripting(void);
>  void setup_python_scripting(void);
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
