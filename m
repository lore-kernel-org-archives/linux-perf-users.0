Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ft9lYhSE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BBF2
	for <linux-perf-users@vger.kernel.org>; Sun,  3 Dec 2023 07:58:03 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3FnJnZ013228;
	Sun, 3 Dec 2023 15:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=vKaGm7QJ9nav5z665Ne/IH5TvrJIH+yELaWQ7TG3J9Q=;
 b=ft9lYhSEVmhf9AqnWcT0os/R9K5VuFM/ss+EWlBZU4o0EV0hZsI9mwB5orgyaKGHFcDw
 yVcMLYlp5ZxskxXq3HC66RB1gjVZuMmrYsXPPnJE+2vXVy36qqg5kE1DSov+SLt41Fez
 imX5SaWODRtmJ0o4X/GlXsy29vZ+4MB5QVMyLc6Efx3ITVgnauEF7AWOZ7qoCzfp3JtF
 Vse/iXIdmMHYEDEDTpTNcF9Cc6h4m5PJCphlYEjLOVHKa9UjL3k01DRrkoMEXVNqf6LZ
 WZm6v+UEEL665lsFMU561tPTpQj/+na0GAx8uYxC4EwSSoFfiGb5V3dMWcNf7VBvF0xD tA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3urvnbg3dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Dec 2023 15:57:43 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B3Fq4pQ018262;
	Sun, 3 Dec 2023 15:57:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3urvnbg3dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Dec 2023 15:57:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3EYAsC018283;
	Sun, 3 Dec 2023 15:57:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urh4k2w31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Dec 2023 15:57:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B3FvdEq8389122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Dec 2023 15:57:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 874E32004B;
	Sun,  3 Dec 2023 15:57:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E74820040;
	Sun,  3 Dec 2023 15:57:37 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.33.217])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  3 Dec 2023 15:57:37 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] perf vendor events: Update datasource event name to fix
 duplicate events
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <5293CFEC-6578-477B-86C2-40A50EBA144B@linux.vnet.ibm.com>
Date: Sun, 3 Dec 2023 21:27:25 +0530
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <87E3CA3F-77D0-4A99-8575-C85544D207E1@linux.vnet.ibm.com>
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
 <92bbba90-c7e4-43de-98dc-497ca323eacc@linux.ibm.com>
 <5293CFEC-6578-477B-86C2-40A50EBA144B@linux.vnet.ibm.com>
To: Disha Goel <disgoel@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@arm.com>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UG0BQ9M0w6Rv6vypBDuNdbLL__R4K-Lw
X-Proofpoint-ORIG-GUID: lVWXUXhvqRsDol9RfywWGYH8ipK8KYaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_14,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312030127



