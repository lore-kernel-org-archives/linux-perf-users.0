From: David Ahern <daahern@cisco.com>
Subject: Re: perf script and raw events?
Date: Tue, 22 Mar 2011 17:17:34 -0600
Message-ID: <4D892E0E.3010505@cisco.com>
References: <20110322224116.GA3794@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:39911 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab1CVXTG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Mar 2011 19:19:06 -0400
In-Reply-To: <20110322224116.GA3794@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org



On 03/22/11 16:41, Arun Sharma wrote:
> David,
> 
> # perf record -agR -e cycles -- sleep 1
> # perf script
> 
> gives me nice list of stack traces. However if I use
> a raw event such as:
> 
> # perf record -agR -e r53003c -- sleep 1
> # perf script

Works fine for me (with your raw patch for perf-script):

# /tmp/build-perf/perf record -agR -e r53003c -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.147 MB perf.data (~6438 samples) ]

# /tmp/build-perf/perf script

perf 27684 [000] 180983.511378: raw 0x53003c:
        ffffffff810d696b put_mems_allowed ([kernel.kallsyms])
        ffffffff810cbfa9 perf_mmap_alloc_page ([kernel.kallsyms])
        ffffffff810ccd13 perf_mmap ([kernel.kallsyms])
        ffffffff810f1772 mmap_region ([kernel.kallsyms])
        ffffffff810f1c02 do_mmap_pgoff ([kernel.kallsyms])

...

What is that raw event? Where do you find the encodings for raw events?

David

> 
> I get no traces and perf script immediately exits. Do you know why?
> 
>  -Arun
