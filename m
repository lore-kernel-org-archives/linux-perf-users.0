From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 09/11] perf tools report: Add custom scripts to script
 menu
Date: Mon, 11 Mar 2019 11:34:55 -0700
Message-ID: <20190311183455.GB29294@tassilo.jf.intel.com>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-10-andi@firstfloor.org>
 <20190311181021.GT10690@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311181021.GT10690@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> Isn't it better to use 'scripts' for those scripts and leave 'script'
> for configuring the 'perf script' command like we have options for
> annotate, etc?

Yes that's fine.

That's just two character updates in the doc and in the strstarts below. 
If there's nothing else can you please just do these changes when you apply?

Thanks.

> > +static int scripts_config(const char *var, const char *value, void *data)
> > +{
> > +	struct script_config *c = data;
> > +
> > +	if (!strstarts(var, "script."))
> > +		return -1;
