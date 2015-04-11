From: Tianwei Zhang <artdream07@gmail.com>
Subject: Re: How to measure VM events using perf-event
Date: Fri, 10 Apr 2015 22:45:52 -0400
Message-ID: <58A37B40-C963-491B-8CAB-D5870EF663EB@gmail.com>
References: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com> <5527EEB3.1060507@codeaurora.org> <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36717 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbbDKCp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 22:45:57 -0400
Received: by qku63 with SMTP id 63so57744068qku.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2015 19:45:56 -0700 (PDT)
In-Reply-To: <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jueyuan Zhu <jueyuan.zhu@gmail.com>
Cc: linux-perf-users@vger.kernel.org

In the KVM-based machine, each VM is a process, with several threads ru=
nning concurrently. You can use ps -eLf to display all the VM threads. =
When measuring the performance of the VM, you should also specify the t=
hread ids in the perf_event_open function.=20

Tianwei

On Apr 10, 2015, at 12:17 PM, Jueyuan Zhu <jueyuan.zhu@gmail.com> wrote=
:

> Hi Chris,
>=20
> Thanks for your suggestions. Since I am using the perf_event_open in =
the host OS, not in the guest OS. So does it need the support of PMU vi=
rtualization? I used the perf command below to measure the VM, and it c=
an give correct results. So I am wondering how to use perf_event_open t=
o get the same results as the perf user command?
>=20
> #perf stat -e instructions -p VM_id sleep 1
>=20
> Thank you!
>=20
> -Jueyuan
>=20
> On Apr 10, 2015, at 11:39 AM, Christopher Covington <cov@codeaurora.o=
rg> wrote:
>=20
>> Hi Jueyuan,
>>=20
>> On 04/09/2015 11:46 PM, Jueyuan Zhu wrote:
>>> Hello,
>>>=20
>>> I am trying to use the perf-event to measure the events for one spe=
cified
>>> VM in KVM platform. Since each VM is just a process in the host OS,=
 so I thought
>>> we could just set the process id of this VM in the perf-event_open =
API to
>>> count the events. The following is my code (based on the example fr=
om
>>> perf_event_open linux manual).=20
>>=20
>>> However, this program=92s output keeps constant whenever this VM is=
 idle, or
>>> running different benchmarks. So it seems the event counting is inc=
orrect. Can
>>> anyone tell me how to set the flags or perf_event_attr to correctly=
 count the
>>> VM events using perf_event_open?=20
>>=20
>> You may want to check that the QEMU or kvmtool you're using correctl=
y
>> virtualizes or emulates the PMU for your architecture. Information a=
bout this
>> might be in the documentation or release notes or if not you could t=
ry asking
>> on the QEMU or kvmtool mailing list tool.
>>=20
>> Chris
>>=20
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
