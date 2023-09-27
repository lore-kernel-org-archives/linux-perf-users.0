Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4084428
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 04:29:47 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12D12522
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:29:46 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R3sw1X016566;
	Wed, 27 Sep 2023 04:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=r48xeO6qHSbESuFokBSF5mwqU5R1jf7NgWwHbLi5xEQ=;
 b=I98WehrEyKmNz6KbsEqSUtUBVpDzCl6lzC0ZecO9n2Xs0Xa7Xj22/gj0lFZvuVb8kU/a
 6tE4fsBk/5dDsfsVIAADBwZoXhiyyYQ0908ywCYpsTMB7hiIgybZMLEqGOnZJIs7gDb+
 CNkVuM3AZgcDOihknGHeemeVb7OQITIOECM4sUnpugqSiga6CpAYzSKpi24apkEYZVlX
 Pzxd0JaRxY9ouDAPK6yUPm2ZucuoDPZjg96PH0zZo3Y9UBfS2TqAdGjtF/tPVtDIRH3c
 ye2l6WSwYlP4Zt/kO/qapRXFh3saCklB1RUOPv4NrmjB7iYF/3WFSFHBwp9DLKq7I6++ zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tccqb8y1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 04:29:40 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R3pX0u007308;
	Wed, 27 Sep 2023 04:29:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tccqb8y0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 04:29:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R20t0K008154;
	Wed, 27 Sep 2023 04:29:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqygxcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 04:29:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38R4TYL814025326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Sep 2023 04:29:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4105620040;
	Wed, 27 Sep 2023 04:29:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E9720049;
	Wed, 27 Sep 2023 04:29:30 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.105.243])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 Sep 2023 04:29:30 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH V2] perf test: Fix parse-events tests to skip parametrized
 events
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAM9d7cj=h=8omHwerjXPaWJbNFOpaiogjw8gsTdvwS7mTschsg@mail.gmail.com>
Date: Wed, 27 Sep 2023 09:59:18 +0530
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Sachin Sant <sachinp@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C9A62C1-6FAD-490E-89D2-3E5D36F52F3E@linux.vnet.ibm.com>
References: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
 <1F3D650F-91B5-4570-85D2-A925320BE7AE@linux.ibm.com>
 <298307AE-8AB5-40B6-A9CC-C1DBE720450C@linux.vnet.ibm.com>
 <2C5606DF-4532-4263-9482-50D5668C09AF@linux.vnet.ibm.com>
 <CA+JHD90aQ5OM3PLrrt2nnBDL1b6-Hx7EsRjpnzawzYY3VSYi3Q@mail.gmail.com>
 <CAM9d7cj=h=8omHwerjXPaWJbNFOpaiogjw8gsTdvwS7mTschsg@mail.gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iX9jFCgHZ6qd6xPEPqn6upUljK6UMba0
X-Proofpoint-GUID: nOgjLVKdX27ArY1DmzuH-3nfR02iJ-Y9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_19,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 27-Sep-2023, at 4:07 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hello,
>=20
> On Mon, Sep 25, 2023 at 10:37=E2=80=AFAM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
>>=20
>>=20
>>=20
>> On Wed, Sep 13, 2023, 7:40 AM Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 08-Sep-2023, at 7:48 PM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 08-Sep-2023, at 11:04 AM, Sachin Sant <sachinp@linux.ibm.com> =
wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On 07-Sep-2023, at 10:29 PM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>>>>>>=20
>>>>>> Testcase "Parsing of all PMU events from sysfs" parse events for
>>>>>> all PMUs, and not just cpu. In case of powerpc, the PowerVM
>>>>>> environment supports events from hv_24x7 and hv_gpci PMU which
>>>>>> is of example format like below:
>>>>>>=20
>>>>>> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
>>>>>> - hv_gpci/event,partition_id=3D?/
>>>>>>=20
>>>>>> The value for "?" needs to be filled in depending on system
>>>>>> configuration. It is better to skip these parametrized events
>>>>>> in this test as it is done in:
>>>>>> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
>>>>>> parametrized events")' which handled a simialr instance with
>>>>>> "all PMU test".
>>>>>>=20
>>>>>> Fix parse-events test to skip parametrized events since
>>>>>> it needs proper setup of the parameters.
>>>>>>=20
>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>> v1 -> v2:
>>>>>> Addressed review comments from Ian. Updated size of
>>>>>> pmu event name variable and changed bool name which is
>>>>>> used to skip the test.
>>>>>>=20
>>>>>=20
>>>>> The patch fixes the reported issue.
>>>>>=20
>>>>> 6.2: Parsing of all PMU events from sysfs                          =
: Ok
>>>>> 6.3: Parsing of given PMU events from sysfs                        =
: Ok
>>>>>=20
>>>>> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
>>>>>=20
>>>>> - Sachin
>>>>=20
>>>> Hi Sachin, Ian
>>>>=20
>>>> Thanks for testing the patch
>>>=20
>>> Hi Arnaldo
>>>=20
>>> Can you please check and pull this if it looks good to go .
>>=20
>>=20
>> Namhyung, can you please take a look?
>=20
> Yep sure.  I think it needs to close the file when getline() fails.
>=20
> Athira, can you please send v3 with that?

Sure, I will post V3 with this change

Athira
>=20
> Thanks,
> Namhyung

