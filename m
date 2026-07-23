Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3242B303
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799646; cv=none; b=QY2ltr1S394k4Eb9rrBaYqGjSGeN3v4voDHzyaDqqr0N7/xiDDc1MIM6kMMbwrrMly5F5QWA9KoGvOgfOZHal4hw7hqAlmgbTZkXzbp3EZTefE67vv0GnMykN4gf0/Shdk+Vjg/1rJi2wig6kFnDSt8AI7i2Hci5t8WSsetxbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799646; c=relaxed/simple;
	bh=fToQzeiM6R6F5GJfCqNcYbwaHPBUKPPJBZasvZUuc7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6QD75JKmOa0wRa0X8XapGqVMxLSl3VhUWkj1ko4fhaB9vL2uakLOSvjvrMz6plRtEv/absfi2niMhoTGL9Knyl8kDTXJfpJ1qkPF7qL8SbGRNJZ+UHk53uzCt4K3WxYwOplmcNBxABtaJKNOha8QMuvgL3WrPR6hRT+jFE82EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrQR9Ay6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrQR9Ay6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Bni32580353;
	Thu, 23 Jul 2026 09:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7lkWB8TBMN9eGwcnbbQpgmiei9lQBtl0ikXiLoJmO
	Qo=; b=LrQR9Ay6QMLundIzl+FZmUy3LIVJ/6tqtxOYdsIrFwmYAF7iOw09nux3Q
	gt73BVHApkP8ybM19hJUWbMHOw0yILCaWYlkYQSWT2A9wDThLwSwHsNHQTqOZqYi
	QVh5M8RC9/Tko4XqO+nAO6itJf8dOlXZ0wj+LeCFPffe95O52qNggmvIG0w9Sj+Y
	FZyn62VUUyBCMFMtvYhcrrVXZ70Mu7gV+dzJmqbF9VQRgKNiLGt6jNsCl7YzuYsM
	9L7uS2nOyzIeNxsswmKf1PrxxQBpCYNa+jWg128Vht291XPaLx6HzRYQy0eVjLCw
	UPPHXfw3NyLj50pTca/m81DoGL5Gw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abpvcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9YgXG011193;
	Thu, 23 Jul 2026 09:40:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gkb8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:40:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9eJbJ49414438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:40:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9304E200A0;
	Thu, 23 Jul 2026 09:40:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A03432009E;
	Thu, 23 Jul 2026 09:40:12 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bl1-in.ibm.com (unknown [9.123.15.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:40:12 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v2 0/2] perf trace-event: Fix security vulnerabilities in trace-event-read.c
Date: Thu, 23 Jul 2026 15:09:58 +0530
Message-ID: <20260723093958.416650-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfXwpRReBeWeoaJ
 PYTUNBHUslWhVr4yCVvQZJyNVlUkJbly3yP6oXIUHsxRNissgtQytH5ML47MLCyKQsW55WT2lCn
 /fT5cyWWq4ouCxKMxzjzkixDpPJneQibmUmhGxMYTS3FR7F/WjEfo/jZ3reWOuy+wIkSATWZyxQ
 FYafQFX8UslKjJvhHnzhzbCJkSiQyVkIiBLgnCtB63WLV1C/vDozRQpw3KeMwNXHAjVJ4r7HKKI
 rbNSv7V3gQdkj2GDBEtjxUYvDyTJ7UbFuukj7hbhLzL1ra9HzDOxGJitjRA2XNQ2w/Q6rDCxU0K
 lWGPpKmrws57rVKuuzu0DfbTiFlhkFaKJanthhjGCzeLrsArU/5+le0AqlOYzwnjaLFzKjtAnJM
 BlfkEpPF8Rmxp6xXmuA/2i37iYxOEJfJZ4CeiU7RTgJTUpEENm6UV8i/Ce03OzeRsndtg6TAcf3
 IdHTYSxsJ/9NzMgYHAA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a61e188 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xBR__Bw1y1-2kD5fWpIA:9 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: UAXcaDFmLwCt5v9l792Bh0b8xJnb3kKX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX6iqdAxPakLc6
 B0jPM0D5fIiRH0InRkz1Fi2ycrFuzR8JD0LwxcsKmO/LzjFcEuku7c0yCUJGwQ1FafksqjhUzqZ
 HUCdqOnj3D1gJyUoWDyb1pMcGAy+I7Q=
X-Proofpoint-GUID: ckgNF4-jTBkiAQq8xbSAxOlL9epCk36Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230091

This series fixes two security issues in trace-event-read.c:

1. Stack buffer overflow in read_string() when a string exceeds
   BUFSIZ, due to a missing bounds check.

2. Integer truncation when passing 64-bit sizes into functions using
   'int' parameters, causing uninitialized memory to be dumped and
   parsers to read out of bounds.

Both are pre-existing bugs; this series fixes them.

Changes in v2:
- Added new patch to fix integer truncation in do_read() and skip().
- Organized as patch series to separate the two security fixes.

v1: https://lore.kernel.org/linux-perf-users/20260722113552.191143-3-tshah@linux.ibm.com/

Tanushree Shah (2):
  perf trace-event: Fix buffer overflow in read_string()
  perf trace-event: Fix integer truncation in do_read() and skip()

 tools/perf/util/trace-event-read.c | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

-- 
2.47.3

