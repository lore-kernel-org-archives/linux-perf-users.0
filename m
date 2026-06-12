Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0894227EB9
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271211; cv=none; b=DAcFE21mDY0veBtf69zojjGYnQcDQEcUf8npsQEFC2OIK5Oxzd297s4c7EPpT1w9JrKycY0TgjtUN/TXC8quOkw9529Y0tZ5IHCiNUMQfvxbJvJuDgn0zj78DaFCjCPbFa2TzEqe1zo/OX+d9n4pB57BwVGbAqDlmrqGpORDToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271211; c=relaxed/simple;
	bh=Smtmb+epIuY0BbF08Q0R9+o/Ei+jB7W3TkpxCG2P7no=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zca/HVHKhL+d0gQJe1F85seDYaMcaZXv+OJzanpNF3QkHOxMIPGiK0/RZ3WuC8wj1Reyc761/pBFd9AcYcCR5p1YQl/jASYqDo7lDTqzAwWsWflWWIbF/emwupxpYGSsu6/WlYo1ANI2S6NWQ+1WTThJsH/9jWmdRgudoD1cSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HkWHMTFf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HkWHMTFf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C1pMIq3872812;
	Fri, 12 Jun 2026 13:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=elbmUS1ey1koIlqqbggIK84UTP6i
	6eMHeNhCQr5Z5ZA=; b=HkWHMTFfEtz9wrUE+qJ6FZRYOwP1XDMHgaQLPm66xXWK
	OCkhbwEfS84OUYNLnSl1OvhEED9lI3RxpbI8CLKdkJptMR1sOGfhTM12eMimgWzQ
	gqocPARKKdvKxwH7XnfA6Hd91y4ypUyP8XnO2doQ80Oa9yOwCLO4KMF+GWWrXdk+
	TtMXERHGwUJ6xJfD9+FkRVxzFDW/irj0Ipb9I7ipwENSa24tqpQQfFjJGOuLZakE
	wVtqAowUgZNZ1CHPru1eOXXI9qW22y4cTIsuXvpWRVxGC8auNH+F9r4iM/hIFjG6
	Cf0IZtFzwCCfxoKLGa4k28ig50Y3R5zDLmkKUAYeqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8f16nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:33:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CDJq4l006888;
	Fri, 12 Jun 2026 13:33:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08r1sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:33:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CDXMb521823850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 13:33:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AB020043;
	Fri, 12 Jun 2026 13:33:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DA8520040;
	Fri, 12 Jun 2026 13:33:22 +0000 (GMT)
Received: from [9.111.61.120] (unknown [9.111.61.120])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 13:33:22 +0000 (GMT)
Message-ID: <3428df2b-abdc-4cb1-98f2-afdd759919b1@linux.ibm.com>
Date: Fri, 12 Jun 2026 15:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: swapnil.sapkal@amd.com, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Missing information in HEADER_CPU_DOMAIN_INFO
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMCBTYWx0ZWRfX9zMnYJUQO+97
 15+eD25BxrfVSAl3VGDESa3cjyxhiuSAFgSJ1zuU0+34nFf1yUJvYJkGxp649THGqTiuSmBwO4/
 y2bDuHlKzicKP1A+l8FDtQ61TOyAJtm4KGBrmhqTvCppPcbUNtButQLLenOiZPE8oxaD/H5JEOa
 TyQMuDppMzmyjZyNfhtoMWEc1DNQ+laZXmjC5fONHawSDECuDS4DbJqTzE/E9rHHaDnbPNitU0D
 X5qsSBfBsthk5LB8ULEJw42moYx1cBxqdgk9f7YP4+dm60N1xsI1Bj4vjPY7rsyhbPI9pQt+Pnc
 zEggJHhPh6reaT+c9mgGZRGw97eY6RGmK15LhXbkew7Z/Ypw2WqrSXNfCAIA3Ts1OBJg9Voa+AL
 U698hdClHlVwlm7Zb7Dx77ufOopFbI41FUYE9UGCm9Jw1XmVhQZsD/vtVmJR87VZxXo+InOt0b/
 GknlP04NlrvSbWxdj3A==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2c0aa8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Lh2iM_emvY-ES8JQXb4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: usO1A5o2sOQe8vewZt91460a26swCd4h
X-Proofpoint-GUID: qq5zDpp-4pGuGHHPgpFki0rWJhXfgyvB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMCBTYWx0ZWRfX+rF0stg6bloJ
 bBvVrTCYF7TceahWiVvUhAxabHKYVSjdhdncpOl+o7NrVCttC71YU54r9JHGOS3LkPsdM35QXpm
 UwZ9IqCnqcMrqbdmFL3ph+Lg8G/m+pc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120120

Hi Swapnil,

Commit d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
introduced the HEADER_CPU_DOMAIN_INFO bit and the necessary data.

However two issues came to my attention.

1. The documentation is incomplete.
File Documentation/perf.data-file-format.txt differs from the data written
in function write_cpu_domain_info().
The first two values written to the header section are schedstat_version
and max_sched_domains. They are missing in the documentation.

2. The function write_cpu_domain_info() writes a variable amount of data,
but does not indicate how much CPU members have actually been written.
This makes it much harder to read back that data from a perf.data file,
because the reader does not know in advance how much data to read.
Since the data structures also contain strings, the file section size does
not help at all, because strings are of variable size.

In my opinion the structure should contain the number of CPU data to read.
My suggestion:
Modify structure cpu_domain_info, which contains the
missing schedstat_version and max_sched_domains fields and contains the
number of CPU records actually written to that header section.
Here is an idea:

        HEADER_CPU_DOMAIN_INFO = 32,

 List of cpu-domain relation info. The format of the data is as below.

 struct domain_info {
        int domain;
        char dname[];
        char cpumask[];
        char cpulist[];
 };

 struct cpu_domain_info {
        int schedstat_version;
        int max_sched_domains;
        int nr_cpus;             <--- new
        struct {
                u32 cpu;
                u32 nr_domains;
                struct domain_info [nr_domains];
        } [nr_cpus];
 };

The above syntax is also in sync the other sections of that documentation file.

What do you think?

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

