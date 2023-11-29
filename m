Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RQ07XaYC"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF3919B6
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 21:33:01 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5FuE0002692;
	Wed, 29 Nov 2023 05:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=Wn6ogUo1+kz5b4j5g1uTHAsFz4YXyyJ/RDHh7bRnCTg=;
 b=RQ07XaYCiqOaVfjw0VLztPONsNc8tuS+LYBFcjlLnM0UiZYv+TQKrBnrFV5x9pm/RcXj
 GYfD6uV5ZND5FtiaIU6SGTdEfQG7KTcXhfV3E4LsTBSJdX7AhdbOULpqgce0SA9zqXXs
 uadW0PoGQdGQCTtNdnujxnOw8ZXU/jCiJQ7XTvF6KItYMa4XVJIhV2RI9FmHtpSDYIXM
 s6p/YUqrEBq6jJInkmPSoabPAWoTcvmFxb0YhDsdhhpfi1Jg06bkuRplPuTKOUHXNj35
 HI0bo10cVGiI/jaA0Ma0LwRv4Kjm9YbXOIjKVQYw9tXHwus22KSI9I7HKhla1MnnytBs /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uny0b0fr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:32:51 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT5GnFt005153;
	Wed, 29 Nov 2023 05:32:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uny0b0fpq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:32:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT57R5f031065;
	Wed, 29 Nov 2023 05:21:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8t5ess-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:21:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT5LdTk41550226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 05:21:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A8F220040;
	Wed, 29 Nov 2023 05:21:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 948592004D;
	Wed, 29 Nov 2023 05:21:37 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.74.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 05:21:37 +0000 (GMT)
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
In-Reply-To: <92bbba90-c7e4-43de-98dc-497ca323eacc@linux.ibm.com>
Date: Wed, 29 Nov 2023 10:51:25 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5293CFEC-6578-477B-86C2-40A50EBA144B@linux.vnet.ibm.com>
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
 <92bbba90-c7e4-43de-98dc-497ca323eacc@linux.ibm.com>
To: Disha Goel <disgoel@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zj4lg6DtThJPbmvSyfzsDBMTbDrYMkNu
X-Proofpoint-GUID: lxnOOtkRJLi09e0RIwUzDxTHTAA2tJGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_02,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290040



> On 27-Nov-2023, at 5:32=E2=80=AFPM, Disha Goel <disgoel@linux.ibm.com> =
wrote:
>=20
> On 23/11/23 9:31 pm, Athira Rajeev wrote:
>=20
>> Running "perf list" on powerpc fails with segfault
>> as below:
>>=20
>>    ./perf list
>>    Segmentation fault (core dumped)
>>=20
>> This happens because of duplicate events in the json list.
>> The powerpc Json event list contains some event with same
>> event name, but different event code. They are:
>> - PM_INST_FROM_L3MISS (Present in datasource and frontend)
>> - PM_MRK_DATA_FROM_L2MISS (Present in datasource and marked)
>> - PM_MRK_INST_FROM_L3MISS (Present in datasource and marked)
>> - PM_MRK_DATA_FROM_L3MISS (Present in datasource and marked)
>>=20
>> pmu_events_table__num_events uses the value from
>> table_pmu->num_entries which includes duplicate events as
>> well. This causes issue during "perf list" and results in
>> segmentation fault.
>>=20
>> Since both event codes are valid, append _DSRC to the Data
>> Source events (datasource.json), so that they would have a
>> unique name. Also add PM_DATA_FROM_L2MISS_DSRC and
>> PM_DATA_FROM_L3MISS_DSRC events. With the fix, perf list
>> works as expected.
>>=20
>> Fixes: fc1435807533 ("perf vendor events power10: Update =
JSON/events")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> I have tested the patch on Power10 machine. Perf list works correctly =
without any segfault now.
>=20
> # ./perf list
>=20
> List of pre-defined events (to be used in -e or -M):
>=20
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>=20
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>=20

Thanks Disha for testing

Athira
>> ---
>>  .../arch/powerpc/power10/datasource.json       | 18 =
++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>=20
>> diff --git =
a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json =
b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
>> index 6b0356f2d301..0eeaaf1a95b8 100644
>> --- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
>> +++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
>> @@ -99,6 +99,11 @@
>>      "EventName": "PM_INST_FROM_L2MISS",
>>      "BriefDescription": "The processor's instruction cache was =
reloaded from a source beyond the local core's L2 due to a demand miss."
>>    },
>> +  {
>> +    "EventCode": "0x0003C0000000C040",
>> +    "EventName": "PM_DATA_FROM_L2MISS_DSRC",
>> +    "BriefDescription": "The processor's L1 data cache was reloaded =
from a source beyond the local core's L2 due to a demand miss."
>> +  },
>>    {
>>      "EventCode": "0x000380000010C040",
>>      "EventName": "PM_INST_FROM_L2MISS_ALL",
>> @@ -161,9 +166,14 @@
>>    },
>>    {
>>      "EventCode": "0x000780000000C040",
>> -    "EventName": "PM_INST_FROM_L3MISS",
>> +    "EventName": "PM_INST_FROM_L3MISS_DSRC",
>>      "BriefDescription": "The processor's instruction cache was =
reloaded from beyond the local core's L3 due to a demand miss."
>>    },
>> +  {
>> +    "EventCode": "0x0007C0000000C040",
>> +    "EventName": "PM_DATA_FROM_L3MISS_DSRC",
>> +    "BriefDescription": "The processor's L1 data cache was reloaded =
from beyond the local core's L3 due to a demand miss."
>> +  },
>>    {
>>      "EventCode": "0x000780000010C040",
>>      "EventName": "PM_INST_FROM_L3MISS_ALL",
>> @@ -981,7 +991,7 @@
>>    },
>>    {
>>      "EventCode": "0x0003C0000000C142",
>> -    "EventName": "PM_MRK_DATA_FROM_L2MISS",
>> +    "EventName": "PM_MRK_DATA_FROM_L2MISS_DSRC",
>>      "BriefDescription": "The processor's L1 data cache was reloaded =
from a source beyond the local core's L2 due to a demand miss for a =
marked instruction."
>>    },
>>    {
>> @@ -1046,12 +1056,12 @@
>>    },
>>    {
>>      "EventCode": "0x000780000000C142",
>> -    "EventName": "PM_MRK_INST_FROM_L3MISS",
>> +    "EventName": "PM_MRK_INST_FROM_L3MISS_DSRC",
>>      "BriefDescription": "The processor's instruction cache was =
reloaded from beyond the local core's L3 due to a demand miss for a =
marked instruction."
>>    },
>>    {
>>      "EventCode": "0x0007C0000000C142",
>> -    "EventName": "PM_MRK_DATA_FROM_L3MISS",
>> +    "EventName": "PM_MRK_DATA_FROM_L3MISS_DSRC",
>>      "BriefDescription": "The processor's L1 data cache was reloaded =
from beyond the local core's L3 due to a demand miss for a marked =
instruction."
>>    },
>>    {


