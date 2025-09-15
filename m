Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFA2D4B61
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920970; cv=none; b=f0q42cKiRTFzYhtJZGMo3AaYSTjEX+swuipCCndFivjEHSp3bKkmhNQbGueFfEvuGfEOXj+nJ0YbNVa6P6eigEX3To0jwAbSnawaB9/NY76Gw4bMPQ2sEZEGDjFm8Ln5hwhOyTvLXplOFosDCvokLpacDX0RAiHQMvJb7dYY33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920970; c=relaxed/simple;
	bh=xymslS9U6SAjKwp4hlRNheL/s1juVadhJUzY7aGNsDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrZY848EpB2tuZBVRW1/GmqBB6W+36hWGs3hOoxCAmxUT1630sp2EPpnDMyjd2hiDtrErqlMbPP97acnY9XDIVUNKQzoVrYVK2UIpBN2OrHE1BYPvayKnzIe9VYbwDVvitcfcysZ3kJBj+gMEG6Wq8oc3Nr8bS0No25ecx33/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NjhTJfNQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NjhTJfNQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ENcfMn026006;
	Mon, 15 Sep 2025 07:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QQN1R0R7rZbykxGAV3xdVmLnQksNaxklig0rYH4sj
	gc=; b=NjhTJfNQsQC2UfWTQdPQ3mnE+ieqf/nk6fCuwfEEbG7zadktlo7ZykSYr
	Y6Wi+/r3bE45JZUq34PKO4XdTTRaVU1gjTFLScbQVRXI+Fo/s2cNX3qGANIvNIVD
	umd7ld0sidCpqCF2e34E3aWgU8cA49Wtxbz/ex08Cx7LFM52FzyHsepENx4h+QwN
	1Ifa0G8MXeaxHgIP6DYFaQnxx18VahKH10RW9hj50fxxN0ETRvA6RlmvbOeJsCD5
	t4dR7BcIDCJnKZvkXgXqokjAz1lt31BU7zqWC9BK045mSSQ5uKO+cvObCXwyWL67
	Z0YsmgVQ7vsXc6O7RMZhVo7IOaZmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504b12dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 07:22:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58F78c7V001197;
	Mon, 15 Sep 2025 07:22:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504b12db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 07:22:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6nJTJ005940;
	Mon, 15 Sep 2025 07:22:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxtwce7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 07:22:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58F7MbrP15728910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 07:22:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B37220040;
	Mon, 15 Sep 2025 07:22:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A643520043;
	Mon, 15 Sep 2025 07:22:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.244.131])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 07:22:30 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, aboorvad@linux.ibm.com,
        sshegde@linux.ibm.com, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
        venkat88@linux.ibm.com, Tejas.Manhas1@ibm.com
Subject: [PATCH V2 0/7] Add interface to expose vpa dtl counters via
Date: Mon, 15 Sep 2025 12:52:17 +0530
Message-Id: <20250915072224.98958-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX6jfTPjEX164H
 HSYRuuRdwoNSanyp3V16AVEjB/YhE4OVcHpdBcZ2WzRZtEFD7paPhofVLI+1V3WdQ3EtS3eQKnh
 3gA3YdMxtVxQ7KtlslrscqA6ZH9j3hTK4Wis/6KCGlsO5vnGdNbrNW1EsClyvU+WHY0zU+hH5Xg
 njGXesQSvaV1sZmhpQcpMFtXfnxkYGhr0H6FxTevsqx8UXLQ4E6BjxvSimF0QTqRM3+anIHj8JR
 H3YBqJfP3WFZMcWaJJg1ZF6nWttoM5K7NSFuVOog91GwzCjKjXaBuvAtBvvmt/o2ak4Av6S9Oc4
 ilpwHXhuqd3dcQD/sE3QvV9zoVhfRBFqwWMw4vJx9SeR/CJ7fhMRCcdsJV8quCreF0NOyoOO0Gd
 eWM+9XZU
