Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D661805E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725001; cv=none; b=EJZz0ZPtXpzD9VIzhhuhVFajv0PuzgbG1U2E0cYtMZs6bZfgRx0KUXiJJNWpRDdJ6U4rQbyjqsGz/+k1/NTvunT5Bm77FakMZxAx0zwcYST2NXP+a3qyxt/YXVNlv9d8LlPyUiiLQLroJyskwtHD9LHT1RjCPSRURasyY1/fBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725001; c=relaxed/simple;
	bh=BSxZy3LI604Plv+p8jsXij8dLD1E8UPbzrasleBwby8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mFW9wKdqNzIk/GYun4Z15PjdOFJpvLcoKWNq1pDhvCPgWDryNUAD1gjAVwEZUiPhK+CBEN8Cti3eovE63Ix2zlAIKsI8iYGFpw0oByFYQVJTWCDjuMqUHCRA4jbfTb4rwXKTSk+Z9oLM5uFMP5mBYYa/+y6e+9GTHTc7odrgNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kPo/Rbqi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kPo/Rbqi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJloai003321
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=A1Udzkcln4Nze1Mf5aOl+/Th6HR1
	wFpbwD4bGZAY0GU=; b=kPo/Rbqi5SJMBR4FM8Gf55rYenbfBLlpL32EBUENzu+3
	bHrq8/JvCvB8aEro3tS16PvckPDGCg2vwKhz7On+XzzJ33lPmiWgOgNEaPM8DOPp
	83MeZENIF32J4S4EgNlDUiyhR/g25o1ftoLx0vzGzDuC4wv8Yy7ZAmvuTF6zHBCR
	iXy5cHWvK7OWizz/O6BEIfwqf8ymMVnmpTChyLH7PYVg2uTgeySv8F6Efat3HIww
	XrRHufDgL3dJWYsUbq10FHr5Z1OCRGf9gydY4ke9jK6H5eUmHdycOV+HmyB/7npX
	6/W9fGk/0pgroB/pMW78ohYhVe2p07vUC50v7M+L5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8j659-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:03:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T57Fwg023873
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:03:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx29tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:03:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T83EoH18415956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:03:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50A682004B;
	Wed, 29 Oct 2025 08:03:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3340D20040;
	Wed, 29 Oct 2025 08:03:14 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 08:03:14 +0000 (GMT)
Message-ID: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
Date: Wed, 29 Oct 2025 09:03:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [linux-next] perf report runtime extremely long
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6901ca47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CR2gYEP0e08wFB8tmF9ersK2YTtA-XM3
X-Proofpoint-ORIG-GUID: CR2gYEP0e08wFB8tmF9ersK2YTtA-XM3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX6LHQg/5H+wFo
 08yelYdevauynl7ByDjNKkhKXqawPCth4ht9L3UK+/o7S1fB/1MYOM5XY9sNvorWsbBoINGrsJf
 2eVoNvhjBe78y1BJ/Y/5wMbPogJQ5UddRdQtp6HgIZClzwXJsARpeRkfuf8oIM7HmOuMzze8dlW
 2jQ2xVIO2LBb9Xx3FGzLRi8cvRG7KmfEqect6/uTZ87k/25glzKsNG/GlgZ/qX1kMpGVqQXThfn
 9Iuxve/tYsH4zAxmksADyTuy95lWrYDelnQp9EvBwdAyST6hF6EIpJUkgUh59Gqk85VEmhuGGyM
 98wNau8JGV++5sqaS4ppHOIr/qzNFToaO2mtaoeyFtKRJhXtq2k0EnsaiM9Yg4gEPiISkO0Cc9e
 Cboob+j+sU84jHiKsFePLIRL9/MIbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi all,

has something changed recently in perf report in linux-next repo?

I run perf report -i <file> -D | grep something
on s390 with 2 different kernels:

master 6.18.0rc3:
# uname -a
Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET 2025 s390x GNU/Linux
# ll /tmp/perf2-eSso2q-2
-rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
# time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null

real	0m22.262s
user	0m22.068s
sys	0m0.200s
# 

This runtime is ok for the perf.data file size.

linux-next:
# uname -a
Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
#ll /tmp/perf2-eSso2q-2
-rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
# time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null

real	2m53.601s
user	2m52.938s
sys	0m0.575s
#

Same perf.data file and run time increased from 22 seconds to nearly 300 seconds, roughly 14 times longer
for the same input!

Has anybody similar observations?

Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

