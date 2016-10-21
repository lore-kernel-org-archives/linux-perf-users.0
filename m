From: Taylor Andrews <andrewst@vmware.com>
Subject: Question about Perf's handling of in-use performance counters
Date: Fri, 21 Oct 2016 21:59:49 +0000
Message-ID: <BN3PR0501MB14590BFC82C2B45B81E56C1BA3D40@BN3PR0501MB1459.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:45141 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754387AbcJUWA5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2016 18:00:57 -0400
Received: from EX13-CAS-010.vmware.com (ex13-cas-010.vmware.com [10.113.191.62])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 6674AB05FA
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2016 15:00:56 -0700 (PDT)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi all,

From what I have seen, this list seems full of perf experts, so I am hoping=
 one or more experts will be able to help me understand some perf behavior =
we are seeing.

First some background:

VMware's virtual x86 performance counter implementation aims to expose in-u=
se (unavailable) performance counters to the guest operating system in the =
hopes that software agents will recognize it as an "in-use" resource and fo=
llow the PMU sharing guidelines outlined in Intel's Performance Monitoring =
Unit Sharing Guide (https://software.intel.com/en-us/articles/performance-m=
onitoring-unit-guidelines/).  There is also a VMware-based mechanism to for=
ce virtual performance counters to be exposed to the guest operating system=
 as in-use.  "In-use" is defined in the sharing guidelines as the enable bi=
ts being found to be set, either in the general purpose PMC's event select =
MSR, or in the case of fixed function counters, in the Fixed Counter Contro=
l MSR.

The Linux PMU driver looks like it currently complains about the BIOS being=
 "broken" if it finds any counters are in-use by it, but it still successfu=
lly initializes: https://github.com/torvalds/linux/blob/a5ebe0ba3dff658c528=
6e8d5f20e4328f719d5a3/arch/x86/kernel/cpu/perf_event.c#L181


The odd behavior:

When running perf in a VMware VM with virtualized x86 performance counters,=
 we sometimes see messages like the following in the log file:

2016-10-10T15:22:46.434-04:00| vcpu-1| I125: VPMC: The guest wrote to the e=
vent selector of in-use virtual performance counter 0, which is disallowed.
2016-10-10T15:22:46.435-04:00| vcpu-1| I125: VPMC: The guest wrote to the e=
vent selector of in-use virtual performance counter 0, which is disallowed.
2016-10-10T15:22:46.436-04:00| vcpu-1| I125: VPMC: The guest wrote to the e=
vent selector of in-use virtual performance counter 0, which is disallowed.

The VMware virtual hardware platform software drops writes to virtual count=
ers it exposes as in-use, and logs warnings similar to above.

We have tried perf 3.13.11-ckt39 on Linux kernel 3.13.0-92-generic, and per=
f 4.8.1 on Linux kernel  4.8.1.  In both cases, when we forcibly mark count=
ers as in-use, we see warnings similar to above. When this happens, we also=
 see perf sometimes report counts of 0 for the events it was attempting to =
count. =20

For example, rotate1 is a simple c++ binary that loops and should advance c=
ycles and instructions counts.  The following perf 3.13.11-ckt39 run was pe=
rformed in a VMware VM x86 that has VPMC enabled on Linux kernel 3.13.0-92-=
generic, and all of the generic counters were forcibly marked as in-use.=20

$ perf stat -e cycles -e instructions ./rotate1 10000
Took 9.519990 seconds

 Performance counter stats for './rotate1 10000':

                 0 cycles
                 0 instructions

      17.213091320 seconds time elapsed

By looking at these warnings, naively, it would appear perf is trying to us=
e counters that are marked as in-use.  I would like to investigate if this =
is expected perf behavior, or unexpected perf behavior.  I have no knowledg=
e about what perf's approach is to handle in-use counters, but I am hoping =
someone here might.  For example, if perf finds the Linux PMU driver has su=
ccessfully initialized, does it assume it has authoritative access to all t=
he counters?  If anyone has specific knowledge about how perf treats x86 pe=
rformance counters that it finds as "in-use" (such as counters that are bei=
ng used by BIOS, or host operating system), could you please reach out to m=
e?

Thanks,
Taylor=20
