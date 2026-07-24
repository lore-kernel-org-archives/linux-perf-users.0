Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529C39021C;
	Fri, 24 Jul 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876321; cv=none; b=MUNHQl3qN8s6iqbogHCKRQCU8aF27eZr4Dm85eiu0bs5iSowbB5XwPjTvX/cDA9sKkSXe7oZsNnG+Dfjp/KbHCiu0CPsFYBso/eApPgQTPTr8ZCiitarBHt3lABphc6LR3dyBitkY10TuESfPzLtb6OROpM17d5qPapb2e6MaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876321; c=relaxed/simple;
	bh=Vx2en35PX1cR6bnVgNFP24QVtprszwSgGRn3NBu8k5U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=arNdsiBRjauocDHs/pbbiCkilTH8HqjU29/7jXeGEbQcoquy1XcHsPTAeIKHFkHA76nmtuDIZlCCUQUjb5NtjC53mr/Mqz/hlYFNWjOOo4ic3jSnDzrBJsrAZ0gHAUl2h4dngE8L1sQ47ghd8UN0HHTLnoQlSQzyqPFh0kv7se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mg+vSQiS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mg+vSQiS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5CPk9827697;
	Fri, 24 Jul 2026 06:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G7u+X6
	I/UMCbtH5D3eq9urjjZlRK3iJ3w53ApW4oBk0=; b=Mg+vSQiS6sFmYnc9eJym4G
	SYh1FM0ge26FdK6J/V9ZzxSkCImZvpW220ZbghoP7+Sv3iaO/IHlwRBKBNHitMDx
	vKAj21qNs8Cs2n2fANsOIdB/M1DGgdZqDX31X4aLwFnmRULyla1RlZuwoZQl9sq9
	8SxXnJ/rqqkCjk/otFssPNLFz3l5B52jqm64583Dv3hkkv4fY5n+t2qccU8bEPR3
	xUiZ5D37O7UurG6rkLr2X3PNCvcW1np1tL8v7vPmSlNf1XAxXuar0+1Ie+xImDrY
	56PXuBgk2sMbiIHYY7DPHf/cgBO35xZWRRZ8tuEvqf7Y5DgESXUltBjnN4K4s3VA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kju59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:58:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O6nlK9020423;
	Fri, 24 Jul 2026 06:58:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyqhvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:58:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O6wam023462602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 06:58:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E56FB20114;
	Fri, 24 Jul 2026 06:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F91B20112;
	Fri, 24 Jul 2026 06:58:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 06:58:35 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 2/6] powerpc/perf: Reject duplicate HTM target
 reservations
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720105538.F23F31F00A3E@smtp.kernel.org>
Date: Fri, 24 Jul 2026 12:28:23 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D033AC32-0B94-4FCA-9886-BB0565406E01@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-3-atrajeev@linux.ibm.com>
 <20260720105538.F23F31F00A3E@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a630d1e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=uzvTcKwlB5XqkVCx_EIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX8bZSEXiuqPNQ
 +c4RCJJNgKv56Kd/3xdYoGdpXgSW5AjH0XoWv/tRvQ5VtrEfsVTWHnOEBLj49kcLFflGKdJxs1Z
 nGJps93GtyFRr9Ic4ym5SZjtNdTqt6wP4xTa3RLlk9vjuB/0grT3OgOtqAXsoRTzJToPYHPfhuY
 fZxP5OBT3tO+Vjxn/h7aLDDMgLm5nFCgBFNs5DXdfvkBMhrhQu+aYujI0TrQo3bVQikOs9/9sDl
 bzXw3qDwbRdUXEgfQ+lt3Q1dTLRoiVmpv0LnqAOxvfejha/OJlAhoNJlVYHILHRIqvkysBD+dtX
 7N/9bGojlSsOtmO3f9e2IH+Aj8oyR1cfkOG9APwzJ4n0M0tSLhKjOwjMgNco4ZQTjIZKtZl9cvZ
 jVUHLMrod9bjfU1XT2h07UgHQc8pRbLWkeXSPkg4V1U72jU/58imYrG+Hg/Q54+4ju7cdQmiatP
 5z9roCwbV990Bx2Iabw==
