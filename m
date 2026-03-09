Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD58198A17
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061475; cv=none; b=kKSNMeNnSfTlXXv78kWx0NINx5DdPbe0iKvMxd5FVgFNFF3U0eZTUkejMvOXxFifpH3eazvkm71mWc5iLvWyPnikT8duY3RaFT+rRpitDoexZYQD7G9qC8KyeSFHg6UEmDGQTBu0gvm6b2G8buPxRPBQuf44ARw3jQoEVZV2LBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061475; c=relaxed/simple;
	bh=/3fWehAOINQ1nKmaIuOeKeEO4h0WDLT7pJKnW+LYtAA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UubToWyTR1z5JpznddW/Brhk+5cGnmQHrR7uIpy864fz5/M1y27UTc32fH0+T/pb0wB2qwGiu7CEVbMmSiAMehlAlZ36yoO6ssE29KrSK9xUOV9EDPk9SuQuI2ST4+5NklWOdVY0PkbTyQSsMQ7t3gDMb5763xG5CiAyfkvrALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W3N04rYX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3N04rYX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628He3Y91027783
	for <linux-perf-users@vger.kernel.org>; Mon, 9 Mar 2026 13:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=HGTBTPtkCTzyvK7ObT9ty+HFTjuV
	KMzX1kJDRsfZFkY=; b=W3N04rYXtMtx69JdysLWx3kS2wIFdad8YFY2WWLuVakF
	gNEHpAY/v63EoKEhg0MnuO7/1ta/+EQ9VU+SoT1DbeLcGNd21JZYAje8astv7IBZ
	0xrTAFpxSCFvfpTZ8F+yU03EksZ7fZui3G9Dv54DNYfVKCY0Q9buRcY6ldwf1BsH
	/bLDZeP3I0qTWQmZh1MhD1fgCRro6afwBm91akKaSgrpQUeFyw/LlWKc/5jxq/2K
	sMNL7JgBF+6sAacbp+fMmKj6CfAybR21WZDdkQY/OcHX5l+iS2ZxM4pqntHfqU3d
	K9N260Q+7zrSFpTeWs44E/+x1IqGLBRxD1pi/Gl8+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun6chj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 13:04:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6298wU0u009535;
	Mon, 9 Mar 2026 13:04:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy53p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 13:04:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629D4SLD48103764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 13:04:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 914492004B;
	Mon,  9 Mar 2026 13:04:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6B420040;
	Mon,  9 Mar 2026 13:04:28 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 13:04:28 +0000 (GMT)
Message-ID: <61a60089-c0a1-47d8-91c7-c1fe68d19f5e@linux.ibm.com>
Date: Mon, 9 Mar 2026 14:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ian Rogers <irogers@google.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Test case '105: perf stat tests' fails for s390.
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Qcm4yLSdsuhEe5LL8trV7PdBji_Iegi9
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69aec561 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=iMFrvE6GpTEsmqhUCv4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNSBTYWx0ZWRfX8T7J0LK+V1zA
 FcKWsTafbwxxCdo0hXcPeKXmICONSj23IIhyrIBrbpNaS1RyeksMXiCwOTqzZc+QPqca3PAFttT
 /Xd7wcLM76HiDHQAx8NsfVgX4s6cA2foxTqq1q2B0Js6DcKUc6l6RosZqpovPbZuJCqzU2vLfhD
 9YBpcB3NvUClHhKF9iqLGiNm63tW3kwQBfajMKBirAtc82mc0IPj8dAvf2SbL1fXyYti81vxDK9
 v+toGKqu1tx0EjF8/1znwkZPrShqVFMKhh/13UZ9ohiyCY0DncL+KWB3ubZXwY5fHqD4S/pF9Rn
 qVp1lQWkVjJTSX7UODaJDDAHupr/lNyQuAYjGbPTOmsmpgG9aLGZwTNTbVepx7ZL+5ZGlNLB52z
 steDfhS0fO/sQOnp9KBNGpU3QBI2eKftAY7xvkx4rpBVDL31gCpP1UEn3eXiMwYwe9y2tdu0kno
 6At1XhsBpzZYKw1a2Tw==
X-Proofpoint-ORIG-GUID: x-9-9bVxpbWxJ6NHm8SVqv97mwxlAozZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090115

Ian,

test case '105: perf stat tests' fails for s390 (linux 7.0.0rc2) . It boils down to this command
 # ./perf stat -C 0-31 -a true
 Error:
 No supported events found.

The first bad commit is this one:
commit cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID table exists")

Before this commit the output of above command is:
Output before that commit:
./perf stat -C 0-31 -a true

 Performance counter stats for 'system wide':

       105      context-switches   #   3579.8 cs/sec  cs_per_second
     29.33 msec cpu-clock          #      7.8 CPUs  CPUs_utilized
        34      cpu-migrations     #   1159.2 migrations/sec  migrations_per_second
        52      page-faults        #   1772.9 faults/sec  page_faults_per_second
 5,026,832      cpu-cycles         #      0.2 GHz  cycles_frequency
 3,029,266      instructions       #      0.6 instructions  insn_per_cycle

0.000851608 seconds time elapsed

Since this is executed on an s390 LPAR, hardware event CPU_CYCLES is available, so it
should be used. This is something I will look into.

Also some other test cases fail after the bad commit:
 ./perf test 2>&1 | grep  FAILED
 99: perf stat CSV output linter                                     : FAILED!
102: perf stat JSON output linter                                    : FAILED!
104: perf stat STD output linter                                     : FAILED!
105: perf stat tests                                                 : FAILED!
133: perftool-testsuite_report                                       : FAILED!

Before the bad commit the output is
 ./perf test 2>&1 | grep FAILED
133: perftool-testsuite_report                                       : FAILED!

Any ideas where to look too narrow down the debuggung are very welcome.

Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

