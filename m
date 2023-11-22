Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VhQjOmFg"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EB197
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 23:38:56 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM71Dnh003003;
	Wed, 22 Nov 2023 07:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=ERicmbOGI3RUqab80z8MALyEkW0R/2MzZIDbXPRE4Zw=;
 b=VhQjOmFgdX7kqpnf6bRwwgokOJF5ftXgptw+/+vpzsO030FtpPnbHlNDfbrgVKwRVmux
 B1Vswn/OiXtOTM06CZ9L8X25g5NdeTQCsZoV0BTGWfuR3dY3e+ilGIoeThadT5OHDvsc
 IcLWBMGEig0ORxEwLcz7gYjpTKqwqT7KcuJXc58MNqh2I4+2WSMnTJF3k3zIizQP6MC5
 X0q5f8ayolIqYEGt4rhZ6BGw96aCPaeyxgAbc7GIsse3Ws9ZmM4LfhOvtqBm6n2pQ8Wf
 +b8iQuS/jhQLHeRKu7pcNyQ+1998LRK63ba/rZp3wDNUzV+ENp8DQVPoAeM3PM+78YvC lA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhchfhr8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 07:38:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7EvmK002680;
	Wed, 22 Nov 2023 07:38:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kx7hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 07:38:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AM7cTkv14418474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 07:38:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077E320043;
	Wed, 22 Nov 2023 07:38:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A9EB20040;
	Wed, 22 Nov 2023 07:38:28 +0000 (GMT)
Received: from [9.171.44.146] (unknown [9.171.44.146])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 07:38:28 +0000 (GMT)
Message-ID: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:38:28 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: REGRESSION linux-next since Nov 16th, perf tool broken (at least on
 s390)
Organization: IBM
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hUmh8eGJsn_AGMJj3kLgA0OgihB9979f
X-Proofpoint-GUID: hUmh8eGJsn_AGMJj3kLgA0OgihB9979f
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220054

perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
any PMU event, as in

  # perf stat -e cycles -- true

   Performance counter stats for 'true':

     <not supported>      cycles                                                               

       0.000598399 seconds time elapsed

       0.000055000 seconds user
       0.000567000 seconds sys

  # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
  event syntax error: 'pai_ext/NNPA_ALL/'
                       \___ Bad event or PMU

  Unable to find PMU or event on a PMU of 'pai_ext'

  Initial error:
  event syntax error: 'pai_ext/NNPA_ALL/'
                       \___ Cannot find PMU `pai_ext'. Missing kernel support?
  #

This error is caused by following commit, which got into linux-next around November 15th:

commit 652ffc2104ec1f69dd4a46313888c33527145ccf
Author: Greg KH <gregkh@linuxfoundation.org>
Date:   Mon Jun 12 15:09:09 2023 +0200

    perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh

This commit adds function pmu_dev_is_visible() as the PMU bus function
to make sysfs attribute files visible.
On a failing system these sysfs attribute files are exported:

#  ll /sys/devices/pai_ext/
drwxr-xr-x. 2 root root    0 Nov 21 14:59 events
drwxr-xr-x. 2 root root    0 Nov 21 14:59 format
lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
-rw-r--r--. 1 root root 4096 Nov 21 14:43 uevent
#

These is no file named 'type'. Other files are also missing.
Therefore the perf tool can not access any PMU event defined by this PMU.

On a system with proper export of all PMU sysfs attributes (same linux-next kernel):
#  ll /sys/devices/pai_crypto/
total 0
drwxr-xr-x. 2 root root    0 Nov 21 14:44 events
drwxr-xr-x. 2 root root    0 Nov 21 14:44 format
-r--r--r--. 1 root root 4096 Nov 21 14:44 nr_addr_filters
-rw-r--r--. 1 root root 4096 Nov 21 14:44 perf_event_mux_interval_ms
lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
-r--r--r--. 1 root root 4096 Nov 21 14:44 type
-rw-r--r--. 1 root root 4096 Nov 21 14:44 uevent
# cat /sys/devices/pai_crypto/type
12
#

Also on such a system the perf stat works again:
# perf stat -e pai_crypto/CRYPTO_ALL/ -C0 -- true

 Performance counter stats for 'CPU(s) 0':

                 0      pai_crypto/CRYPTO_ALL/

       0.000741258 seconds time elapsed

#

On s390 there is no need to export sysfs file 'nr_addr_filters', but setting
this member pmu::nr_addr_filters to a non-zero value before
calling perf_pmu_register() exhibits the old behavior again.

In my opinion this breaks previous behavior.

Is this intended?
How to fix this?

Thanks for your help.



-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
