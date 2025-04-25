Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122722318;
	Fri, 25 Apr 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596979; cv=none; b=LOigT7AIuZBTPNH2R5L5ZT3NyXjZ71QcwHcyz8IsGAkl8uggUFgUhj9P9hxTRGqgvlPAGmYihDe3fFM5EOWtxtIUASd/39XzzbxRTEbx6VTEpuAHH4r0kCmYoa4DX7LAjVbBxqcLXGue4nO20LIWBQdwOtZFq9qzWJTxeUpWXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596979; c=relaxed/simple;
	bh=/xogTKYdH/vtpwuV6WmbMtmVjmzowZMwp4af7H7eSak=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fGaEkQnghOz6+Q7AF36jZfn95rnxqsnuebFyA+cO2WHiZf1dcGyyBABmaDwldfTplmy2Z9HOX/laXjGhcmdSe4iAdCbBLWSMNKa2T6kL/0l4S7xo+qrgyd7nbDuSpNOjtR4AL5QnFv3ajsZZCjdI1HsuKMZsCeFwQHeK+HbHLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RMNgqEw8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RMNgqEw8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAOhMd005388;
	Fri, 25 Apr 2025 16:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xV4nKT/dqdi+EMCMAjNGXCDTTCLY
	S4NYZHn71L2zQbE=; b=RMNgqEw8hpnOuPj+WtAGkG6V/SvrvZHLC5RVa7nm27bd
	uuyVjmLnp9VmdUSjyj4rBg3bM0EZEq01hTC50dHJMa4bwjcGCFiPoAvteZF0/xtZ
	iTrKOII+gBrYWMZUg9tpzJx/55QWKZ2sPLo5VyE5t/BSpnsJE5TmeAGgRdTld/Xq
	2OoH/eP/2gULyQPYgI6J70DYhvA52Yf3ld/R4ExHtrp/dVwX8bSrOYxhWclS2SQ4
	bnphRG/YxxNmR6l2GKn2MHS5U/wPdwY2iNtjhKvkzyl0Q3a01bMVLs5rzmAv3q0l
	PaQMDf/VctY+fqRhsW7sFLsDHV+o1t+aF6fy5XLJRQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wew472t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 16:02:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCbqfW028421;
	Fri, 25 Apr 2025 16:02:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvx0dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 16:02:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PG2pc029164104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:02:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240AE58061;
	Fri, 25 Apr 2025 16:02:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959AA58059;
	Fri, 25 Apr 2025 16:02:47 +0000 (GMT)
Received: from [9.61.252.14] (unknown [9.61.252.14])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 16:02:47 +0000 (GMT)
Message-ID: <9c40ab1a-3d08-4af8-a430-0ba245842959@linux.ibm.com>
Date: Fri, 25 Apr 2025 21:32:46 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>,
        Athira Rajeev <atrajeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sgarzare@redhat.com,
        mst@redhat.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]Warning while building tools/perf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExMSBTYWx0ZWRfXzcUPJggrtboI ZpWiqQ6U2e5IgyQRJaR0BMqS7qZH19mqCLyKQKWOiaDiycYjk6rTEqdovbSuTu/0o+WmpPYTROB Ai0vvEr9DEYX9Qwue5+s5tx/N7rN1b1UfXKU3tEcvaf6mgZDSyOoXpIjrQOJ95zmSjAqKjEErYe
 s61r0kGd395LyR3JK7BJ+jFL7se5W05dyyPyQISRJtd4K1TbQ9i4LcEN/QFpuc6Qatb0nqN8G6e lvWl8MKrBJX3K5h98YSbE1LhtgAWj7+bvQk5vtlaR25bIu7BnceGyRzahoGYlls+Y8St/RsBMJM 0Fs9vNydcKnUez91IIxwrGVt1OFiNHe4NTPPmuE4ryiDfTBW/7ypdNipPnGbY7qRVRQcSCymxHz
 oDZN5E4nJo/3bSuZ+6g98n5dKOW2vNlAQd7/l0XvtNwAFmt1ts0C+zAwrbve2er5XFtvV0je
