From: "Pavey, Nicholas" <npavey@akamai.com>
Subject: Thoughts on processor vendor?
Date: Mon, 29 Dec 2014 09:33:08 -0500
Message-ID: <D0C6CFDE.B04E%npavey@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from prod-mail-xrelay08.akamai.com ([96.6.114.112]:42412 "EHLO
	prod-mail-xrelay08.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbaL2OkC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Dec 2014 09:40:02 -0500
Received: from prod-mail-xrelay08.akamai.com (localhost.localdomain [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id E5FF248762
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Dec 2014 14:33:11 +0000 (GMT)
Received: from prod-mail-relay09.akamai.com (prod-mail-relay09.akamai.com [172.27.22.68])
	by prod-mail-xrelay08.akamai.com (Postfix) with ESMTP id DA1144875D
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Dec 2014 14:33:11 +0000 (GMT)
Received: from email.msg.corp.akamai.com (usma1ex-cas2.msg.corp.akamai.com [172.27.123.31])
	by prod-mail-relay09.akamai.com (Postfix) with ESMTP id C09651E03D
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Dec 2014 14:33:11 +0000 (GMT)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi Perf experts,

What=B9s your opinion regarding tracing support (e.g. Performance count=
ers,
hardware debug features) in x86 processors developed by AMD and Intel.

I=B9m interested in whether the common tracing tools (perf, oprofile,
systemtap, lltng etc etc) are more mature on AMD=B9s or Intel=B9s syste=
ms (or
perhaps it doesn=B9t matter?), and whether there are any processor mode=
ls
that are particularly well supported or should be avoided.

=46or example, I=B9m considering a machine with an AMD A10 series proce=
ssor or
alternatively an Intel i5 series processor.

Just to be clear, I=B9m not trying to start a flame-war here! My questi=
on is
specific to tracing tooling support and not to relative performance, pr=
ice
or purchasing philosophy.

(Full disclosure: I worked for AMD for quite a while, so I=B9d prefer o=
ne of
their machines, but ultimately I=B9ll use whatever=B9s got the best too=
l
support. I could conceivably be convinced to contribute to support for
AMDs systems, but that=B9s another conversation!).

Thanks for your help,


Nick
