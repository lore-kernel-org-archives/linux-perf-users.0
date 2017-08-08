From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Not getting PMC events on Broadwell-EX
Date: Tue, 8 Aug 2017 09:53:24 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1708080951470.8732@macbook-air>
References: <B10BA2E5-3BC7-481F-8EC7-DFEB229526EC@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36471 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbdHHNxb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2017 09:53:31 -0400
Received: by mail-io0-f178.google.com with SMTP id g35so13923967ioi.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Aug 2017 06:53:31 -0700 (PDT)
In-Reply-To: <B10BA2E5-3BC7-481F-8EC7-DFEB229526EC@vmware.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "H. Taheri" <rezato@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, 7 Aug 2017, H. Taheri wrote:

> I am getting 0s, or <not supported>, or <not counted> for events that 
> are supposed to work on this processor. For example, according to Intel 
> documentation, L2_RQSTS.MISS and L2_RQSTS.REFERENCES are supported on 
> this processor with event code 0x24 and unit masks 0x3f and 0xff. But 
> when I run perf stat (also with -d -d -d to see if the built-in command 
> options can get the cache stats), I get:

Check your docs on the order for the fields.

You can use libpfm4 as so:
	./check_events L2_RQSTS:MISS
	Requested Event: L2_RQSTS:MISS
	Actual    Event: 
	bdw_ep::L2_RQSTS:MISS:k=1:u=1:e=0:i=0:c=0:t=0:intx=0:intxcp=0
	PMU            : Intel Broadwell EP
	IDX            : 421527583
	Codes          : 0x533f24

You want the umask first, then the event (0x3f24)

Vince
