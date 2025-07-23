Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEEEAE7;
	Wed, 23 Jul 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232001; cv=none; b=sQmt9PetsfnlHLU1eemAsw4UQkQslX4cR1OqWzvRWSBSavenQplN9TxGJ3jvmPXjyD+2M6fAruKTgQUK7lip0PUWIZ2+oJvpAZ3KWU8vKFdvt7+9jeNSWEq+m3VUuGTgW7gJwdBqebx3kUZwhYh+SMDmBnhIT2EI7yYOITKixCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232001; c=relaxed/simple;
	bh=S9Se4NuSA42yZUgXJgt8LkY9wfVVkkvF3bhtyBZpUXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH9TFF9alziRu9q8ddG/1Xc1PQg8KO7a8IKtu5H5tu5NS5ehPKZqIcv5Kth2FYGVKHiCS39BT8p2YAxXi/iFrBzSMtfj43pxAAYYlvWH/tXO13BuRwwxrFgdPrJA7STI0Il5OxmUqyMnYmW3aEPdbuyQ4VcXylvxp97RF2pBHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpTfisrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpTfisrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8976C4CEEB;
	Wed, 23 Jul 2025 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753232001;
	bh=S9Se4NuSA42yZUgXJgt8LkY9wfVVkkvF3bhtyBZpUXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpTfisrYvJhaneY9HRei6iOVZ+VVYZlxrO2D+8LZxQ/MJ+SxFnvssquTO1OV54BDV
	 kZvFGLDRC5hJdKvF9FH7b03V++wcYfJePs9nyySkWz9klr4DmMAIIYgjkYc2r8MfXd
	 1Yh9FsPOuANnHTxoSQKp7B7RrT/qIuuKfh8lWTXqLqKnqHalcakOQ9PJ4AWxbJKCaL
	 jUCn3Dg9NMmetGd8W02+GsAb5JYhLOQhR1+zhF2qdEUvF7LRlyinKPiAST9m6ZNABj
	 aO8WzEpGpdPv3MgyAhqRGTWr7KLbActg8Nptf9pMzwLgn+CyGNGnXUTftiTFoh6/y8
	 u5AVSLIhM7Psg==
Date: Tue, 22 Jul 2025 17:53:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: ftrace: add graph tracer options
 args/retval/retval-hex/retaddr
Message-ID: <aIAyfpLifAM-BoFb@google.com>
References: <20250613114048.132336-1-changbin.du@huawei.com>
 <cee4d3e644ab4bea8959eff1c16d2a20@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cee4d3e644ab4bea8959eff1c16d2a20@huawei.com>

Hello,

On Tue, Jul 22, 2025 at 10:03:58AM +0000, duchangbin wrote:
> Kindly ping.

Sorry for the delay, processing now...

Thanks,
Namhyung

