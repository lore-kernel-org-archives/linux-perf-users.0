From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Date: Mon, 20 Jul 2020 21:21:33 +0200
Message-ID: <20200720192133.GM760733@krava>
References: <20200720070127.109234-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200720070127.109234-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>, ak@linux.intel.com
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jul 20, 2020 at 12:31:22PM +0530, Kajol Jain wrote:
> Patchset enhance current runtime parameter support. It introduces new
> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> used to specify perpkg events. 
> 
> The "PerCore" and "PerChip" specifies whether its core or chip events.
> Based on which we can decide which runtime parameter user want to
> access. Now character  '?' can refers different parameter based on user
> requirement.
> 
> Initially, every time we want to add new terms like chip, core, thread
> etc, we need to create corrsponding fields in pmu_events and event
> struct.
> This patchset adds an enum called 'aggr_mode_class' which store all these
> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined. I try to test it with  my current setup.
> 
> I also need to replace PerPkg field to AggregationMode in all the
> x86 uncore json files. It will great if Andi and team can test it
> and let me know if they have any concerns.
> 
> Changelog:
> v3 -> v4:
> - Include pmu-events.h header file in jevents.c and remove
>   redecalaration of enum aggr_mode_class as Suggested by Jiri.
> - Add Acked-by tag.

looks good to me, but still missing reaction from people maintaining
intel's jsons

jirka
