From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Wed, 30 Jan 2019 23:33:08 +0100
Message-ID: <20190130223308.GA8145@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <87zhrhzxpo.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zhrhzxpo.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 30, 2019 at 12:39:47PM -0800, Andi Kleen wrote:
> Jiri Olsa <jolsa@redhat.com> writes:
> >
> > the patch adds check_eriod pmu callback.. I need to check if there's
> > better way to do this, but so far it fixes the crash for me
> >
> > if you guys could check this patch, that'd be great
> 
> There's already a limit_period callback, perhaps that could
> be extended. But ok, can do it this way too.

right, we call it within x86_perf_event_set_period to limit
the period, but I guess we should include this check after
changing the period:

        if (event->attr.sample_period && x86_pmu.limit_period) {
                if (x86_pmu.limit_period(event, event->attr.sample_period) >
                                event->attr.sample_period)
                        return -EINVAL;
        }

> 
> I suspect there are some other cases that need this callback, not
> just BTS, e.g. the checks in hsw_hw_config

ok, the sample_period values for checkpointed events,
we should check for this as well.. I'll add that

jirka
