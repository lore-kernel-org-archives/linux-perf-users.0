Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA73398A;
	Wed, 28 May 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428065; cv=none; b=py8vQ3GuDj1yfOQCPLGYZLvyQh7bqhSC+2XsKlO8fIBIAqxbGuM0iVMQTxocWFSFIEwaOILnexwoi6kxsl0AYLmffjvPrd8dOTqXTJgxxigSuJfyoIcva4DBC2F+tFzvYe9qKSrWgZL79+D5EQP5yCVQl3m8tQ68Boxse9/ugAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428065; c=relaxed/simple;
	bh=C5cBFqMtxDyHOh5cYqHPUlKRQ4UDdHA8dzrRsVt0heI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilwV5goDQzY/8lpY1Wrd0Y/TVIz/JhnkZ3y3mFHTe4QMJcTVWaiEBW5LgWLpG4Lx6JiGRmKXKUgwUYcXx4e++6asejlpVhOd0n5vr6C8xCoLxMlcIJu05Kc+wfhBXRQASqyS+kW99KB0UwpCmJOD4aG1dUMsb6LSOjRpunjg+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=koHvMo6l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="koHvMo6l"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S8eoLT003540;
	Wed, 28 May 2025 10:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0KymHl1YrZju146WA
	uwWhH5mwRc0fQXuXhbbB8no0nY=; b=koHvMo6l4fEPv/eEwE4dWKQveDzL6tC4F
	vSXNGYQnnfyqgLWzdFp8stGHvWsClmuQelzedmsD2se9fymYlsti/YJm1l2Sg+G7
	ZtIz39s84fRU8kbTQYyOcuMaAGtt6R30jMmArcFV8uqxSO2V9Q+GZ/V6fW9IxnjT
	cbHOnKKhq0WfnEKAXQ7Ayk3aCMi0qtdlFTzUUNGORyRokcHovH6oOdK4zI2vUelf
	49awOA/TQldD813tMnEETWFfMFlTGD93iZsxCI8QGTVjuO73jZMoOu57V2kQdB3d
	CllzG4JZyhJSNGWSmf8hYqvVFwvJ9c+anR6ywOoQFh0XKQZmyWCAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wy690ffu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 10:27:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54SAHLp7005637;
	Wed, 28 May 2025 10:27:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wy690ffn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 10:27:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54S6Hlwi028915;
	Wed, 28 May 2025 10:27:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usepy2k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 10:27:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SAQxmb55443928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 10:26:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B47C20049;
	Wed, 28 May 2025 10:26:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 878D120040;
	Wed, 28 May 2025 10:26:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 May 2025 10:26:58 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: rostedt@goodmis.org
Cc: aahringo@redhat.com, acme@kernel.org, adrian.hunter@intel.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        andrii.nakryiko@gmail.com, beaub@linux.microsoft.com,
        blakejones@google.com, broonie@kernel.org, fweimer@redhat.com,
        indu.bhagat@oracle.com, irogers@google.com, jemarch@gnu.org,
        jolsa@kernel.org, jordalgo@meta.com, jpoimboe@kernel.org,
        jremus@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
        mhiramat@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, sam@gentoo.org, wnliu@google.com, x86@kernel.org,
        hca@linux.ibm.com
Subject: [PATCH] fixup! unwind_user/sframe: Add support for reading .sframe contents
Date: Wed, 28 May 2025 12:26:55 +0200
Message-ID: <20250528102655.1455423-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250424201823.595811743@goodmis.org>
References: <20250424201823.595811743@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UP3dHDfy c=1 sm=1 tr=0 ts=6836e4f8 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=CCpqsmhAAAAA:8 a=u0hKKabxG1pr0n04s-QA:9 a=x3xD2gU-9FUA:10
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: AVHS09y03cNbPT7bymJ0m0UlsulVvs2F
X-Proofpoint-ORIG-GUID: RzZ7FAImJogcA7vgndjTTNRu5cvmUmDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfX0tBCRHsHk3YI d4jmrUFtOj9UGpGNwgVHwiY+i8TcUWvRr+cOEfeQIeW0BHyrS7hGpcfkewI8NJ74hgb57E4aOIk s4k+1I0/4om/rmX9oqITunsyszOz5n19NxFD+OCnDMqzxKowOxLrhzIPX60FNuQH6UK+5Z1pPY2
 8LgRtMnMf2PK0eBkBjUgYPX4qzMsoPjj3PSn21XNdQ3jSSJ4+0HWYUCmAc9cK/F2pJSywILi+HK /bpvZxH0WylO5rzDrAFADD+7YCyAbI+dSOUk3WIDzZPEQzN1cJTCH913I6MpjaH4jipY54T9u8M 1yyw9imN7aAvh53Hlr0cq8RamO6zgZsyGmqiQR8Ts/oH1P9Kbd+KV3vfABAbYFZ7nno8WOtbWzp
 3cO7Zbw7cR6dmi5/NHg609cZfMS0/R8HJfX0pNsENl3UJYEZFRRIo1aQidkgkUIZvlZwOWzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280087

