From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: Filter option should follow a tracer option
Date: Tue, 19 Sep 2017 18:16:16 -0500
Message-ID: <20170919181616.3f79792ed311051de61b6d3f@arm.com>
References: <2141818167.39420.1503049431846@office.mailbox.org>
        <20170822190011.GA31893@kernel.org>
        <a214874a-a271-729e-d253-731e648a10e6@intel.com>
        <98754540.17249.1503478275998@office.mailbox.org>
        <de75121e-cafc-0389-039b-fb038e0ff7c6@intel.com>
        <301454280.19507.1503490276770@office.mailbox.org>
        <20170823132251.GB31893@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbdISXQT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Sep 2017 19:16:19 -0400
In-Reply-To: <20170823132251.GB31893@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jack Henschel <jackdev@mailbox.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org

On Wed, 23 Aug 2017 10:22:51 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

Hi Arnaldo,

[adding tools/perf/util/evsel.c maintainers to cc]

> Em Wed, Aug 23, 2017 at 02:11:16PM +0200, Jack Henschel escreveu:
> > > Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um 12:33 geschrieben:
> > > On 23/08/17 11:51, Jack Henschel wrote:
> > > >> Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um 08:06 geschrieben:
> > > >> On 22/08/17 22:00, Arnaldo Carvalho de Melo wrote:
> > > >>> Em Fri, Aug 18, 2017 at 11:43:51AM +0200, Jack Henschel escreveu:
> > > >> Have you checked the value of /sys/bus/event_source/devices/intel_pt/nr_addr_filters ?
> > > > I don't have that file:
> > > 
> > > Which definitely means address filtering is not supported.  That is
> > > mentioned in the man page for 'perf record'.
> 
> > Ok, thanks for the clarification. It is mentioned in the perf record
> > man-page, but the perf error message could be a little bit more
> > specific for this issue. (e.g.
> > /sys/bus/event_source/devices/intel_pt/nr_addr_filters not present ->
> > "CPU does not support address filtering").
> 
> Right, I'll get that into some __strerror() function. Will CC you when
> that is done.
> 
> E.g. __strerror() function: perf_evsel__open_strerror(), that helps the
> user wrt errors returned by the perf_evsel__open() function:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=perf/core#n2669

I don't know if you've noticed, but I too am not very happy with the
way perf and/or various PMU drivers cannot report exact error
information back to the user.

I tried to inquire about alternatives to pr_err/dmesg, and gave David
Howell's supplemental error facility "errorf" a shot [1], which worked
nicely I thought until I chased David Howells down at Plumbers, where
he said Linus Torvalds had nacked it (on a mailing list whose archives
aren't publically accessible, linux-summit I think).

So, for any PMU drivers that can return a single error code for multiple
reasons, see e.g. [2], we're effectively back to square one, i.e., the
suboptimal pr_err/dmesg.

In this email thread's Intel-PT case, the fix is to add additional
error message text to perf userspace's perf_evsel__open_strerror() for
the additional possible condition(s) that can make the driver fail its
event_init(), and tell the user what the problem is, based on the
specific error code returned by the PMU driver.

In Arm arch, however, there is a greater variety of on- and off-core
(also called SoC) PMUs that do not have an as-consistent look and
feel as in x86, power, or s390 arches.  I'm also seeing a trend in x86
uncore drivers to have more error conditions than the on-core ones [3].

Back on Arm, though, the naive perf user usually gets confusing
messages, e.g., perf saying:

"PMU Hardware doesn't support sampling/overflow-interrupts."

if the user didn't supply an event sample period to record via -c.

Or "The arm_spe_0// event is not supported." instead of something like
"spe-pmu@0: not supported on CPU 4. Supported CPU list: 0-3"

I can - and intend on - cleaning up the most general Arm cases, and
aligning the PMU driver exit codes with new userspace text in evsel.c,
which may or may not agree with the existing x86 content.

Would you agree with this type of change, and if so, would you
prefer an ifdef on $ARCH, or a dynamic/runtime arch check?

I haven't attempted it yet, but imagine things will still be unclear
for the user in cases where there are too many PMU driver conditions
per single error code.  In that case, should the perf userspace report
the error, after having gained knowledge about the specific PMU in
use?  IOW, should userspace perf customize its error messages to the
PMU in the record -e parameter?

If yes, then consider the case of the Arm SPE driver, where the h/w
will only accept 256, 512, 768, 1024, 1536, 2048, 3072, 4096 values for
the event sample period (currently specified via "perf record -c <n>").
In order to inform the user of the possible values for the particular
version of the h/w, should the driver be modified to expose this
numeric list to the perf tool via /sys/bus/event_source/devices/?  It
could then emit something like this:

"spe-pmu@0: invalid sample period.  Valid values are 256, 512, 768,
1024, 1536, 2048, 3072, 4096"

Thanks for your input into these important perf usage case matters.

Kim

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1472313.html

[2] https://github.com/torvalds/linux/blob/master/drivers/perf/xgene_pmu.c#L899
https://github.com/torvalds/linux/blob/master/drivers/perf/qcom_l3_pmu.c#L486
https://github.com/torvalds/linux/blob/master/drivers/perf/qcom_l2_pmu.c#L473

[3] https://github.com/torvalds/linux/blob/master/arch/x86/events/intel/uncore_snb.c#L342
https://github.com/torvalds/linux/blob/master/arch/x86/events/amd/uncore.c#L184
