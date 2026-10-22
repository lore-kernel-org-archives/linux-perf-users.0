Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702552;
	b=hLK53L1e6auVfXtWFMXrI7gxPza4CmkxUq4TW8sjfs3NBQQvFQlunCejajwZEc/trOKd
	 3E50G6WMhR5UyGbn0GovFIZvJnGmau6qixiZPqDjubW+AjVrw4zaVv0PG5ZCfxt8mA5bq
	 gYptuTBcdTr9OTXf383XpRFqqGvHAfM2Dwj4+TGa1MqEOCt8ucxj5816xhVbhySBCY+ow
	 Bt/AiODuz03EEY2GecYwpzM1efahIZuqCie4TAUFGtQcFatqeFd3/X/Xx6jJwQjyt2dWK
	 OQ/7KTHoDXXZP5xQ6uewhpudYZIPgDDNYOsYyH3c8c88jy5IlisMoagDXXb+tU0Y2Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V0nNbhrNqYn6JLiKi39af5VNF7bCxetGO8A+BTTNcAk=;
	b=Ov1C1UBnfc2wncbQV7weiXX8dcUEVwMHK9wiXlu/P2KZjhLFTv52SUEWDeaMS9t9Z1Us
	 LwFEtsfbag8XyZQr+2rElp6am9QWzFiWdvfi5c8TNt8DJ2PobQGV2m9skC5kmtfJPp6Ea
	 SXUg5TYlETdZ05qEnt/oMebPV9R/TNZBWvuhDYKPLG7aK84Oal0kA3tSI/cS3sVArHFfb
	 ODoZwyJ2ETBomoJtoTF1kagmLc1UNyP4UrIhX0AG24VZGPsH6bnYaLw9Z6QgBWz2+sifo
	 RQgtVqV/XWeY/+Bu7C+piDszpKeIzEJIYO1sF/9SdC7JuG/oKLBlixdeVFwdhuJwZig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoImKDni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE97606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoImKDni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763881F01825;
	Thu, 22 Oct 2026 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702551;
	bh=V0nNbhrNqYn6JLiKi39af5VNF7bCxetGO8A+BTTNcAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoImKDniH/GFIdVKPeIQ2oTGuV/zv2OeT3NCFech2pSvVYZevredUN5pvd9unm/dU
	 gxizd66zLZFXHYuXO5DXICHiMJ2xvVRloHbBibIcthNnYZuWFw8NwW+KEXO4wuo8Dz
	 tgwqagnTav5npjUGoVhkZXdjLMQGicTkaNrxM9LvUI5FE4+nIiWPNZRwGsspl3Tdyi
	 myUAueIUEN0sa/VpOZ3OcSJmHtJUUhOFnVOCCoU7yu9n04egw1S96PPpnjkuqqcMJN
	 2ZBlyNNZ/nmYeB5nfXLPq8DBS2K3dmJVeE5q1KrWUOzTsPwwFi0138ypJF2WbyoU+2
	 evwwYsbOh6oVQ==
Message-ID: <sashiko-outbox-182030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/11] perf bpf-filter: Support BPF sample filters on
 tracepoint events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-3-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:55:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf parse-events: is_possible_tp_filter() misroutes generic cpu=
 tp filters
- [Medium] perf parse-events: misrouted tracepoint filters in is_possible_t=
p_filter()
--

commit dbe9f68d8a043d94d321ad8e9a98e3b1d3114baf
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Support BPF sample filters on tracepoint events

This commit adds a BPF_PROG_TYPE_TRACEPOINT sample filter program to evalua=
te
context-independent filter terms (uid, gid, tid, pid, cpu, time, cgroup) on
tracepoint events, and updates set_filter() and perf_bpf_filter__prepare() =
to
route and attach those filters.

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 2f3317ce17f08..d6bab89ade5de 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c

[ ... ]

> @@ -2593,10 +2595,40 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
>  	return 0;
>  }
> =20
> +static bool is_filter_word_char(char c)
> +{
> +	return isalnum((unsigned char)c) || c =3D=3D '_' || c =3D=3D '/' || c =
=3D=3D '.';
> +}
> +
> +static bool has_filter_word(const char *str, const char *word)
> +{
> +	size_t len =3D strlen(word);
> +	const char *p =3D str;
> +
> +	while ((p =3D strstr(p, word)) !=3D NULL) {
> +		bool start_ok =3D (p =3D=3D str) || !is_filter_word_char(p[-1]);
> +		bool end_ok =3D !is_filter_word_char(p[len]);
> +
> +		if (start_ok && end_ok)
> +			return true;
> +		p +=3D len;
> +	}
> +	return false;
> +}
> +
>  /* Will a tracepoint filter work for str or should a BPF filter be used?=
 */
