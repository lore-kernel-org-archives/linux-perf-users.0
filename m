Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA820ADF2
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Dec 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151188; cv=none; b=MPsLqjgeWRumSfjMsj+HXAApikWpq1tq7fxBbKW1/rdYF9WSXs7hjVpikezaeQ2T6hOpi3T3Pw99wT87roFkW6uNnyT9t+0h9QaVWPeg7Qn2iUMUdZAsR1PW0+SoGunHg8Q6lrcDpTrCYcTW9YfUZYVeWyhsYxWmun9CdR5vvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151188; c=relaxed/simple;
	bh=l8baT6gBe3yJL4poZwdSYUopXvvvQkYrUf0NJKRGDNQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eSZU2Pc6F1bOlKDlVn+0ZFFfmANa7scK3M3DqD5s2cER7ld4ZkCPVfEz4ls0AjiqYOJG+CQseWPH3N4QGMPFgjLZvfrTwjeRe4Ez0qV/ZciPrNZidHmAQt3V/xN4cYCS/YWwJHaMwzY/h7x0i5L6jqfN9EzmqBa5M3XOYvyRs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFvFTyaM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFvFTyaM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29xD7K007712
	for <linux-perf-users@vger.kernel.org>; Mon, 2 Dec 2024 14:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6b3cDUCz+cDKHy+5MoMNvYlyXY2S
	+UyqKdqgyGn0dO0=; b=SFvFTyaMz2tG5YNDg3dHuOsC1SjlJ/eywBexbrGDNc3z
	75iVpAVIhndWCBp3NDorgf/ojeKUEKo3lCRpTppcVkb9zvsIdB0wtlbu9mtbm3dY
	3W1wr51MlJItOtC88Wuow6ZlbnigejaHd24FvtR+JoSoBQXbD+Hkqf+MtjNNfpmz
	VVRG+wbp1gk7oyskv1vMHBu9wtITaNDxtlHF9fnYmpMvnI1UTSZejtOHTxWfOMo2
	BZFLI92luUA0vc580MWYAbqc7+84E0GS3bm+7mkPOQkMikXXB84k6UfOX+ZzdXrR
	aM5u5sKWAMxSkhkNUEcgPVzTH6isXgNuHN4VgmmymQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4p9dfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 02 Dec 2024 14:53:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B2EZ6S2022601
	for <linux-perf-users@vger.kernel.org>; Mon, 2 Dec 2024 14:53:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4p9dff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 14:53:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DZChY029469;
	Mon, 2 Dec 2024 14:53:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddy6n0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 14:53:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2Er0KJ32375360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 14:53:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A145420043;
	Mon,  2 Dec 2024 14:53:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69CBA20040;
	Mon,  2 Dec 2024 14:53:00 +0000 (GMT)
Received: from [9.171.14.28] (unknown [9.171.14.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 14:53:00 +0000 (GMT)
Message-ID: <12338ec9-51a0-44ef-b2e6-4a95d3bf0e4d@linux.ibm.com>
Date: Mon, 2 Dec 2024 15:53:00 +0100
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
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Perf test 7 fails on s390 since 6.12.0
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xcte3eGhTSfN_56AYQmbPNuGx86KEJuV
X-Proofpoint-ORIG-GUID: Dp5WNpf9NPMpxnFPYXyevw92SYuLiT3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412020125

I just downloaded the latest kernel tree 6.13.0rc1 and observed several
failures of the perf test suite.

This test case is the first one:
# ./perf test -F 7
Unrecognized literal '#system_tsc_freq'  7: Simple expression parser  : FAILED!
# 

# ./perf test -Fvv 7
--- start ---
Using CPUID IBM,9175,705,ME1,3.8,002f
parsing metric: 1+1
parsing metric: FOO+BAR
lookup(FOO): val 1.000000
lookup(BAR): val 2.000000
...

parsing metric: #num_cpus
literal: #num_cpus = 8.000000
parsing metric: #num_cores
literal: #num_cores = 4.000000
parsing metric: #num_dies
literal: #num_dies = 0.000000
parsing metric: #num_packages
literal: #num_packages = 1.000000
parsing metric: #system_tsc_freq
Unrecognized literal '#system_tsc_freq'literal: #system_tsc_freq = nan
FAILED tests/expr.c:252 #system_tsc_freq == 0
---- end ----
  7: Simple expression parser         : FAILED!
[root@b83lp65 perf]# 

I bisectred this to 

# git bisect good
609aa2667f67c1588d4e741110265f74b7713177 is the first bad commit
commit 609aa2667f67c1588d4e741110265f74b7713177
Author: Ian Rogers <irogers@google.com>
Date:   Tue Oct 1 20:20:12 2024 -0700

    perf tool_pmu: Switch to standard pmu functions and json descriptions
    
    Use the regular PMU approaches with tool json events to reduce the
    amount of special tool_pmu code - tool_pmu__config_terms and
    tool_pmu__for_each_event_cb are removed. Some functions remain, like
    tool_pmu__str_to_event, as conveniences to metricgroups. Add
    tool_pmu__skip_event/tool_pmu__num_skip_events to handle the case that
    tool json events shouldn't appear on certain architectures. This isn't
    done in jevents.py due to complexity in the empty-pmu-events.c and
    when all vendor json is built into the tool.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/r/20241002032016.333748-10-irogers@google.com
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>


Note this test used to work before on s390.
It now also fails on the 6.13.0-rc1.

Any hints on how to fix this? Thanks.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

