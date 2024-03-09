Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679D2E84F
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Mar 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709968763; cv=none; b=jaat2uJPYWeUENgvoUtDFffPgg3Thqc2JxB/t1b4keigUCBHAzlM1fZb/DE0a3D6JD2lCFG+g0G+2xtJAHpFTreegt9uQ+Q36EfLZToDwhXf3Lu7XYqbm7KLem2+dafizYLfLte2WQAwx8lLmkbNRf52R0FsEIXJqTncMefZmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709968763; c=relaxed/simple;
	bh=/onOmummxkeSWrjRM+2PC1o9Q7EXKSA9PiLgHYo7PqM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J2kYtBIbRFlqs38CG50/9GTNX07G7AhDz6nsiqwGfz5IJHVgwzxaRUQdTtmGZhnJVoAvxsgOhhi/U5G5kZQHEerPGNbAsCjafSI+G/e1kemK1KI3Vu8wk/aKTNMnWz/YXmDyU0uVdQ9Y+oz1NIcNgZL99JH7iOmU8XA7Y/HahXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nm5Km4CT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nm5Km4CT"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42972M0X006860;
	Sat, 9 Mar 2024 07:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=DqTVunyJyVnU8QeI0LGC3UP85TKjorFtvLCvhyPdYPY=;
 b=nm5Km4CT/yGbV5lpegZ5ubOQkM5q9p3n4TTE0MFMU402etryWBp1V3G2PUjyO2m9ygI4
 eqVy7T7DozN4V4CHl0qi6FB1mc671Q2hzVkp1HF8XPhl6r9wYqKlPI9EnOJYoN7+HXwf
 K52QTzvWLiZPJuBIRk9tYMXCoQWJ/BtGcLbh6SuXrZuG4jdBLj4IerjpyjDP5xMSymlx
 heAHajMXPdwcRHfkc9/4zTMWAbmGxX7WhFC+LYtMUbvbG4layflLAV67IZwVZA7NMqmZ
 C2kteZUtfXV5rGYXhfnkCg2VY+ICCMEsJZWce1YFvH0/aKKYlvvtGSo/q7U+OkUkU76k cA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrk198461-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:19:11 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4297IbGg005848;
	Sat, 9 Mar 2024 07:19:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrk198460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:19:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4296nKcX025387;
	Sat, 9 Mar 2024 07:19:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu09hyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:19:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4297J4It34734390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 Mar 2024 07:19:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84F6320043;
	Sat,  9 Mar 2024 07:19:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7C420040;
	Sat,  9 Mar 2024 07:19:00 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.52.192])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  9 Mar 2024 07:18:59 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/3] tools/perf/arch/powerpc: Add load/store in powerpc
 annotate instructions for data type profling
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240309055136.96556-2-atrajeev@linux.vnet.ibm.com>
Date: Sat, 9 Mar 2024 12:48:46 +0530
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1EBC8FF-80A4-4A2A-BEAC-E170EB4400CB@linux.vnet.ibm.com>
References: <20240309055136.96556-1-atrajeev@linux.vnet.ibm.com>
 <20240309055136.96556-2-atrajeev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Opbe4tFRSjxwnrQXFSU-9S253YP8hNl2
X-Proofpoint-ORIG-GUID: VkkSyzsDxmTP6smMBFPkFYtJ-7G0sukz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090057

Hi All,

Please ignore this version. I made mistake in cover letter. I am =
re-posting the correct version now.
Sorry for the confusion

Thanks
Athira

