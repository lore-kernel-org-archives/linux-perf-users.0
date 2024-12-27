Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27851B4150;
	Fri, 27 Dec 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296554; cv=none; b=htmdJMoMttA0RuEyrbZh9AMbG5gVOYA26oq3DJjOoMYq7v/uCFrh8j6ubyCOw8BAGsdGUYKnGhimancl5T082SZ6bU2vaTtnIcMMXuOwUkvdixJYkbAObTxObupP8yqHgWukw2GJPjIqy2z2PeWcALEw8qXOdA8Dag4kFhmKHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296554; c=relaxed/simple;
	bh=PVgn7SOthhTy1VVdHAvhuxpiBLqjWynB7W6BHWhfaIA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PzfwrQbY2bbAc5O2x9Wa6gDs6Vlq02+sLcLvVVT+RBrC5FRVCdJtb7MFf5rpibySg4yAHvOc3ORKRfBKwWspd85J2Q1bsw+M/W9muEZVq09geB0TP6ljlzqgcstywiMmgm+b0S67Rv7k901JdZZC2K2ERWseo7YVOQoNazUSHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=onHUGNgt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="onHUGNgt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR85uaK004513;
	Fri, 27 Dec 2024 10:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vhkt83
	LEj3negpsJ+XlZ3EkwgNdnU1H0Wd1BWbzMz7Q=; b=onHUGNgtBWEVL8jN1b7qgs
	K1MlfcrGb3Q/AAdgVWet9m1z6SUTi9+fSrhMjy42bGMo9eBIYTszRXc5GjKqT5vN
	SqNtKHwnqnIsWnftjsPWyOLKe2GAM2nJi5aTZPxk8/ZrKE9PeDLJVDdfG4M7pXvP
	GrUVTZDwJdGYPoysX9SImU5WaYpxXSUdf2ysGNF43AG6ITe4qZOaT1L/HHI+zorx
	hwt9ggt0iENkN9P5FGf1aDuTo3bLtEelOY5ArVAfNaIRK7j8M/sIB45COyn39Gx3
	40zSTbp/m4aXcdKyft2v88BGb8VcuaGeb5u3MjOtjdFwefWOikFkCLN5AwTvnp1w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43sre2gg65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:48:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BRAjZvT024455;
	Fri, 27 Dec 2024 10:48:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43sre2gg62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:48:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR9jkuT002084;
	Fri, 27 Dec 2024 10:48:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43pa7k5a52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:48:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BRAmqwG56689124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 10:48:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F3E42004D;
	Fri, 27 Dec 2024 10:48:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECEB920040;
	Fri, 27 Dec 2024 10:48:46 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Dec 2024 10:48:46 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf: Fix segfault during perf record --off-cpu
 when debuginfo is not enabled
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241223135813.8175-1-atrajeev@linux.vnet.ibm.com>
Date: Fri, 27 Dec 2024 16:18:32 +0530
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <409D0233-93FF-40D6-BC2E-B7625E4E1B97@linux.vnet.ibm.com>
References: <20241223135813.8175-1-atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, hbathini@linux.ibm.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2TwLuhjEodGZQvvKv3Q1mGk-UmtsUgOX
X-Proofpoint-GUID: 9rk6Xm1of3bla2AqxfhzikfB5AsxU4vM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412270087



> On 23 Dec 2024, at 7:28=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
> When kernel is built without debuginfo, running perf record with
> --off-cpu results in segfault as below:
>=20
>   ./perf record --off-cpu -e dummy sleep 1
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was =
CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in =
/lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   Segmentation fault (core dumped)
>=20
> The backtrace pointed to:
>=20
>   #0  0x00000000100fb17c in btf.type_cnt ()
>   #1  0x00000000100fc1a8 in btf_find_by_name_kind ()
>   #2  0x00000000100fc38c in btf.find_by_name_kind ()
>   #3  0x00000000102ee3ac in off_cpu_prepare ()
>   #4  0x000000001002f78c in cmd_record ()
>   #5  0x00000000100aee78 in run_builtin ()
>   #6  0x00000000100af3e4 in handle_internal_command ()
>   #7  0x000000001001004c in main ()
>=20
> Code sequence is:
>   static void check_sched_switch_args(void)
>   {
>        struct btf *btf =3D btf__load_vmlinux_btf();
>        const struct btf_type *t1, *t2, *t3;
>        u32 type_id;
>=20
>        type_id =3D btf__find_by_name_kind(btf, =
"btf_trace_sched_switch",
>                                         BTF_KIND_TYPEDEF);
>=20
> btf__load_vmlinux_btf fails when CONFIG_DEBUG_INFO_BTF is not enabled.
> Here bpf__find_by_name_kind calls btf__type_cnt with NULL btf
> value and results in segfault. To fix this, add a check to see if
> btf is not NULL before invoking bpf__find_by_name_kind
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> tools/perf/util/bpf_off_cpu.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/tools/perf/util/bpf_off_cpu.c =
b/tools/perf/util/bpf_off_cpu.c
> index a590a8ac1f9d..4269b41d1771 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -100,6 +100,11 @@ static void check_sched_switch_args(void)
> const struct btf_type *t1, *t2, *t3;
> u32 type_id;
>=20
> + if (!btf) {
> + pr_debug("Missing btf, check if CONFIG_DEBUG_INFO_BTF is =
enabled\n");
> + goto cleanup;
> + }
> +

Hi,

Looking for review comments on this

Athira
> type_id =3D btf__find_by_name_kind(btf, "btf_trace_sched_switch",
> BTF_KIND_TYPEDEF);
> if ((s32)type_id < 0)
> --=20
> 2.43.5
>=20

