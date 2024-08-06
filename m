Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2176035;
	Tue,  6 Aug 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969797; cv=none; b=mcFK2/fK0MYq3U+rfHZAdydpABIdrvqw+KAhwzo7vuLwnd5ZfbxYm3hQ25WiATxR1/VxIhjc4iyXvPbnqBbtqbyiA/dlYxOsgOpNjkLu0BeXIYmqy+rdSvjJNA3JH+1B8IbB3aJizy1si4lAehViBHhIYlkxlZH/swMsMSq2iLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969797; c=relaxed/simple;
	bh=hFAZ7FCFO9rKzAQbVaI6sjjJ24oeRUaeik7OoJ3QmOk=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=uhCTvHQLe/hzSGUwkxbgT8hC64eGBSpsYonDAsqP9p61otNO8XwLASXz34Ahg/DfRfsWgVGRfStfo+3jCmFAIj5rUNTtLcgxAP2xaRYocp08zH+I8lhPWYXWy/rpT5yVVIjD6zrR57V/BCJwN9zj8q0xw6o/y1Z0h3zbyNA3ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f5yJMqjZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f5yJMqjZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476IIg5j012253;
	Tue, 6 Aug 2024 18:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=FYSwAcjr1nIv5Tk4T/Q5ZP0lt5gtN9VU8NfX5+Pk1WI=; b=f5yJMqjZ0f3s
	yUPxF34GAZ4ErswTBKAI1x75KmS22hNl1R/A4zkzb0mkII6rMzaObMB//LWC55Ch
	A9ZRJ16APMzgEu6e3C0wfBXHsa8fSVC1b4wfeyQGcyNC+4wXsp31QIV9jHk+PyYe
	l6qi4shfuevHoHZqz4osgWv66VG24ba1DsQobYg9ShnX8y/zudEv9mV3ECakVikR
	LZzrbu1WLv1DoSjvM4Q7BWX+qnDeAyfz3rzTgTcKqH2DqW/hWrfPn3Ph/VK7m+Dn
	NKiSEHRZKbCLNEMmYXoJMbq/wtVtIf3SzRfxtDGs/Vs1Ajbps8c7feYmyWN5C1GW
	HXpkDwlsug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ub2x1x8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 18:42:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476IgpTQ023983;
	Tue, 6 Aug 2024 18:42:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ub2x1x8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 18:42:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476Gfq1j006462;
	Tue, 6 Aug 2024 18:42:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mctrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 18:42:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476Igl0O28901836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 18:42:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192472005A;
	Tue,  6 Aug 2024 18:42:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 681F420040;
	Tue,  6 Aug 2024 18:42:40 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.173.2])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Aug 2024 18:42:40 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAPqJEFr78B_74PCsxxHdDZtdrJVUL6j6u4vauCaoTaR7Rr=Rrw@mail.gmail.com>
Date: Wed, 7 Aug 2024 00:12:26 +0530
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com,
        greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Message-Id: <2EA2700A-027A-4AD4-B93F-0426D6BF76D2@linux.vnet.ibm.com>
References: <20240719081651.24853-1-eric.lin@sifive.com>
 <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>
 <ZrDzBrrBPBkSKLRC@x1>
 <CAPqJEFraOmS72dQQK2ou9EoxbCKZ8m_+DhQQfPmCy6wfxfQWzQ@mail.gmail.com>
 <CAP-5=fXSiqQT+-mztdrV=Y6p+iPhZnmY9uqL08KrEe3bSybJxw@mail.gmail.com>
 <CAPqJEFr78B_74PCsxxHdDZtdrJVUL6j6u4vauCaoTaR7Rr=Rrw@mail.gmail.com>
To: Eric Lin <eric.lin@sifive.com>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j_7xYmBVyRWkDkn0_Iw60H-gEuAKS9pq
X-Proofpoint-ORIG-GUID: oqj54L8ImZFWz2RKIQ2gTNe1W0cchucJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_14,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060126