X-Proofpoint-ORIG-GUID: QVT4Pias0bWszpjmRUni_8ee5QwQHNN6
X-Authority-Analysis: v=2.4 cv=dt/bC0g4 c=1 sm=1 tr=0 ts=68c7bec2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=sGukl9S6aO4tzaH1yDAA:9
X-Proofpoint-GUID: TUloGCkoenHPoW4DN9ilTUuLiSaZ5Km_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020

The pseries Shared Processor Logical Partition(SPLPAR) machines can
retrieve a log of dispatch and preempt events from the hypervisor
using data from Disptach Trace Log(DTL) buffer. With this information,
user can retrieve when and why each dispatch & preempt has occurred.
The vpa-dtl PMU exposes the Virtual Processor Area(VPA) DTL counters
via perf.

- Patches 1 to 6 has powerpc PMU driver code changes to capture DTL
  trace in perf.data. And patch 7 has documentation update.

Infrastructure used
===================

The VPA DTL PMU counters do not interrupt on overflow or generate any
PMI interrupts. Therefore, hrtimer is used to poll the DTL data. The timer
nterval can be provided by user via sample_period field in nano seconds.
vpa dtl pmu has one hrtimer added per vpa-dtl pmu thread. DTL (Dispatch
Trace Log) contains information about dispatch/preempt, enqueue time etc.
We directly copy the DTL buffer data as part of auxiliary buffer and it
will be processed later. This will avoid time taken to create samples
in the kernel space. The PMU driver collecting Dispatch Trace Log (DTL)
entries makes use of AUX support in perf infrastructure. On the tools side,
this data is made available as PERF_RECORD_AUXTRACE records.

To corelate each DTL entry with other events across CPU's, an auxtrace_queue
is created for each CPU. Each auxtrace queue has a array/list of auxtrace buffers.
All auxtrace queues is maintained in auxtrace heap. The queues are sorted
based on timestamp. When the different PERF_RECORD_XX records are processed,
compare the timestamp of perf record with timestamp of top element in the
auxtrace heap so that DTL events can be co-related with other events
Process the auxtrace queue if the timestamp of element from heap is
lower than timestamp from entry in perf record. Sometimes it could happen that
one buffer is only partially processed. if the timestamp of occurrence of
another event is more than currently processed element in the queue, it will
move on to next perf record. So keep track of position of buffer to continue
processing next time. Update the timestamp of the auxtrace heap with the timestamp
of last processed entry from the auxtrace buffer.

This infrastructure ensures dispatch trace log entries can be corelated
and presented along with other events like sched.

With the kernel changes;

  # ls /sys/devices/vpa_dtl/
  events  format  perf_event_mux_interval_ms  power  subsystem  type  uevent

Thanks
Athira

Aboorva Devarajan (1):
  powerpc/time: Expose boot_tb via accessor

Athira Rajeev (4):
  powerpc/perf/vpa-dtl: Add support to setup and free aux buffer for
    capturing DTL data
  powerpc/perf/vpa-dtl: Add support to capture DTL data in aux buffer
  powerpc/perf/vpa-dtl: Handle the writing of perf record when aux wake
    up is needed
  powerpc/perf/vpa-dtl: Add documentation for VPA dispatch trace log PMU

Kajol Jain (2):
  powerpc/vpa_dtl: Add interface to expose vpa dtl counters via perf
  docs: ABI: sysfs-bus-event_source-devices-vpa-dtl: Document sysfs
    event format entries for vpa_dtl pmu

 .../sysfs-bus-event_source-devices-vpa-dtl    |  25 +
 Documentation/arch/powerpc/index.rst          |   1 +
 Documentation/arch/powerpc/vpa-dtl.rst        | 155 +++++
 arch/powerpc/include/asm/time.h               |   4 +
 arch/powerpc/kernel/time.c                    |   8 +-
 arch/powerpc/perf/Makefile                    |   2 +-
 arch/powerpc/perf/vpa-dtl.c                   | 596 ++++++++++++++++++
 7 files changed, 789 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl
 create mode 100644 Documentation/arch/powerpc/vpa-dtl.rst
 create mode 100644 arch/powerpc/perf/vpa-dtl.c

-- 
2.47.1

