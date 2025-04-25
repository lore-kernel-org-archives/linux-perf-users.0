Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2F14F9EB;
	Fri, 25 Apr 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597266; cv=none; b=dc9MoEDaTSeIshOvqzCE9taKRq6RI7P0YQMfIAN2QrsdPHR8WXuhwoWxipnX0mxUZInln5lvB1l43fsPz+2a3YsqsjIidbysPnpHfDU7i4F1HxOjOEDli7PWt0BvfKFUwBzZWeNbtdoKGe2CKqObYp2R9HJ4kxW0LV26s/gK3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597266; c=relaxed/simple;
	bh=5O7iV/W2chq5GklIjOdCtIN/ECQvXe/3G2d7Eljipts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qEecuhgyihr6EI2Hw3RuWbmOePQNN1BIEMtsfgtyBhdUi1jp57JdEYNORof1BiOd3XPDGKKLEgLzSv6lUhxBFoITHSrwzQYJtVLvdkydBG+0hnQiIWQF3liu6weeqG+LZq57i/bW0hMibSxWE37fIQO82lNuF+YQs3hYtzSwIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dDYMkr6o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dDYMkr6o"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA41SL026437;
	Fri, 25 Apr 2025 16:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GkeXgS
	jZh9ajob+i6TRSkXjv+/YhfqrO0zFPsHMuiKk=; b=dDYMkr6oDt/2cozFe+Ew09
	9tujJA8ErezovC/ga2t+MW45yChVYhGrwC86MVa50sIChfxwGD89jW0E121hGNsw
	o6F1yPG5dpOzvYawe0BsHgf3Ur+wZkYk+Zbr/GKMaAN7ti+PEiJ+twQOSXgyAWKQ
	Qj9IaZsIu/My4hkpdQWzs+QVfFSiIBmzX6EZzNBBZm7TrggRCqezcfDoipAXOvUS
	bFctriTthsuJdLmJBBDotXIkObfM7ot/n8xVCKTTBPjMshurn3So2/Pfz4K1gWPC
	wRRdeiMa3Cbgnq55cPInSogxKXVT9V7bZL0FovkJZ424uuuFodzaioJ1zuRLcyMA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688ajspgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 16:07:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCtbj6005893;
	Fri, 25 Apr 2025 16:07:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxp0ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 16:07:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PG7aki31654532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:07:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24E2258059;
	Fri, 25 Apr 2025 16:07:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B33ED58057;
	Fri, 25 Apr 2025 16:07:33 +0000 (GMT)
Received: from [9.61.252.14] (unknown [9.61.252.14])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 16:07:33 +0000 (GMT)
Message-ID: <43507075-ec04-44c8-a95f-49e074d933d8@linux.ibm.com>
Date: Fri, 25 Apr 2025 21:37:32 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]Warning while building tools/perf
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>,
        Athira Rajeev <atrajeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sgarzare@redhat.com,
        mst@redhat.com
References: <9c40ab1a-3d08-4af8-a430-0ba245842959@linux.ibm.com>
In-Reply-To: <9c40ab1a-3d08-4af8-a430-0ba245842959@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExNCBTYWx0ZWRfX/SPKQXwH4PJi zUj3WVU0Uc0J9wfZLBas9qkYZTF5IqKZjXsuPJ8qM9xCcSkFheaQFEiZLlu0lncsG4GwNQznAIN eENNyVVyPa7HF4Li4P/6Hpi+77AuzGVJ+KBtGT71SsF4rt4kBpwlQM2CU1/Ojnuou+ypqkaGg4y
 s5hFjKNhjOicluDePU3LqNBqBgURiisLgSuHddEVMRPciNTzDRoajkUrT5/Af1RrhR92k/XQ/fP 1q3+w4KnIGjz/q43JcuBO/SkRLqkMuvhLAu9bMGlanH4xvyPtdCPi7nzMEcy7jgRdEOU2hb50JV DLd8oFWkdAbWO5ektq46IOkn+ymgJDzc294Ip14qDosaySSm62yT/SMvcLXdOjM4QEoo+BseE3P
 G2+MVPl8ZukhsXhgwOsq3+W26B5Q5VqakBfKaGwp7K7Eo1PHbR+w5Z963l42/wvYmlyVP5iw
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=680bb34a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=t_VceZeAIPjMNq324LgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: y0zjUMfM0TBVcEXtdp0h5y1VY0JgZUUs
X-Proofpoint-ORIG-GUID: y0zjUMfM0TBVcEXtdp0h5y1VY0JgZUUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250114


