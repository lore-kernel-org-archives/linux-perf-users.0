Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF341125AB
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:36 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6AE199
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 02:56:34 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9h37N025825
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=HmxmGZ3Hg+4RdfjhaYTObhs1gq2ZKYp8UnX0vEpEvFs=;
 b=WQyWg/Jrmag8Z6Q11MgRzvSyfO/NeAx51qntQy0XrkN4g55TDinKwifmgPL7pXFS9hUz
 gwYCs44YJ3/ijPLo8agoj9QjNY154jp05ucjGOeq0STJvj3QaJoe8YhJClLnY/fI6OEB
 +fTD+mpJSgkYpFswM361mBL6vR+Osw4nY/Z0kKrbbJD3E2RWRCc4kdjHRDpbRmv4IE/e
 TcFKXEP4SRzjoumk2Dk3seJUrPljIhycQnskFRT3cRjU91eXiGvPufRwsWcAhVnd6dwc
 wSZMqNuaM3R9EI0gonFE+AzRv39+Lx4pJoQdoTtT2tblozdCZ1/wpqsmrgag2IGzD2el VQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdv6j89gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9oemY008228
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbnurqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38T9uVZ414549644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4566620049
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24CB520040
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:31 +0000 (GMT)
Received: from [9.171.8.252] (unknown [9.171.8.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:56:31 +0000 (GMT)
Message-ID: <3a212e80-b00b-f44b-3d2c-6e221d8cc1ac@linux.ibm.com>
Date: Fri, 29 Sep 2023 11:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Question to perf record command
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UZFumGCGNmI2PYpQn3YB6GDUhicGHdWn
X-Proofpoint-ORIG-GUID: UZFumGCGNmI2PYpQn3YB6GDUhicGHdWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I have a question regarding command perf record.

Command ./perf record -R -e cycles -vvv -C0 -- true
sets up perf_event_open system call with CPU == 0 and PID == -1.

According to the documentation, this applies to all processes on CPU 0
and not just the process named true.

Is this indended? I thought process true should be traced when running on 
CPU 0. Shouldn't the perf_event_open() system call in called with
CPU set to 0 and PID set to PID of process true?

Tracing output:
# ./perf record -R -e cycles -vvv -C0 -- true
DEBUGINFOD_URLS=
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
perf record opening and mmapping events
Opening: cycles
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|ID|CPU|PERIOD|RAW
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  freq                             1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
....


When command invocation is
# ./perf record -R -e cycles -vvv -- true

the forked process named true (PID 13092) is traced on all CPUs:
[root@a35lp67 perf]# ./perf record -R -e cycles -vvv  -- true
DEBUGINFOD_URLS=
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
perf record opening and mmapping events
Opening: cycles
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CPU|PERIOD|RAW
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 13092  cpu 0  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 13092  cpu 1  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 13092  cpu 2  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 13092  cpu 3  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 13092  cpu 4  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 13092  cpu 5  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 13092  cpu 6  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 13092  cpu 7  group_fd -1  flags 0x8 = 13
mmap size 528384B
....

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