---

Notes (jremus):
    Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/
    
    The struct sframe_fre field ip_off must be u32, as the SFrame FRE start
    address (sfre_start_address) is unsigned 8-bit, 16-bit, or 32-bit:
    https://sourceware.org/binutils/docs/sframe-spec.html#SFrame-Frame-Row-Entries
    
    When searching for a FRE of a FDE for an IP, the IP offset from function
    start address (ip_off = ip - (sec->sframe_start + fde->start_addr)) is
    always positive, as the search for a FDE for the same IP returned a
    FDE with:  sec->sframe_start + fde->start_addr <= ip
    This enables comparison against the unsigned FDE ip_off.
    
    This fixup includes a proposed fix from Josh (with minor modification
    due to duplicate macro names) to correctly perform sign extension when
    reading (un-)signed SFrame FDE/FRE fields:
    https://lore.kernel.org/all/20250207210614.nks6bxad4jhdulwg@jpoimboe/

 kernel/unwind/sframe.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 3f7cc9bc27eb..8804ac59edfa 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -19,7 +19,7 @@
 
 struct sframe_fre {
 	unsigned int	size;
-	s32		ip_off;
+	u32		ip_off;
 	s32		cfa_off;
 	s32		ra_off;
 	s32		fp_off;
@@ -129,33 +129,48 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 	return -EFAULT;
 }
 
-#define __UNSAFE_GET_USER_INC(to, from, type, label)			\
+#define ____UNSAFE_GET_USER_INC(to, from, type, label)			\
 ({									\
 	type __to;							\
 	unsafe_get_user(__to, (type __user *)from, label);		\
 	from += sizeof(__to);						\
-	to = (typeof(to))__to;							\
+	to = __to;							\
 })
 
-#define UNSAFE_GET_USER_INC(to, from, size, label)			\
+#define __UNSAFE_GET_USER_INC(to, from, size, label, u_or_s)		\
 ({									\
 	switch (size) {							\
 	case 1:								\
-		__UNSAFE_GET_USER_INC(to, from, u8, label);		\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##8, label);	\
 		break;							\
 	case 2:								\
-		__UNSAFE_GET_USER_INC(to, from, u16, label);		\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##16, label);	\
 		break;							\
 	case 4:								\
-		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##32, label);	\
 		break;							\
 	default:							\
-		dbg_sec_uaccess("%d: bad UNSAFE_GET_USER_INC size %u\n",\
+		dbg_sec_uaccess("%d: bad unsafe_get_user() size %u\n",	\
 				__LINE__, size);			\
 		return -EFAULT;						\
 	}								\
 })
 
+#define UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label)		\
+	__UNSAFE_GET_USER_INC(to, from, size, label, u)
+
+#define UNSAFE_GET_USER_SIGNED_INC(to, from, size, label)		\
+	__UNSAFE_GET_USER_INC(to, from, size, label, s)
+
+#define UNSAFE_GET_USER_INC(to, from, size, label)				\
+	_Generic(to,								\
+		 u8:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u16:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u32:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 s8:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s16:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s32:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label))
+
 static __always_inline int __read_fre(struct sframe_section *sec,
 				      struct sframe_fde *fde,
 				      unsigned long fre_addr,
@@ -164,7 +179,8 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
 	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
 	unsigned char offset_count, offset_size;
-	s32 ip_off, cfa_off, ra_off, fp_off;
+	u32 ip_off;
+	s32 cfa_off, ra_off, fp_off;
 	unsigned long cur = fre_addr;
 	unsigned char addr_size;
 	u8 info;
@@ -248,9 +264,9 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	unsigned long fre_addr;
 	bool which = false;
 	unsigned int i;
-	s32 ip_off;
+	u32 ip_off;
 
-	ip_off = (s32)(ip - sec->sframe_start) - fde->start_addr;
+	ip_off = ip - (sec->sframe_start + fde->start_addr);
 
 	if (fde_type == SFRAME_FDE_TYPE_PCMASK)
 		ip_off %= fde->rep_size;
-- 
2.45.2