> On 29-Nov-2023, at 10:51=E2=80=AFAM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
>=20
>=20
>> On 27-Nov-2023, at 5:32=E2=80=AFPM, Disha Goel =
<disgoel@linux.ibm.com> wrote:
>>=20
>> On 23/11/23 9:31 pm, Athira Rajeev wrote:
>>=20
>>> Running "perf list" on powerpc fails with segfault
>>> as below:
>>>=20
>>>   ./perf list
>>>   Segmentation fault (core dumped)
>>>=20
>>> This happens because of duplicate events in the json list.
>>> The powerpc Json event list contains some event with same
>>> event name, but different event code. They are:
>>> - PM_INST_FROM_L3MISS (Present in datasource and frontend)
>>> - PM_MRK_DATA_FROM_L2MISS (Present in datasource and marked)
>>> - PM_MRK_INST_FROM_L3MISS (Present in datasource and marked)
>>> - PM_MRK_DATA_FROM_L3MISS (Present in datasource and marked)
>>>=20
>>> pmu_events_table__num_events uses the value from
>>> table_pmu->num_entries which includes duplicate events as
>>> well. This causes issue during "perf list" and results in
>>> segmentation fault.
>>>=20
>>> Since both event codes are valid, append _DSRC to the Data
>>> Source events (datasource.json), so that they would have a
>>> unique name. Also add PM_DATA_FROM_L2MISS_DSRC and
>>> PM_DATA_FROM_L3MISS_DSRC events. With the fix, perf list
>>> works as expected.
>>>=20
>>> Fixes: fc1435807533 ("perf vendor events power10: Update =
JSON/events")
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>=20
>> I have tested the patch on Power10 machine. Perf list works correctly =
without any segfault now.
>>=20
>> # ./perf list
>>=20
>> List of pre-defined events (to be used in -e or -M):
>>=20
>>  branch-instructions OR branches                    [Hardware event]
>>  branch-misses                                      [Hardware event]
>>=20
>> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>>=20
>=20
> Thanks Disha for testing
>=20
> Athira
Hi Arnaldo,

Can we get this pulled in if the patch looks good ?

Thanks
Athira

>>> ---
>>> .../arch/powerpc/power10/datasource.json       | 18 =
++++++++++++++----
>>> 1 file changed, 14 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git =
a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json =
b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
>>> index 6b0356f2d301..0eeaaf1a95b8 100644
>>> --- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
>>> +++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
>>> @@ -99,6 +99,11 @@
>>>     "EventName": "PM_INST_FROM_L2MISS",
>>>     "BriefDescription": "The processor's instruction cache was =
reloaded from a source beyond the local core's L2 due to a demand miss."
>>>   },
>>> +  {
>>> +    "EventCode": "0x0003C0000000C040",
>>> +    "EventName": "PM_DATA_FROM_L2MISS_DSRC",
>>> +    "BriefDescription": "The processor's L1 data cache was reloaded =
from a source beyond the local core's L2 due to a demand miss."
>>> +  },
>>>   {
>>>     "EventCode": "0x000380000010C040",
>>>     "EventName": "PM_INST_FROM_L2MISS_ALL",
>>> @@ -161,9 +166,14 @@
>>>   },
>>>   {
>>>     "EventCode": "0x000780000000C040",
>>> -    "EventName": "PM_INST_FROM_L3MISS",
>>> +    "EventName": "PM_INST_FROM_L3MISS_DSRC",
>>>     "BriefDescription": "The processor's instruction cache was =
reloaded from beyond the local core's L3 due to a demand miss."
>>>   },
>>> +  {
>>> +    "EventCode": "0x0007C0000000C040",
>>> +    "EventName": "PM_DATA_FROM_L3MISS_DSRC",
>>> +    "BriefDescription": "The processor's L1 data cache was reloaded =
from beyond the local core's L3 due to a demand miss."
>>> +  },
>>>   {
>>>     "EventCode": "0x000780000010C040",
>>>     "EventName": "PM_INST_FROM_L3MISS_ALL",
>>> @@ -981,7 +991,7 @@
>>>   },
>>>   {
>>>     "EventCode": "0x0003C0000000C142",
>>> -    "EventName": "PM_MRK_DATA_FROM_L2MISS",
>>> +    "EventName": "PM_MRK_DATA_FROM_L2MISS_DSRC",
>>>     "BriefDescription": "The processor's L1 data cache was reloaded =
from a source beyond the local core's L2 due to a demand miss for a =
marked instruction."
>>>   },
>>>   {
>>> @@ -1046,12 +1056,12 @@
>>>   },
>>>   {
>>>     "EventCode": "0x000780000000C142",
>>> -    "EventName": "PM_MRK_INST_FROM_L3MISS",
>>> +    "EventName": "PM_MRK_INST_FROM_L3MISS_DSRC",
>>>     "BriefDescription": "The processor's instruction cache was =
reloaded from beyond the local core's L3 due to a demand miss for a =
marked instruction."
>>>   },
>>>   {
>>>     "EventCode": "0x0007C0000000C142",
>>> -    "EventName": "PM_MRK_DATA_FROM_L3MISS",
>>> +    "EventName": "PM_MRK_DATA_FROM_L3MISS_DSRC",
>>>     "BriefDescription": "The processor's L1 data cache was reloaded =
from beyond the local core's L3 due to a demand miss for a marked =
instruction."
>>>   },
>>>   {


