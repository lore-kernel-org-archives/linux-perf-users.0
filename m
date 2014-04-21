From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: recording rapl/power events
Date: Mon, 21 Apr 2014 10:07:00 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1404211004570.10033@vincent-weaver-1.um.maine.edu>
References: <5354D05C.8080201@metascale.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:57154 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbaDUODk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Apr 2014 10:03:40 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so4043884qcx.27
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2014 07:03:39 -0700 (PDT)
In-Reply-To: <5354D05C.8080201@metascale.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrien BAK <adrien.bak@metascale.org>
Cc: linux-perf-users@vger.kernel.org

On Mon, 21 Apr 2014, Adrien BAK wrote:

> However, it seems that I can't record a sequence of power events :
> 
> perf record -a -e power/energy-pkg/ sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
> event (power/energy-pkg/).
> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=y kernel support configured?

RAPL events cannot generate interrupts, so I don't think you can sample 
like this.

You can possibly sample using some other event (like one of the software 
clock events) and include the RAPL event in the list of events to record, 
not sure if that will accomplish what you're trying to do.

Vince
