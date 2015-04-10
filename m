From: Jueyuan Zhu <jueyuan.zhu@gmail.com>
Subject: Re: How to measure VM events using perf-event
Date: Fri, 10 Apr 2015 12:17:08 -0400
Message-ID: <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
References: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com> <5527EEB3.1060507@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33407 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbbDJQRM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 12:17:12 -0400
Received: by qkx62 with SMTP id 62so35961596qkx.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2015 09:17:11 -0700 (PDT)
In-Reply-To: <5527EEB3.1060507@codeaurora.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: linux-perf-users@vger.kernel.org

Hi Chris,

Thanks for your suggestions. Since I am using the perf_event_open in th=
e host OS, not in the guest OS. So does it need the support of PMU virt=
ualization? I used the perf command below to measure the VM, and it can=
 give correct results. So I am wondering how to use perf_event_open to =
get the same results as the perf user command?

#perf stat -e instructions -p VM_id sleep 1

Thank you!

-Jueyuan

On Apr 10, 2015, at 11:39 AM, Christopher Covington <cov@codeaurora.org=
> wrote:

> Hi Jueyuan,
>=20
> On 04/09/2015 11:46 PM, Jueyuan Zhu wrote:
>> Hello,
>>=20
>> I am trying to use the perf-event to measure the events for one spec=
ified
>> VM in KVM platform. Since each VM is just a process in the host OS, =
so I thought
>> we could just set the process id of this VM in the perf-event_open A=
PI to
>> count the events. The following is my code (based on the example fro=
m
>> perf_event_open linux manual).=20
>=20
>> However, this program=92s output keeps constant whenever this VM is =
idle, or
>> running different benchmarks. So it seems the event counting is inco=
rrect. Can
>> anyone tell me how to set the flags or perf_event_attr to correctly =
count the
>> VM events using perf_event_open?=20
>=20
> You may want to check that the QEMU or kvmtool you're using correctly
> virtualizes or emulates the PMU for your architecture. Information ab=
out this
> might be in the documentation or release notes or if not you could tr=
y asking
> on the QEMU or kvmtool mailing list tool.
>=20
> Chris
>=20
> --=20
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum,
> a Linux Foundation Collaborative Project
