From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf probe and bitfields
Date: Fri, 26 Jan 2018 15:56:56 +0900
Message-ID: <20180126065656.GD22737@sejong>
References: <52f06b83-1065-dc88-756e-7f8fffc5c21e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:47364 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeAZG46 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Jan 2018 01:56:58 -0500
Content-Disposition: inline
In-Reply-To: <52f06b83-1065-dc88-756e-7f8fffc5c21e@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Perf Users <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

Hi David,

On Fri, Jan 19, 2018 at 08:43:50AM -0800, David Ahern wrote:
> Hi Arnaldo / Masami:
> 
> Are there known issues / limitations with perf probe and bitfields?
> 
> Here's an example: pkt_type is a bitfield in sk_buff. When I put a probe
> in arp_rcv to examine the pkt_type value:
> 
> $ perf probe 'arp_rcv ptype=skb->pkt_type dev=dev->name:string'

Bitfield type takes 3 parameters according to the Doc/perf-probe.txt.
Maybe it's like 'ptype=skb->pkt_type:b3@0/8' ?

Thanks,
Namhyung


> 
> I only get '0' output:
> 
> $ perf script
>      vhost-27472 27483 [013] 4313207.619714: probe:arp_rcv:
> (ffffffff815653b0) ptype=0 dev="br1"
>      vhost-27472 27483 [013] 4313207.619763: probe:arp_rcv:
> (ffffffff815653b0) ptype=0 dev="br1"
>      vhost-27472 27483 [013] 4313210.588990: probe:arp_rcv:
> (ffffffff815653b0) ptype=0 dev="br1"
> 
> when I know broadcast packet are getting handled (pkt_type ==
> PACKET_BROADCAST). This is confirmed by adding a printk to arp_rcv.
> 
> Thanks,
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
