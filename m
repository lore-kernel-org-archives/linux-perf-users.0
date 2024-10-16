Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABC18C030;
	Wed, 16 Oct 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102123; cv=none; b=FhQvDBgS9KBXiHNQG1ZLg3TRgBRAyJ+hwW5sigY9UDwg2yAeizRlDjGQ1bot2rU0tjvbXOoCkcWjb+mD+9XqVv2hs5EaYULUgZ9L3I3Dy7RnW/TgK+vME764rHRhHJLDSlMTboQEm0QonrmrJwEmNFhdC2UB8avZSegymnYm+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102123; c=relaxed/simple;
	bh=B/sGpEq00bwshiw68X7r01udrXD+3gSGCJ2yzLTShb0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CPA9bJhaIhC/h//XtfOPz2yJyYPY+KqvDfYoPcjvmImhLeCpdW2ACEnGqHgOkPlSPifPmR2ZRDo1ijUUukIj3i5AB5dyUP4zCaiAZz6EcojW8bcqYvdMqgEl92a3Q/UxarwjETYJN2kkkneG45345bxVj02liJZz02/GvXUjz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZJIi5jVt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJIi5jVt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGniMh026979;
	Wed, 16 Oct 2024 18:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dAPbA/
	oOxlwGEOrT4GfnpP1j6I5yc9/VypAv3KCsGy0=; b=ZJIi5jVtjKqF3PtDZHf84q
	tQmLZ+D8AwGmO2ZcN138zH3dIHu+jrgNCt3bi1Tby0in9Lz+AoIefOpR1xf8qLkQ
	CE4ueVrGcceTqBXnIvAW4PX9tzrn72LJGp4o9J0P7mcOA9PbTC+MMdiw+mo2vAWY
	ES1ewcP2VxKF+s0MW+DMUu9cHQLufrRiqvCtIezBtPpoIi4sNo+ZIfFRDr/j1c5x
	NQJk2K/opEUx+kiHRtNmuOPgmKL5U63Nb9H21GdI5UvFYPF5dV1MCBOtTe5gJkmo
	VQjfYVZZOKGpu3ud5ncE8Hq73k3gWjukUQ//3fgbeakqhuigE+4KIVSbq8x+71qA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahbr0ab3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:08:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GI8TR7031888;
	Wed, 16 Oct 2024 18:08:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahbr0ab2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:08:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGXJrO027432;
	Wed, 16 Oct 2024 18:08:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txtvr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:08:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GI8Pwk50528670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 18:08:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0533220040;
	Wed, 16 Oct 2024 18:08:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4B3420043;
	Wed, 16 Oct 2024 18:08:17 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.242.239])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:08:17 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH V2 1/2] tools/perf/pmu-events/powerpc: Add support for
 compat events in json
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Zw_5OLkwefdGOnA3@google.com>
Date: Wed, 16 Oct 2024 23:38:02 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <99F59594-A65B-48B6-9252-29EDA1AF2DA3@linux.vnet.ibm.com>
References: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
 <Zw_5OLkwefdGOnA3@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rFV3FUdG9IL4168xZhgsmUCJw1ydwLQ9
X-Proofpoint-ORIG-GUID: uYRwyQ604yNdSO9BNViKUsbLuRGBy_1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160115



> On 16 Oct 2024, at 11:04=E2=80=AFPM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> Hello Athira,
>=20
> On Thu, Oct 10, 2024 at 08:21:06PM +0530, Athira Rajeev wrote:
>> perf list picks the events supported for specific platform
>> from pmu-events/arch/powerpc/<platform>. Example power10 events
>> are in pmu-events/arch/powerpc/power10, power9 events are part
>> of pmu-events/arch/powerpc/power9. The decision of which
>> platform to pick is determined based on PVR value in powerpc.
>> The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv
>>=20
>> Example:
>>=20
>> Format:
>>        PVR,Version,JSON/file/pathname,Type
>>=20
>> 0x004[bcd][[:xdigit:]]{4},1,power8,core
>> 0x0066[[:xdigit:]]{4},1,power8,core
>> 0x004e[[:xdigit:]]{4},1,power9,core
>> 0x0080[[:xdigit:]]{4},1,power10,core
>> 0x0082[[:xdigit:]]{4},1,power10,core
>>=20
>> The code gets the PVR from system using get_cpuid_str function
>> in arch/powerpc/util/headers.c ( from SPRN_PVR ) and compares
>> with value from mapfile.csv
>>=20
>> In case of compat mode, say when partition is booted in a power9
>> mode when the system is a power10, add an entry to pick the
>> ISA architected events from "pmu-events/arch/powerpc/compat".
>> Add json file generic-events.json which will contain these
>> events which is supported in compat mode.
>>=20
>> Suggested-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> Is this the latest version?
>=20
> Thanks,
> Namhyung

Hi Namhyung

Yes, this is the latest version=20

