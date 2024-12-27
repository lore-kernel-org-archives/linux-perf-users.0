Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91642A83;
	Fri, 27 Dec 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296563; cv=none; b=M7f09sb6YO8EyRqFeiUAyWOC7uyY57p82cKdm7XPeHU2VQ5lZaqLI3CclOLkmfnTUCt3SShjl2laxtVxjWwPJalRuW1/h4XT18y8hI+U4i8gOdNWfb+6jZJW/iiVzPYWdke4pTF1jMPSvRLUo6UoObjyBdyvWOaC3bFfN/sXKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296563; c=relaxed/simple;
	bh=7K5OfvmRIDwwcTQKw01ahtV+zXTkO2v6hOLNNG+ymXk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DJmUmQsmJ+uxeUBUfvgTwqK705I7pYGBVM4r+Iz/JU85OuZdQHPb0DFuStS06GNjX8KLJywo6GeMZQkglaM08hQcSVSn4gzny2nrGDC4AReuKM9G03RumbsR64mNgMAxa1HcLCXfxEM4RGz5quYIyHefDbFmoliL1TmyYwaQ/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HqUPQvyk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HqUPQvyk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR85eDl003611;
	Fri, 27 Dec 2024 10:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wwixQH
	47C1FRBQ3ODY6xJRX4lnffuu9a+otQiE1oX9Q=; b=HqUPQvyknywAifcpK0yUcv
	EEOLjd90gaNszbO4T4MboPfDbccjmjOTyHwxYMR+XdLNmOgOtq/M+t7QVsSgaZmm
	a6MIwlREwijSNn2pTDHmfUm3BztNvTvXoUTbXMaL6XvUWukBbckmK4as+PRU2afe
	fAe2WG3d/Is0tddWT/Z3wRwdpYhuH+u+Wn46u/AUZkM8E7LmmZJxmWheDHXyX2j/
	rIdiDWSgdPUPzLZBmzKrMkkc8+jGd7sklI79zgrfnZkOTEyU8yp/A+ElMqe19GRV
	dTqEnfDT+nYS33eVo1eqaR3ACh3wk0dusu27mzOkQtPTVEUubQpwMobHEYP1K9Xg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43sre2gg7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:49:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BRAnESO001168;
	Fri, 27 Dec 2024 10:49:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43sre2gg7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:49:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR80qI6010617;
	Fri, 27 Dec 2024 10:49:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p90ndj6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:49:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BRAn9ON55902510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 10:49:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1B620049;
	Fri, 27 Dec 2024 10:49:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94E9820040;
	Fri, 27 Dec 2024 10:49:04 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Dec 2024 10:49:04 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf: Fix return code for lock_contention_prepare
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241223135655.8042-1-atrajeev@linux.vnet.ibm.com>
Date: Fri, 27 Dec 2024 16:18:53 +0530
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB87FEA4-4F00-497A-85F8-6E05E92C52E9@linux.vnet.ibm.com>
References: <20241223135655.8042-1-atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nndw5PRxUOLtd80qVPCL2xNnE3O_tN4E
X-Proofpoint-GUID: wFcuXOAdu0r7wRwVdwjZbjaaPQ6BX7-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412270087



> On 23 Dec 2024, at 7:26=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
> perf lock contention returns zero exit value even if the lock =
contention
> BPF setup failed.
>=20
>   # ./perf lock con -b true
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was =
CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in =
/lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was =
CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in =
/lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   libbpf: Error loading vmlinux BTF: -ESRCH
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   # echo $?
>    0
>=20
> Fix this by saving the return code for lock_contention_prepare
> so that command exits with proper return code
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Hi,

Looking for review comments on this

Athira

> ---
> tools/perf/builtin-lock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 208c482daa56..2226c7dd4ae6 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2049,7 +2049,8 @@ static int __cmd_contention(int argc, const char =
**argv)
> goto out_delete;
> }
>=20
> - if (lock_contention_prepare(&con) < 0) {
> + err =3D lock_contention_prepare(&con);
> + if (err < 0) {
> pr_err("lock contention BPF setup failed\n");
> goto out_delete;
> }
> --=20
> 2.43.5
>=20

