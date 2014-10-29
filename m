From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 15:12:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1410291509160.895@vincent-weaver-1.umelst.maine.edu>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu> <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr> <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu>
 <545136EF.9030503@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:57233 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332AbaJ2TFF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 15:05:05 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so880682qaq.15
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 12:05:04 -0700 (PDT)
In-Reply-To: <545136EF.9030503@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: Vince Weaver <vincent.weaver@maine.edu>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 29 Oct 2014, Manuel Selva wrote:

> Yes, perf mem doesn't work on my Sandy Bridge. I should be missing something,
> maybe a kernel parameter somewhere, or something like that, but I don't know
> where searching ...

well if you're getting operation not supported you are probably running 
into this chunk of code in arch/x86/kernel/cpu/perf_event.c


int x86_pmu_hw_config(struct perf_event *event)
{
        if (event->attr.precise_ip) {
                int precise = 0;

                /* Support for constant skid */
                if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
                        precise++;

                        /* Support for IP fixup */
                        if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >= 2) 
                                precise++;
                }

                if (event->attr.precise_ip > precise)
                        return -EOPNOTSUPP;



and if you look, pebs_broken can be enabled on Sandybridge CPUs due to 
firmware errata.  Did you check your dmesg for messages starting with 
PEBS?

Vince
