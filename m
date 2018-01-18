From: Dmitry Menshikov <d.menshikov@gmail.com>
Subject: Slow tcp_write_xmit/tcp_ack syscalls with a lot of save_stack calls
 on OpenVZ kernel
Date: Thu, 18 Jan 2018 10:28:35 +0200
Message-ID: <CAFNYHvrWHfUr3bbid1iEfGTwP53g5r=fGmvSsRRtamSfJLFO=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:37946 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeARI2i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Jan 2018 03:28:38 -0500
Received: by mail-lf0-f48.google.com with SMTP id g72so19992666lfg.5
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2018 00:28:37 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi! I'm new in kernel debugging, so I'm asking for help.

I ran into a trouble with bad network performance on Centos. The issue
was observed on the latest OpenVZ RHEL7 kernel (3.10 based) on Dell
server with 24 cores and Broadcom 5720 NIC. No matter it was host
system or OpenVZ container. Server receives RTMP connections and
reproxy RTMP streams to another consumers. Reads and writes was
unstable and streams froze periodically for a few seconds.

I've started to check system using strace and perf. Strace affects
system heavily and seems that only perf may help. I've used OpenVZ
debug kernel with debugfs enabled. I've found that system spends too
much time in swapper process (according to perf data). I've built
flame graph for the system under load (100mbit in data, 200 mbit out)
and have noticed that kernel spent too much time in tcp_write_xmit and
tcp_ack. On the top of these calls I see save_stack syscalls.

On another hand, I tested the same scenario on Amazon EC2 instance
(latest Amazon Linux AMI 2017.09) and perf doesn't track such issues.
Total amount of samples was 300000, system spends 82% of time
according to perf samples in swapper, but net_rx_action (and as
consequent tcp_write_xmit and tcp_ack) in swapper takes only 1797
samples (0.59% of total amount of samples). On the top of
net_rx_action call in flame graph I don't see any calls related to
stack traces.

https://i.stack.imgur.com/XdnBT.png

Output of OpenVZ system looks differently. Among 1833152 samples
500892 (27%) was in swapper process, 194289 samples (10.5%) was in
net_rx_action.

https://i.stack.imgur.com/BCtil.png

Full svg of calls on vzkernel7 is here
(https://www.dropbox.com/s/n2g2cywakhl58mb/vzkernel7_all_processes.svg?dl=0)
and svg of EC2 instance calls is here
(https://www.dropbox.com/s/gh0uxltxa1ws0ir/ec2_all_processes.svg?dl=0).

So, I want to ask for help and I have few questions.

1) Why flame graph from EC2 instance doesn't contain so much
save_stack calls like my server?
2) Does perf forces system to call save_stack or it's some kernel
setting? May it be disabled and how?
3) Does Xen on EC2 guest process all tcp_ack and other syscalls? Is it
possible that host system on EC2 server makes some job and guest
system doesn't see it?

Thank you for a help.


-- 
Yours truly, Dmitry Menshikov
http://dmenshikov.com