> -static bool is_possible_tp_filter(const char *str)
> +static bool is_possible_tp_filter(struct evsel *evsel, const char *str)
>  {
> -	return strstr(str, "uid") =3D=3D NULL;
> +	static const char *const bpf_tp_terms[] =3D {
> +		"uid", "gid", "tid", "pid", "cpu", "time", "cgroup",
> +	};

[Severity: Medium]
In tools/perf/util/parse-events.c, is_possible_tp_filter() includes "cpu" in
bpf_tp_terms[] and returns false whenever evsel__field(evsel, "cpu") is NUL=
L.

In kernel/trace/trace_events.c, trace_define_generic_fields() registers "cp=
u"
in ftrace_generic_fields for all tracepoint events:

kernel/trace/trace_events.c:trace_define_generic_fields() {
	int ret;

	__generic_field(int, CPU, FILTER_CPU);
	__generic_field(int, cpu, FILTER_CPU);
	__generic_field(int, common_cpu, FILTER_CPU);

While trace_find_event_field() resolves ftrace_generic_fields when applying=
 a
tracepoint filter via PERF_EVENT_IOC_SET_FILTER, f_next() and f_show() only
emit ftrace_common_fields and event-specific fields in the tracefs format
file parsed by evsel__field().

For any tracepoint that does not define its own event-specific "cpu" field
(such as sched:sched_switch or kmem:mm_page_alloc), evsel__field(evsel, "cp=
u")
returns NULL, so parse_filter() -> set_filter() -> is_possible_tp_filter()
returns false.

Will this cause valid ftrace tracepoint predicate filters referencing the
generic "cpu" field (such as compound filters combining "cpu" with
event-specific fields, "&&", parentheses, or "CPUS{...}" masks) to be
misrouted to perf_bpf_filter__parse() and fail to parse, while forcing
standalone "cpu" tracepoint filters onto the shared
trace_event_call->prog_array BPF filter requiring CAP_BPF?

> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(bpf_tp_terms); i++) {
> +		if (has_filter_word(str, bpf_tp_terms[i]) &&
> +		    !evsel__field(evsel, bpf_tp_terms[i]))
> +			return false;
> +	}
> +	return true;
>  }

[Severity: Medium]
Can parse_filter() -> foreach_evsel_in_last_glob() -> set_filter() ->
is_possible_tp_filter() in tools/perf/util/parse-events.c also misroute
tracepoint filters in the following cases?

First, when perf is built without HAVE_LIBTRACEEVENT (NO_LIBTRACEEVENT=3D1),
PERF_TYPE_TRACEPOINT events and kernel ftrace filters (applied via
PERF_EVENT_IOC_SET_FILTER in perf_evsel__apply_filter()) are still supported
via tp_pmu__id(), but the stub in tools/perf/util/evsel.h unconditionally
returns NULL:

tools/perf/util/evsel.h:
static inline struct tep_format_field *
evsel__field(struct evsel *evsel __maybe_unused, const char *name __maybe_u=
nused)
{
	return NULL;
}

When evsel__field() returns NULL, any tracepoint filter referencing a format
field whose name appears in bpf_tp_terms[] (such as "pid" on
sched:sched_wakeup, sched:sched_process_fork, or signal:signal_generate)
causes is_possible_tp_filter() to return false. A filter like
--filter "pid =3D=3D 1234" on sched:sched_wakeup will then be routed to
perf_tp_sample_filter and match current's TGID (bpf_get_current_pid_tgid() =
>>
32) instead of the tracepoint's target "pid" field, while compound filters
like --filter "pid =3D=3D 1234 && success =3D=3D 1" will fail to parse in
perf_bpf_filter__parse().

Second, even with HAVE_LIBTRACEEVENT enabled, has_filter_word() scans the r=
aw
filter string with strstr() without skipping quoted string literals, and
is_filter_word_char() treats quotes, hyphens, and glob characters as word
boundaries. On an event without a field of that name (for example,
sched:sched_switch), a valid tracepoint string filter such as
prev_comm =3D=3D "cpu" or next_comm =3D=3D "systemd-time" matches inside th=
e quoted
literal, causing is_possible_tp_filter() to return false and
perf_bpf_filter__parse() to reject the filter.

Third, if a filter on an event like sched:sched_wakeup combines a tracepoint
field whose name is in bpf_tp_terms[] with a BPF-only term (such as
"pid =3D=3D 1234, uid =3D=3D 0"), is_possible_tp_filter() returns false for=
 the
entire string, causing "pid" to be evaluated as current's TGID in BPF rather
than the tracepoint's "pid" field.

> =20
>  static int set_filter(struct evsel *evsel, const void *arg)
> @@ -2611,7 +2643,7 @@ static int set_filter(struct evsel *evsel, const vo=
id *arg)
>  		return -1;
>  	}
> =20
> -	if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT && is_possible_tp=
_filter(str)) {
> +	if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT && is_possible_tp=
_filter(evsel, str)) {
>  		if (evsel__append_tp_filter(evsel, str) < 0) {
>  			fprintf(stderr,
>  				"not enough memory to hold filter string\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D2
