Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F01C84BB
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768026; cv=none; b=khvHPnQVW+iEH1M4+532dIH52/BPFdsSPuCkqLLq/M/XAyCn5+JFy1sDQ1ZjHnTxWXLaTTbpH9OMRz68dNNfaaiC5Z2dLLmIn9MNWWKOzGT1s1TbqarGI3B9BfIT/XpLH2pnJte9U0FBlvCnpEfZoBnKu5VjLy4G4cgfBX5f5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768026; c=relaxed/simple;
	bh=aARyNTYVp+3cWGjmZA/5zGpALXsjBLqwaj5cVrA217U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IJ4FF1OxXsYYoI6hNGlK03zQWgZ0JeN27BTBPa0CbUC0CTIp4eM1OLZ9A82DY+DFK1X2/x4eOmLJsX7bfZ+0VEwxvH82GchV1BhS5nYT8tq3HUQvXX9cSdLyN/TbbvmE/io8s2lu4KMbMDSCA9JveV9T0z0vx4x2vF/02weNW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=puRvf732; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="puRvf732"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B39mlL1018231
	for <linux-perf-users@vger.kernel.org>; Wed, 3 Dec 2025 13:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8QTpehON1SRLPEGCgVvX3JM/JGF2
	XYWb9xa+F/pqL0I=; b=puRvf732Kiiep1r4YyKN/O0kDkZmU+ISu8Oo0mSXKYn/
	rUgsheFY8VkOe8gmelth6qVsUn00a2NXHePRZbv86X6x3i27N9pKGZLoqVT6+K2q
	qywKyRidvtHYyAE48sAfOPWkuACtpfrhm2wrncy0/zsV+RwPH7J/WdYPGesdpr63
	8Im6ZLuX8URCegGovchI12HS7BtV0K1pH3IfuRCWteE1Sk5Fvh+LBbP29J79ySl2
	2P4Epr+QOZkxZ/XaXrSKM8Xz82tgs5LDepEBdNTfAu1LTIldur9y5Nb4IFD6rbcp
	DRbbBo/VTiS+w42IGKc8QRQnLewczTQJN6qMJM7Y5Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5jd5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:20:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B39mpCp003867
	for <linux-perf-users@vger.kernel.org>; Wed, 3 Dec 2025 13:20:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjsyjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:20:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3DKIxm62062972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 13:20:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 637482004D;
	Wed,  3 Dec 2025 13:20:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4750F20043;
	Wed,  3 Dec 2025 13:20:18 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 13:20:18 +0000 (GMT)
Message-ID: <94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com>
Date: Wed, 3 Dec 2025 14:20:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: perf stat dumps core when CPU offline
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wzd61_0cwWOdY6JZWzDdFVE_Ob2Lf5UO
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=69303917 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vBw0vaNz1gO5Gv2NntgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX/aFMEEA8pXMi
 LQHWDQ4fmGL7Y7YMzerUg5m48hE+Z7a8tzHLn0phniBs3mOsHSwKakIvIwh3hF3hbaTdnsCynk7
 eC7y9ZjTQ9mHtr+BxnktZrD+MvXvivd0Pv+LvYRxqgw7TtOGr6SVi5x9bJ+SsZJgoPW04GQN0I6
 mjByIelAp8eoqj/OmRgidDV16hT0UMZOrCyn7x4UEv/n+Qvu3CB47Kx/A0MfBWkDJ15DlGvUiXu
 l6OAhZsg7LMucGiECTmf/6DDtTanDUNsTRTY1M+AjGJZctxLDjOi1ZQhBmlkNET/hT2fIZyCmBx
 wKbRAuut60rFXQ3IcLcz7s3o0ViDKCTuOsS3cdDn42dZTewNcZFkqGTAGnYs2f0m4+kSkuxJasd
 n4ET7ojj6JsW/6ssnmapsMR+mhaR7g==
X-Proofpoint-GUID: wzd61_0cwWOdY6JZWzDdFVE_Ob2Lf5UO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

Hi all,

Is this a known issue? Trying to do a perf stat on a CPU which is offline.

# echo 1 > /sys/devices/system/cpu/cpu1/online
# perf stat -C1 -e cycles -- true

 Performance counter stats for 'CPU(s) 1':

           123,965      cycles                                                                

       0.000356838 seconds time elapsed

# echo 0 > /sys/devices/system/cpu/cpu1/online
# perf stat -C1 -e cycles -- true
WARNING: A requested CPU in '1' is not supported by PMU 'cpum_cf' (CPUs 0,2-7) for event 'cycles'
Segmentation fault         (core dumped) perf stat -C1 -e cycles -- true
# 

This happens on linux-next and linux.

Thanks a lot
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

