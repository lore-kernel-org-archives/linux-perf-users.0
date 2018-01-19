From: David Ahern <dsahern@gmail.com>
Subject: perf probe and bitfields
Date: Fri, 19 Jan 2018 08:43:50 -0800
Message-ID: <52f06b83-1065-dc88-756e-7f8fffc5c21e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33579 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755899AbeASQnw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Jan 2018 11:43:52 -0500
Received: by mail-pg0-f50.google.com with SMTP id u1so1836813pgr.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2018 08:43:52 -0800 (PST)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Perf Users <linux-perf-users@vger.kernel.org>

Hi Arnaldo / Masami:

Are there known issues / limitations with perf probe and bitfields?

Here's an example: pkt_type is a bitfield in sk_buff. When I put a probe
in arp_rcv to examine the pkt_type value:

$ perf probe 'arp_rcv ptype=skb->pkt_type dev=dev->name:string'

I only get '0' output:

$ perf script
     vhost-27472 27483 [013] 4313207.619714: probe:arp_rcv:
(ffffffff815653b0) ptype=0 dev="br1"
     vhost-27472 27483 [013] 4313207.619763: probe:arp_rcv:
(ffffffff815653b0) ptype=0 dev="br1"
     vhost-27472 27483 [013] 4313210.588990: probe:arp_rcv:
(ffffffff815653b0) ptype=0 dev="br1"

when I know broadcast packet are getting handled (pkt_type ==
PACKET_BROADCAST). This is confirmed by adding a printk to arp_rcv.

Thanks,
David
