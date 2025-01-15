Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6812459D4
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946274; cv=none; b=D6biqd/aaOBNcmwf9QACBa4MjaSvFv/c7WPfdZgErJ7RdMGtOP1vcGrPyWx4rA/qlir64zXqMkA1exxJICxb0QBTPBe0cCux8nJzd3yLp0uwYiVfTO/OyrIFZtG6F9D7nuhsI9Twfn71UT7CyIRluDp7u8RXuHfTFqnSCqKEGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946274; c=relaxed/simple;
	bh=eXs0b38KvcJxirilnrOHZmh0F3qmSWivx94TX36TvR4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WBBDEJaAwmddpRR1qRQ5G8Oh1ORT/K8Hei+vFujAHB2iEnadijk1jhNXZXkD5VRCDi2gj6OXSAZ1+npTjTIpUXA1ojzbyKgsdw1d0ha4Lh8xDS/z/15w6SuZ7+Uo3cCIfUkhgWzvcUmfJOmDHF3ws3RIbqfrerV1zcjuTFVskRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJxyt5/3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJxyt5/3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F3rJNN019928;
	Wed, 15 Jan 2025 13:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cTO+4b
	O2FTgoqSx5b20mgeevsh2AE9q9eFw6Yvn5Yrc=; b=kJxyt5/3nc+JPDXx6MG8/A
	uGLg6N1z3BkkcZkra9HWThp0OzXXqFQJos8ta7M4IjpONMwSHVnYNOmyUBpdcXuC
	lQlYf7wvSRRCqOwDOnNgHM+eKgvPSa0DOBWXosZPF/SBFicrDti8kj4sWz1E4wAi
	B4D+x3qawiM6WnBb54LvEmEEM2fttNdwb/c1pWI6YT71LkcOiHxIPCd7wR2aVa6U
	4Pukaf8OmgRRIYF7ZE2uiYQ9GDeoXBHtYgsAny2jW8v0w66Q5GFIl+19bW+RXgXk
	00uuU738124k/XqrYPa7rGsOThSovDPffi4BNSKh6ezNKzuwfIggVlLK7Lnd3QFg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjt60p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:04:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FCqr0L019490;
	Wed, 15 Jan 2025 13:04:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjt60j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:04:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50F9mvC4002738;
	Wed, 15 Jan 2025 13:04:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by8ff4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:04:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FD4IgX49349052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 13:04:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E84320040;
	Wed, 15 Jan 2025 13:04:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3275520049;
	Wed, 15 Jan 2025 13:04:13 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.249.232])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 13:04:12 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH V2] tools/perf/builtin-lock: Fix return code for functions
 in __cmd_contention
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Z4WQ6IO1euKOMIHN@google.com>
Date: Wed, 15 Jan 2025 18:33:58 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B7C2224-EB83-427E-987F-58997BA03CD2@linux.vnet.ibm.com>
References: <20250110093730.93610-1-atrajeev@linux.vnet.ibm.com>
 <Z4WQ6IO1euKOMIHN@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SFsGXvn1re3ijClSK7-xgGe1mYWmsiIR
X-Proofpoint-GUID: Kq0FW7B2nVKZxA2I88He8sDoQVxX7_mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150099



> On 14 Jan 2025, at 3:47=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Fri, Jan 10, 2025 at 03:07:30PM +0530, Athira Rajeev wrote:
>> perf lock contention returns zero exit value even if the lock =
contention
>> BPF setup failed.
>>=20
>>  # ./perf lock con -b true
>>  libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was =
CONFIG_DEBUG_INFO_BTF enabled?
>>  libbpf: failed to find '.BTF' ELF section in =
/lib/modules/6.13.0-rc3+/build/vmlinux
>>  libbpf: failed to find valid kernel BTF
>>  libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was =
CONFIG_DEBUG_INFO_BTF enabled?
>>  libbpf: failed to find '.BTF' ELF section in =
/lib/modules/6.13.0-rc3+/build/vmlinux
>>  libbpf: failed to find valid kernel BTF
>>  libbpf: Error loading vmlinux BTF: -ESRCH
>>  libbpf: failed to load object 'lock_contention_bpf'
>>  libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
>>  Failed to load lock-contention BPF skeleton
>>  lock contention BPF setup failed
>>  # echo $?
>>   0
>>=20
>> Fix this by saving the return code for lock_contention_prepare
>> so that command exits with proper return code. Similarly set the
>> return code properly for two other functions in builtin-lock, namely
>> setup_output_field() and select_key().
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>=20
> Thanks,
> Namhyung
Hi Namhyung,

Thanks for the reviewed-by=20

Athira

>=20
>> ---
>> Changelog:
>> v1 -> v2
>> Fixed return code in functions: setup_output_field()
>> and select_key() as pointed out by Namhyung.
>>=20
>> tools/perf/builtin-lock.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
>> index 208c482daa56..94a2bc15a2fa 100644
>> --- a/tools/perf/builtin-lock.c
>> +++ b/tools/perf/builtin-lock.c
>> @@ -2049,7 +2049,8 @@ static int __cmd_contention(int argc, const =
char **argv)
>> goto out_delete;
>> }
>>=20
>> - if (lock_contention_prepare(&con) < 0) {
>> + err =3D lock_contention_prepare(&con);
>> + if (err < 0) {
>> pr_err("lock contention BPF setup failed\n");
>> goto out_delete;
>> }
>> @@ -2070,10 +2071,14 @@ static int __cmd_contention(int argc, const =
char **argv)
>> }
>> }
>>=20
>> - if (setup_output_field(true, output_fields))
>> + err =3D setup_output_field(true, output_fields);
>> + if (err) {
>> + pr_err("Failed to setup output field\n");
>> goto out_delete;
>> + }
>>=20
>> - if (select_key(true))
>> + err =3D select_key(true);
>> + if (err)
>> goto out_delete;
>>=20
>> if (symbol_conf.field_sep) {
>> --=20
>> 2.43.5


