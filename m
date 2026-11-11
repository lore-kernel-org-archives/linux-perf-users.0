Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384016;
	b=uvK8z5h6rvXq+vYtQdm+4zgMjyttql3NBHDDM+vOJtiNiwS13FtUbD8PYhsk60vIuFjp
	 dSNJa6vsAcJH7LATeGCLgaR8ijvMYcqYOJBup9bmkt9g1IHpiFL2oeWc/QBVSpBXIs1sC
	 kPXMApmoL/WFbBac0GXgQamfr75lC9oMptmytKNpKxlPUHa+qWR/jDnjPrUxQR/RLAYzx
	 nZ7B39vaEU8hWAgi2jzBFiw/OqN/hwaZLyOpyaJpEQV6HZrUuqfiosjaGwt0JnKs550uo
	 r36q53SIMPRsvZOIEWpBT0HBQquuOXGqp4JpFaiUNvpnvQ5VExZ0JfFOuJHacnISKnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384016;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Dses+xQ2+cfA2qsP+zMtzHIPrnkvI/iOIla6JM1cwxw=;
	b=xaDzNO+tBwApBvgBET7bKvA5nDKC7eJUPF1RVF/Wj1wt7HWU5daMHK3JtZaFdDHWDDOR
	 kRB8gXkpPhERXTxC9pkwtBo4REWQvg/W7kjQrsyzU+yLXKUr+gu7PxjKJGI6xYueb65v/
	 pn1iA7VQSzHulfK2sUpyG/oy9GVXDYvVzSvo1BtGXd7k1JsS9c+79uBLjc70uwlks2uci
	 NlQcubae5nAohx/rn68EjprqoQcAfHMUpOEgAeFh1dICZ4vUUcKhTfM4LpHEWa2lnuNqh
	 0wqZMcODONDQf5UjizdW9UZdiiRovKbhbOpQdu7jeSL5jplE7WzipgYKGgmLeRqMaNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VjNXtv0W;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5E606A320;
	Wed, 11 Nov 2026 08:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A5E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VjNXtv0W
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iFbQ486352;
	Wed, 11 Nov 2026 07:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Dses+xQ2+cfA2qsP+zMtzHIPrnkvI/iOIla6JM1cw
	xw=; b=VjNXtv0Wrkypw4CbBPSyvVCWs9hu08Bv91R664SD3BjW+vdTE4uXBcoUs
	CsdsHHmS70yAlOSOmT2++J6V7ViOQk/aGyOd549h9JG8UAA6t6Qcm0tM5qa5LChX
	/34fq/KiWaeKesViz30b3Tul826HgvwrVAnJYKAM2tfVIt+ig8jLeLST6GTmpwON
	A0ZSszoRmvqM2WnxCM/RF+/epA4cLsX0gr16NM05Gf9vZx8n8S3dk8S4GhmMeB08
	y2bHXZtzR9pwdKnWKPWQ8B1D5mWOLaih9b280QcaVMxfzPhz70A3bQBDQF0HsZEe
	z4yUmEeYXRC0slpIyz7mhpWOE0mgA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug697rx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 07:59:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5K3hr1747921;
	Wed, 11 Nov 2026 07:59:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51s959-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 07:59:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB7xqP847710578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 07:59:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3724720040;
	Wed, 11 Nov 2026 07:59:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE4EB20043;
	Wed, 11 Nov 2026 07:59:48 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 07:59:48 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
Subject: [PATCH 0/5] cpumask: Use cpumask_intersects* APIs where applicable
Date: Wed, 11 Nov 2026 13:29:40 +0530
Message-ID: <20261111075945.3930230-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _ILj8DNpx5AzId_t_Oc4DNupIN7b8Ztd
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af4207b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=N73upePAzneGQQU5UeIA:9
X-Proofpoint-GUID: azgE8Jl0FqBN9p062ATuk96YL8e-3OCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfX8NbA9j2GVon0
 xjHQiJB7OQp2G+6UI4YSH8aUAcOcVGHYx2tTTDlTB7JHdMqbX1Ztp5HDGPx0U/BM6W4KWXr/khz
 2bo3Z+n6oQRjN01txgSu2zkUQeFiQ1RbMF5XysiFCyRNffiEf6cHRp8yJQ1MQmWjsQHYKQYjgVf
 CWM9lrx1+vGmGZaKIiRKmrZUKXCfM15ad9kR9iOhQXtCg3d4VjaHUofZMaZv0odixymSS8UkOAe
 tHlXcdVNEYn9Vj2cFbkTHKB7cBuatHRRn9u8Xo0RvlKgRxPvmVabq5OT7AlevKMvYpg3N9r6zoN
 QBI8mMD9pc2vwxnSY0g4u3nTa43smQzEfzZcdJIX7CYkNVjLI8mvQLhWk08elbZInLwioLp7t4+
 E0KU62IIemAzyz3KULn+VADQIepRS7BzyeFBBIK+gepfnV0wsL24vHFYzG/2KINDnjd6wdHB0xl
 kgr2MA/3vJgRifT+A4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMCBTYWx0ZWRfXyAI4VYmVMIJU
 8X4gUrCzC/SfDEAoQ5FbOGRniEybjq3S0xSw3cD8Es6cO0vm66iZ6XGUge996K4JtTWR6YX68E6
 5Vudi/p8EKCgxKS5uHUU2e2cadqHIB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110030

It was observed while working on cpumask_intersects_and, check like
below could use it instead.

if (cpumask_first_and_and() < nr_cpu_ids)

While there, did check the code for any such similar patterns of
cpumask_any_and, cpumask_first_and and explicit loops where
cpu found by these APIs are not being used. All those callsites
instead can simply use cpumask_intersects.

Note that few more places can use similar change. But, I have left
them as is. 
drivers/net/ethernet/sfc/efx_channels.c+370
drivers/net/ethernet/sfc/siena/efx_channels.c+371
drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c+153

Also, these patches can combined into three patches if that is
easier for review/merge. I have kept it separate since they belong
to different subsystems.

Shrikanth Hegde (5):
  sched/rt: cpupri_find: Use cpumask_intersects where applicable
  cpu/hotplug: Use cpumask_intersects where applicable
  perf: Use cpumask_intersects where applicable
  cpuidle: Use cpumask_intersects_and where applicable
  arch_topology: Use cpumask_intersects where applicable

 drivers/base/arch_topology.c | 9 +--------
 drivers/cpuidle/coupled.c    | 4 ++--
 kernel/cpu.c                 | 3 +--
 kernel/events/core.c         | 7 ++-----
 kernel/sched/cpupri.c        | 2 +-
 5 files changed, 7 insertions(+), 18 deletions(-)

-- 
2.52.0

