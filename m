Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6D347C7;
	Thu, 31 Oct 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402467; cv=none; b=OBqHT8ZZI1og0to0O5TgMM1er1g9fFpBFZF9iAmVo7ej5mvjgV5SGK/vvZAEyj1iGYgL4cAqQLEjHoAxmliwUYDKm7qnK9q17lYj7TYF+Xd4RHCIA/7OE2WeoXcekJ0qjzZycgnSBhsWwKklZcDI2Ew6TTHL6WTaqYbWEVz96Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402467; c=relaxed/simple;
	bh=O8OzNAeJYEDuDI8H5uolvFuhdB/IauRTtLsD6e9mocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIrI9WRrZQpcYmNL20B2tK1xFAk3Bj1KR758OJrXu+REiXGK7mAhOdaOuIqr4VCoXFaQK27bweSTBFTvxWrd29liUO+TmfMF+deL8hDh7JLGChOnnZWC/3bp2AgwAidiIrPkP1LVeWs+AVqK0dgUN191U66KiGAWy1mcMCJMKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaiZ+qgs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaiZ+qgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498BAC4CEC3;
	Thu, 31 Oct 2024 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402467;
	bh=O8OzNAeJYEDuDI8H5uolvFuhdB/IauRTtLsD6e9mocg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaiZ+qgsNmDYM/BSiZNELOz8fZd9eqbqpP97r0EoJ0FxkZPF0r+xGq25VohevgHyO
	 o93sY8B8n8aydWScbrFL68bvDWlnTPovUY8nzitJPKAgMNoXKRTCwCRaBhxeheGTHN
	 0KD4iMxSwODHtgXElRYSLRLI6cULvMVQYQDgw2NJUlQbzxxdaPYA+Y7hQWATeas3jC
	 bqKlBp9rWanMXhJBOvmOXoSpUUZWd7A+ly/SCVOW5rLPA/p1uqGI0cNl0vlAm0uOnP
	 YdL+tYhrLSpMKRLnoo+pntIv7/5lGjwdlUaHzyC3PWblKMc0eUQ9mne56V/G/47NFP
	 Ee7QsdEWb7x/Q==
Date: Thu, 31 Oct 2024 16:21:03 -0300
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
Subject: Re: [PATCH v5 08/21] perf script: Move script_spec code to
 trace-event-scripting.c
