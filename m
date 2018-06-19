From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/3] perf stat: Remove duplicate event counting
Date: Tue, 19 Jun 2018 12:17:06 -0300
Message-ID: <20180619151706.GJ20477@kernel.org>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-3-tmricht@linux.ibm.com>
 <20180615082124.GG5082@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615082124.GG5082@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jun 15, 2018 at 10:21:24AM +0200, Jiri Olsa escreveu:
> On Thu, Jun 14, 2018 at 01:48:45PM +0200, Thomas Richter wrote:
> 
> SNIP
> 
> > +static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
> > +				char **new_str)
> > +{
> > +	if (!*old_str)
> > +		goto set_new;
> > +
> > +	if (*new_str) {	/* Have new string, check with old */
> > +		if (strcasecmp(*old_str, *new_str))
> > +			pr_debug("alias %s differs in field '%s'\n",
> > +				 name, field);
> > +		zfree(old_str);
> > +	} else		/* Nothing new --> keep old string */
> > +		return;
> > +set_new:
> > +	*old_str = *new_str;
> > +	*new_str = NULL;
> > +}
> > +
> > +static void perf_pmu_update_alias(struct perf_pmu_alias *old,
> > +				  struct perf_pmu_alias *newalias)
> > +{
> > +	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
> > +	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
> > +			    &newalias->long_desc);
> > +	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
> > +	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
> > +			    &newalias->metric_expr);
> > +	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
> > +			    &newalias->metric_name);
> > +	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
> > +	old->scale = newalias->scale;
> > +	old->per_pkg = newalias->per_pkg;
> > +	old->snapshot = newalias->snapshot;
> > +	memcpy(old->unit, newalias->unit, sizeof(old->unit));
> > +}
> > +
> > +/* Delete an alias entry. */
> > +static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> > +{
> > +	zfree(&newalias->name);
> > +	zfree(&newalias->desc);
> > +	zfree(&newalias->long_desc);
> > +	zfree(&newalias->topic);
> > +	zfree(&newalias->str);
> > +	zfree(&newalias->metric_expr);
> > +	zfree(&newalias->metric_name);
> > +	parse_events_terms__purge(&newalias->terms);
> > +	free(newalias);
> > +}
> > +
> > +/* Merge an alias, search in alias list. If this name is already
> > + * present merge both of them to combine all information.
> > + */
> > +static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
> > +				 struct list_head *alist)
> > +{
> > +	struct perf_pmu_alias *a;
> > +
> > +	list_for_each_entry(a, alist, list) {
> > +		if (!strcasecmp(newalias->name, a->name)) {
> > +			perf_pmu_update_alias(a, newalias);
> > +			perf_pmu_free_alias(newalias);
> > +			return true;
> > +		}
> > +	}
> > +	return false;
> > +}
> 
> ok, I like your change better.. we can rebuilt it to use
> rb tree later when we have this fixed

Ok, can I take this as an Acked-by or Reviewed-by?

- Arnaldo
