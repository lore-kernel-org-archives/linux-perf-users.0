Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C31A3A8A;
	Tue, 22 Jul 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178646; cv=none; b=rZft6zrNCOfwlLM9MfwD600iOiTkYJst2dL9ALUKcXLIsLb3pcCy9q2LUHom46mJskCs1ojbxL319NmKjGr6apu+rIQpMU/bnJ1f+q6HA1n5/oT+/EziUUJV4zF12yuAzZfuInXdnUW8VJQZxB0HiSfjiQXqKBkGGddE8PoEiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178646; c=relaxed/simple;
	bh=ciQe6j8mxWOcy3iJT12t1gBIn5aZbJ3XYHxczD1+HzY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuLT34TuUMibwvSLQD1RWXoQ8VwlDODzPTIGzhKE9+nJDzJpoXeiUUzSfW/aWbwE1tZ09ODQZqv2C4DWqgCTTrlsDPBaX7oltXSzPbP7Y9elj8ks1tSQWFz6y3Cu4H3O84DPB5X3IPArf2to7rNevF3HXT3rXBwlV0YVw3fdgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bmXpl4BTdz1R8gb;
	Tue, 22 Jul 2025 18:01:19 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F284140118;
	Tue, 22 Jul 2025 18:03:59 +0800 (CST)
Received: from kwepemq500002.china.huawei.com (7.202.195.240) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 18:03:59 +0800
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 kwepemq500002.china.huawei.com (7.202.195.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 18:03:59 +0800
Received: from kwepemq200002.china.huawei.com ([7.202.195.90]) by
 kwepemq200002.china.huawei.com ([7.202.195.90]) with mapi id 15.02.1544.011;
 Tue, 22 Jul 2025 18:03:59 +0800
From: duchangbin <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: ftrace: add graph tracer options
 args/retval/retval-hex/retaddr
Thread-Topic: [PATCH] perf: ftrace: add graph tracer options
 args/retval/retval-hex/retaddr
Thread-Index: AQHb3FgJ+kCFGr9YTkC54VEFB2tYbLQ+JxcA
Date: Tue, 22 Jul 2025 10:03:58 +0000
Message-ID: <cee4d3e644ab4bea8959eff1c16d2a20@huawei.com>
References: <20250613114048.132336-1-changbin.du@huawei.com>
In-Reply-To: <20250613114048.132336-1-changbin.du@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemq200002.china.huawei.com (15.02.1544.011)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B23A9DF356B2C41B1D09D3EACF3B3A1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Kindly ping.

On Fri, Jun 13, 2025 at 07:40:47PM +0800, Changbin Du wrote:
> This change adds support for new funcgraph tracer options funcgraph-args,
> funcgraph-retval, funcgraph-retval-hex and funcgraph-retaddr.
>=20
> The new added options are:
>   - args       : Show function arguments.
>   - retval     : Show function return value.
>   - retval-hex : Show function return value in hexadecimal format.
>   - retaddr    : Show function return address.
>=20
>  # ./perf ftrace -G vfs_write --graph-opts retval,retaddr
>  # tracer: function_graph
>  #
>  # CPU  DURATION                  FUNCTION CALLS
>  # |     |   |                     |   |   |   |
>  5)               |  mutex_unlock() { /* <-rb_simple_write+0xda/0x150 */
>  5)   0.188 us    |    local_clock(); /* <-lock_release+0x2ad/0x440 ret=
=3D0x3bf2a3cf90e */
>  5)               |    rt_mutex_slowunlock() { /* <-rb_simple_write+0xda/=
0x150 */
>  5)               |      _raw_spin_lock_irqsave() { /* <-rt_mutex_slowunl=
ock+0x4f/0x200 */
>  5)   0.123 us    |        preempt_count_add(); /* <-_raw_spin_lock_irqsa=
ve+0x23/0x90 ret=3D0x0 */
>  5)   0.128 us    |        local_clock(); /* <-__lock_acquire.isra.0+0x17=
a/0x740 ret=3D0x3bf2a3cfc8b */
>  5)   0.086 us    |        do_raw_spin_trylock(); /* <-_raw_spin_lock_irq=
save+0x4a/0x90 ret=3D0x1 */
>  5)   0.845 us    |      } /* _raw_spin_lock_irqsave ret=3D0x292 */
>  5)               |      _raw_spin_unlock_irqrestore() { /* <-rt_mutex_sl=
owunlock+0x191/0x200 */
>  5)   0.097 us    |        local_clock(); /* <-lock_release+0x2ad/0x440 r=
et=3D0x3bf2a3cff1f */
>  5)   0.086 us    |        do_raw_spin_unlock(); /* <-_raw_spin_unlock_ir=
qrestore+0x23/0x60 ret=3D0x1 */
>  5)   0.104 us    |        preempt_count_sub(); /* <-_raw_spin_unlock_irq=
restore+0x35/0x60 ret=3D0x0 */
>  5)   0.726 us    |      } /* _raw_spin_unlock_irqrestore ret=3D0x8000000=
0 */
>  5)   1.881 us    |    } /* rt_mutex_slowunlock ret=3D0x0 */
>  5)   2.931 us    |  } /* mutex_unlock ret=3D0x0 */
>=20
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  4 ++
>  tools/perf/builtin-ftrace.c              | 60 +++++++++++++++++++++++-
>  tools/perf/util/ftrace.h                 |  4 ++
>  3 files changed, 67 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Docume=
ntation/perf-ftrace.txt
> index b77f58c4d2fd..4b21a755132f 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -123,6 +123,10 @@ OPTIONS for 'perf ftrace trace'
>  --graph-opts::
>  	List of options allowed to set:
> =20
> +	  - args         - Show function arguments.
> +	  - retval       - Show function return value.
> +	  - retval-hex   - Show function return value in hexadecimal format.
> +	  - retaddr      - Show function return address.
>  	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
>  	  - noirqs       - Ignore functions that happen inside interrupt.
>  	  - verbose      - Show process names, PIDs, timestamps, etc.
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index bba36ebc2aa7..f7cf1dd7b64b 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -301,6 +301,10 @@ static void reset_tracing_options(struct perf_ftrace=
 *ftrace __maybe_unused)
