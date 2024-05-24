Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76F85927;
	Fri, 24 May 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553061; cv=none; b=X8yc/7DvJSqpUskoliwwCV6VQJnBZYiJmWM+sKlFJxxMnSAfLPO5tlilGhMznYxVwJaZKATiiwA2ViuLYpwyZtqkMtsFwLGsvh/Q3UD8eMlpvbUhUQehhcsMkaQ+tsggsGfFYD+Pn842Cnvztlm/S1cfKX6NIv3fZ7jAVuNb+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553061; c=relaxed/simple;
	bh=oBf7bcHVfwDhT7NnUZ51qla42k8K1jGE2RiMmIhhshI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A6441j+bmfQQPMMb8BR/IZVdjS3ABMacBFDLMBTKiISm1KSAzlT6CISvoF3HXDovBp23IiiEAKDH95FA03PvgYtIx912KFAojR3CHdv/v0UiD+xQ5BgDlmXUWO4yakbr8wrKwEzHjTioJXWxe4tv3Xbyx8VKLXK4iYagpQ9srW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dc+x0ZUk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dc+x0ZUk"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OCDGt6017042;
	Fri, 24 May 2024 12:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=oBf7bcHVfwDhT7NnUZ51qla42k8K1jGE2RiMmIhhshI=;
 b=Dc+x0ZUkLi93hCJTM/KnsohvY7Wa9AceNVoXJLsrcGIjNXdmQg/D2S+bz1dOI5AEvhB6
 qi6I9jwoStXf4+8IRhBY8jteag5R76gzReHEQfgsLGZlVo0Pq6YUI5NDYXFKQ77OfLyr
 wh7tjCnE2TS89ZU9YZziJ3yqLbn9XgecpV3Z7RcfFYBlOLr8D6TMvahdos/UzfqZJ7Cy
 E45dSj5KFMGHr4MKl0KTFLRS4AwFIcwH3HCSOPvEERD8P7YQNfZR785ScmLYUo7bn1tJ
 //YDA4RqRI/nCC4dhnLLPnJVEvz8ea72GS1ryvUpS/CDt6PbTVuq9Fn2Sezo7YUjoZJJ gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yatq000kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 12:17:23 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44OCHN8G025833;
	Fri, 24 May 2024 12:17:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yatq000k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 12:17:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44O9oMf6023565;
	Fri, 24 May 2024 12:17:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77nprj1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 12:17:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44OCHGMR49742276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 12:17:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1E5D20043;
	Fri, 24 May 2024 12:17:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B1420040;
	Fri, 24 May 2024 12:17:14 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.64.109])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 May 2024 12:17:14 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH V2 8/9] tools/perf: Add support to find global register
 variables using find_data_type_global_reg
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <05213684-d45b-4a6c-82ef-6ec7fd2653b2@csgroup.eu>
Date: Fri, 24 May 2024 17:47:02 +0530
Cc: "acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "segher@kernel.crashing.org" <segher@kernel.crashing.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "disgoel@linux.vnet.ibm.com" <disgoel@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akanksha@linux.ibm.com" <akanksha@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ACEF7F9-E80E-48A2-BEFA-8C6292A4EB1F@linux.vnet.ibm.com>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
 <20240506121906.76639-9-atrajeev@linux.vnet.ibm.com>
 <05213684-d45b-4a6c-82ef-6ec7fd2653b2@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y7dN92aEfY0Kvi8p8eKbUz8iAikDYhmU
X-Proofpoint-GUID: W5GWdf68vqtMY-nDt8N0z99K5V87SGxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=972 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240085



> On 7 May 2024, at 3:33=E2=80=AFPM, Christophe Leroy =
<christophe.leroy@csgroup.eu> wrote:
>=20
>=20
>=20
> Le 06/05/2024 =C3=A0 14:19, Athira Rajeev a =C3=A9crit :
>> There are cases where define a global register variable and associate =
it
>> with a specified register. Example, in powerpc, two registers are
>> defined to represent variable:
>> 1. r13: represents local_paca
>> register struct paca_struct *local_paca asm("r13");
>>=20
>> 2. r1: represents stack_pointer
>> register void *__stack_pointer asm("r1");
>=20
> What about r2:
>=20
> register struct task_struct *current asm ("r2");

Hi Christophe,

Referring to arch/powerpc/include/asm/current.h, =E2=80=9Ccurrent=E2=80=9D=
 in powerpc 64 bit is from paca_struct which is handled with r13
R2 definition which you shared above is for 32 bit case.

Thanks
Athira
>=20
>>=20
>> These regs are present in dwarf debug as DW_OP_reg as part of =
variables
>> in the cu_die (compile unit). These are not present in die search =
done
>> in the list of nested scopes since these are global register =
variables.
>>=20

