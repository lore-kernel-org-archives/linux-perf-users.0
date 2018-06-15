From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/3] perf alias: Rebuild alias expression string to make
 it comparable
Date: Fri, 15 Jun 2018 10:12:42 +0200
Message-ID: <20180615081242.GF5082@krava>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-2-tmricht@linux.ibm.com>
 <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jun 14, 2018 at 08:53:14AM -0500, Paul Clarke wrote:

SNIP

> > +		if (ret)
> > +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > +					 ",");
> > +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> > +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > +					 "%s=%#x", term->config, term->val.num);
> > +		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> > +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > +					 "%s=%s", term->config, term->val.str);
> 
> If we exceed 256, we just suddenly terminate the rebuilding without reporting any issues.
> 
> > +	}
> > +
> >  	alias->name = strdup(name);
> >  	if (dir) {
> >  		/*
> > @@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> >  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
> >  	}
> >  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
> > -	alias->str = strdup(val);
> > +	alias->str = strdup(newval);

hum, how is newval different from val? AFAICS it's the same

jirka
