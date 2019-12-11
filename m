From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events
Date: Wed, 11 Dec 2019 12:38:02 -0800
Message-ID: <20191211203802.GB862919@tassilo.jf.intel.com>
References: <20191120084059.24458-1-kjain@linux.ibm.com>
 <ed80bcc2-a507-bcf8-9084-181b18b6a95f@linux.ibm.com>
 <20191211134528.GC15181@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191211134528.GC15181@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

> > But while looking at the patch, I found that, commit f01642e4912b
> > has (again) screwed up logic for metric with overlapping events.
> 
> Is someone looking into this?

Looks like we really need some proper regression tests for this.

-Andi
