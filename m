Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCB32C92
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759644; cv=none; b=We2WgF6Poqg1hNOC1btRJUXKHOEL8jeWeUWNkapEclOyHcCHiQGGo04i+4DdF1WxxzIcKs7Oh2CHb4Ly5gYeqpVQOP134AuGBHxKNLidJ22CnZZceSYgdPjMdjC/i7PddSF69RsvgNEUNTB2mZuSv956tgxYOeH1kHwqAt0AOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759644; c=relaxed/simple;
	bh=QWGs52Y3vywTkU5BR/53WCiOzZhHsn4Bupke7Bei+4U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fRKDL/z/YBo2T2pHro2He+XuUa2OgGvQhGHoTjpodY2zNH74ypseWaENPD80OgD11OGfLNxCRTIcMrY3dHAo2ywBCxBFMlhUnmqUI4Lpnw4TY8jfF/PFDI5WG/0L70ZgRSLH2wftBfvwdk/peVvqTKN1tag40ZdSTWdhwb7HaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AR1wKSg6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AR1wKSg6"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I5lBd6023904;
	Mon, 18 Mar 2024 11:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=S5RrdgYdNywGJjeGNuBTwvu3j4q0Muj1unJI9PLR7cU=;
 b=AR1wKSg6ZTpb4Of1p9IZRgnaTtOCqn3gVh0st8jc7dpg5yHfWnfl2amhcQFHnMtSxqKb
 6GrlOPoVZns/H+EUZ+yiLCy3I7xOx6tJe+GfcFqLHnnmIqlbD9RxAChcvf50J9a1sGBz
 0TECwfy/g8v5BR4Z/J6qR7MolvhRAavGBlNE2LUaNmgm0cfo9x5XkEqhHm4OKNMJrbT0
 nEUtGEib5WGLTHW60U46lri2cQh8naNyQaOrMT6nr6VrAnMMebTGCYQFQdjKn03lsdy1
 4g/LGpobQJ5iX1Z26sc3tv+RcppdM+QWW2CJ9MWARNbujJ5SeTMCFMHRKNeIZzIg3IV1 /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wwn31ux7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 11:00:25 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42IB0P75012707;
	Mon, 18 Mar 2024 11:00:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wwn31ux76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 11:00:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IAjUSd019843;
	Mon, 18 Mar 2024 11:00:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqyk81xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 11:00:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42IB0Ikp35586378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 11:00:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57CE920063;
	Mon, 18 Mar 2024 11:00:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50C542006C;
	Mon, 18 Mar 2024 11:00:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.91])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Mar 2024 11:00:16 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 3/3] tools/perf/arch/powerc: Add get_arch_regnum for
 powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <6e09dc28-4a2e-49d8-a2b5-ffb3396a9952@csgroup.eu>
Date: Mon, 18 Mar 2024 16:30:04 +0530
Cc: "acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "disgoel@linux.vnet.ibm.com" <disgoel@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <779935D2-7CCE-4505-B1C9-719E26039977@linux.vnet.ibm.com>
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
 <20240309072513.9418-4-atrajeev@linux.vnet.ibm.com>
 <6e09dc28-4a2e-49d8-a2b5-ffb3396a9952@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7xTOOvv1wKyXImw445KnOTltHi29nA1l
X-Proofpoint-ORIG-GUID: rlVh5cNZAKgq4GPXLnhx0n062DmtgVDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_02,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403180081



> On 09-Mar-2024, at 3:24=E2=80=AFPM, Christophe Leroy =
<christophe.leroy@csgroup.eu> wrote:
>=20
>=20
>=20
> Le 09/03/2024 =C3=A0 08:25, Athira Rajeev a =C3=A9crit :
>> The function get_dwarf_regnum() returns a DWARF register number
>> from a register name string. This calls arch specific function
>> get_arch_regnum to return register number for corresponding arch.
>> Add mappings for register name to register number in powerpc code:
>> arch/powerpc/util/dwarf-regs.c
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>  tools/perf/arch/powerpc/util/dwarf-regs.c | 29 =
+++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c =
b/tools/perf/arch/powerpc/util/dwarf-regs.c
>> index 0c4f4caf53ac..d955e3e577ea 100644
>> --- a/tools/perf/arch/powerpc/util/dwarf-regs.c
>> +++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
>> @@ -98,3 +98,32 @@ int regs_query_register_offset(const char *name)
>>   return roff->ptregs_offset;
>>   return -EINVAL;
>>  }
>> +
>> +struct dwarf_regs_idx {
>> + const char *name;
>> + int idx;
>> +};
>> +
>> +static const struct dwarf_regs_idx powerpc_regidx_table[] =3D {
>> + { "r0", 0 }, { "r1", 1 }, { "r2", 2 }, { "r3", 3 }, { "r4", 4 },
>> + { "r5", 5 }, { "r6", 6 }, { "r7", 7 }, { "r8", 8 }, { "r9", 9 },
>> + { "r10", 10 }, { "r11", 11 }, { "r12", 12 }, { "r13", 13 }, { =
"r14", 14 },
>> + { "r15", 15 }, { "r16", 16 }, { "r17", 17 }, { "r18", 18 }, { =
"r19", 19 },
>> + { "r20", 20 }, { "r21", 21 }, { "r22", 22 }, { "r23", 23 }, { =
"r24", 24 },
>> + { "r25", 25 }, { "r26", 26 }, { "r27", 27 }, { "r27", 27 }, { =
"r28", 28 },
>> + { "r29", 29 }, { "r30", 30 }, { "r31", 31 },
>> +};
>> +
>> +int get_arch_regnum(const char *name)
>> +{
>> + unsigned int i;
>> +
>> + if (*name !=3D 'r')
>> + return -EINVAL;
>> +
>> + for (i =3D 0; i < ARRAY_SIZE(powerpc_regidx_table); i++)
>> + if (!strcmp(powerpc_regidx_table[i].name, name))
>> + return powerpc_regidx_table[i].idx;
>=20
> Can you do more simple ?
>=20
> Something like:
>=20
> int n;
>=20
> if (*name !=3D 'r')
> return -EINVAL;
> n =3D atoi(name + 1);
> return n >=3D 0 && n < 32 ? n : -ENOENT;

Hi Christophe,

Thanks for reviewing patch and for the suggestions.

Sure, I will check this approach and address in V2

Thanks
Athira
>=20
>> +
>> + return -ENOENT;
>> +}

