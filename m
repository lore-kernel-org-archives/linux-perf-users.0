From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Fri, 10 Jun 2011 17:42:08 -0300
Message-ID: <20110610204208.GC13694@ghostprotocols.net>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43248 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab1FJUmQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jun 2011 16:42:16 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sam Liao <phyomh@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Em Thu, Jun 09, 2011 at 02:44:19PM +0800, Sam Liao escreveu:
> Add "caller/callee" option to support inverted butterfly report,
> in the inverted report (with caller option), the call graph start
> from the callee's ancestor. Users can use such view to catch system's
> performance bottleneck from a sysprof like view. Using this option
> with specified sort order like pid gives us high level view of call
> graph statistics.

Looks OK, haven't had time to test tho.

=46r=E9d=E9ric, can you process this one? Tomorrow I'll be off the grid=
,
vacations!

Thanks a lot,

- Arnaldo

> ---
>  tools/perf/builtin-report.c |   28 ++++++++++++++++++++++------
>  tools/perf/util/callchain.h |    6 ++++++
>  tools/perf/util/hist.c      |    3 ++-
>  tools/perf/util/session.c   |    7 ++++++-
>  4 files changed, 36 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.=
c
> index 287a173..2ceac45 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -45,7 +45,7 @@ static struct perf_read_values	show_threads_values;
>  static const char	default_pretty_printing_style[] =3D "normal";
>  static const char	*pretty_printing_style =3D default_pretty_printing=
_style;
>=20
> -static char		callchain_default_opt[] =3D "fractal,0.5";
> +static char		callchain_default_opt[] =3D "fractal,0.5,callee";
>  static symbol_filter_t	annotate_init;
>=20
>  static int perf_session__add_hist_entry(struct perf_session *session=
,
> @@ -386,13 +386,29 @@ parse_callchain_opt(const struct option *opt
> __used, const char *arg,
>  	if (!tok)
>  		goto setup;
>=20
> -	tok2 =3D strtok(NULL, ",");
>  	callchain_param.min_percent =3D strtod(tok, &endptr);
>  	if (tok =3D=3D endptr)
>  		return -1;
>=20
> -	if (tok2)
> +	/* get the print limit */
> +	tok2 =3D strtok(NULL, ",");
> +	if (!tok2)
> +		goto setup;
> +
> +	if (tok2[0] !=3D 'c') {
>  		callchain_param.print_limit =3D strtod(tok2, &endptr);
> +		tok2 =3D strtok(NULL, ",");
> +		if (!tok2)
> +			goto setup;
> +	}
> +
> +	/* get the call chain order */
> +	if (!strcmp(tok2, "caller"))
> +		callchain_param.order =3D ORDER_CALLER;
> +	else if (!strcmp(tok2, "callee"))
> +		callchain_param.order =3D ORDER_CALLEE;
> +	else
> +		return -1;
>  setup:
>  	if (callchain_register_param(&callchain_param) < 0) {
>  		fprintf(stderr, "Can't register callchain params\n");
> @@ -436,9 +452,9 @@ static const struct option options[] =3D {
>  		   "regex filter to identify parent, see: '--sort parent'"),
>  	OPT_BOOLEAN('x', "exclude-other", &symbol_conf.exclude_other,
>  		    "Only display entries with parent-match"),
> -	OPT_CALLBACK_DEFAULT('g', "call-graph", NULL, "output_type,min_perc=
ent",
> -		     "Display callchains using output_type (graph, flat, fractal,
> or none) and min percent threshold. "
> -		     "Default: fractal,0.5", &parse_callchain_opt, callchain_defau=
lt_opt),
> +	OPT_CALLBACK_DEFAULT('g', "call-graph", NULL,
> "output_type,min_percent, call_order",
> +		     "Display callchains using output_type (graph, flat, fractal,
> or none) , min percent threshold and callchain order. "
> +		     "Default: fractal,0.5,callee", &parse_callchain_opt,
> callchain_default_opt),
>  	OPT_STRING('d', "dsos", &symbol_conf.dso_list_str, "dso[,dso...]",
>  		   "only consider symbols in these dsos"),
>  	OPT_STRING('C', "comms", &symbol_conf.comm_list_str, "comm[,comm...=
]",
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.=
h
> index 1a79df9..9b4ff16 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -14,6 +14,11 @@ enum chain_mode {
>  	CHAIN_GRAPH_REL
>  };
>=20
> +enum chain_order {
> +	ORDER_CALLER,
> +	ORDER_CALLEE
> +};
> +
>  struct callchain_node {
>  	struct callchain_node	*parent;
>  	struct list_head	siblings;
> @@ -41,6 +46,7 @@ struct callchain_param {
>  	u32			print_limit;
>  	double			min_percent;
>  	sort_chain_func_t	sort;
> +	enum chain_order	order;
>  };
>=20
>  struct callchain_list {
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 627a02e..dae4202 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -14,7 +14,8 @@ enum hist_filter {
>=20
>  struct callchain_param	callchain_param =3D {
>  	.mode	=3D CHAIN_GRAPH_REL,
> -	.min_percent =3D 0.5
> +	.min_percent =3D 0.5,
> +	.order  =3D ORDER_CALLEE
>  };
>=20
>  u16 hists__col_len(struct hists *self, enum hist_column col)
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f5a8fbd..e545a4d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -247,9 +247,14 @@ int perf_session__resolve_callchain(struct
> perf_session *self,
>  	callchain_cursor_reset(&self->callchain_cursor);
>=20
>  	for (i =3D 0; i < chain->nr; i++) {
> -		u64 ip =3D chain->ips[i];
> +		u64 ip;
>  		struct addr_location al;
>=20
> +		if (callchain_param.order =3D=3D ORDER_CALLEE)
> +			ip =3D chain->ips[i];
> +		else
> +			ip =3D chain->ips[chain->nr - i - 1];
> +
>  		if (ip >=3D PERF_CONTEXT_MAX) {
>  			switch (ip) {
>  			case PERF_CONTEXT_HV:
> --=20
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