My bad, missed to mention the warning in the previous mail.

On 25/04/25 9:32 pm, Venkat Rao Bagalkote wrote:
> Hello,
>
>
> I am seeing a new build warning while building tools/perf on the 
> mainline kernel, with base:
>
> commit 02ddfb981de88a2c15621115dd7be2431252c568 (HEAD -> master, 
> origin/master, origin/HEAD)
> Merge: 30e268185e59 b0b7ee3b574a
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Apr 24 13:01:31 2025 -0700
>
>     Merge tag 'scsi-fixes' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
>
>     Pull SCSI fixes from James Bottomley:
>      "The single core change is an obvious bug fix (and falls within 
> the LF
>       guidelines for patches from sanctioned entities). The other driver
>       changes are a bit larger but likewise pretty obvious"
>
>     * tag 'scsi-fixes' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi:
>       scsi: mpi3mr: Add level check to control event logging
>       scsi: ufs: core: Add NULL check in 
> ufshcd_mcq_compl_pending_transfer()
>       scsi: core: Clear flags for scsi_cmnd that did not complete
>       scsi: ufs: Introduce quirk to extend PA_HIBERN8TIME for UFS devices
>       scsi: ufs: qcom: Add quirks for Samsung UFS devices
>       scsi: target: iscsi: Fix timeout on deleted connection
>       scsi: mpi3mr: Reset the pending interrupt flag
>       scsi: mpi3mr: Fix pending I/O counter
>       scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()
>

Warning:

diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h 
include/uapi/linux/vhost.h

>
> Git Bisect is pointing to below commit as first bad commit.
>
>
> a940e0a685575424d33324ec7f0089045249de0a is the first bad commit
> commit a940e0a685575424d33324ec7f0089045249de0a
> Author: Stefano Garzarella <sgarzare@redhat.com>
> Date:   Mon Mar 3 09:52:37 2025 +0100
>
>     vhost: fix VHOST_*_OWNER documentation
>
>     VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
>     instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
>
>     To avoid confusion, let's use the right names in the documentation.
>     No change to the API, only the documentation is involved.
>
>     Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>     Message-Id: <20250303085237.19990-1-sgarzare@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>  include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> Upon reverting the above commit, warning is not seen.
>
>
> Bisect log:
>
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [9c32cda43eb78f78c73aee4aa344b777714e259b] Linux 6.15-rc3
> git bisect good 9c32cda43eb78f78c73aee4aa344b777714e259b
> # status: waiting for bad commit, 1 good commit known
> # bad: [02ddfb981de88a2c15621115dd7be2431252c568] Merge tag 
> 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect bad 02ddfb981de88a2c15621115dd7be2431252c568
> # good: [cc0dec3f659d19805fcaf8822204137c9f27a912] Merge branch 
> 'net-stmmac-fix-timestamp-snapshots-on-dwmac1000'
> git bisect good cc0dec3f659d19805fcaf8822204137c9f27a912
> # bad: [0251ddbffbeb213f0f74ef94b2cacce580eb8d76] Merge tag 
> 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> git bisect bad 0251ddbffbeb213f0f74ef94b2cacce580eb8d76
> # good: [bc3372351d0c8b2726b7d4229b878342e3e6b0e8] Merge tag 
> 'for-6.15-rc3-tag' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good bc3372351d0c8b2726b7d4229b878342e3e6b0e8
> # bad: [fbd3039a64b01b769040677c4fc68badeca8e3b2] virtio_console: fix 
> missing byte order handling for cols and rows
> git bisect bad fbd3039a64b01b769040677c4fc68badeca8e3b2
> # bad: [a940e0a685575424d33324ec7f0089045249de0a] vhost: fix 
> VHOST_*_OWNER documentation
> git bisect bad a940e0a685575424d33324ec7f0089045249de0a
> # good: [16c22c56d4282584742022a37d4f79a46ca6094a] virtio_pci: Use 
> self group type for cap commands
> git bisect good 16c22c56d4282584742022a37d4f79a46ca6094a
> # first bad commit: [a940e0a685575424d33324ec7f0089045249de0a] vhost: 
> fix VHOST_*_OWNER documentation
>
>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>
