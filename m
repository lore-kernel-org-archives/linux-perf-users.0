Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D5175A92;
	Sat,  2 May 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777710627; cv=none; b=uQn8jht5TSbCfqkdXIhUyqXsH9el+GIcpQ/6nd4vk5l2QDvB63fQNdZZJ36zMYizJfr9/2XZpBdzu17MRWeE8OHyMiPhPsQRO2pEE0GhIaRmhPdSOaC7WSrPdjT2tbTGnutTvLZF4xPgWfXAtbNMXwCycxebYa4LbPCkOCPmaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777710627; c=relaxed/simple;
	bh=+0DAXK9tZDCUrVBgVgQola2a/fLyqN+fBg2d9rNuUUY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jr8zP9sbIqN/t/N0sd+6jNJWstCDX4oLKJXD7CTx2TcwnMaUUarG2P44wxxcSzYZ/XEICMMdT2dMOgA862BkiE3nNSXRf7EncPybWqQIjanmZIwSDKEcu+R6TltsE2e/R6rvzlcrEGcyaD2RcaNdDfTt/G29FI77LivcDoZX8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IYUIu2qa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IYUIu2qa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64247SHO2771421;
	Sat, 2 May 2026 08:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+0DAXK
	9tZDCUrVBgVgQola2a/fLyqN+fBg2d9rNuUUY=; b=IYUIu2qacFfHGCt+fAQFby
	34SF/AAQyPzKl3JmEwUJQyCFigfucx62Etz94m7uvOvKB6OOjRKSNeMLwyDCCzSA
	lpWW9v/+l+aJ58v373I7ghOUDFtbXv/olVjd3LmZxomWanYlyzxIocQ+xJ5Ra7W/
	DxVI64wJ0W4coyrwtBxoekgeinDgtnNLR+rUJY12rm1QO1k71GmPgyTNF0EoGtgX
	T+SwkJ9wVbtbVBEAe/+IzUw+QEE5eDUIW7PTLB1s3uSaMlDm3KAtAo6KYdJ6VEmo
	IU0zRGPZ3zifBmKCu/2XS9QRSUSZrL+BMUVbO02XQQ11U/YQEzyFrCr41LpLao2A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xx8fh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 08:30:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64289mBe017849;
	Sat, 2 May 2026 08:30:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9jdgmhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 08:30:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6428UGkC45613368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 08:30:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEDF820040;
	Sat,  2 May 2026 08:30:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5DA520049;
	Sat,  2 May 2026 08:30:15 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.223.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  2 May 2026 08:30:15 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V3 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260502081055.8D980C19425@smtp.kernel.org>
Date: Sat, 2 May 2026 14:00:02 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C36AD9FA-6A1F-4F22-9969-9C54B2A72ED7@linux.ibm.com>
References: <20260502073924.99965-2-atrajeev@linux.ibm.com>
 <20260502081055.8D980C19425@smtp.kernel.org>
To: sashiko@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDA3OCBTYWx0ZWRfXyir10AiBRY40
 wQhVBSeMxXiwk1KV8+nCztaLommOKoKI4ZavWhJLPRpE7XSpSnxW4EPkTbbXC4paisfetcNQGNU
 WMjGesFGLb7P89G5o/MEhLcJY75b+CfTXHMFHHEiQ3C76x3U5j2OmgW76FuQBPt0mmoLmhaAlN/
 Dn7QJ/tnMsbdKt8w2azNfHo/b1NkPpSVF03s85jgI0Mxp3EzXOjpartx1hUbAAT8PwVfi5lt/0/
 RMg3hBXiXLLYA7f+thInZA0sG0/HT0t4RMbBJ/PaXbP7pTPGM+5hR42zHMY8Za/32ZplDpBLoNg
 QqBhnkis534Hbb355KWgI96l5b6RStODQIVIj8OyI7/mVvuITK8RR1id01JqW8iyRHrw6w3LN20
 DPmV471SBrUjuLYrIjqxWEBKS+Jlz4giDsz0W/hGegYSTljfwAPWHYS5Yn6J+Fb0rynkCOK/A20
 h+VECcr8Jsuxkda9fNQ==
X-Proofpoint-ORIG-GUID: i-uQ2BhmKIHjJtyRQxyYRVB3-DUqUCfd
X-Proofpoint-GUID: i-uQ2BhmKIHjJtyRQxyYRVB3-DUqUCfd
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f5b61b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=MY_HrMRdi1cWDE6F8JsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020078



> On 2 May 2026, at 1:40=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Is this description for case 'c' completely accurate?
>=20
> Looking at the architecture-specific implementations, such as the one =
in
> tools/perf/arch/x86/util/auxtrace.c, it appears the function can =
return
> positive error codes. For instance, the x86 implementation calls =
get_cpuid(),
> which returns ENOBUFS (a positive integer) on failure. This positive =
value
> is then assigned to *err before returning NULL.
>=20
> Could this comment be updated to reflect that *err can be any non-zero
> value on failure, rather than strictly less than zero?

Sure

I will update this in next version

Thanks
Athira


