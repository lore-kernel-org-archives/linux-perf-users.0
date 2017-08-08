From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Not getting PMC events on Broadwell-EX
Date: Tue, 08 Aug 2017 09:32:25 -0700
Message-ID: <878tiu3tra.fsf@firstfloor.org>
References: <B10BA2E5-3BC7-481F-8EC7-DFEB229526EC@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65020 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbdHHQc1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2017 12:32:27 -0400
In-Reply-To: <B10BA2E5-3BC7-481F-8EC7-DFEB229526EC@vmware.com> (H. Taheri's
        message of "Mon, 7 Aug 2017 21:37:19 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "H. Taheri" <rezato@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

"H. Taheri" <rezato@gmail.com> writes:

> I am getting 0s, or <not supported>, or <not counted>  for events that are supposed to work on this processor. For example, according to Intel documentation, L2_RQSTS.MISS and L2_RQSTS.REFERENCES are supported on this processor with event code 0x24 and unit masks 0x3f and 0xff. But when I run perf stat (also with -d -d -d to see if the built-in command options can get the cache stats), I get:
>
> [root@prme-perf-broadwell-2 intel]# perf stat -d -d -d -e cycles -e instructions -e r24ff -e r243f sleep 10

You're missing -a, so it's only measuring sleep itself.

-Andi
