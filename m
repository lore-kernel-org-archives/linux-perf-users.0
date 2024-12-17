Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA64158535;
	Tue, 17 Dec 2024 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416870; cv=none; b=myDwKmWeKaFV3icfawtW7hUXk0wKYUCnJM3R8DyzzWpoQk8W1yyweCbe87UZKPsD4egJwaEyPOg0Ayj+LCO+6zAjKXiFUz3A5HMnvGarme7VaGSONczogCVbRcnqGpI5itbC29ZbmOZ1QL3lEV6XDINX6ZugrAseIIan4LwqRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416870; c=relaxed/simple;
	bh=WWPNWcU0FNkKkn4vV60HW9D/U2Y9k6Epcfo1JvpcVZo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aIV9Y4dSt7w3imq21anUl+t7iqar1Vsroub7Bq78sRsQjbQSJE+Tsh7oc3BXBlwBs6R5oahAtyDsNsiWovSRlpYHrX6KLEEyVWJdy+kX2asx+K2s0ZAqiEHfOfLYLyUSfT27QBxnOfGMiFvVXf10ssx40eXWj76p4c8jtfcwYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hYuWR4+7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hYuWR4+7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHXxBv027390;
	Tue, 17 Dec 2024 06:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WWPNWc
	U0FNkKkn4vV60HW9D/U2Y9k6Epcfo1JvpcVZo=; b=hYuWR4+7TdfZ2oqMQ+kQQy
	N+y+l8F6KJPlOCHBWtz8b2HuWPaGdpPxjfEU1Ygh/1oD2C0rdoAL1LKJY1QFmLNA
	M3qeCLMd3M5Qn3j2TkIn3iFqafXj5vAmbDOat+9u9yuKbdzNKJAkSSsvFjsQEC1y
	4un8sY9fSUKu4/Dec/3e6S1isd3xFRXBbLQveH4Q1ZS2DPAejGs/lqLHDQbOB7KE
	tnhY6WYhbn5cQNxqg1YtqwiSmrb8cWlwpCIYaUUP8dZIrrs08LXHWBB3oX6xtgBF
	3HuHDjg9YWRLz1fzNsOgF4wpRyOGxGU4Btfh3ypd3Wvqqi6eot88fohw2LsWUWdg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2damb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:27:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BH6Lq81012878;
	Tue, 17 Dec 2024 06:27:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2dam9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:27:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1qbaN014435;
	Tue, 17 Dec 2024 06:27:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy1ny3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:27:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH6RXxT57803182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:27:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9280620049;
	Tue, 17 Dec 2024 06:27:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3030820040;
	Tue, 17 Dec 2024 06:27:26 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.252.224])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 06:27:25 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/arch/powerpc: Add register mask for power11
 PVR in extended regs
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Z2BZMhDFO-aJ_Gjw@x1>
Date: Tue, 17 Dec 2024 11:57:11 +0530
Cc: kajoljain <kjain@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <67F96642-1A52-486C-BC55-E9B23E2F190D@linux.vnet.ibm.com>
References: <20241206135637.36166-1-atrajeev@linux.vnet.ibm.com>
 <2907ca2f-b973-42fd-ae03-99732dfda7a1@linux.ibm.com>
 <0402AAF0-5498-48C7-BEBA-2C0B7508D9E2@linux.vnet.ibm.com>
 <Z2BZMhDFO-aJ_Gjw@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e7k5AqGA83bJXz4gWo1VKGa0FclRrmwL
X-Proofpoint-GUID: k-SuPy_SPFhvBIUXZMLSyWOttBQlSQ5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=853 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170047



> On 16 Dec 2024, at 10:15=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Mon, Dec 16, 2024 at 03:32:12PM +0530, Athira Rajeev wrote:
>>> On 11 Dec 2024, at 5:32=E2=80=AFPM, kajoljain <kjain@linux.ibm.com> =
wrote:
>>> On 12/6/24 19:26, Athira Rajeev wrote:
>>>> Perf tools side uses extended mask to display the platform
>>>> supported register names (with -I? option) to the user
>>>> and also send this mask to the kernel to capture the extended =
registers
>>>> as part of each sample. This mask value is decided based on
>>>> the processor version ( from PVR ).
>=20
>>>> Add PVR value for power11 to enable capturing the extended regs
>>>> as part of sample in power11.
>=20
>>> Patch looks fine to me.
>=20
>>> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
>=20
>> Can we please pull in this patch if it looks fine.
>=20
> Sure,
>=20
> Thanks, applied to perf-tools-next,
>=20
> - Arnaldo
Thanks Arnaldo for pulling this in=20

Athira


