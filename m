Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCF1361
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841298; cv=none; b=pRNSca7dJaupvoufRmpXH+4CUvvlrJeTUZsgxUUa+yLo4kQju2UJ3+K0IbTt45WLEXjfJ9qy+Gw1vwgCWemlLzanCSZ5B9VQ2M2b4akDERS2BvY8lAo2cnOctC/P4vZt9UJCU+CL7GWdinP1GdzD+QnkyP0/e4KDJCmy4WZT0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841298; c=relaxed/simple;
	bh=DyyPnyTOEuxgVfwm5K0hM1cGz/+PCtWa8xOenl7ZRnU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NjVRkNWI70CVZViMvt8UeT4/7jl5WH1saEEcNyn20xw3fozppPmr8e22ahCUdXANU0/VCvgsR8eCR9S7a3FLUq+0UJC2GiIWAnTmSE0w5Pqnd9zDg6uqmIarF+1Y4P+wWeFrVNxkjvjvyZOM80homBxwRx6gcKoWtY6OVuv5QpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FJs/+9sJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FJs/+9sJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E3qkc6003540;
	Tue, 14 Jan 2025 07:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DyyPny
	TOEuxgVfwm5K0hM1cGz/+PCtWa8xOenl7ZRnU=; b=FJs/+9sJnoF46qBhISRJc+
	3ISzi9ATO//PjuVrK3O3l79bGXoNtAlJme9952cR61Xoao4KVASzB/o4WtROUOUh
	zN2LB+l+OQUdB7HjHWfsHc47laIc3tmcZNbf1sEX/QD1A7KH+PsDH0ZGpEB2wJ+A
	wGkCvkwnNdU+YMFUNVW0LrCnmm/0h8nt99FTTP/VEnIM7WL1VCUiWOHmP3e22lnp
	h7S4QVeh9UaEPRzfzfV5smuYvKS792JcXL3wZrU/5kR4H/+1hij3ayXkO0htHl0/
	oKtJs/iGyAE4psbQmuUXgv7I0WIjB+B5sHDXl7VR1XAmvxfB9qhtWOwuG2XGBHKQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445gdjgrtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 07:54:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50E7sjCl020730;
	Tue, 14 Jan 2025 07:54:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445gdjgrtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 07:54:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50E5Hdih017366;
	Tue, 14 Jan 2025 07:54:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk24j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 07:54:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50E7sebN35979760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 07:54:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21A7C20043;
	Tue, 14 Jan 2025 07:54:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D5E920040;
	Tue, 14 Jan 2025 07:54:34 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.251.19])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jan 2025 07:54:34 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH V2] tools/perf/tests/base_probe: Fix check for the count
 of existing probes in test_adding_kernel
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Z4UsBYLWa1CJfn3F@x1>
Date: Tue, 14 Jan 2025 13:24:19 +0530
Cc: jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org, mpetlan@redhat.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <371F1454-EFBF-496B-B27C-341700488B96@linux.vnet.ibm.com>
References: <20250110094324.94604-1-atrajeev@linux.vnet.ibm.com>
 <07be4391-4a28-4761-9171-26580aea6312@redhat.com> <Z4UsBYLWa1CJfn3F@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Veronika Molnarova <vmolnaro@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uCa65NgVI4cG2ZsRz6XyDFDFYGpl_dnS
X-Proofpoint-ORIG-GUID: GQBcSFno-YioZh7NDQlpPb44KLKClzBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140061



> On 13 Jan 2025, at 8:36=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Mon, Jan 13, 2025 at 11:21:24AM +0100, Veronika Molnarova wrote:
>> On 1/10/25 10:43, Athira Rajeev wrote:
>>> But if there are other probes in the system, the log will
>>> contain reference to other existing probe too. Hence change
>>> usage of check_all_lines_matched.pl to check_all_patterns_found.pl
>>> This will make sure expecting string comes in the result
>>>=20
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>=20
>> Acked-by: Veronika Molnarova <vmolnaro@redhat.com>
>=20
> Thanks, applied to perf-tools-next,
>=20
> - Arnaldo
Thanks Veronika for the ack and thanks Arnaldo for pulling in the patch

Thanks
Athira=
