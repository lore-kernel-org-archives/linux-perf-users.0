From: Christopher Covington <cov@codeaurora.org>
Subject: Re: How to measure VM events using perf-event
Date: Fri, 10 Apr 2015 11:39:31 -0400
Message-ID: <5527EEB3.1060507@codeaurora.org>
References: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52092 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbbDJPje (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 11:39:34 -0400
In-Reply-To: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jueyuan Zhu <jueyuan.zhu@gmail.com>, linux-perf-users@vger.kernel.org

Hi Jueyuan,

On 04/09/2015 11:46 PM, Jueyuan Zhu wrote:
> Hello,
>=20
> I am trying to use the perf-event to measure the events for one speci=
fied
> VM in KVM platform. Since each VM is just a process in the host OS, s=
o I thought
> we could just set the process id of this VM in the perf-event_open AP=
I to
> count the events. The following is my code (based on the example from
> perf_event_open linux manual).=20

> However, this program=92s output keeps constant whenever this VM is i=
dle, or
> running different benchmarks. So it seems the event counting is incor=
rect. Can
> anyone tell me how to set the flags or perf_event_attr to correctly c=
ount the
> VM events using perf_event_open?=20

You may want to check that the QEMU or kvmtool you're using correctly
virtualizes or emulates the PMU for your architecture. Information abou=
t this
might be in the documentation or release notes or if not you could try =
asking
on the QEMU or kvmtool mailing list tool.

Chris

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project