> On 09-Mar-2024, at 11:21=E2=80=AFAM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
> Add powerpc instruction nmemonic table to associate load/store
> instructions with move_ops. mov_ops is used to identify mem_type
> to associate instruction with data type and offset. Also initialize
> and allocate arch specific fields for nr_instructions, instructions =
and
> nr_instructions_allocate.
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> .../perf/arch/powerpc/annotate/instructions.c | 66 +++++++++++++++++++
> 1 file changed, 66 insertions(+)
>=20
> diff --git a/tools/perf/arch/powerpc/annotate/instructions.c =
b/tools/perf/arch/powerpc/annotate/instructions.c
> index a3f423c27cae..07af4442be38 100644
> --- a/tools/perf/arch/powerpc/annotate/instructions.c
> +++ b/tools/perf/arch/powerpc/annotate/instructions.c
> @@ -1,6 +1,65 @@
> // SPDX-License-Identifier: GPL-2.0
> #include <linux/compiler.h>
>=20
> +/*
> + * powerpc instruction nmemonic table to associate load/store =
instructions with
> + * move_ops. mov_ops is used to identify mem_type to associate =
instruction with
> + * data type and offset.
> + */
> +static struct ins powerpc__instructions[] =3D {
> + { .name =3D "lbz", .ops =3D &mov_ops,  },
> + { .name =3D "lbzx", .ops =3D &mov_ops,  },
> + { .name =3D "lbzu", .ops =3D &mov_ops,  },
> + { .name =3D "lbzux", .ops =3D &mov_ops,  },
> + { .name =3D "lhz", .ops =3D &mov_ops,  },
> + { .name =3D "lhzx", .ops =3D &mov_ops,  },
> + { .name =3D "lhzu", .ops =3D &mov_ops,  },
> + { .name =3D "lhzux", .ops =3D &mov_ops,  },
> + { .name =3D "lha", .ops =3D &mov_ops,  },
> + { .name =3D "lhax", .ops =3D &mov_ops,  },
> + { .name =3D "lhau", .ops =3D &mov_ops,  },
> + { .name =3D "lhaux", .ops =3D &mov_ops,  },
> + { .name =3D "lwz", .ops =3D &mov_ops,  },
> + { .name =3D "lwzx", .ops =3D &mov_ops,  },
> + { .name =3D "lwzu", .ops =3D &mov_ops,  },
> + { .name =3D "lwzux", .ops =3D &mov_ops,  },
> + { .name =3D "lwa", .ops =3D &mov_ops,  },
> + { .name =3D "lwax", .ops =3D &mov_ops,  },
> + { .name =3D "lwaux", .ops =3D &mov_ops,  },
> + { .name =3D "ld", .ops =3D &mov_ops,  },
> + { .name =3D "ldx", .ops =3D &mov_ops,  },
> + { .name =3D "ldu", .ops =3D &mov_ops,  },
> + { .name =3D "ldux", .ops =3D &mov_ops,  },
> + { .name =3D "stb", .ops =3D &mov_ops,  },
> + { .name =3D "stbx", .ops =3D &mov_ops,  },
> + { .name =3D "stbu", .ops =3D &mov_ops,  },
> + { .name =3D "stbux", .ops =3D &mov_ops,  },
> + { .name =3D "sth", .ops =3D &mov_ops,  },
> + { .name =3D "sthx", .ops =3D &mov_ops,  },
> + { .name =3D "sthu", .ops =3D &mov_ops,  },
> + { .name =3D "sthux", .ops =3D &mov_ops,  },
> + { .name =3D "stw", .ops =3D &mov_ops,  },
> + { .name =3D "stwx", .ops =3D &mov_ops,  },
> + { .name =3D "stwu", .ops =3D &mov_ops,  },
> + { .name =3D "stwux", .ops =3D &mov_ops,  },
> + { .name =3D "std", .ops =3D &mov_ops,  },
> + { .name =3D "stdx", .ops =3D &mov_ops,  },
> + { .name =3D "stdu", .ops =3D &mov_ops,  },
> + { .name =3D "stdux", .ops =3D &mov_ops,  },
> + { .name =3D "lhbrx", .ops =3D &mov_ops,  },
> + { .name =3D "sthbrx", .ops =3D &mov_ops,  },
> + { .name =3D "lwbrx", .ops =3D &mov_ops,  },
> + { .name =3D "stwbrx", .ops =3D &mov_ops,  },
> + { .name =3D "ldbrx", .ops =3D &mov_ops,  },
> + { .name =3D "stdbrx", .ops =3D &mov_ops,  },
> + { .name =3D "lmw", .ops =3D &mov_ops,  },
> + { .name =3D "stmw", .ops =3D &mov_ops,  },
> + { .name =3D "lswi", .ops =3D &mov_ops,  },
> + { .name =3D "lswx", .ops =3D &mov_ops,  },
> + { .name =3D "stswi", .ops =3D &mov_ops,  },
> + { .name =3D "stswx", .ops =3D &mov_ops,  },
> +};
> +
> static struct ins_ops *powerpc__associate_instruction_ops(struct arch =
*arch, const char *name)
> {
> int i;
> @@ -52,6 +111,13 @@ static struct ins_ops =
*powerpc__associate_instruction_ops(struct arch *arch, con
> static int powerpc__annotate_init(struct arch *arch, char *cpuid =
__maybe_unused)
> {
> if (!arch->initialized) {
> + arch->nr_instructions =3D ARRAY_SIZE(powerpc__instructions);
> + arch->instructions =3D calloc(arch->nr_instructions, sizeof(struct =
ins));
> + if (arch->instructions =3D=3D NULL)
> + return -ENOMEM;
> +
> + memcpy(arch->instructions, (struct ins *)powerpc__instructions, =
sizeof(struct ins) * arch->nr_instructions);
> + arch->nr_instructions_allocated =3D arch->nr_instructions;
> arch->initialized =3D true;
> arch->associate_instruction_ops =3D =
powerpc__associate_instruction_ops;
> arch->objdump.comment_char      =3D '#';
> --=20
> 2.43.0
>=20

