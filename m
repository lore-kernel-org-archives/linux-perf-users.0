From: David Ahern <dsahern@gmail.com>
Subject: Re: perf probe and bitfields
Date: Tue, 30 Jan 2018 09:53:19 -0700
Message-ID: <2a2ba32f-2c71-d81d-252c-dffe0ca1c002@gmail.com>
References: <52f06b83-1065-dc88-756e-7f8fffc5c21e@gmail.com>
 <20180126065656.GD22737@sejong>
 <b506165b-22bf-db70-0ef5-30c4ee4e2295@gmail.com>
 <20180127140459.8e54eefcf9d74609cbcaa739@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:45076 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeA3QxV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Jan 2018 11:53:21 -0500
Received: by mail-pf0-f177.google.com with SMTP id a88so9590329pfe.12
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2018 08:53:21 -0800 (PST)
In-Reply-To: <20180127140459.8e54eefcf9d74609cbcaa739@gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Perf Users <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

On 1/26/18 10:04 PM, Masami Hiramatsu wrote:
> On Fri, 26 Jan 2018 09:28:49 -0700
> David Ahern <dsahern@gmail.com> wrote:
> 
>> On 1/25/18 11:56 PM, Namhyung Kim wrote:
>>> Hi David,
>>>
>>> On Fri, Jan 19, 2018 at 08:43:50AM -0800, David Ahern wrote:
>>>> Hi Arnaldo / Masami:
>>>>
>>>> Are there known issues / limitations with perf probe and bitfields?
>>>>
>>>> Here's an example: pkt_type is a bitfield in sk_buff. When I put a probe
>>>> in arp_rcv to examine the pkt_type value:
>>>>
>>>> $ perf probe 'arp_rcv ptype=skb->pkt_type dev=dev->name:string'
>>>
>>> Bitfield type takes 3 parameters according to the Doc/perf-probe.txt.
>>> Maybe it's like 'ptype=skb->pkt_type:b3@0/8' ?
>>
>> missed that. Thanks, Namyhung.
> 
> 
> 
> Hmm, if you have debuginfo, it must be automatically translated.
> E.g.
> 
> $ sudo perf probe -D "arp_rcv ptype=skb->pkt_type dev=dev->name:string"
> p:probe/arp_rcv _text+8135904 ptype=+144(%di):b3@5/8 dev=+0(%si):string
> 
> So as you can see the ptype automatically has ":b3@5/8" types.

I was expecting it to automatically figure that out. The kernels in
question were custom built and the vmlinux must not have been available.

Thanks the tip.
