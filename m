Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFF2572;
	Wed, 24 Jul 2024 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799529; cv=none; b=WvfG5PJGc5CI2BqyjPA8t3kBDPNXx/h9RwiwAJgnJBtnd1+JZfKLwPwOJ0gLWiFAHKoipc8P5Kmx6y6hSvFBLiZGzCdHeW0GRLrF+jr5py8NDbV6Jo/X286d4cRx4Zf9DUnOsd3ApvMcM47bxVqZJLt1rVd+07wncqoNpqDNoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799529; c=relaxed/simple;
	bh=JskXxz+z9vv2dDmv/bFh6SWi8sOI7oGRF4ElERA+/oI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CirwG6Ne7xQESaaneOnY01kBR4bVPfsEdUHMEAlERgZD/T07pb8yZK+pdi6s/GT2W+AFViaec+V0agInnfFZM8dTiT6CKgEl6sZKS+tJUSBj0wdgumgATWnvlfjcJi8P+dWUTURE07U3KCGBPzWerHb3x+7/8875VpdbP45R8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mjX6EqFc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mjX6EqFc"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5TtKp012286;
	Wed, 24 Jul 2024 05:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=y
	KeNXOFqy5g6jqxiUJsZ8uQo5fk6656MZM9jPDJC63U=; b=mjX6EqFcHHQSzsFSS
	pN+jAtjCe7OocWo4RfiPqmyU44Lyo7ZDjI6+sy4JHvGPRBEBwskpWBst531VErJi
	5IDosVg3NswRzY1PS2P1+wtUrcfquZNEQFz4gFJVDn1HeQIoqKAdiYjmRFMcDlv0
	Mo1YN0RnE+4YB0oaExg86br8sCmTPnbwHdr646261EmIpv99VhEf49qMjTU1FoZL
	6qDzD37lH1B8i2WrkZB1n9zPjDAmIImbi20QStNmeOGWLQPCa4o5pKoPVCxy7XRd
	AX4TNgfQKJ2vNK9V86t/K6O/NE9XeSCIEpokf4Z/8ZNhC/rSSeoFBk1N4/UcRrDR
	xGPag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jugj80du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 05:38:25 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46O5cOoN028714;
	Wed, 24 Jul 2024 05:38:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jugj80dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 05:38:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46O5Gghw007084;
	Wed, 24 Jul 2024 05:38:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72p658-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 05:38:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46O5cI7F51184052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 05:38:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8EA420043;
	Wed, 24 Jul 2024 05:38:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A89B20040;
	Wed, 24 Jul 2024 05:38:15 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.99.114])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jul 2024 05:38:14 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH V8 03/15] tools/perf: Update TYPE_STATE_MAX_REGS to
 include max of regs in powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Zp__NN2SrLvqn423@x1>
Date: Wed, 24 Jul 2024 11:08:02 +0530
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDC1FE3A-5513-4EE0-8656-EF388B99D24D@linux.vnet.ibm.com>
References: <20240718084358.72242-1-atrajeev@linux.vnet.ibm.com>
 <20240718084358.72242-4-atrajeev@linux.vnet.ibm.com> <Zp__NN2SrLvqn423@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iPjqfZzVbuW1qVoBJIy8ox7Ti3gFWMEj
X-Proofpoint-GUID: XgydcZ4057_P2ByQwLwu5cYCCmw3RMWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_03,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240038



> On 24 Jul 2024, at 12:36=E2=80=AFAM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Thu, Jul 18, 2024 at 02:13:46PM +0530, Athira Rajeev wrote:
>> TYPE_STATE_MAX_REGS is arch-dependent. Currently this is defined
>> to be 16. While checking if reg is valid using has_reg_type,
>> max value is checked using TYPE_STATE_MAX_REGS value. Define
>> this conditionally for powerpc.
>=20
> So what would happen if I get a perf.data file on a powerpc system and
> then try to do data-type profiling on a x86 system?
>=20
> I'm processing this now, but please consider fixing this up in some
> other fashion, I think we have support for collecting registers in a =
way
> that perf.data has all that is needed for us to print them in a cross
> arch way, no?
>=20
> I see there is the FIXME there, ok.
>=20
> - Arnaldo
>=20

Hi Arnaldo

Sure,  thanks.
>> Reviewed-and-tested-by: Kajol Jain <kjain@linux.ibm.com>
>> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/annotate-data.h | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/tools/perf/util/annotate-data.h =
b/tools/perf/util/annotate-data.h
>> index 6fe8ee8b8410..992b7ce4bd11 100644
>> --- a/tools/perf/util/annotate-data.h
>> +++ b/tools/perf/util/annotate-data.h
>> @@ -189,7 +189,11 @@ struct type_state_stack {
>> };
>>=20
>> /* FIXME: This should be arch-dependent */
>> +#ifdef __powerpc__
>> +#define TYPE_STATE_MAX_REGS  32
>> +#else
>> #define TYPE_STATE_MAX_REGS  16
>> +#endif
>>=20
>> /*
>>  * State table to maintain type info in each register and stack =
location.
>> --=20
>> 2.43.0

