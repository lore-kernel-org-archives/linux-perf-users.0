From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf stat: Add transaction flag (-T) support for s390
Date: Fri, 22 Jun 2018 07:31:08 -0700
Message-ID: <20180622143108.GW30690@tassilo.jf.intel.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
 <20180621080452.61012-4-tmricht@linux.ibm.com>
 <87in6bsg2z.fsf@linux.intel.com>
 <57f6e02e-a8e8-73fb-11d1-24fb6b5e2e9a@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57f6e02e-a8e8-73fb-11d1-24fb6b5e2e9a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

> > 
> > You may need to add support for wildcard pmus to it.
> > 
> > -Andi
> > 
> 
> Currently only one PMU on s390 does support transactions, its the PMU with counters
> named cpum_cf.

Right, but you don't want to hard code that pmu into builtin-stat.

-Andi
