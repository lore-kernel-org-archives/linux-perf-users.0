From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 07/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 11 Mar 2019 15:35:45 -0300
Message-ID: <20190311183545.GY10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-8-andi@firstfloor.org>
 <20190311172420.GC9664@krava>
 <20190311174605.GA29294@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311174605.GA29294@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 10:46:05AM -0700, Andi Kleen escreveu:
> On Mon, Mar 11, 2019 at 06:24:20PM +0100, Jiri Olsa wrote:
> > On Mon, Mar 11, 2019 at 07:44:58AM -0700, Andi Kleen wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> > > index 9e5f87558af6..cdba58447b85 100644
> > > --- a/tools/perf/ui/browsers/scripts.c
> > > +++ b/tools/perf/ui/browsers/scripts.c
> > > @@ -125,7 +125,7 @@ static int list_scripts(char *script_name, bool *custom,
> > >  	return ret;
> > >  }
> > >  
> > > -static void run_script(char *cmd)
> > > +void run_script(char *cmd)
> > >  {
> > >  	pr_debug("Running %s\n", cmd);
> > >  	SLang_reset_tty();
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index fd5d02c1a521..3a0e2bb40529 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -436,6 +436,13 @@ static int hist_entry__init(struct hist_entry *he,
> > >  			goto err_rawdata;
> > >  	}
> > >  
> > > +	if (symbol_conf.res_sample) {
> > > +		he->res_samples = calloc(sizeof(struct res_sample),
> > > +					symbol_conf.res_sample);
> > > +		if (!he->res_samples)
> > > +			return -ENOMEM;
> > > +	}
> > 
> > https://lore.kernel.org/lkml/20190311123227.GA26829@krava/
> 
> Here's an updated patch.

And here is the diff to what was before. Replaced the previous patch
with this one and I'm adding Jiri's Acked-by to the whole series, as he
provided me privately, thanks guys!

- Arnaldo


diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3a0e2bb40529..c2894013191a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -440,7 +440,7 @@ static int hist_entry__init(struct hist_entry *he,
 		he->res_samples = calloc(sizeof(struct res_sample),
 					symbol_conf.res_sample);
 		if (!he->res_samples)
-			return -ENOMEM;
+			goto err_srcline;
 	}
 
 	INIT_LIST_HEAD(&he->pairs.node);
@@ -453,6 +453,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_srcline:
+	free(he->srcline);
+
 err_rawdata:
 	free(he->raw_data);
 
