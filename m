From: Dennis Gnad <dennis.gnad@kit.edu>
Subject: Re: Understanding timestamps in perf.data
Date: Thu, 3 Sep 2015 11:50:13 +0200
Message-ID: <55E817D5.4070505@kit.edu>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
 <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
 <87oahk4ock.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from scc-mailout-kit-02.scc.kit.edu ([129.13.231.82]:60539 "EHLO
	scc-mailout-kit-02.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692AbbICJu2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Sep 2015 05:50:28 -0400
In-Reply-To: <87oahk4ock.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 02.09.2015 21:23, Andi Kleen wrote:
> David Ahern <dsahern@gmail.com> writes:
>> The counter values are not relevant for profiling. They are programmed
>> to rollover and generate an NMI which causes the sample to be taken.
> Actually it's relevent if you use adaptive frequency mode
> (-F or default, not using -c) because it varies then.
>
> The count values are reported by default in perf script.
>
> -Andi
Was this only more recently added to perf? I can't see it for kernel 3.16.
