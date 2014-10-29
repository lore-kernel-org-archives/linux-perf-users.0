From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 20:21:57 +0100
Message-ID: <54513E55.9060503@insa-lyon.fr>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu> <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr> <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu> <545136EF.9030503@insa-lyon.fr> <alpine.DEB.2.11.1410291509160.895@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.insa-lyon.fr ([134.214.182.244]:42211 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbaJ2TWP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 15:22:15 -0400
In-Reply-To: <alpine.DEB.2.11.1410291509160.895@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Yes the problem is there ! Thanks I am not enough "fluent" in kernel 
code to identify this. Here is my dmesg:

perf_event_intel: PEBS disabled due to CPU errata, please upgrade microcode

Does it mean that I must "upgrade my hardware" through the upgrade of 
microcode ? I never did such a thing.

Manu

On 10/29/2014 08:12 PM, Vince Weaver wrote:
> On Wed, 29 Oct 2014, Manuel Selva wrote:
>
>> Yes, perf mem doesn't work on my Sandy Bridge. I should be missing something,
>> maybe a kernel parameter somewhere, or something like that, but I don't know
>> where searching ...
>
> well if you're getting operation not supported you are probably running
> into this chunk of code in arch/x86/kernel/cpu/perf_event.c
>
>
> int x86_pmu_hw_config(struct perf_event *event)
> {
>          if (event->attr.precise_ip) {
>                  int precise = 0;
>
>                  /* Support for constant skid */
>                  if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
>                          precise++;
>
>                          /* Support for IP fixup */
>                          if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >= 2)
>                                  precise++;
>                  }
>
>                  if (event->attr.precise_ip > precise)
>                          return -EOPNOTSUPP;
>
>
>
> and if you look, pebs_broken can be enabled on Sandybridge CPUs due to
> firmware errata.  Did you check your dmesg for messages starting with
> PEBS?
>
> Vince
>
