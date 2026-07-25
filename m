Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66170836
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007063; cv=none; b=KAdOtf6UTEdrIhG4nQoBAn84AntyA/A+KcRggyExloxMiBvFyq3zjvsXuDVuRoeZLZ/YBq6nzZcvQpCDtXTv/GjZKsZPL6byNPDxUpZ7OHxQjJuTM7o2206j2peq447FNbGAAcjtYoqXEGTSSh6OYsm0ekPrnzcVo2qMA3ohzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007063; c=relaxed/simple;
	bh=oGIxb0O73uP/t3ZBG7w/nUc8Yg50lZzXz2RGTlCz7UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUikkSgd1l9W1nbXUWeWOkv/FtVe/fvbSq3GKE8GFx7sLkAs9qRwWl7mgURPZOSvzLTw4nYjIModw5Pt5tZSsvcNcv9rzsU6NbM8Imzd53pz6u0yJgCcIQXwjSSiuRK2855UQrKowrt202ZWVpVXg5nUfbnGDIUZAdH8HIFMEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XHfSiMkv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XHfSiMkv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHI82X1239019;
	Sat, 25 Jul 2026 19:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IszEcNNn2iImfIDoJQ8Y29oClVaqnGIbSfaSZnclB
	Eo=; b=XHfSiMkvgEJS1ppKJdj8nALpR8iUPKvSVnXcmbEocKyRNIcmNP4o/3gw6
	JQoTKvkXPDUJStwN5ASsq7OUv6yOk6J0vKE/Jo0mmjOsv0sKBAnX6XLpN4PJord+
	tx0RsnHutqdyk1mgWnJ8ZOt1iPjds/VtayX/aKhturdQvzUQTKTuYHRhEBsSDeMq
	hcCMSsZBbqEj6zYJRVJhyuSKwlnD4CWUcdmFuVGlF/TB80uVaTJ4lpFVl/l8mOxk
	jL2DD4+UPa+mjanr5VxRIEyxnby2DyaphCAa0nHLs924gz+vrx55+JgwsJ40TKJy
	PjMnLPJEiBNQZ3xef9hYgjlsetMag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwch5bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 19:17:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PJBGiu031851;
	Sat, 25 Jul 2026 19:17:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12jat0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 19:17:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PJHRiB9175524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 19:17:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9258920089;
	Sat, 25 Jul 2026 18:50:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C632E20082;
	Sat, 25 Jul 2026 18:49:55 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:49:55 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 0/5] perf trace-event: Fix overflow, loop and cleanup bugs
Date: Sun, 26 Jul 2026 00:19:48 +0530
Message-ID: <20260725184953.234759-1-tshah@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: oLeemL2Y3ot1Bh1Ep0gqxvF5whnFCsAt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE4MyBTYWx0ZWRfX+Qjj64xQ8Tib
 KdTByt/zv5fdlE9W2mdrdhyL4WMJTebUZ6aIJZ6bOLPFsv6k2M97/ngI/+mTHGsD2uchhqwM/iF
 xtJUyDu0Z/Ukve8pIJjfYvepvJoT8vY=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a650bcc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6RsbtAvGglQN-_1x-NkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE4MyBTYWx0ZWRfX9W+hsVLL0J0y
 yN68NYPYMG9Hgnjmb1vzxKpvz/77vsRfE902kaVkMUEeH5U6oYkRx1ovsolybDue82XApuAnkR0
 AfpCtfxgVNY5sffu/HUL3FbYbSdOU4WyhyZWOoKChpFiT1qICYhQaz0d2OTVvt4fX44VRHRpgIR
 8jiKY/4l977i1f6Uj01+tW0uOy3rRNbILpiuwjn7I4F9pBm0iSk94BA7gwQPzFCKVp6qkDXF+cc
 pydZejL77d9t/IwMMETXV3a9CQghmmhisoo0Gnr64H4ZnJKlscTwsYdFa5IP7j7AHREC0dVpvFc
 riy4NOIYLcunmM8Y0yHLoXFWgb95Vp+7D8ySJfjPZzpv+cAKiYjelh6Tbam/9wIn8mc7B9WR7ne
 XblwDyoS9TfqOqtWNiHlWVYheEEUqYi2P7ovQrHu90A82DJAubxNbjmB8rJeL8UYnwQ+YTtNH1V
 TLavJVnmNxa3HzZAvSw==
X-Proofpoint-GUID: usMoTNEl8O-MEYzYC5SC9TwNZsq369Jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250183

This series fixes five security issues in trace-event-read.c and
trace-event.c:
1. Stack buffer overflow in read_string() when a string exceeds
   BUFSIZ, due to a missing bounds check.
2. Integer truncation when passing 64-bit sizes into do_read() and
   skip(), which use 'int' parameters, causing uninitialized memory
   to be dumped and parsers to read out of bounds.
3. Double free / use-after-free in trace_event__cleanup(): it frees
   t->pevent but never clears the pointer, so calling it twice on
   the same trace_event touches already-freed memory. Also fixes a
   related leak in trace_event__init(), which overwrites
   t->pevent/t->plugin_list without releasing any existing handle
   if called more than once on the same struct.
4. Heap buffer overflow in read_ftrace_printk() and
   read_saved_cmdline(): size + 1 can overflow to 0 in malloc(),
   allocating a tiny buffer while a huge read is still attempted
   into it.
5. Infinite loop in skip(): it does not check do_read()'s return
   value, so a crafted size can spin the loop indefinitely.

Patches 4 and 5 are latent bugs that patch 2's type fix exposes by
removing accidental truncation that had been masking them.

Tanushree Shah (5):
  perf trace-event: Fix buffer overflow in read_string()
  perf trace-event: Fix integer truncation in do_read() and skip()
  perf trace-event: Avoid double free and leak in
    trace_event__cleanup()/trace_event__init()
  perf trace-event: Fix heap overflows in
    read_ftrace_printk()/read_saved_cmdline()
  perf trace-event: Fix infinite loop in skip()

 tools/perf/util/trace-event-read.c | 54 ++++++++++++++++++++----------
 tools/perf/util/trace-event.c      | 11 +++++-
 2 files changed, 47 insertions(+), 18 deletions(-)

---
Changes in v4:
- Fixed a leak in trace_event__init(): repeated calls overwrite
  t->pevent/t->plugin_list without releasing the existing handle.
- Fixed the same size + 1 overflow in read_saved_cmdline() as
  read_ftrace_printk() (size == ULLONG_MAX wraps to 0 in malloc()).
- Added <limits.h> for the UINT_MAX/ULLONG_MAX checks.

Changes in v3:
- Added new patch to fix double free in trace_event__cleanup().
- Added new patch to fix heap buffer overflow in read_ftrace_printk().
- Added new patch to fix infinite loop in skip().

Changes in v2:
- Added new patch to fix integer truncation in do_read() and skip().
- Organized as patch series to separate the two security fixes.

v1: https://lore.kernel.org/linux-perf-users/20260722113552.191143-3-tshah@linux.ibm.com/

-- 
2.47.3

