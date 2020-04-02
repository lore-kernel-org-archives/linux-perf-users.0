From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v8 6/7] tools/perf: Enable Hz/hz prinitg for
 --metric-only option
Date: Thu, 2 Apr 2020 13:42:06 -0700
Message-ID: <20200402204206.GB397326@tassilo.jf.intel.com>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
 <20200401203340.31402-7-kjain@linux.ibm.com>
 <20200402124946.GH2518490@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200402124946.GH2518490@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 9e757d18d713..679aaa655824 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -237,8 +237,6 @@ static bool valid_only_metric(const char *unit)
> >  	if (!unit)
> >  		return false;
> >  	if (strstr(unit, "/sec") ||
> > -	    strstr(unit, "hz") ||
> > -	    strstr(unit, "Hz") ||
> 
> will this change output of --metric-only for some setups then?
> 
> Andi, are you ok with this?

Yes should be ok

$ grep -i ScaleUnit.*hz arch/x86/*/* 
$ 

Probably was for some metric we later dropped.

-Andi
