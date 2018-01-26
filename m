From: David Ahern <dsahern@gmail.com>
Subject: Re: perf probe and bitfields
Date: Fri, 26 Jan 2018 09:28:49 -0700
Message-ID: <b506165b-22bf-db70-0ef5-30c4ee4e2295@gmail.com>
References: <52f06b83-1065-dc88-756e-7f8fffc5c21e@gmail.com>
 <20180126065656.GD22737@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:40845 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeAZQ25 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Jan 2018 11:28:57 -0500
Received: by mail-pf0-f175.google.com with SMTP id i66so574401pfd.7
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jan 2018 08:28:56 -0800 (PST)
In-Reply-To: <20180126065656.GD22737@sejong>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Perf Users <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

On 1/25/18 11:56 PM, Namhyung Kim wrote:
> Hi David,
> 
> On Fri, Jan 19, 2018 at 08:43:50AM -0800, David Ahern wrote:
>> Hi Arnaldo / Masami:
>>
>> Are there known issues / limitations with perf probe and bitfields?
>>
>> Here's an example: pkt_type is a bitfield in sk_buff. When I put a probe
>> in arp_rcv to examine the pkt_type value:
>>
>> $ perf probe 'arp_rcv ptype=skb->pkt_type dev=dev->name:string'
> 
> Bitfield type takes 3 parameters according to the Doc/perf-probe.txt.
> Maybe it's like 'ptype=skb->pkt_type:b3@0/8' ?

missed that. Thanks, Namyhung.