X-Proofpoint-ORIG-GUID: HWPBscadJe517aF_QFqy15S-P_MtinHv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX4iEgtpJgAhV8
 ewZ6HqhMcOtvJD+pizmU88osVwxltvpzooTHm5GcWQAeTiI2iA/JqZWGs8ak3zFNZmQuYwWtpPE
 VsVQoFIygnHpkC2n8XUQ7cOxGjcB4/8=
X-Proofpoint-GUID: HWPBscadJe517aF_QFqy15S-P_MtinHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240059



> On 20 Jul 2026, at 4:25=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [High] Rejecting duplicate HTM target reservations with `-EBUSY` =
breaks `perf record -a`.
> --
>=20
> --- Patch [2]: [PATCH V2 2/6] powerpc/perf: Reject duplicate HTM =
target reservations ---
> commit ab5064c1a585bcfce6e8560bc79aa814badd08ff
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/perf: Reject duplicate HTM target reservations
>=20
> This commit tracks reserved HTM targets globally to prevent concurrent
> event initialization races. It rejects duplicate reservations for the =
same
> target in htm_event_init() by returning -EBUSY.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index 5d3aa9c7fd8d1..a188a40287044 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
> [ ... ]
>> @@ -188,11 +203,30 @@ static int htm_event_init(struct perf_event =
*event)
>> }
>>=20
>> /* Allocate per-event private state; freed via event->destroy */
>> - event->pmu_private =3D kzalloc(sizeof(struct htm_target_id), =
GFP_KERNEL);
>> - if (!event->pmu_private)
>> + target =3D kzalloc(sizeof(*target), GFP_KERNEL);
>> + if (!target)
>> return -ENOMEM;
>>=20
>> - ((struct htm_target_id *)event->pmu_private)->cfg =3D cfg;
>> + target->cfg =3D cfg;
>> + target->tracing_active =3D HTM_TRACING_INACTIVE;
>> + INIT_LIST_HEAD(&target->list);
>> +
>> + mutex_lock(&htm_targets_lock);
>> + list_for_each_entry(tmp, &htm_active_targets_list, list) {
>> + if (tmp->cfg.htmtype =3D=3D cfg.htmtype &&
>> + tmp->cfg.nodeindex =3D=3D cfg.nodeindex &&
>> + tmp->cfg.nodalchipindex =3D=3D cfg.nodalchipindex &&
>> + tmp->cfg.coreindexonchip =3D=3D cfg.coreindexonchip) {
>> + mutex_unlock(&htm_targets_lock);
>> + kfree(target);
>> + return -EBUSY;
>=20
> [Severity: High]
> Does returning -EBUSY here break "perf record -a" for this PMU?
>=20
> Since the commit message notes that a cpumask was deliberately =
omitted,
> the perf tool will attempt to open the event on every online CPU =
sequentially
> when running "perf record -a". The first open (e.g., for CPU 0) will =
succeed,
> but the very next open (for CPU 1) will hit this path and return =
-EBUSY.
>=20
> Because the perf tool treats -EBUSY as a fatal error, won't this abort =
the
> entire profiling session instead of just skipping the duplicate =
target?

The HTM target event are expected to be opened/pinned on a CPU
The documentation also updates that.=20
Returning -EBUSY from htm_event_init() for a duplicate open is
intentional and correct.  A user who mistakenly opens the same HTM
target twice (or runs perf record without cpu=3DN, causing every online
CPU to attempt an open of the same target) receives a clear "PMU
counters are busy" error from the perf tool, directing them to add the
required cpu=3DN qualifier.  Opening the same HTM node/chip/core target
from multiple CPUs simultaneously has no meaningful purpose: HTM
hardware tracing operates on the target itself, not on the CPU that
issued the hcall.

This reasoning will be updated in V3

Thanks
Athira
>=20

>> + }
>> + }
>> +
>> + list_add_tail(&target->list, &htm_active_targets_list);
>> + mutex_unlock(&htm_targets_lock);
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720104447.11843-1-atrajeev@linux.ibm.c=
om?part=3D2

