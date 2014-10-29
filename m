From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 18:05:15 +0100
Message-ID: <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.insa-lyon.fr ([134.214.182.244]:39690 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933723AbaJ2RF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 13:05:26 -0400
In-Reply-To: <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

The same event as the one you mentionned (I also checked that it's the =
same event than the  one used by perf mem record)

Setting precise-ip to 0 allows me to open the event and then mmap the r=
esult, but I don't have any sample.

Manu



> Le 29 oct. 2014 =C3=A0 17:09, Vince Weaver <vincent.weaver@maine.edu>=
 a =C3=A9crit :
>=20
>> On Wed, 29 Oct 2014, Manuel Selva wrote:
>>=20
>> I am trying to setup load latency sampling on a Sandy Bridge process=
or (Cpu
>> familly 6, model 42, model name  Intel(R) Core(TM) i5-2520M CPU @ 2.=
50GHz)
>> running a 3.13 linux kernel.
>>=20
>> After deep investigations made of reading of the Intel SDM, examples=
 provided
>> by the pfm library and the source code of perf, I am still not able =
to get
>> sample. I think for now that my problem is related to the precise_ip=
 parameter
>> of the  perf_event_attr structure.
>>=20
>> Any time I change this value from 0 to 1 or from 0 to 2 (2 is the va=
lue to
>> enable PEBS isn't it ?) the perf_event_open system call failed with =
a "Not
>> supported operation" error. Running perf mem record on this Sandy Br=
idge
>> platform also result in the same error.
>=20
> Which event are you trying to use?
>=20
> On my Ivybrige machine using 3.14 I am able to get latency values wit=
h
>    pe.config=3D0x1cd;       =20
>        pe.config1=3D3;          =20
>        pe.precise_ip=3D2;
>=20
> Vince