> On 6 Aug 2024, at 3:26=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wrote:
>=20
> This Message Is From an External Sender
> This message came from outside your organization.
> Report Suspicious
>=20
> Hi Ian,
>=20
> On Tue, Aug 6, 2024 at 12:00=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Aug 5, 2024 at 8:29=E2=80=AFPM Eric Lin <eric.lin@sifive.com> w=
rote:
> > >
> > >
> > > Hi Arnaldo,
> > >
> > > On Mon, Aug 5, 2024 at 11:43=E2=80=AFPM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 05, 2024 at 07:54:33PM +0530, Athira Rajeev wrote:
> > > > >
> > > > >
> > > > > > On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.co=
m> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sif=
ive.com> wrote:
> > > > > >>
> > > > > >> Hi Athira,
> > > > > >>
> > > > > >> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
> > > > > >> <atrajeev@linux.vnet.ibm.com> wrote:
> > > > > >>>
> > > > > >>>
> > > > > >>>
> > > > > >>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifiv=
e.com> wrote:
> > > > > >>>>
> > > > > >>>> Currently, if vendor JSON files have two duplicate event nam=
es,
> > > > > >>>> the "perf list" command will trigger a segfault.
> > > > > >>>>
> > > > > >>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > > > > >>>> pmu_events_table__num_events() gets the number of JSON events
> > > > > >>>> from table_pmu->num_entries, which includes duplicate events
> > > > > >>>> if there are duplicate event names in the JSON files.
> > > > > >>>
> > > > > >>> Hi Eric,
> > > > > >>>
> > > > > >>> Let us consider there are duplicate event names in the JSON f=
iles, say :
> > > > > >>>
> > > > > >>> metric.json with: EventName as pmu_cache_miss, EventCode as 0=
x1
> > > > > >>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0=
x2
> > > > > >>>
> > > > > >>> If we fix the segfault and proceed, still =E2=80=9Cperf list=
=E2=80=9D will list only one entry for pmu_cache_miss with may be 0x1/0x2 a=
s event code ?
> > > > > >>> Can you check the result to confirm what =E2=80=9Cperf list=
=E2=80=9D will list in this case ? If it=E2=80=99s going to have only one e=
ntry in perf list, does it mean there are two event codes for pmu_cache_mis=
s and it can work with either of the event code ?
> > > > > >>>
> > > > > >>
> > > > > >> Sorry for the late reply.
> > > > > >> Yes, I've checked if there are duplicate pmu_cache_miss events=
 in the
> > > > > >> JSON files, the perf list will have only one entry in perf lis=
t.
> > > > > >>
> > > > > >>> If it happens to be a mistake in json file to have duplicate =
entry with different event code (ex: with some broken commit), I am thinkin=
g if the better fix is to keep only the valid entry in json file ?
> > > > > >>>
> > > > > >>
> > > > > >> Yes, I agree we should fix the duplicate events in vendor JSON=
 files.
> > > > > >>
> > > > > >> According to this code snippet [1], it seems the perf tool ori=
ginally
> > > > > >> allowed duplicate events to exist and it will skip the duplica=
te
> > > > > >> events not shown on the perf list.
> > > > > >> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add=
 JSON
