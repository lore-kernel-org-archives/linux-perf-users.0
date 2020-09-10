From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v9 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Date: Thu, 10 Sep 2020 09:20:48 -0300
Message-ID: <20200910122048.GD4018363@kernel.org>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
 <20200907100529.GF1199773@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200907100529.GF1199773@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Sep 07, 2020 at 12:05:29PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 07, 2020 at 12:11:28PM +0530, Kajol Jain wrote:
> > Patchset enhance current runtime parameter support. It introduces new
> > fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> > used to specify perpkg events.
> > 
> > The "PerCore" and "PerChip" specifies whether its core or chip events.
> > Based on which we can decide which runtime parameter user want to
> > access. Now character  '?' can refers different parameter based on user
> > requirement.
> > 
> > Initially, every time we want to add new terms like chip, core, thread
> > etc, we need to create corrsponding fields in pmu_events and event
> > struct.
> > This patchset adds an enum called 'aggr_mode_class' which store all these
> > aggregation like perchip/percore. It also adds new field 'AggregationMode'
> > to capture these terms.
> > Now, if user wants to add any new term, they just need to add it in
> > the enum defined.
> > 
> > This patchset also adds  changes of adding new structure
> > called 'json_event' inside jevents.c
> > file to improve the callback prototype inside jevent file.
> > Initially, whenever user want to add new field, they need to update
> > in all function callback which makes it more and more complex with
> > increased number of parmeters.
> > With this change, we just need to add it in new structure 'json_event'.
> > link to the RFC patch: https://lkml.org/lkml/2020/8/25/217
> > 
> > Changelog:
> > v8 -> v9
> > - Free aggr_mode memory [Jiri Olsa].
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
