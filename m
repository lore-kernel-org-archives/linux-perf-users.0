From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 2/5] perf/jevents: Add new structure to pass json
 fields.
Date: Mon, 31 Aug 2020 10:43:57 +0200
Message-ID: <20200831084357.GC287892@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-3-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200827130958.189146-3-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Aug 27, 2020 at 06:39:55PM +0530, Kajol Jain wrote:

SNIP

> -	if (!*field)						\
> +#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
> +	je->field = strdup(es->field);				\
> +	if (!je->field)						\
>  		return -ENOMEM;					\
>  } } while (0)
>  
> @@ -428,11 +440,7 @@ static void free_arch_std_events(void)
>  	}
>  }
>  
> -static int save_arch_std_events(void *data, char *name, char *event,
> -				char *desc, char *long_desc, char *pmu,
> -				char *unit, char *perpkg, char *metric_expr,
> -				char *metric_name, char *metric_group,
> -				char *deprecated, char *metric_constraint)
> +static int save_arch_std_events(void *data, struct json_event *je)
>  {
>  	struct event_struct *es;
>  
> @@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
>  		return NULL;
>  
>  	for (i = 0; fixed[i].name; i++)
> -		if (!strcasecmp(name, fixed[i].name))
> -			return (char *)fixed[i].event;
> +		if (!strcasecmp(name, fixed[i].name)) {
> +			strcpy(event, fixed[i].event);

hum what's this strcpy for in here? we're just replacing separated
variables with struct members, why do you need to copy the event in
here?

thanks,
jirka
