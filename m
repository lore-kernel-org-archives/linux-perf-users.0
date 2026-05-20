Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74083D811E
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281097; cv=none; b=njE6QqsntLJo8TANulc7FE+DViRZV0ssBZjf2zqXv1Tq/Jic2XV+2H0zuyJ78I/ZKDpXGvPrTfjphH6AABA/IHcEhXLsiOd9HviXeTIJ0UGi47vvlnXZNQqKzXIAza+944qeTGfcjqfrUVltYrhUGCcPIH6N9cmaGK/+bElJVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281097; c=relaxed/simple;
	bh=90dTr1Qi9yuACudF20aHkhxWz9US003iAdGh3vLNMVg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Wl+aJVo3nDOZQyAlmJhm5d0yLWFLkb62Sff2946kDnwhUiWsbC+Qs2tacmXqdEX9rZkje/3fFAI7qIBMjIURQ3Bl63AswXURSvcZD7beF2k+G47HB0VVsQluLLQkAWIt0K1Wy5/IZ+YXe7q8adGEBZeg999Js2KYHO+kg7GRVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tq3UF9cb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tq3UF9cb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KArbhs3991710
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Sns0GUJ/XY12OEqiv4hazkqDCWRp
	KQM2m2rwx6a/zEA=; b=Tq3UF9cb2AXB8MvCD9zHpB+trRaDpIp0RRA4JviXeaoU
	9EkN6PDC/UdcbBgNhxwNEeLXLI7KVdCwyPp+ttbJ73SPKnIqjNp+UY9lH3guGXJS
	B3Hen98bKkrN4HAgIfPkOUmEW3V/CQfXsNNsJqrtuh5Va1+uWAM595uo7c2+ODWZ
	TYy/l6q7MQAr4/Kg5iAGMtNw9FyfHOdAjvppZvp6ag7pFFkyChVM3vY9ZXrPJ4Fv
	+msido7UclGWIyaP/kzEaB7bliPHVRhXF2XusI10M1Vp+fNeV9vBxAVzPuA/zLEy
	UpqvXBEtBwhe+x6XinKvRq8bL052xpp/DC6IkC1FzA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8h1rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KCdGbX009945
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vyesm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KCiqsg51183948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFB0120040
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE9B320049
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:52 +0000 (GMT)
Received: from [9.111.38.205] (unknown [9.111.38.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:44:52 +0000 (GMT)
Message-ID: <314df838-4c38-4f03-9515-ae1dabd09a54@linux.ibm.com>
Date: Wed, 20 May 2026 14:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test case 'perf kwork record' fails due to abortion
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMiBTYWx0ZWRfXzazXY5wjUYhi
 w3Gb3BTo+r88kMRR/UpxujalPhwRUpoocNSP4zBK7QsOtWX0RdWtKTqqYDqVGjLuLXJI1BcuTB5
 QoppSqsiE8DcP95GWHLrqq3ud50Ccwz6BSppTuEzi4NBoLUjkwyvyD+VLMk6n/LGu9It2UKDEal
 gXbFLFzPAoSnEs07/614CBBAI5+VuC6YtFy9bV7qzHVsxfKJTyvd4tjM0zmI09tiWItQmFOY46d
 mm4v4hYLjTMy8XbdwoX4dz0r+Bnx+wwJGIm0LQ2uIYhoAKVZsRVQ7u+Cl23Xy9NBsuYh+5gbHHU
 1zIFvNI0aejVFJntAeeG3grARASyF3AwpjjqfP9O2Rp+Gecz/RDT9ftIlJA5Pa4yCNdrh0mGENY
 VR3g5lWE4WB6eAijmyuTwuQz8h10HynQ/ThdFYxggrPvNmR7QegD3t/AUF6zAcVinwh0MVjdwnE
 edq5+Gi37e0+p+Fr6fA==
X-Proofpoint-GUID: 2Bz7Z3vhK6x1yiMMbXC5YfgbE6lB1LhS
X-Proofpoint-ORIG-GUID: 2Bz7Z3vhK6x1yiMMbXC5YfgbE6lB1LhS
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0dacc7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=HVa9FsKFN9bTpKEVuYAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200122

The test case 
# perf kwork record -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.280 MB perf.data (568 samples) ]
double free or corruption (!prev)
Aborted                    perf kwork record -- sleep 1
# echo $?
134
# 

The perf kwork record is kill with signal 6 (SIGABRT) and the test fails
on x86_64 and s390, probably on other platforms as well.

Is this a known issue? 

Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