>  	write_tracing_option_file("funcgraph-proc", "0");
>  	write_tracing_option_file("funcgraph-abstime", "0");
>  	write_tracing_option_file("funcgraph-tail", "0");
> +	write_tracing_option_file("funcgraph-args", "0");
> +	write_tracing_option_file("funcgraph-retval", "0");
> +	write_tracing_option_file("funcgraph-retval-hex", "0");
> +	write_tracing_option_file("funcgraph-retaddr", "0");
>  	write_tracing_option_file("latency-format", "0");
>  	write_tracing_option_file("irq-info", "0");
>  }
> @@ -542,6 +546,41 @@ static int set_tracing_sleep_time(struct perf_ftrace=
 *ftrace)
>  	return 0;
>  }
> =20
> +static int set_tracing_funcgraph_args(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->graph_args) {
> +		if (write_tracing_option_file("funcgraph-args", "1") < 0)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->graph_retval || ftrace->graph_retval_hex) {
> +		if (write_tracing_option_file("funcgraph-retval", "1") < 0)
> +			return -1;
> +	}
> +
> +	if (ftrace->graph_retval_hex) {
> +		if (write_tracing_option_file("funcgraph-retval-hex", "1") < 0)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->graph_retaddr) {
> +		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
>  {
>  	if (!ftrace->graph_noirqs)
> @@ -642,6 +681,21 @@ static int set_tracing_options(struct perf_ftrace *f=
trace)
>  		return -1;
>  	}
> =20
> +	if (set_tracing_funcgraph_args(ftrace) < 0) {
> +		pr_err("failed to set tracing option funcgraph-args\n");
> +		return -1;
> +	}
> +
> +	if (set_tracing_funcgraph_retval(ftrace) < 0) {
> +		pr_err("failed to set tracing option funcgraph-retval\n");
> +		return -1;
> +	}
> +
> +	if (set_tracing_funcgraph_retaddr(ftrace) < 0) {
> +		pr_err("failed to set tracing option funcgraph-retaddr\n");
> +		return -1;
> +	}
> +
>  	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
>  		pr_err("failed to set tracing option funcgraph-irqs\n");
>  		return -1;
> @@ -1607,6 +1661,10 @@ static int parse_graph_tracer_opts(const struct op=
tion *opt,
>  	int ret;
>  	struct perf_ftrace *ftrace =3D (struct perf_ftrace *) opt->value;
>  	struct sublevel_option graph_tracer_opts[] =3D {
> +		{ .name =3D "args",		.value_ptr =3D &ftrace->graph_args },
> +		{ .name =3D "retval",		.value_ptr =3D &ftrace->graph_retval },
> +		{ .name =3D "retval-hex",		.value_ptr =3D &ftrace->graph_retval_hex },
> +		{ .name =3D "retaddr",		.value_ptr =3D &ftrace->graph_retaddr },
>  		{ .name =3D "nosleep-time",	.value_ptr =3D &ftrace->graph_nosleep_time=
 },
>  		{ .name =3D "noirqs",		.value_ptr =3D &ftrace->graph_noirqs },
>  		{ .name =3D "verbose",		.value_ptr =3D &ftrace->graph_verbose },
> @@ -1699,7 +1757,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
>  		     "Set nograph filter on given functions", parse_filter_func),
>  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> -		     "Graph tracer options, available options: nosleep-time,noirqs,ver=
bose,thresh=3D<n>,depth=3D<n>",
> +		     "Graph tracer options, available options: args,retval,retval-hex,=
retaddr,nosleep-time,noirqs,verbose,thresh=3D<n>,depth=3D<n>",
>  		     parse_graph_tracer_opts),
>  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
>  		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", pa=
rse_buffer_size),
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index a9bc47da83a5..782c33227e92 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -29,6 +29,10 @@ struct perf_ftrace {
>  	int			graph_depth;
>  	int			func_stack_trace;
>  	int			func_irq_info;
> +	int			graph_args;
> +	int			graph_retval;
> +	int			graph_retval_hex;
> +	int			graph_retaddr;
>  	int			graph_nosleep_time;
>  	int			graph_noirqs;
>  	int			graph_verbose;
> --=20
> 2.43.0
>=20

--=20
Cheers,
Changbin Du
