From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 1/3] perf jevents: Add support for parsing
 perchip/percore events
Date: Sun, 16 Aug 2020 09:35:21 -0700
Message-ID: <20200816163521.GF1486171@tassilo.jf.intel.com>
References: <20200816090719.72018-1-kjain@linux.ibm.com>
 <20200816090719.72018-2-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200816090719.72018-2-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

> @@ -321,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>  static int print_events_table_entry(void *data, char *name, char *event,
>  				    char *desc, char *long_desc,
>  				    char *pmu, char *unit, char *perpkg,
> -				    char *metric_expr,
> +				    char *metric_expr, char *aggr_mode,
>  				    char *metric_name, char *metric_group,
>  				    char *deprecated, char *metric_constraint)

We should really define a struct now to pass the parameters,
the callback prototype is getting ridiculous.

I know it's my fault originally, but sorry you probably have to do it
because you are touching it last.

-Andi
