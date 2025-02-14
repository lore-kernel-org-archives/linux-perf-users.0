Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9D256C62
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528525; cv=none; b=HrScdfZyP1hhCAh6LhuImPwbykKwRgHDUNWtBmp32drgWPiBfBDafqNcyo53tB7t9cEOnYzEo5BltGXdfk+kE34vGoQK5Xob37TR4bLYkvjZMGjSf5pFnmQ97yRljnAO0hJznlgBOMMu5KlNbzbTfoTNnLIKRqJo62xAHdSY46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528525; c=relaxed/simple;
	bh=ftyb/9BKtB7NhFJH+J4U/oyLZeJ0rM3YZGofXN7XW4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nqq6b4LisabXanDuJZwTglv7U9SylKgZosBT8iEZl1SoyssNYDjg6I1IhkyeQzZNpxVnfwfaI6shrIno8dw8IVzfJGkm1+T+kTCyXOJn1dEfuOBInzz4A9pE/DEHpZBh+2+tbTc1GiE84/0uCnMgBawa7JWoUsO7ZKcdN8+nYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZaWDrrzF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZaWDrrzF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E217Fv013379;
	Fri, 14 Feb 2025 10:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Nxht2g
	qC6hYRkE+gAhSX1mypj3264SfMDe4UK7IJDcc=; b=ZaWDrrzFmO44RpaXK6QH8P
	IjhxHXo7dVNU2z7WgLSDkfwbQnLQK9gTEl9FJMze/wdijXzX9uFanNycD1sZC60f
	gw1nSiSuIV6Ib3/rIPo6riPUfkOXpAHydRYWAZ0T+A7tpnlEAaMPz4fCIyWAg53s
	WaI+vRQe/WKYEypCOWJRrpd1a4BU5fpsMdnyEdLZ8un2rqZVkqS+qQ6rwEjXFEEt
	tnkAU727sQEnos1cCITDjnZ63Pb+sbg9zBJL5k6OkpDdnBzv66mtzYJC3MfXd3/n
	dh0DgGQRMNiHaH+iJgZ9Tw4p9tFjsDvoNTp8+wqLOCBkfudbMluoeLrlTiqvj9cw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44svp09xhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:21:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E6FGUF021713;
	Fri, 14 Feb 2025 10:21:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phkt378r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:21:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EALuWw54854050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 10:21:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B7620040;
	Fri, 14 Feb 2025 10:21:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86E902007A;
	Fri, 14 Feb 2025 10:21:56 +0000 (GMT)
Received: from [9.171.39.145] (unknown [9.171.39.145])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 10:21:56 +0000 (GMT)
Message-ID: <b8b12ca5-28bd-4e17-923a-f4f5853b999a@linux.ibm.com>
Date: Fri, 14 Feb 2025 11:21:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf script: perf script hangs forever in linux-next
To: Namhyung Kim <namhyung@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, ashelat@redhat.com,
        Michael Petlan <mpetlan@redhat.com>
References: <c41e4b04-e1fd-45ab-80b0-ec2ac6e94310@linux.ibm.com>
 <Z66mwEOy06-6hvO_@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Z66mwEOy06-6hvO_@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9FQ5Oau7OzcPaFwvm6J1s5obBEWGffav
X-Proofpoint-GUID: 9FQ5Oau7OzcPaFwvm6J1s5obBEWGffav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=956 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140072

On 2/14/25 03:13, Namhyung Kim wrote:
> perf script flamegraph -a -F 99 sleep 1

Thanks Namhyung,

i have tested your patch and both invocations of the perf script command
work again as can be seen here:

# perf script flamegraph -a -- sleep 1
dumping data to flamegraph.html
#  perf record -- dd if=/dev/zero of=/dev/null bs=1M count=10K > /dev/null
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 0.294051 s, 36.5 GB/s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.060 MB perf.data (1177 samples) ]
#  perf script report flamegraph
dumping data to flamegraph.html
# 

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
