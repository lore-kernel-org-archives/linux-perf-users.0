Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7022424C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558976; cv=none; b=ZRJk7EJl3SGxhHlTU2i/DQglBKomEVYmOXYXSg8S9HmbugSvNoTEIMhsVo18EdHns6qutEJXwZgOHX6dJXSqYwTWL6hs8sESYpoEkrkJSBKCWEa8YYDaXNlOpWtvEduha7aQvwWPEQskhAK9cDUDx2vYMlwbYZtrBzR30jGyZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558976; c=relaxed/simple;
	bh=MPlnaurfQxhS586mfirvmSmfM3YXRpqnV61eQq9/skI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mnjpRQxHhUuXrTU+A155dKPh69YE4pQ+gSFo1RxioA8nugp/OxsswYNQC5nPbvtO3qzF9XYtq47XpY96ECxpja3pqIjsANoqqCdSL3PhXP0gNRNNKAT3tlQJztIKH2eyrfrcNr9KfAbeg2U3hUWaqgYgdz6UH87czHhd4mWAyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rv9NCNSq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rv9NCNSq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FMmkIr001027
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 10:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xKXEqGhiQSjbxBa7il1NXU+m/ccA
	4sbg+PcEQxqg/cg=; b=rv9NCNSqkAOtPueKiTjcyuT1dnlvQNVug7F1QW4xTSD2
	x90OwOCgmJIfbmcNh5nWLI5Uz212h7NdE7peRKbnXSFwpAXR3df1w4B7ZJ65FOid
	qG9sa0SwMpgIkNkYI2j5M8BqCbCX5CNV9m8xROYOVsI5tHYIOREUWOSxZuQTDkAD
	09lkc04RXGQUXJEtIO2dEjKDqOdIMjIJLYlbDoDXOJpVvW1E56kRKHogKG2rwkcL
	4g/8yqFVjqXbyiQafB+LzGjgus9r+nfTpk/XAsWvF9j+F15xUKIkxY6QtA4COOzZ
	JRVr2DUDYd+VhM1Ve2KlLAWLk5v+qvyOfALhaTsd4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9bmj77v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 10:22:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60GAAJpA019072
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 10:22:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9bmj77t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 10:22:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60G89VqG025866;
	Fri, 16 Jan 2026 10:22:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kkwhuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 10:22:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60GAMn6b45875630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 10:22:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76F172006E;
	Fri, 16 Jan 2026 10:22:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFF820069;
	Fri, 16 Jan 2026 10:22:49 +0000 (GMT)
Received: from [9.111.56.19] (unknown [9.111.56.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Jan 2026 10:22:49 +0000 (GMT)
Message-ID: <d51ff863-d6d2-4512-9ebb-235bd8cbafd7@linux.ibm.com>
Date: Fri, 16 Jan 2026 11:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test: Exclude disjoint subcmd names dumps core (linux-next repo)
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vc1ucbzB0aSDpu-mVKNUrjvwLXQk82DH
X-Proofpoint-ORIG-GUID: 9ROw7-wQBBbWYbT_Zyz_qemxHUwsjZcg
X-Authority-Analysis: v=2.4 cv=TrvrRTXh c=1 sm=1 tr=0 ts=696a117d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Lh2iM_emvY-ES8JQXb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA3NiBTYWx0ZWRfX0ojeuwN3et+4
 8GrR8bNScnRY+tpZc4PVbhpMdNB5bRD8gJGYfol3GimHFAGo/1G5xvG7zaYHVh8qpmxHS25SB3h
 p0DJuZItIC7ZdxbC/6ZmrqJrqBIi07VB6+uiKlk4D2EUwvKNbgbMdFs9fXnEQznUIOfICcxHQpf
 jsSlpScpfd3+6d9AI2Q55OTRdJGjKSnr5quv4TbI27f9qmuVTSgNQIV4LFqWEXSj5/CVH7eqQCh
 m7etWtpdzv7h0y5goEYMW180YzaQ5CTQqP+Zd5IDrGC1sggXC2JRFnbDn8te7UoXO5Fdve7Zo2v
 Ldu5QwKvKrRn0v13Z+S71skeQdk+htwvgv++2ot4C5ya3vX4xpbyO8ERAdMun3TdRWiZuf2eSe/
 kBn0qoOqnv5c3cIXtteXQT+90TH0pbUUfHjepS5uGLDAKjAcyqdViIheNfxLlNc1wfVGwzG/wO1
 sCXPFNYKkBPFUrVK6BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160076

Hi Ian, 
                                                                              
Commit ef92c4351ec7 ("perf test subcmd help: Add exclude disjoint subcmd names")
dumps core on s390. Is this already known?                                    
                                                                              
Here is the output:                                                           
 # ./perf test  68                                                            
 68: libsubcmd help tests               :                                     
 68.1: Load subcmd names                : Ok                                  
 68.2: Uniquify subcmd names            : Ok                                  
 68.3: Exclude duplicate subcmd names   : Ok                                  
 68.4: Exclude disjoint subcmd names    : FAILED!                             
                                                                              
 # ./perf test -Fvvvv 68                                                      
 --- start ---                                                                
 ---- end ----                                                                
 68.1: Load subcmd names                : Ok                                  
 --- start ---                                                                
 ---- end ----                                                                
 68.2: Uniquify subcmd names           : Ok                                   
 --- start ---                                                                
 ---- end ----                                                                
 68.3: Exclude duplicate subcmd names  : Ok                                   
 --- start ---                                                                
perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.   
Aborted                    (core dumped) ./perf test -Fvvvv 68                
                                                                             
Any ideas where to start diging? Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Ehningen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

