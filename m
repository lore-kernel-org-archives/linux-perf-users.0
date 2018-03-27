From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf tools: Add a dso_size option to perf report --sort
Date: Tue, 27 Mar 2018 12:45:07 -0300
Message-ID: <20180327154507.GB3043@kernel.org>
References: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
 <20180327112702.GQ13724@tassilo.jf.intel.com>
 <20180327090507.622cba7cac16a7e812170067@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327090507.622cba7cac16a7e812170067@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@arm.com>
Cc: Andi Kleen <ak@linux.intel.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Mar 27, 2018 at 09:05:07AM -0500, Kim Phillips escreveu:
> On Tue, 27 Mar 2018 04:27:02 -0700
> Andi Kleen <ak@linux.intel.com> wrote:
> 
> > On Tue, Mar 27, 2018 at 06:09:56AM -0500, Kim Phillips wrote:
> > > Add DSO size to perf report/top sort output list.
> > > 
> > > This includes adding a map__size fn to map.h, which is
> > > approximately equal to the DSO data file_size:
> > 
> > What's the point of knowing the size?  
 
> I think it's just an extra convenience over symbol_size (added in
> commit 7768f8dada66d6  "perf tools: Allow sorting by symbol size") for
> tools developers' aggregation statistics.

Yeah, for completeness, may be useful for someone, probably for Maxim?
:-)
 
> > Most of the DSO may not be faulted in. If anything the working
> > set would be more interesting. This would need more changes
> > though.
> 
> Indeed.  Maxim?

Right, that would be another interesting metric to have,

- Arnaldo
