From: Masami Hiramatsu <masami.hiramatsu@gmail.com>
Subject: Re: perf probe and bitfields
Date: Sat, 27 Jan 2018 14:04:59 +0900
Message-ID: <20180127140459.8e54eefcf9d74609cbcaa739@gmail.com>
References: <52f06b83-1065-dc88-756e-7f8fffc5c21e@gmail.com>
        <20180126065656.GD22737@sejong>
        <b506165b-22bf-db70-0ef5-30c4ee4e2295@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:37389 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeA0FFD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 Jan 2018 00:05:03 -0500
Received: by mail-pg0-f41.google.com with SMTP id z17so1437730pgc.4
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jan 2018 21:05:03 -0800 (PST)
In-Reply-To: <b506165b-22bf-db70-0ef5-30c4ee4e2295@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Perf Users <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

On Fri, 26 Jan 2018 09:28:49 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 1/25/18 11:56 PM, Namhyung Kim wrote:
> > Hi David,
> > 
> > On Fri, Jan 19, 2018 at 08:43:50AM -0800, David Ahern wrote:
> >> Hi Arnaldo / Masami:
> >>
> >> Are there known issues / limitations with perf probe and bitfields?
> >>
> >> Here's an example: pkt_type is a bitfield in sk_buff. When I put a probe
> >> in arp_rcv to examine the pkt_type value:
> >>
> >> $ perf probe 'arp_rcv ptype=skb->pkt_type dev=dev->name:string'
> > 
> > Bitfield type takes 3 parameters according to the Doc/perf-probe.txt.
> > Maybe it's like 'ptype=skb->pkt_type:b3@0/8' ?
> 
> missed that. Thanks, Namyhung.



Hmm, if you have debuginfo, it must be automatically translated.
E.g.

$ sudo perf probe -D "arp_rcv ptype=skb->pkt_type dev=dev->name:string"
p:probe/arp_rcv _text+8135904 ptype=+144(%di):b3@5/8 dev=+0(%si):string

So as you can see the ptype automatically has ":b3@5/8" types.

Thanks,

-- 
Masami Hiramatsu