> 
> On Fri, Jun 13, 2025 at 07:40:47PM +0800, Changbin Du wrote:
> > This change adds support for new funcgraph tracer options funcgraph-args,
> > funcgraph-retval, funcgraph-retval-hex and funcgraph-retaddr.
> > 
> > The new added options are:
> >   - args       : Show function arguments.
> >   - retval     : Show function return value.
> >   - retval-hex : Show function return value in hexadecimal format.
> >   - retaddr    : Show function return address.
> > 
> >  # ./perf ftrace -G vfs_write --graph-opts retval,retaddr
> >  # tracer: function_graph
> >  #
> >  # CPU  DURATION                  FUNCTION CALLS
> >  # |     |   |                     |   |   |   |
> >  5)               |  mutex_unlock() { /* <-rb_simple_write+0xda/0x150 */
> >  5)   0.188 us    |    local_clock(); /* <-lock_release+0x2ad/0x440 ret=0x3bf2a3cf90e */
> >  5)               |    rt_mutex_slowunlock() { /* <-rb_simple_write+0xda/0x150 */
> >  5)               |      _raw_spin_lock_irqsave() { /* <-rt_mutex_slowunlock+0x4f/0x200 */
> >  5)   0.123 us    |        preempt_count_add(); /* <-_raw_spin_lock_irqsave+0x23/0x90 ret=0x0 */
> >  5)   0.128 us    |        local_clock(); /* <-__lock_acquire.isra.0+0x17a/0x740 ret=0x3bf2a3cfc8b */
> >  5)   0.086 us    |        do_raw_spin_trylock(); /* <-_raw_spin_lock_irqsave+0x4a/0x90 ret=0x1 */
> >  5)   0.845 us    |      } /* _raw_spin_lock_irqsave ret=0x292 */
> >  5)               |      _raw_spin_unlock_irqrestore() { /* <-rt_mutex_slowunlock+0x191/0x200 */
> >  5)   0.097 us    |        local_clock(); /* <-lock_release+0x2ad/0x440 ret=0x3bf2a3cff1f */
> >  5)   0.086 us    |        do_raw_spin_unlock(); /* <-_raw_spin_unlock_irqrestore+0x23/0x60 ret=0x1 */
> >  5)   0.104 us    |        preempt_count_sub(); /* <-_raw_spin_unlock_irqrestore+0x35/0x60 ret=0x0 */
> >  5)   0.726 us    |      } /* _raw_spin_unlock_irqrestore ret=0x80000000 */
> >  5)   1.881 us    |    } /* rt_mutex_slowunlock ret=0x0 */
> >  5)   2.931 us    |  } /* mutex_unlock ret=0x0 */
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |  4 ++
> >  tools/perf/builtin-ftrace.c              | 60 +++++++++++++++++++++++-
> >  tools/perf/util/ftrace.h                 |  4 ++
> >  3 files changed, 67 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index b77f58c4d2fd..4b21a755132f 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -123,6 +123,10 @@ OPTIONS for 'perf ftrace trace'
> >  --graph-opts::
> >  	List of options allowed to set:
> >  
> > +	  - args         - Show function arguments.
> > +	  - retval       - Show function return value.
> > +	  - retval-hex   - Show function return value in hexadecimal format.
> > +	  - retaddr      - Show function return address.
> >  	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
> >  	  - noirqs       - Ignore functions that happen inside interrupt.
> >  	  - verbose      - Show process names, PIDs, timestamps, etc.
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index bba36ebc2aa7..f7cf1dd7b64b 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -301,6 +301,10 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
> >  	write_tracing_option_file("funcgraph-proc", "0");
> >  	write_tracing_option_file("funcgraph-abstime", "0");
> >  	write_tracing_option_file("funcgraph-tail", "0");
> > +	write_tracing_option_file("funcgraph-args", "0");
> > +	write_tracing_option_file("funcgraph-retval", "0");
> > +	write_tracing_option_file("funcgraph-retval-hex", "0");
> > +	write_tracing_option_file("funcgraph-retaddr", "0");
> >  	write_tracing_option_file("latency-format", "0");
> >  	write_tracing_option_file("irq-info", "0");
> >  }
> > @@ -542,6 +546,41 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
> >  	return 0;
> >  }
> >  
> > +static int set_tracing_funcgraph_args(struct perf_ftrace *ftrace)
> > +{
> > +	if (ftrace->graph_args) {
> > +		if (write_tracing_option_file("funcgraph-args", "1") < 0)
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
> > +{
> > +	if (ftrace->graph_retval || ftrace->graph_retval_hex) {
> > +		if (write_tracing_option_file("funcgraph-retval", "1") < 0)
> > +			return -1;
> > +	}
> > +
> > +	if (ftrace->graph_retval_hex) {
> > +		if (write_tracing_option_file("funcgraph-retval-hex", "1") < 0)
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
> > +{
> > +	if (ftrace->graph_retaddr) {
> > +		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0)
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
> >  {
> >  	if (!ftrace->graph_noirqs)
> > @@ -642,6 +681,21 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
> >  		return -1;
> >  	}
> >  
> > +	if (set_tracing_funcgraph_args(ftrace) < 0) {
> > +		pr_err("failed to set tracing option funcgraph-args\n");
> > +		return -1;
> > +	}
> > +
> > +	if (set_tracing_funcgraph_retval(ftrace) < 0) {
> > +		pr_err("failed to set tracing option funcgraph-retval\n");
> > +		return -1;
> > +	}
> > +
> > +	if (set_tracing_funcgraph_retaddr(ftrace) < 0) {
> > +		pr_err("failed to set tracing option funcgraph-retaddr\n");
> > +		return -1;
> > +	}
> > +
> >  	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
> >  		pr_err("failed to set tracing option funcgraph-irqs\n");
> >  		return -1;
> > @@ -1607,6 +1661,10 @@ static int parse_graph_tracer_opts(const struct option *opt,
> >  	int ret;
> >  	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
> >  	struct sublevel_option graph_tracer_opts[] = {
> > +		{ .name = "args",		.value_ptr = &ftrace->graph_args },
> > +		{ .name = "retval",		.value_ptr = &ftrace->graph_retval },
> > +		{ .name = "retval-hex",		.value_ptr = &ftrace->graph_retval_hex },
> > +		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
> >  		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
> >  		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
> >  		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
> > @@ -1699,7 +1757,7 @@ int cmd_ftrace(int argc, const char **argv)
> >  	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
> >  		     "Set nograph filter on given functions", parse_filter_func),
> >  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> > -		     "Graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
> > +		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
> >  		     parse_graph_tracer_opts),
> >  	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
> >  		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
> > diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> > index a9bc47da83a5..782c33227e92 100644
> > --- a/tools/perf/util/ftrace.h
> > +++ b/tools/perf/util/ftrace.h
> > @@ -29,6 +29,10 @@ struct perf_ftrace {
> >  	int			graph_depth;
> >  	int			func_stack_trace;
> >  	int			func_irq_info;
> > +	int			graph_args;
> > +	int			graph_retval;
> > +	int			graph_retval_hex;
> > +	int			graph_retaddr;
> >  	int			graph_nosleep_time;
> >  	int			graph_noirqs;
> >  	int			graph_verbose;
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Cheers,
> Changbin Du
