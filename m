From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: PEBS event monitoring
Date: Thu, 29 Nov 2012 19:18:23 +0900
Message-ID: <50B7366F.9020304@core.kaist.ac.kr>
References: <50B6FBD0.1010406@core.kaist.ac.kr> <87hao8q44w.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:39380 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab2K2KSc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Nov 2012 05:18:32 -0500
In-Reply-To: <87hao8q44w.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org



2012-11-29 =BF=C0=C8=C4 4:06, Namhyung Kim =BE=B4 =B1=DB:
> Hi Chulmin,
>=20
> On Thu, 29 Nov 2012 15:08:16 +0900, Chulmin Kim wrote:
>> Hi, all.
>>
>> Sorry for consecutive basic questions.
>>
>> I am about to use PEBS monitoring of Intel CPU. (westmere)
>>
>> Let me elaborate pfmon example a bit.
>>
>>   %  pfmon --smpl-module=3Dpebs -einstructions_retired --inv=3D1
>> --counter-mask=3D1 --long-smpl-periods=3D2660000 -uk -- foo
>>   # counts   %self    %cum          code addr
>>       1976  70.67%  70.67% 0x00000000004005e9
>>        710  25.39%  96.07% 0x00000000004005f1
>>         61   2.18%  98.25% 0x00000000004005e0
>>         21   0.75%  99.00% 0x00000000004005ed
>>         10   0.36%  99.36% 0x00000000004005f4
>>          2   0.07%  99.43% 0xffffffff80583110
>>          2   0.07%  99.50% 0xffffffff8024b4f8
>>
>> As shown in the above,
>> I want to get the count number attached with address information.
>>
>> While the example is only for retired instruction event, I want the =
same
>> thing for memory event (mem_load_retired) using Perf.
>>
>> Is there any guide for this issue?
>=20
> Is this what you're looking for? (FYI, it's not merged yet)
>=20
> https://lkml.org/lkml/2012/11/21/295

Yeah! It is exactly the one I'm looking for.

Thanks!

>=20
> Thanks,
> Namhyung
>=20
