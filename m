From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v4 0/8] powerpc/perf: Add json file metric support for
 the hv_24x7 socket/chip level events
Date: Tue, 10 Mar 2020 15:18:36 -0300
Message-ID: <20200310181836.GA12036@kernel.org>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309093506.GB67774@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200309093506.GB67774@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 09, 2020 at 10:35:06AM +0100, Jiri Olsa escreveu:
> On Mon, Mar 09, 2020 at 11:55:44AM +0530, Kajol Jain wrote:
> > First patch of the patchset fix inconsistent results we are getting when
> > we run multiple 24x7 events.
> > 
> > Patchset adds json file metric support for the hv_24x7 socket/chip level
> > events. "hv_24x7" pmu interface events needs system dependent parameter
> > like socket/chip/core. For example, hv_24x7 chip level events needs
> > specific chip-id to which the data is requested should be added as part
> > of pmu events.
> > 
> > So to enable JSON file support to "hv_24x7" interface, patchset expose
> > total number of sockets and chips per-socket details in sysfs
> > files (sockets, chips) under "/sys/devices/hv_24x7/interface/".
> > 
> > To get sockets and number of chips per sockets, patchset adds a rtas call
> > with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
> > handles partition migration case to re-init these system depended
> > parameters by adding proper calls in post_mobility_fixup() (mobility.c).
> > 
> > Patch 6 & 8 of the patchset handles perf tool plumbing needed to replace
> > the "?" character in the metric expression to proper value and hv_24x7
> > json metric file for different Socket/chip resources.
> > 
> > Patch set also enable Hz/hz prinitg for --metric-only option to print
> > metric data for bus frequency.
> > 
> > Applied and tested all these patches cleanly on top of jiri's flex changes
> > with the changes done by Kan Liang for "Support metric group constraint"
> > patchset and made required changes.
> > 
> > Changelog:
> > v3 -> v4
> > - Made changes suggested by jiri.
> 
> could you please mention them next time? ;-)
> 
> > - Apply these patch on top of Kan liang changes.
> 
> Arnaldo, could you please pull the expr flex changes and Kan's
> metric group constraint changes? it's both prereq of this patchset

Both are now in my perf/core branch, will go upstream soon, should I go
and pickup the perf tooling bits in this patchkit?

- Arnaldo
