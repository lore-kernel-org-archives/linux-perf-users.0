Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D734AB03;
	Mon, 20 Jul 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535458; cv=none; b=ejSPx0CWjv0p955fGbFKkYepJbrKIUvWLoZxVpIhz4oKMrEfmUphwMLSUcjVE/jjvnjmxBDn8EazF+CITRKW4dFXOfw5FtFhEB+sDdum/eyhyMRBZcnQE/UjdmiXX0DpZN6IQ+7cGZtW/88VRgw3Sko/xS2M8fAIkR2bVVAsGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535458; c=relaxed/simple;
	bh=UOv7/mxoOLwldaafIf/TGnLCbCd+/1yTASiVSazfcRc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I5Q6+motAXILH/op0hFJe4D2k25SuBSKhjOyhs987yXZTcUmlBZS3eQ1PPvPvPdgZRurdbNhW+GRJQLNAcmlIsB6y+ifX2TnIl3n6A3ZUJnMxD6IOMLionfmeznOnB39bH0WfEx1hWKcSpxqxYZrtU8iq2GyVZQKG8rKuYGxfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=joTR08Od; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="joTR08Od"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fmJt1367865;
	Mon, 20 Jul 2026 08:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UOv7/m
	xoOLwldaafIf/TGnLCbCd+/1yTASiVSazfcRc=; b=joTR08Odn9vzchpNEDkMIU
	Og/wTpKAdM/JnBF4NXYLHipNfry0OdmKkJETxnsUciHR3udx9G1hgBFeiifkx6oc
	6144Ht2J0zPHS+JQItmwDHMNP/ysuiWrCVYG7RUp/10Inw9+rwARTNR1JwQeMaC+
	MNvRCdpR+hZIvo0myQkGknJMoMOte5+KtPfl7pAl9KFfAFpA2RHdeKkH7w4idifM
	TPqwmJX5kBwNUh7A7EQcw59OcMM5OcIGcE1k2vf8K5YckZRBOzbPUK+4vhwB5few
	V4gBfUg6PLVeovEau+fi6E70OQzU4fSOaspQXyLPkPJDGH9jB7D5iEZukr2l30Zw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fx7gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:17:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K84bql031428;
	Mon, 20 Jul 2026 08:17:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjmqdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:17:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8HWjV49283378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:17:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E12342004B;
	Mon, 20 Jul 2026 08:17:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E5DD20043;
	Mon, 20 Jul 2026 08:17:32 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 08:17:32 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 1/9] tool/perf: Move auxtrace_record__init for
 powerpc-vpadtl as separate utility
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701085631.1964F1F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 13:47:20 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <858D1D5D-D09C-4EA2-8DEB-1681EB741311@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-2-atrajeev@linux.ibm.com>
 <20260701085631.1964F1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfXy0W5zV9PeYya
 pmvoyhHrEtxJItrLtnhw0Ng8EZpAaCjxpNDX6qkjLT3P87Z6LVYg4jXVRkuhir4LA2j/++60lk2
 WvGe3MWPOecZh61nM6TcmafQm+cfjZNCCjg+0ZT+4B7OI7t/GTxg3FOhgmiBh56TfSM6XL9AyEH
 H46XUikQBYOfcsVn4u6yblylIayWTJBE3fgHRcn5WKcehEwNbix9ZpWKHiSlvTUGi/8xroy+M6W
 /Tnwtb5nY9mEYG0EKqEmaJU+6styIVGIXx0Nq2jyHdrksIlLOCAKr3Dnbm0WHxlQcpet38KWPri
 MYqvXnG1N50ul8jy4zGz1eJfITXbvlF9aOX3Ta2WqrMv1XuNLIRLhsa38bQnvhcbGKvTxYkFlr9
 fb5S7nwcR1VMUH6OVDfN3SP45dRC88fKxbQ8V1/7q1YQf3fAugGInWInmr3LfxsN7y+opwHAYhS
 ITS3NrH1tbRJ+fY4Hxg==
X-Proofpoint-GUID: 2_kyOAv5Kpelm03Yh8svragg7kET4-Yn
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dd99f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Jix3sQQKJjvBtDP5BVUA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX4HUbWMVCrRSg
 KSa/hfdpT7ieCG0ABerTdgxLff4l8Erceaq0/j3iLeplzY7NcraFAsg1Uh46onm1bq/uYN4bc9L
 pbK9x9xE/mTOryC/GYM1nR24mSiEPiY=
X-Proofpoint-ORIG-GUID: 2_kyOAv5Kpelm03Yh8svragg7kET4-Yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200090



> On 1 Jul 2026, at 2:26=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Memory allocation failure in vpa_dtl_recording_init silently =
returns success, masking -ENOMEM and causing a subsequent NULL pointer =
dereference.
> - [Low] Missing explicit inclusion of POSIX standard headers =
<stdlib.h> and <limits.h> breaks musl libc compatibility.

Thanks for the feedback and review from Sashiko

I will send a V2 with fixes :
- Handle memory allocation failure in vpa_dtl_recording_init
- add POSIX standard headers

Thanks
Athira
> --
>=20
> (Note: The format of this report is altered to provide a free-form =
summary of the findings, rather than inline diff comments, due to system =
recitation restrictions.)
>=20
> commit 9f7d3d8f8dc04ee94edc0507b7b561997e9bd6a5
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tool/perf: Move auxtrace_record__init for powerpc-vpadtl as separate =
utility
>=20
> This commit extracts the auxtrace_record__init logic for =
powerpc-vpadtl into a
> separate utility file, vpa-dtl.c, allowing other PMUs to share the =
auxtrace
> infrastructure.
>=20
> [Severity: High]
> When zalloc() fails in the new vpa_dtl_recording_init() function, it =
returns
> NULL. However, because the refactored function no longer takes the err =
pointer
> argument, it cannot propagate the -ENOMEM error back up the stack.=20
>=20
> In auxtrace_record__init(), the err variable is initially set to 0. If
> vpa_dtl_recording_init() returns NULL due to memory exhaustion,
> auxtrace_record__init() will also return NULL while leaving the error =
code
> as 0 (success).=20
>=20
> Could this regression lead to memory corruption or crashes? Since
> pos->needs_auxtrace_mmap is already set to true earlier in the =
function,
> the caller will see a success code and incorrectly proceed to map the =
auxtrace
> buffer. Eventually, this reaches __auxtrace_mmap__read(), which =
evaluates
> itr->alignment. If itr is NULL because of the masked allocation =
failure, won't
> this trigger a NULL pointer dereference?
>=20
> [Severity: Low]
> The newly added file tools/perf/arch/powerpc/util/vpa-dtl.c uses the =
POSIX
> function free() in powerpc_vpadtl_free() and the constant UINT_MAX in
> powerpc_vpadtl_recording_options().
>=20
> Are we missing some required include directives here? The file doesn't =
seem to
> explicitly include stdlib.h or limits.h. While this might compile fine =
under
> glibc due to implicit header inclusions, does this regression break =
compilation
> on stricter libc implementations like musl?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701084115.80383-1-atrajeev@linux.ibm.c=
om?part=3D1

