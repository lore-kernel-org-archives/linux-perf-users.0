From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 3/3] perf stat: Remove duplicate event counting
Date: Fri, 15 Jun 2018 10:56:16 +0200
Message-ID: <351a9e7d-5cca-57ae-8e87-4a792bde5ecd@linux.ibm.com>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-3-tmricht@linux.ibm.com> <20180615082124.GG5082@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615082124.GG5082@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 06/15/2018 10:21 AM, Jiri Olsa wrote:
> On Thu, Jun 14, 2018 at 01:48:45PM +0200, Thomas Richter wrote:
> 
> SNIP
> 
>> +static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
>> +				char **new_str)
>> +{
>> +	if (!*old_str)
>> +		goto set_new;
>> +
>> +	if (*new_str) {	/* Have new string, check with old */
>> +		if (strcasecmp(*old_str, *new_str))
>> +			pr_debug("alias %s differs in field '%s'\n",
>> +				 name, field);
>> +		zfree(old_str);
>> +	} else		/* Nothing new --> keep old string */
>> +		return;
>> +set_new:
>> +	*old_str = *new_str;
>> +	*new_str = NULL;
>> +}
>> +
>> +static void perf_pmu_update_alias(struct perf_pmu_alias *old,
>> +				  struct perf_pmu_alias *newalias)
>> +{
>> +	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
>> +	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
>> +			    &newalias->long_desc);
>> +	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
>> +	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
>> +			    &newalias->metric_expr);
>> +	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
>> +			    &newalias->metric_name);
>> +	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
>> +	old->scale = newalias->scale;
>> +	old->per_pkg = newalias->per_pkg;
>> +	old->snapshot = newalias->snapshot;
>> +	memcpy(old->unit, newalias->unit, sizeof(old->unit));
>> +}
>> +
>> +/* Delete an alias entry. */
>> +static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>> +{
>> +	zfree(&newalias->name);
>> +	zfree(&newalias->desc);
>> +	zfree(&newalias->long_desc);
>> +	zfree(&newalias->topic);
>> +	zfree(&newalias->str);
>> +	zfree(&newalias->metric_expr);
>> +	zfree(&newalias->metric_name);
>> +	parse_events_terms__purge(&newalias->terms);
>> +	free(newalias);
>> +}
>> +
>> +/* Merge an alias, search in alias list. If this name is already
>> + * present merge both of them to combine all information.
>> + */
>> +static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>> +				 struct list_head *alist)
>> +{
>> +	struct perf_pmu_alias *a;
>> +
>> +	list_for_each_entry(a, alist, list) {
>> +		if (!strcasecmp(newalias->name, a->name)) {
>> +			perf_pmu_update_alias(a, newalias);
>> +			perf_pmu_free_alias(newalias);
>> +			return true;
>> +		}
>> +	}
>> +	return false;
>> +}
> 
> ok, I like your change better.. we can rebuilt it to use
> rb tree later when we have this fixed
> 
> thanks,
> jirka
> 

Thanks for the review. I will resend the patch set later today when I have added
Arnaldo's comments.
After that we add your rb tree stuff.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
