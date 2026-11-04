Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760269;
	b=shWSJGkxXclmiMVSXPp66+SOsN457TfKZ3FGoChbvncMvZWAQf11xWdZUT5rN0vjj9Qk
	 Xo19gRQCulRYvugOuF6KOTQIXIj/hgjLbxBuOC+FRwq7ZdZHgBWa9kgcX2DCodJuCXECZ
	 7JBe4j5JpLLqEsuizWg7Yed5J/zqQdokPi8O3ozGCWvccbz3coaOzKHfgALJXcwYjUYCx
	 kMNsFCNhOO9mhUG0CWgTh0RTk9jUZ3c6YNv1a+lgyuN2K/SAtsvIBZ/0/65ygLv6SWMwW
	 MtA1IXUMQ0lcBRROQt3u8NEH5nvGEA+zL5jJLnQcjGUFSCdOs9W75Jatqr3DIGiGIzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pk4Y8J5YOz2KtCgbccO5t8Yzcv4H+l37Dymd5REE5k4=;
	b=1dHnpFP5DgM+LZZ2ZXMhsPdyMIHgjEYwKv1NTSy/VmXLZ9SFBZmMbIGuMTpNRL0znQH2
	 m5N2aykhvwQEDaDPRgcw7X0LHw0CHTwUAqGtYTIQJhng3F8Sm4+Lv0r9Lvk1pbC6RhXn/
	 D95LPcQ5Yx8lNSI7IAMYNnYUsD42Xv1bIapK/jhxl1LKC8iuesixCZxLSOMxQs3pAGp8X
	 fQNWI22No6czq+c7fKTyeYk3Y3dOWLdjcQeP65kAKC0HLNw9bmPB7lG139HQKXLIexePr
	 pJhwtleX0U6EUbzbnzusV9EyOZjJqLrslIqiEfCJJzW4FwtF4ZArcXpbgkvmWI/dcoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfAdT0Lr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A6606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfAdT0Lr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC51F00A17;
	Wed,  4 Nov 2026 02:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760269;
	bh=pk4Y8J5YOz2KtCgbccO5t8Yzcv4H+l37Dymd5REE5k4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EfAdT0LrIlYfoplEOaf1DmV0lB1g8TW0AAxaGbuSjNyCSxDtxd3+UKazdi1AbmSpm
	 phC+6mk+6ZGJK6trVk+WMV2CjhjnRIQlg7IAXYW8CNDlw5VhrWAzYSq4Oh7ETxXDaU
	 kZ+wLXVULkOKcV9Vat4lFSGuwkL+SY3tapDCXrcc5FzNe5fYFRdNFM1ygXNjS3sDVw
	 GxNLnciJXzsKNIL89Puno2UqIQ+jfJKbo+IIB82e/BWVCRbbr/73qYZXU0YiniQflL
	 OSsO+Orm5LdVLFFYsvJhpuQrd98YKAQ/jDIQgzD0PHzhIdF/86iotNpVdbrL3XexFM
	 e/AM0NWHnVkKQ==
Message-ID: <sashiko-outbox-196518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/41] perf parse-events: Decode metric-id terms when
 adding events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-17-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:44:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf parse-events: memory leaks and lost -EINVAL in __add_event()
--

commit d94adf4cbdeb9f222163d5aa1a9c0bfba671278a
Author: Ian Rogers <irogers@google.com>

perf parse-events: Decode metric-id terms when adding events

This commit moves metric-id encoding and decoding from metricgroup.c into
parse-events.c so that metric-ids are decoded when evsels are created in
__add_event() rather than rewritten after parsing.

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 159d847f44ce2..1c02c2b906840 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -171,6 +171,73 @@ static void fix_raw(struct parse_events_terms *confi=
g_terms, struct perf_pmu *pm

[ ... ]

> +static int parse_events__decode_metric_id(struct strbuf *sb, const char =
*x)
> +{
> +	const char *orig =3D x;
> +	size_t i;
> +	char c;
> +	int ret;
> +
> +	for (; *x; x++) {
> +		c =3D *x;
> +		if (*x =3D=3D '!') {
> +			x++;
> +			i =3D *x - '0';
> +			if (i >=3D strlen(metric_id_code_characters)) {
> +				pr_err("Bad metric-id encoding in: '%s'", orig);
> +				return -EINVAL;
> +			}
> +			c =3D metric_id_code_characters[i];
> +		}
> +		ret =3D strbuf_addch(sb, c);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static struct evsel *
>  __add_event(struct list_head *list, int *idx,
>  	    struct perf_event_attr *attr,
> @@ -261,7 +328,12 @@ __add_event(struct list_head *list, int *idx,
>  	}
> =20
>  	if (metric_id) {
> -		evsel->metric_id =3D strdup(metric_id);
> +		struct strbuf sb =3D STRBUF_INIT;
> +		int ret =3D parse_events__decode_metric_id(&sb, metric_id);
> +
> +		if (!ret)
> +			evsel->metric_id =3D strdup(sb.buf);
> +		strbuf_release(&sb);
>  		if (!evsel->metric_id)
>  			goto out_err;
>  	}

[Severity: Medium]
When parse_events__decode_metric_id() fails on a malformed metric-id
encoding (such as cpu/instructions,metric-id=3Dfoo!9/) and returns -EINVAL,
does jumping to out_err in __add_event() lose the -EINVAL error code and
leak both config_terms and evsel->unit?

In __add_event(), out_err frees evsel directly instead of calling
evsel__put(evsel) and returns NULL before config_terms is spliced into
evsel->config_terms:

tools/perf/util/parse-events.c:__add_event() {
	...
	if (config_terms)
		list_splice_init(config_terms, &evsel->config_terms);
	...
out_err:
	perf_cpu_map__put(cpus);
	perf_cpu_map__put(pmu_cpus);
	zfree(&evsel->name);
	zfree(&evsel->metric_id);
	free(evsel);
	return NULL;
}

When __add_event() returns NULL to parse_events_add_pmu() (as well as
add_event() and __parse_events_add_numeric()), the caller converts the
failure into -ENOMEM and returns without freeing config_terms:

tools/perf/util/parse-events.c:parse_events_add_pmu() {
	...
	evsel =3D __add_event(list, &parse_state->idx, &attr, /*init_attr=3D*/true,
			    get_config_name(&parsed_terms),
			    get_config_metric_id(&parsed_terms), parse_state->pmus, pmu,
			    &config_terms, first_wildcard_match, term_cpu, alternate_hw_config);
	perf_cpu_map__put(term_cpu);
	if (!evsel) {
		parse_events_terms__exit(&parsed_terms);
		return -ENOMEM;
	}
	...
}

Previously, metric-id decoding ran after __add_event() had already spliced
config_terms into evsel->config_terms, and a failure in
decode_all_metric_ids() cleaned up the evlist via evlist__delete() ->
evsel__delete() -> evsel__exit().

Note that a later patch in the series, commit 21ed6e9ff56d ("perf evsel:
Generalize metric_id to a set of metric_ids"), replaces free(evsel) with
evsel__put(evsel) in __add_event(), which resolves the evsel->unit leak,
but the unspliced config_terms leak in parse_events_add_pmu() and the loss
of the -EINVAL return code remain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D16
