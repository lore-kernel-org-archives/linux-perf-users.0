From: Christopher Covington <cov@codeaurora.org>
Subject: Re: How to measure VM events using perf-event
Date: Fri, 10 Apr 2015 12:57:06 -0400
Message-ID: <552800E2.50006@codeaurora.org>
References: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com> <5527EEB3.1060507@codeaurora.org> <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55722 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbbDJQ5K (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 12:57:10 -0400
In-Reply-To: <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jueyuan Zhu <jueyuan.zhu@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Jueyuan,

On 04/10/2015 12:17 PM, Jueyuan Zhu wrote:
> Hi Chris,
>=20
> Thanks for your suggestions. Since I am using the perf_event_open in =
the
> host OS, not in the guest OS. So does it need the support of PMU
> virtualization? I used the perf command below to measure the VM, and =
it can
> give correct results. So I am wondering how to use perf_event_open to=
 get the
> same results as the perf user command?
>=20
> #perf stat -e instructions -p VM_id sleep 1

Sorry, I overlooked that. I like to set pinned and inherit, but nothing=
 jumps
out to me as wrong. If you'd like to look at more examples of using
perf_event_open, the test suite has the largest collection I know of.

https://github.com/deater/perf_event_tests

Chris

> On Apr 10, 2015, at 11:39 AM, Christopher Covington <cov@codeaurora.o=
rg> wrote:
>=20
>> Hi Jueyuan,
>>
>> On 04/09/2015 11:46 PM, Jueyuan Zhu wrote:
>>> Hello,
>>>
>>> I am trying to use the perf-event to measure the events for one spe=
cified
>>> VM in KVM platform. Since each VM is just a process in the host OS,=
 so I thought
>>> we could just set the process id of this VM in the perf-event_open =
API to
>>> count the events. The following is my code (based on the example fr=
om
>>> perf_event_open linux manual).=20
>>
>>> However, this program=92s output keeps constant whenever this VM is=
 idle, or
>>> running different benchmarks. So it seems the event counting is inc=
orrect. Can
>>> anyone tell me how to set the flags or perf_event_attr to correctly=
 count the
>>> VM events using perf_event_open?=20
>>
>> You may want to check that the QEMU or kvmtool you're using correctl=
y
>> virtualizes or emulates the PMU for your architecture. Information a=
bout this
>> might be in the documentation or release notes or if not you could t=
ry asking
>> on the QEMU or kvmtool mailing list tool.
>>
>> Chris
>>
>> --=20
>> Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora =
=46orum,
>> a Linux Foundation Collaborative Project
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project