X-Proofpoint-ORIG-GUID: igNqSKHLNCFqJqVkjaCvg3BQj6LqmFcg
X-Authority-Analysis: v=2.4 cv=JLU7s9Kb c=1 sm=1 tr=0 ts=680bb22c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=tWyVsHfbM1qZIku4hgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: igNqSKHLNCFqJqVkjaCvg3BQj6LqmFcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250111

Hello,


I am seeing a new build warning while building tools/perf on the 
mainline kernel, with base:

commit 02ddfb981de88a2c15621115dd7be2431252c568 (HEAD -> master, 
origin/master, origin/HEAD)
Merge: 30e268185e59 b0b7ee3b574a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Apr 24 13:01:31 2025 -0700

     Merge tag 'scsi-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi

     Pull SCSI fixes from James Bottomley:
      "The single core change is an obvious bug fix (and falls within the LF
       guidelines for patches from sanctioned entities). The other driver
       changes are a bit larger but likewise pretty obvious"

     * tag 'scsi-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi:
       scsi: mpi3mr: Add level check to control event logging
       scsi: ufs: core: Add NULL check in 
ufshcd_mcq_compl_pending_transfer()
       scsi: core: Clear flags for scsi_cmnd that did not complete
       scsi: ufs: Introduce quirk to extend PA_HIBERN8TIME for UFS devices
       scsi: ufs: qcom: Add quirks for Samsung UFS devices
       scsi: target: iscsi: Fix timeout on deleted connection
       scsi: mpi3mr: Reset the pending interrupt flag
       scsi: mpi3mr: Fix pending I/O counter
       scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()


Git Bisect is pointing to below commit as first bad commit.


a940e0a685575424d33324ec7f0089045249de0a is the first bad commit
commit a940e0a685575424d33324ec7f0089045249de0a
Author: Stefano Garzarella <sgarzare@redhat.com>
Date:   Mon Mar 3 09:52:37 2025 +0100

     vhost: fix VHOST_*_OWNER documentation

     VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
     instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.

     To avoid confusion, let's use the right names in the documentation.
     No change to the API, only the documentation is involved.

     Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
     Message-Id: <20250303085237.19990-1-sgarzare@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

  include/uapi/linux/vhost.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)


Upon reverting the above commit, warning is not seen.


Bisect log:


git bisect start
# status: waiting for both good and bad commits
# good: [9c32cda43eb78f78c73aee4aa344b777714e259b] Linux 6.15-rc3
git bisect good 9c32cda43eb78f78c73aee4aa344b777714e259b
# status: waiting for bad commit, 1 good commit known
# bad: [02ddfb981de88a2c15621115dd7be2431252c568] Merge tag 'scsi-fixes' 
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad 02ddfb981de88a2c15621115dd7be2431252c568
# good: [cc0dec3f659d19805fcaf8822204137c9f27a912] Merge branch 
'net-stmmac-fix-timestamp-snapshots-on-dwmac1000'
git bisect good cc0dec3f659d19805fcaf8822204137c9f27a912
# bad: [0251ddbffbeb213f0f74ef94b2cacce580eb8d76] Merge tag 'for_linus' 
of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect bad 0251ddbffbeb213f0f74ef94b2cacce580eb8d76
# good: [bc3372351d0c8b2726b7d4229b878342e3e6b0e8] Merge tag 
'for-6.15-rc3-tag' of 
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good bc3372351d0c8b2726b7d4229b878342e3e6b0e8
# bad: [fbd3039a64b01b769040677c4fc68badeca8e3b2] virtio_console: fix 
missing byte order handling for cols and rows
git bisect bad fbd3039a64b01b769040677c4fc68badeca8e3b2
# bad: [a940e0a685575424d33324ec7f0089045249de0a] vhost: fix 
VHOST_*_OWNER documentation
git bisect bad a940e0a685575424d33324ec7f0089045249de0a
# good: [16c22c56d4282584742022a37d4f79a46ca6094a] virtio_pci: Use self 
group type for cap commands
git bisect good 16c22c56d4282584742022a37d4f79a46ca6094a
# first bad commit: [a940e0a685575424d33324ec7f0089045249de0a] vhost: 
fix VHOST_*_OWNER documentation


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