Message-ID: <ZyPYn3lmNOSWmCUs@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-9-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:39PM -0700, Ian Rogers wrote:
> The script_spec code is referenced in util/trace-event-scripting but
> the list was in builtin-script, accessed via a function that required
> a stub function in python.c. Move all the logic to
> trace-event-scripting, with lookup and foreach functions exposed for
> builtin-script's benefit.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c             | 67 +---------------------
>  tools/perf/util/python.c                |  5 --
>  tools/perf/util/trace-event-scripting.c | 75 +++++++++++++++++++++++++
>  tools/perf/util/trace-event.h           |  3 +-
>  4 files changed, 80 insertions(+), 70 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 62e851fdf5ca..11c0ee8c1afc 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2956,79 +2956,18 @@ static int __cmd_script(struct perf_script *script)
>  	return ret;
>  }
>  
> -struct script_spec {
> -	struct list_head	node;
> -	struct scripting_ops	*ops;
> -	char			spec[];
> -};
> -
> -static LIST_HEAD(script_specs);
> -
> -static struct script_spec *script_spec__new(const char *spec,
> -					    struct scripting_ops *ops)
> +static int list_available_languages_cb(struct scripting_ops *ops, const char *spec)
>  {
> -	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
> -
> -	if (s != NULL) {
> -		strcpy(s->spec, spec);
> -		s->ops = ops;
> -	}
> -
> -	return s;
> -}
> -
> -static void script_spec__add(struct script_spec *s)
> -{
> -	list_add_tail(&s->node, &script_specs);
> -}
> -
> -static struct script_spec *script_spec__find(const char *spec)
> -{
> -	struct script_spec *s;
> -
> -	list_for_each_entry(s, &script_specs, node)
> -		if (strcasecmp(s->spec, spec) == 0)
> -			return s;
> -	return NULL;
> -}
> -
> -int script_spec_register(const char *spec, struct scripting_ops *ops)
> -{
> -	struct script_spec *s;
> -
> -	s = script_spec__find(spec);
> -	if (s)
> -		return -1;
> -
> -	s = script_spec__new(spec, ops);
> -	if (!s)
> -		return -1;
> -	else
> -		script_spec__add(s);
> -
> +	fprintf(stderr, "  %-42s [%s]\n", spec, ops->name);
>  	return 0;
>  }
>  
> -static struct scripting_ops *script_spec__lookup(const char *spec)
> -{
> -	struct script_spec *s = script_spec__find(spec);
> -	if (!s)
> -		return NULL;
> -
> -	return s->ops;
> -}
> -
>  static void list_available_languages(void)
>  {
> -	struct script_spec *s;
> -
>  	fprintf(stderr, "\n");
>  	fprintf(stderr, "Scripting language extensions (used in "
>  		"perf script -s [spec:]script.[spec]):\n\n");
> -
> -	list_for_each_entry(s, &script_specs, node)
> -		fprintf(stderr, "  %-42s [%s]\n", s->spec, s->ops->name);
> -
> +	script_spec__for_each(&list_available_languages_cb);
>  	fprintf(stderr, "\n");
>  }
>  
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 0fa8e27769be..3d938fe2de6a 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1305,11 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
>  /* The following are stubs to avoid dragging in builtin-* objects. */
>  /* TODO: move the code out of the builtin-* file into util. */
>  
> -int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
> -{
> -	return -1;
> -}
> -
>  arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
>  {
>  	return NULL;
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 8abb7a7b6888..ad62d8e5a368 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -24,6 +24,81 @@ unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
>  
>  struct scripting_context *scripting_context;
>  
> +struct script_spec {
> +	struct list_head	node;
> +	struct scripting_ops	*ops;
> +	char			spec[];
> +};
> +
> +static LIST_HEAD(script_specs);
> +
> +static struct script_spec *script_spec__new(const char *spec,
> +					    struct scripting_ops *ops)
> +{
> +	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
> +
> +	if (s != NULL) {
> +		strcpy(s->spec, spec);
> +		s->ops = ops;
> +	}
> +
> +	return s;
> +}
> +
> +static void script_spec__add(struct script_spec *s)
> +{
> +	list_add_tail(&s->node, &script_specs);
> +}
> +
> +static struct script_spec *script_spec__find(const char *spec)
> +{
> +	struct script_spec *s;
> +
> +	list_for_each_entry(s, &script_specs, node)
> +		if (strcasecmp(s->spec, spec) == 0)
> +			return s;
> +	return NULL;
> +}
> +
> +static int script_spec_register(const char *spec, struct scripting_ops *ops)
> +{
> +	struct script_spec *s;
> +
> +	s = script_spec__find(spec);
> +	if (s)
> +		return -1;
> +
> +	s = script_spec__new(spec, ops);
> +	if (!s)
> +		return -1;
> +
> +	script_spec__add(s);
> +	return 0;
> +}
> +
> +struct scripting_ops *script_spec__lookup(const char *spec)
> +{
> +	struct script_spec *s = script_spec__find(spec);
> +
> +	if (!s)
> +		return NULL;
> +
> +	return s->ops;
> +}
> +
> +int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec))
> +{
> +	struct script_spec *s;
> +	int ret = 0;
> +
> +	list_for_each_entry(s, &script_specs, node) {
> +		ret = cb(s->ops, s->spec);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
>  void scripting_context__update(struct scripting_context *c,
>  			       union perf_event *event,
>  			       struct perf_sample *sample,
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index bbf8b26bc8da..81fceaf297ba 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -116,7 +116,8 @@ struct scripting_ops {
>  
>  extern unsigned int scripting_max_stack;
>  
> -int script_spec_register(const char *spec, struct scripting_ops *ops);
> +struct scripting_ops *script_spec__lookup(const char *spec);
> +int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
>  
>  void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
>  		       struct machine *machine);
> -- 
> 2.47.0.163.g1226f6d8fa-goog