> > > > > >> events"),  if there are two duplicate events, it causes a segf=
ault.
> > > > > >>
> > > > > >> Can I ask, do you have any suggestions? Thanks.
> > > > > >>
> > > > > >> [1] https://github.com/torvalds/linux/blob/master/tools/perf/u=
til/pmus.c#L491
> > > > > >>
> > > > > >
> > > > > > Kindly ping.
> > > > > >
> > > > > > Can I ask, are there any more comments about this patch? Thanks.
> > > > > >
> > > > > Hi Eric,
> > > > >
> > > > > The functions there says alias and to skip duplicate alias. I am =
not sure if that is for events
> > > > >
> > > > > Namhyung, Ian, Arnaldo
> > > > > Any comments here ?
> > > >
> > > > So I was trying to reproduce the problem here before looking at the
> > > > patch, tried a simple:
> > > >
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> > > > diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json b=
/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > > index 2e93b7835b41442b..167a41b0309b7cfc 100644
> > > > --- a/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > > +++ b/tools/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > > @@ -1,4 +1,13 @@
> > > >  [
> > > > +    {
> > > > +        "BriefDescription": "Counts the number of cache lines repl=
aced in L1 data cache.",
> > > > +        "Counter": "0,1,2,3",
> > > > +        "EventCode": "0x51",
> > > > +        "EventName": "L1D.REPLACEMENT",
> > > > +        "PublicDescription": "Counts L1D data line replacements in=
cluding opportunistic replacements, and replacements that require stall-for=
-replace or block-for-replace.",
> > > > +        "SampleAfterValue": "100003",
> > > > +        "UMask": "0x1"
> > > > +    },
> > > >      {
> > > >          "BriefDescription": "Counts the number of cache lines repl=
aced in L1 data cache.",
> > > >          "Counter": "0,1,2,3",
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ grep L1D.REPLACEMENT tools=
/perf/pmu-events/arch/x86/rocketlake/cache.json
> > > >         "EventName": "L1D.REPLACEMENT",
> > > >         "EventName": "L1D.REPLACEMENT",
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > > >
> > > > I.e. duplicated that whole event definition:
> > > >
> > > > Did a make clean and a rebuild and:
> > > >
> > > > root@x1:/home/acme/git/pahole# perf list l1d.replacement
> > > >
> > > > List of pre-defined events (to be used in -e or -M):
> > > >
> > > >
> > > > cache:
> > > >   l1d.replacement
> > > >        [Counts the number of cache lines replaced in L1 data cache.=
 Unit: cpu_core]
> > > > root@x1:/home/acme/git/pahole# perf list > /dev/null
> > > > root@x1:/home/acme/git/pahole#
> > > >
> > > > No crash, can you provide instructions on how to reproduce the prob=
lem?
> > > >
> > > > I would like to use the experience to add a 'perf test' to show this
> > > > failing and then after the patch it passing that new test.
> > > >
> > >
> > > The segfault occurs when the vendor JSON files contain two events wit=
h duplicate names.
> > >
> > > I tried adding two duplicate events "L1D.REPLACEMENT" and "L1D_PEND_M=
ISS.FB_FULL"  and the issue can be reproduced on my laptop on the x86 platf=
orm.
> > >
> > > ericl@EricL-ThinkPadX1-TW 11:11 ~/linux_src/linux/tools/perf (master)
> > > git diff
> > > diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/cache.json
> > > index f4144a1110be..71062a82699d 100644
> > > --- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> > > +++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> > > @@ -8,6 +8,24 @@
> > >          "SampleAfterValue": "100003",
> > >          "UMask": "0x1"
> > >      },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cache lines replac=
ed in L1 data cache.",
> > > +        "Counter": "0,1,2,3",
> > > +        "EventCode": "0x51",
> > > +        "EventName": "L1D.REPLACEMENT",
> > > +        "PublicDescription": "Counts L1D data line replacements incl=
uding opportunistic replacements, and replacements that require stall-for-r=
eplace or block-for-replace.",
> > > +        "SampleAfterValue": "100003",
> > > +        "UMask": "0x1"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Number of cycles a demand request has w=
aited due to L1D Fill Buffer (FB) unavailability.",
> > > +        "Counter": "0,1,2,3",
> > > +        "EventCode": "0x48",
> > > +        "EventName": "L1D_PEND_MISS.FB_FULL",
> > > +        "PublicDescription": "Counts number of cycles a demand reque=
st has waited due to L1D Fill Buffer (FB) unavailability. Demand requests i=
nclude cacheable/uncacheable demand load, store, lock or SW prefetch access=
es.",
> > > +        "SampleAfterValue": "1000003",
> > > +        "UMask": "0x2"
> > > +    },
> > >      {
> > >          "BriefDescription": "Number of cycles a demand request has w=
aited due to L1D Fill Buffer (FB) unavailability.",
> > >          "Counter": "0,1,2,3",
> > >
> > > ericl@EricL-ThinkPadX1-TW 11:11 ~/linux_src/linux/tools/perf (master)
> > > $ ./perf list
> > > Segmentation fault (core dumped)
> >
> > Hi Eric,
> >
> > the series we were asking you to test was:
> > https://lore.kernel.org/linux-perf-users/20240805194424.597244-1-iroger=
s@google.com/
> > It can be convenient to use the b4 tool to grab a set of patches. It
> > is also in the perf-tools-next tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/
> > in the tmp.perf-tools-next branch, so you could clone that.
> >
> > Having duplicate events doesn't make sense. When a sysfs event and
> > json event exist with the same name, the json events values override
> > those of the sysfs event:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dtmp.perf-tools-next#n599
> > Two json events doesn't have a clear meaning and which would be found
> > would be dependent on a binary search. To avoid the problem the linked
> > to series forbids duplicate events in the json and adds a build test
> > building all architectures json. As this would break due to duplicate
> > events, as your patch shows, there are json fixes for RISC-V and ARM.
> >

Hi Arnaldo, Ian

Thanks for quick response and providing the fix.
I tested with tmp.perf-tools-next branch from git://git.kernel.org/pub/scm/=
linux/kernel/git/perf/perf-tools-next.git

The build reports "Duplicate event=E2=80=9D error when having duplicate eve=
nts in the JSON files

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira

>=20
> I tested the series and added duplicate events on the JSON files
>=20
> diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json b/to=
ols/perf/pmu-events/arch/riscv/sifive/u74/memory.json
> index be1a46312ac3..48f5aec4875a 100644
> --- a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
> +++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
> @@ -1,4 +1,9 @@
>  [
> +  {
> +    "EventName": "ICACHE_RETIRED",
> +    "EventCode": "0x0000102",
> +    "BriefDescription": "Instruction cache miss"
> +  },
>    {
>      "EventName": "ICACHE_RETIRED",
>      "EventCode": "0x0000102",
> @@ -29,4 +34,4 @@
>      "EventCode": "0x0002002",
>      "BriefDescription": "UTLB miss"
>    }
>=20
> When building the perf tool, it will show the build error as follows:
>=20
>=20
>   CC      tests/pmu-events.o                  =20
>   CC      util/cacheline.o                  =20
> Traceback (most recent call last):                =20
>   File "pmu-events/jevents.py", line 1313, in <module>                   =
             =20
>     main()                                   =20
>   File "pmu-events/jevents.py", line 1304, in main
>     ftw(arch_path, [], process_one_file)
>   File "pmu-events/jevents.py", line 1245, in ftw
>     ftw(item.path, parents + [item.name], action)
>   File "pmu-events/jevents.py", line 1243, in ftw
>     action(parents, item)
>   File "pmu-events/jevents.py", line 646, in process_one_file
>     print_pending_events()
>   File "pmu-events/jevents.py", line 510, in print_pending_events
>     assert event.name !=3D last_name, f"Duplicate event: {last_pmu}/{last=
_name}/ in {_pending_events_tblname}"
> AssertionError: Duplicate event: default_core/icache_retired/ in pmu_even=
ts__sifive_u74
>   LD      arch/riscv/util/perf-util-in.o
> pmu-events/Build:35: recipe for target 'pmu-events/pmu-events.c' failed
> make[3]: *** [pmu-events/pmu-events.c] Error 1
> make[3]: *** Deleting file 'pmu-events/pmu-events.c'
> Makefile.perf:763: recipe for target 'pmu-events/pmu-events-in.o' failed
> make[2]: *** [pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      bench/futex-lock-pi.o
>=20
> I think the patch series can detect if the vendor JSON file has duplicate=
 events when building the perf tool. Thanks.
>=20
>=20
> Best regards,
> Eric Lin
>=20
> > Thanks,
> > Ian


