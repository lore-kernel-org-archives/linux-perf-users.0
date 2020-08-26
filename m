From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 12:57:12 +0200
Message-ID: <20200826105712.GE703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:

SNIP

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
> @@ -485,11 +476,8 @@ static char *real_event(const char *name, char *event)
>  }
>  
>  static int
> -try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> -	  char **name, char **long_desc, char **pmu, char **filter,
> -	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
> -	  char **metric_group, unsigned long long eventcode,
> -	  char **deprecated, char **metric_constraint)
> +try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
> +	  struct json_event *je)
>  {
>  	/* try to find matching event from arch standard values */
>  	struct event_struct *es;
> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>  		if (!strcmp(arch_std, es->name)) {
>  			if (!eventcode && es->event) {
>  				/* allow EventCode to be overridden */
> -				free(*event);
> -				*event = NULL;
> +				je->event = NULL;

should you free je->event in here?

jirka
