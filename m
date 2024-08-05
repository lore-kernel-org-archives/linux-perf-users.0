Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D72558A5;
	Mon,  5 Aug 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867917; cv=none; b=OeUckiqnb/WSgdovbnnwUXe5OvR84R/219RLjOjq40oBq6irlLKyq076znu/0b+VbsP4pCt5smcP/TRb0n8uHaPjvPO7CXQKyLS/DfrbJc1crTMhvSOIxkjhiXqxotW4ff4e0QcQ+U/5W+h8oGWXMmcf+Ssg+l9NmuHGa1xPqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867917; c=relaxed/simple;
	bh=i5jOkpU0saQlHWBwMxEkekfn47bUW3NPXi5kCCk9udg=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=PHWpAOTKiWOuMTHE666ptT4twU3FGLQenHJ8Bmj/Fow5s+NKNBcgJ5eaHhVyeL0daocBMp65SX+hdtSAAzAkaAJ4VB1zFssQG1qWGzen+zeiD7QfBs43LUnHMzcTwy3ilIhM77kTdcF7J6Byr8TjtSXBppzzrpWqlCyWr0/XQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cu5tGmUf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cu5tGmUf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475E2LWp003425;
	Mon, 5 Aug 2024 14:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=xIFl4TkiQtFGki9t7LsvdfvBaXPysotJQDJ/QoUV51w=; b=Cu5tGmUfpzcO
	r7GVKQ4xlQha7IfaASwoyzvNj2VkiQdTXRv4WNuh0zsQtb37kdy5OZALY7lSnmTE
	H6gkBqyI0a79s4BaFmdE4Q5MQTpNp9fvuy26L3Y+NnFqRlm84HejTQ5j3DFCZKRQ
	rlS/zNoY0TV9DLEDnhc6Xm95gnCEv1db1vCPB5OLMAlgVGwQrHNQjwGen4G5gzAu
	vGYCZBXyW+lgDVhiTIpe2UdKy/10BoG/pbGFPr1ch0YAT+tvnhOhR1jFoVJAMH/R
	AOin9X14himwoZnV9aIi8bKxZP8zWjXUvWtz8TSenG/2WjCgmJLN4tRY1EV3+w7E
	XfkmTM4SgQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u04v81sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 14:24:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 475EOsgi010509;
	Mon, 5 Aug 2024 14:24:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u04v81sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 14:24:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 475EGPsl018637;
	Mon, 5 Aug 2024 14:24:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvty0by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 14:24:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 475EOnOM32833876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 14:24:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3F42004D;
	Mon,  5 Aug 2024 14:24:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2AD20040;
	Mon,  5 Aug 2024 14:24:45 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.108.113])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Aug 2024 14:24:45 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
Date: Mon, 5 Aug 2024 19:54:33 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com,
        greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Message-Id: <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>
References: <20240719081651.24853-1-eric.lin@sifive.com>
 <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
To: Eric Lin <eric.lin@sifive.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7eIHP0mMiZw-bsYu-vHG8_1DXws6afDh
X-Proofpoint-ORIG-GUID: XJs1nOLmiMc087DOl-63KtoeY-q6a-88
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
 definitions=2024-08-05_03,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408050103



> On 4 Aug 2024, at 8:36=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wrote:
>=20
> Hi,
>=20
> On Sun, Jul 21, 2024 at 11:44=E2=80=AFPM Eric Lin <eric.lin@sifive.com> w=
rote:
>>=20
>> Hi Athira,
>>=20
>> On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
>> <atrajeev@linux.vnet.ibm.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wro=
te:
>>>>=20
>>>> Currently, if vendor JSON files have two duplicate event names,
>>>> the "perf list" command will trigger a segfault.
>>>>=20
>>>> In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
>>>> pmu_events_table__num_events() gets the number of JSON events
>>>> from table_pmu->num_entries, which includes duplicate events
>>>> if there are duplicate event names in the JSON files.
>>>=20
>>> Hi Eric,
>>>=20
>>> Let us consider there are duplicate event names in the JSON files, say :
>>>=20
>>> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
>>> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
>>>=20
>>> If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=9D w=
ill list only one entry for pmu_cache_miss with may be 0x1/0x2 as event cod=
e ?
>>> Can you check the result to confirm what =E2=80=9Cperf list=E2=80=9D wi=
ll list in this case ? If it=E2=80=99s going to have only one entry in perf=
 list, does it mean there are two event codes for pmu_cache_miss and it can=
 work with either of the event code ?
>>>=20
>>=20
>> Sorry for the late reply.
>> Yes, I've checked if there are duplicate pmu_cache_miss events in the
>> JSON files, the perf list will have only one entry in perf list.
>>=20
>>> If it happens to be a mistake in json file to have duplicate entry with=
 different event code (ex: with some broken commit), I am thinking if the b=
etter fix is to keep only the valid entry in json file ?
>>>=20
>>=20
>> Yes, I agree we should fix the duplicate events in vendor JSON files.
>>=20
>> According to this code snippet [1], it seems the perf tool originally
>> allowed duplicate events to exist and it will skip the duplicate
>> events not shown on the perf list.
>> However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
>> events"),  if there are two duplicate events, it causes a segfault.
>>=20
>> Can I ask, do you have any suggestions? Thanks.
>>=20
>> [1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pmus.c=
#L491
>>=20
>=20
> Kindly ping.
>=20
> Can I ask, are there any more comments about this patch? Thanks.
>=20
Hi Eric,

The functions there says alias and to skip duplicate alias. I am not sure i=
f that is for events

Namhyung, Ian, Arnaldo
Any comments here ?

Thank
Athira

>=20
> Regards,
> Eric Lin
>=20
>> Regards,
>> Eric Lin
>>=20
>>> Thanks
>>> Athira
>>>=20
>>>>=20
>>>> perf_pmu__for_each_event() adds JSON events to the pmu->alias
>>>> list and copies sevent data to the aliases array. However, the
>>>> pmu->alias list does not contain duplicate events, as
>>>> perf_pmu__new_alias() checks if the name was already created.
>>>>=20
>>>> When sorting the alias data, if there are two duplicate events,
>>>> it causes a segfault in cmp_sevent() due to invalid aliases in
>>>> the aliases array.
>>>>=20
>>>> To avoid such segfault caused by duplicate event names in the
>>>> JSON files, the len should be updated before sorting the aliases.
>>>>=20
>>>> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
>>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>>>> ---
>>>> tools/perf/util/pmus.c | 5 +++--
>>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>> index b9b4c5eb5002..e38c3fd4d1ff 100644
>>>> --- a/tools/perf/util/pmus.c
>>>> +++ b/tools/perf/util/pmus.c
>>>> @@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct prin=
t_callbacks *print_cb, void *p
>>>> {
>>>> struct perf_pmu *pmu;
>>>> int printed =3D 0;
>>>> - int len;
>>>> + size_t len, j;
>>>> struct sevent *aliases;
>>>> struct events_callback_state state;
>>>> bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_state=
);
>>>> @@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct prin=
t_callbacks *print_cb, void *p
>>>> perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
>>>> perf_pmus__print_pmu_events__callback);
>>>> }
>>>> + len =3D state.index;
>>>> qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>>> - for (int j =3D 0; j < len; j++) {
>>>> + for (j =3D 0; j < len; j++) {
>>>> /* Skip duplicates */
>>>> if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
>>>> continue;
>>>> --
>>>> 2.43.2


