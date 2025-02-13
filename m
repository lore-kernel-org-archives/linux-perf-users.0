Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0C20AF66
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445012; cv=none; b=HyevPDmEF9z0t8a8gkVNbNNqf1c4vmjL7JeksJx9mQsejp37RRl0jRDJV8OSdYB33WPTKhmJQwxQZrJ978Zh+nx/b4G6ycpI4j5DYLXKJGRhpNSzbrrxkItQoYjYwUlodcZDR4ElqO1SClq9uh0zS4ow7rSeZcqvX9RbObgGFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445012; c=relaxed/simple;
	bh=uH0K6GShrEJy3bYMbc+eFzYclbRVKJaOsQeu0/nwWNs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ee2Y7jBFfYphqzsU/7buXfgiYzOosmnMnwjsD7mtkAilB97oX7Dg6XVWxK6Zo/C52HOiRBLPcAwt1MnYjwcUUlrexQRYByo2ejNEhzb1QACtkVg8bY3mhgvqAYXnqwPB4Fbaf3QXgDPbV1h6YLaMPo/K+XY7vOZtFSNiG8ueT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CYM432Ge; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CYM432Ge"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D17uMN008977;
	Thu, 13 Feb 2025 11:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=clze/b7tSpztvAe4MjkprpKjE1Ta
	4GWl0THyxBzmO54=; b=CYM432GeUtoYCtC6asZcWjhQCdl2fhSr1H/Wxgb5RL8Z
	gG3BYDUvzwWUcK+WH5qf1TfoXiFVIoj3kMUsS/E6dwDnFsNYAGHV8KcCJNB65UuE
	uTJr+iRfSM/5Cqj41A6VnmtBie3qlg2TUBnnXsLk0HucceQSiLgC6OO0hfO/NhX6
	wMhh8kQqwaDIEYJ9AUHswa4bSapn0ApeGlPR+FSg1V2kl/yzpIJr84B4eGLe0l8F
	T0ZnJhuWyjw1X1Vvwuy0IGWSo3JsX/a7KI4jOV/QLUq2zgyJ1UjrLsCBrsXk8EVS
	QxbCFPOB/AgpHKQtTOsBkJcx6QZ7t01HZtDYtsaF4g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44s6ta2e70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 11:10:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51D98RCI011648;
	Thu, 13 Feb 2025 11:10:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktk5m82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 11:10:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DBA4RS37880262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:10:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BAF120146;
	Thu, 13 Feb 2025 11:06:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DBA020144;
	Thu, 13 Feb 2025 11:06:41 +0000 (GMT)
Received: from [9.152.212.90] (unknown [9.152.212.90])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 11:06:41 +0000 (GMT)
Message-ID: <c41e4b04-e1fd-45ab-80b0-ec2ac6e94310@linux.ibm.com>
Date: Thu, 13 Feb 2025 12:06:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, ashelat@redhat.com,
        Michael Petlan <mpetlan@redhat.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: perf script: perf script hangs forever in linux-next
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v0t0nhw5_RqdTQIweqAJHGNGTrI_R7hR
X-Proofpoint-GUID: v0t0nhw5_RqdTQIweqAJHGNGTrI_R7hR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=936 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130084

Command 'perf script report flamegraph' hangs for ever as can
be seen with these commands:

  # perf record -- dd if=/dev/zero of=/dev/null bs=1M count=10K > /dev/null
  10240+0 records in
  10240+0 records out
  10737418240 bytes (11 GB, 10 GiB) copied, 0.387818 s, 27.7 GB/s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.074 MB perf.data (1520 samples) ]
  #
  # time perf script report flamegraph
  ^C

  real  0m53.506s
  user  0m0.017s
  sys   0m0.012s
  #
  
Control-C interrupt is needed to terminate the command.

If I revert commit 23e0a63c6dd3f69cb7ee18411e5f6857cca55b30
 Author: Anubhav Shelat <ashelat@redhat.com>
 Date:   Fri Jan 31 09:57:05 2025 -0500

    perf script: force stdin for flamegraph in live mode

then everythings works fine again:

 # PERF_EXEC_PATH=/root/mirror-linux-next/tools/perf ./perf script report flamegraph
 # dumping data to flamegraph.html
 # 

Can you fix this so above invocation works again or revert that patch?

Thanks a lot
~                                                                                                   
~                                                                                                   
~                   
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