Thanks
Athira
>=20
>> ---
>>=20
>> .../arch/powerpc/compat/generic-events.json   | 117 =
++++++++++++++++++
>> .../perf/pmu-events/arch/powerpc/mapfile.csv  |   1 +
>> 2 files changed, 118 insertions(+)
>> create mode 100644 =
tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
>>=20
>> diff --git =
a/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json =
b/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
>> new file mode 100644
>> index 000000000000..6f5e8efcb098
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
>> @@ -0,0 +1,117 @@
>> +[
>> +  {
>> +    "EventCode": "0x600F4",
>> +    "EventName": "PM_CYC",
>> +    "BriefDescription": "Processor cycles."
>> +  },
>> +  {
>> +    "EventCode": "0x100F2",
>> +    "EventName": "PM_CYC_INST_CMPL",
>> +    "BriefDescription": "1 or more ppc insts finished"
>> +  },
>> +  {
>> +    "EventCode": "0x100f4",
>> +    "EventName": "PM_FLOP_CMPL",
>> +    "BriefDescription": "Floating Point Operations Finished."
>> +  },
>> +  {
>> +    "EventCode": "0x100F6",
>> +    "EventName": "PM_L1_ITLB_MISS",
>> +    "BriefDescription": "Number of I-ERAT reloads."
>> +  },
>> +  {
>> +    "EventCode": "0x100F8",
>> +    "EventName": "PM_NO_INST_AVAIL",
>> +    "BriefDescription": "Number of cycles the ICT has no itags =
assigned to this thread."
>> +  },
>> +  {
>> +    "EventCode": "0x100fc",
>> +    "EventName": "PM_LD_CMPL",
>> +    "BriefDescription": "Load instruction completed."
>> +  },
>> +  {
>> +    "EventCode": "0x200F0",
>> +    "EventName": "PM_ST_CMPL",
>> +    "BriefDescription": "Stores completed from S2Q (2nd-level store =
queue)."
>> +  },
>> +  {
>> +    "EventCode": "0x200F2",
>> +    "EventName": "PM_INST_DISP",
>> +    "BriefDescription": "PowerPC instruction dispatched."
>> +  },
>> +  {
>> +    "EventCode": "0x200F4",
>> +    "EventName": "PM_RUN_CYC",
>> +    "BriefDescription": "Processor cycles gated by the run latch."
>> +  },
>> +  {
>> +    "EventCode": "0x200F6",
>> +    "EventName": "PM_L1_DTLB_RELOAD",
>> +    "BriefDescription": "DERAT Reloaded due to a DERAT miss."
>> +  },
>> +  {
>> +    "EventCode": "0x200FA",
>> +    "EventName": "PM_BR_TAKEN_CMPL",
>> +    "BriefDescription": "Branch Taken instruction completed."
>> +  },
>> +  {
>> +    "EventCode": "0x200FC",
>> +    "EventName": "PM_L1_ICACHE_MISS",
>> +    "BriefDescription": "Demand instruction cache miss."
>> +  },
>> +  {
>> +    "EventCode": "0x200FE",
>> +    "EventName": "PM_L1_RELOAD_FROM_MEM",
>> +    "BriefDescription": "L1 Dcache reload from memory"
>> +  },
>> +  {
>> +    "EventCode": "0x300F0",
>> +    "EventName": "PM_ST_MISS_L1",
>> +    "BriefDescription": "Store Missed L1"
>> +  },
>> +  {
>> +    "EventCode": "0x300FC",
>> +    "EventName": "PM_DTLB_MISS",
>> +    "BriefDescription": "Data PTEG reload"
>> +  },
>> +  {
>> +    "EventCode": "0x300FE",
>> +    "EventName": "PM_DATA_FROM_L3MISS",
>> +    "BriefDescription": "Demand LD - L3 Miss (not L2 hit and not L3 =
hit)"
>> +  },
>> +  {
>> +    "EventCode": "0x400F0",
>> +    "EventName": "PM_LD_MISS_L1",
>> +    "BriefDescription": "L1 Dcache load miss"
>> +  },
>> +  {
>> +    "EventCode": "0x400F2",
>> +    "EventName": "PM_CYC_INST_DISP",
>> +    "BriefDescription": "Cycle when instruction(s) dispatched."
>> +  },
>> +  {
>> +    "EventCode": "0x400F6",
>> +    "EventName": "PM_BR_MPRED_CMPL",
>> +    "BriefDescription": "A mispredicted branch completed. Includes =
direction and target."
>> +  },
>> +  {
>> +    "EventCode": "0x400FA",
>> +    "EventName": "PM_RUN_INST_CMPL",
>> +    "BriefDescription": "PowerPC instruction completed while the run =
latch is set."
>> +  },
>> +  {
>> +    "EventCode": "0x400FC",
>> +    "EventName": "PM_ITLB_MISS",
>> +    "BriefDescription": "Instruction TLB reload (after a miss), all =
page sizes. Includes only demand misses."
>> +  },
>> +  {
>> +    "EventCode": "0x400fe",
>> +    "EventName": "PM_LD_NOT_CACHED",
>> +    "BriefDescription": "Load data not cached."
>> +  },
>> +  {
>> +    "EventCode": "0x500fa",
>> +    "EventName": "PM_INST_CMPL",
>> +    "BriefDescription": "Instructions."
>> +  }
>> +]
>> diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv =
b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
>> index 4d5e9138d4cc..cbd3cb443784 100644
>> --- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
>> +++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
>> @@ -16,3 +16,4 @@
>> 0x004e[[:xdigit:]]{4},1,power9,core
>> 0x0080[[:xdigit:]]{4},1,power10,core
>> 0x0082[[:xdigit:]]{4},1,power10,core
>> +0x00ffffff,1,compat,core
>> --=20
>> 2.27.0


