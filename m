Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C8285C91
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116391; cv=none; b=gXVQTq3VvGcE3e6C/aMFw9iTZ1xDrQ17IRMsFz6X41k/AFZegeFVxv3bRKKSfFzISZDzc2kyLixL4pQ3ABjpktetdDXLROFgC2hcHn/++g4ZdYyjw52qkbm9AhlugSLnKbhq4V9zMbKqwlvOb/5v8ls0NM+5v4AK/LDrBJVhzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116391; c=relaxed/simple;
	bh=Va/O0w+JROzZ9mFRZcTcXZU0siAoFrYt2iGgmPsUtYo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gu5fGLXzvPsmip/+13nEZFMMcJZOXMFNUNNloQfK/BcMx05in6+/z6aNSJEHNDggA5MZfVHB7iQm+KLdN3THxDTjqGL6V98kO8MQPtdJ8L2QUszAvXAE7yVqksaSFU64Q9aL+KESurbjx74+no/I3N7ejmwH29eHuoviYtlJ8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AfQEnRQM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AfQEnRQM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 613Ad4g0008561
	for <linux-perf-users@vger.kernel.org>; Tue, 3 Feb 2026 10:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=VCsI7rCCXQL22wr2go2zmZMCyWlN
	E1Mgg0DYzMyUcMg=; b=AfQEnRQM9AvOTjHaCdAfOdaWvKUbSwN1JQ+APiJd61zU
	N40Z7J87G8RMc1wteg0jWBgWMVQkLdVTQxQxbubX0I7YsLeK/KaaZwwdJ8FDQUMN
	FHoSiUanp4/aONgYfujYPS2yAd3c2Sw/4DkxGl70abocDZsH4LhP2w8YhfuT4A4u
	JbsA8ND0PaZThpFHLNC3r9Cx3Oa+mpo9g31QFhiWgRJYfLktyNfB0zT5AaRWDEBg
	DUMULPTsHnrWHVBmu1jwI/rjv1VkfNajAVmu73sbtNVTv3Kxe59DOgqNP43pObbi
	BwhZQVEKlw/Dc6k8UbRZSppBu91+SEBY+n7GIz+aRw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gttaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:59:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61379cP7005938
	for <linux-perf-users@vger.kernel.org>; Tue, 3 Feb 2026 10:59:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9j8hps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:59:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 613AxkGL28377582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Tue, 3 Feb 2026 10:59:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95EC420043
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 10:59:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80E7C20040
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 10:59:46 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 10:59:46 +0000 (GMT)
Message-ID: <5fe285bf-469d-4a0e-9958-96cf3dae70c4@linux.ibm.com>
Date: Tue, 3 Feb 2026 11:59:46 +0100
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
Subject: Linux-next: perf test -Fv 44 dumps core
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=6981d525 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4m0sb6oGD8KnM4vvvrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3HHLtdq9ZHmcWyLrljGky3QzsSCxknIZ
X-Proofpoint-ORIG-GUID: 3HHLtdq9ZHmcWyLrljGky3QzsSCxknIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4NyBTYWx0ZWRfX/fCI9owG9vco
 /v6vSPe2okI9zvZYnSETgFkMMJvnSzrpTfm5UxD0JISVLjs2jqgeRI/fvm/p5APbUrHzTuR7N+K
 VLrB+lCzaJFD9B4Zkjk5QYiCGn6NYk80z9OgMP7mW56aV9ZguerAPHwtY823h9AwKaEcI1CF7K5
 I9JZsKb6Zgb+6xSNr+KvOb2UICVVdtVWyl83ueVWN8r2jo4n+aprYqX/ADh1O3XQGl5w6basKcl
 YSL1SAl2H0dbHo8i7GEge3qvt+9Dkrh2eZH+A+lQ1wLcHht6xJnM8Lhtk2+cvtE3rKVisO9HXvS
 CcCb3+Ud1rfGZAJexkCtZoqh0Sr2T4yrGdIaGFprRyY+rw7qs66tYM2ha01YN/A6I6ieFkNefFd
 d6zb4swoAGE3QuGGUPBLz3UT7UtF/2b15GVMlPBV0A9z1UhdlDCEPt1y9l1Rj448kkG3DMfTKOj
 OGVkYF2Tve82h74iNBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030087


In linux-next repository, the test case

root in linux-next/tools/perf on  master [?] via C v15.2.1-gcc 
❯ ./perf test -F 'Read backward ring buffer'
Segmentation fault         (core dumped) ./perf test -F 'Read backward ring buffer'

root in linux-next/tools/perf on  master [?] via C v15.2.1-gcc 
❯ 


fails with core dump on s390. This happens since 29-Jan-2026.
Here is the core dump:

Core was generated by `./perf test -Fvvvvv 44'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x0000000001113dc8 in __read_once_size (p=0x14, res=0x3ffe2a76a44, size=4)
    at /root/mirror-linux-next/tools/include/linux/compiler.h:180
180             case 4: *(__u32_alias_t *) res = *(volatile __u32_alias_t *) p; break;
(gdb) where
#0  0x0000000001113dc8 in __read_once_size (p=0x14, \
                res=0x3ffe2a76a44, size=4)
    at /root/mirror-linux-next/tools/include/linux/compiler.h:180
#1  atomic_read (v=0x14) at /root/mirror-linux-next/tools/include/\
                   asm-generic/atomic-gcc.h:26
#2  0x0000000001113ff2 in refcount_read (r=0x14) at \
                   /root/mirror-linux-next/tools/include/linux/refcount.h:70
#3  0x0000000001115086 in perf_mmap__read_init (map=0x0) at mmap.c:186
                   --------------------------->^^^^^^^^^ NULL pointer
#4  0x00000000011f9640 in count_samples (evlist=0x25f9c60, sample_count=0x3ffe2a76e88, \
                comm_count=0x3ffe2a76e8c)
    at tests/backward-ring-buffer.c:41
#5  0x00000000011f9856 in do_test (evlist=0x25f9c60, mmap_pages=256, \
                sample_count=0x3ffe2a76e88, comm_count=0x3ffe2a76e8c)
    at tests/backward-ring-buffer.c:79
#6  0x00000000011f9b0e in test__backward_ring_buffer (test=0x16a9650 \
                <suite.backward_ring_buffer>, subtest=0)
    at tests/backward-ring-buffer.c:140
#7  0x00000000011b2866 in start_test (test=0x16a9650 <suite.backward_ring_buffer>,\ 
                curr_suite=43, curr_test_case=0, child=0x25f9670,
    width=64, pass=1) at tests/builtin-test.c:506
#8  0x00000000011b31c0 in __cmd_test (suites=0x25f8e40, argc=1, argv=0x3ffe2a77dc0, \
                skiplist=0x0) at tests/builtin-test.c:649
    ....
    
    
Gdb sessions shows that evlist->overwrite_mmap is a NULL pointer:

 (gdb) p evlist->overwrite_mmap
 $6 = (struct mmap *) 0x0
 (gdb)

Is this a known issue?

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

