Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD61E1C22;
	Thu, 30 Jan 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252055; cv=none; b=Xsn5HZ7SA4Prnqwy15Ld1HxIPSIoIJT+9ZU0n2Z3mW3B08VN/9GuMmo9iCKtnLLvcD1Yg+CR0UiyasmbWaw4OgbMm2vqFnqn84uGnP+mRwl+uve7op5cCrPfWE3uSc+2ELtyvxR9UbGGuW0f30JjX24BWecvfs5LvBLSoG2eWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252055; c=relaxed/simple;
	bh=01XrsdRjYQUuzCV/8wdpwj2XzP4Wh4EpvEWE2NQy0f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alcpzcTDCkgwPXXjEgej7xMGEo+AonwzfhqWRNMCF4wttvCKXDM0aPs3wAhJAdba4LfbT5NiRi6Z/OT7hWr4JNDgYNDSvzEhNgJDUdILUVlK02G1nGn+OTWL4wlpiCB0b8UrBMrVMkEsg13VqNNLIdytETf7nxS+RXOAxJS+hrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=najRa96U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="najRa96U"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDM7FJ029090;
	Thu, 30 Jan 2025 15:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5yPzKn
	HlC5hmM8wTxP5pPtfQVF3ni708QzQ5fobgJ6E=; b=najRa96UzVbBilid3CsBHt
	QazQVQbeI5BOuiVuOdIoC9u+XxvP8soFoiWL2Qnrly3fznsNKAjOGDN0X2wefX0H
	xtTpKCFZHVBh2MtES8Fll15cfyhvyXEYwTBP+MB6iabLCpqBkndct5Z8jP/drybF
	p6NBtAJWw+i/lxRkOcgS6rfhPATzg/hx2FO7CNhpOtWV2ycznq4rDzM3olE21vEN
	D57RgH8EcBBwMlC9kOrMkiGek6wIfLuf6cJgxjmHdgnvU8nTF7BYNcaLcStok/YK
	6/hY0lSpsooXL526LYatMrvZMPzOiiyinO1r1SkgIJBJuLcSm7UaLlZCxR+haBpw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9bn7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 15:47:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50UFh59W023787;
	Thu, 30 Jan 2025 15:47:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9bn7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 15:47:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCNZ8E019368;
	Thu, 30 Jan 2025 15:47:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9n6rtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 15:47:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UFl1Ml20578590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 15:47:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3012320063;
	Thu, 30 Jan 2025 15:47:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD2332004E;
	Thu, 30 Jan 2025 15:47:00 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 15:47:00 +0000 (GMT)
Message-ID: <b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com>
Date: Thu, 30 Jan 2025 16:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 33ZbN1Z8UbxAnSiJj-nHHtlrR_ATxvRs
X-Proofpoint-GUID: cuqClh0N30bGX-bPNVFxrv8rzrZyY5n6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_07,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300117

On 22.01.2025 03:31, Josh Poimboeuf wrote:
> In preparation for using sframe to unwind user space stacks, add an
> sframe_find() interface for finding the sframe information associated
> with a given text address.
> 
> For performance, use user_read_access_begin() and the corresponding
> unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
> regions would break noinstr validation, so there aren't any debug
> messages yet.  That will be added in a subsequent commit.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

> +struct sframe_fre {
> +	unsigned int	size;
> +	s32		ip_off;

The IP offset (from function start) in the SFrame V2 FDE is unsigned:

u32 ip_off;

> +	s32		cfa_off;
> +	s32		ra_off;
> +	s32		fp_off;
> +	u8		info;
> +};

...

> +#define __UNSAFE_GET_USER_INC(to, from, type, label)			\
> +({									\
> +	type __to;							\
> +	unsafe_get_user(__to, (type __user *)from, label);		\
> +	from += sizeof(__to);						\
> +	to = (typeof(to))__to;							\
> +})
> +
> +#define UNSAFE_GET_USER_INC(to, from, size, label)			\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__UNSAFE_GET_USER_INC(to, from, u8, label);		\
> +		break;							\
> +	case 2:								\
> +		__UNSAFE_GET_USER_INC(to, from, u16, label);		\
> +		break;							\
> +	case 4:								\
> +		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
> +		break;							\
> +	default:							\
> +		return -EFAULT;						\
> +	}								\
> +})

This does not work for the signed SFrame fields, such as the FRE CFA,
RA, and FP offsets, as it does not perform the required sign extension.
One option would be to rename to UNSAFE_GET_USER_UNSIGNED_INC() and
re-introduce UNSAFE_GET_USER_SIGNED_INC() using s8, s16, and s32.

> +static __always_inline int __read_fre(struct sframe_section *sec,
> +				      struct sframe_fde *fde,
> +				      unsigned long fre_addr,
> +				      struct sframe_fre *fre)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> +	unsigned char offset_count, offset_size;
> +	s32 ip_off, cfa_off, ra_off, fp_off;

The IP offset (from function start) in the SFrame V2 FRE is unsigned:

u32 ip_off;
s32 cfa_off, ra_off, fp_off;

> +	unsigned long cur = fre_addr;
> +	unsigned char addr_size;
> +	u8 info;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EFAULT;
> +
> +	if (fre_addr + addr_size + 1 > sec->fres_end)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);

Ok: The SFrame V2 FRE IP offset is unsigned u8, u16, or u32.

> +	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(info, cur, 1, Efault);

Ok: The SFrame V2 FRE info word is one byte of data.

> +	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
> +	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
> +	if (!offset_count || !offset_size)
> +		return -EFAULT;
> +
> +	if (cur + (offset_count * offset_size) > sec->fres_end)
> +		return -EFAULT;
> +
> +	fre->size = addr_size + 1 + (offset_count * offset_size);
> +
> +	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);

Issue: The SFrame V2 FRE CFA offset is signed s8, s16, or s32.  Sign
extension required when storing in s32.

> +	offset_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {
> +		if (!offset_count--)
> +			return -EFAULT;
> +
> +		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);

Issue: The SFrame V2 FRE RA offset is signed s8, s16, or s32.  Sign
extension required when storing in s32.

> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && offset_count) {
> +		offset_count--;
> +		UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);

Issue: The SFrame V2 FRE FP offset is signed s8, s16, or s32.  Sign
extension required when storing in s32.

> +	}
> +
> +	if (offset_count)
> +		return -EFAULT;
> +
> +	fre->ip_off		= ip_off;
> +	fre->cfa_off		= cfa_off;
> +	fre->ra_off		= ra_off;
> +	fre->fp_off		= fp_off;
> +	fre->info		= info;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}
> +
> +static __always_inline int __find_fre(struct sframe_section *sec,
> +				      struct sframe_fde *fde, unsigned long ip,
> +				      struct unwind_user_frame *frame)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	struct sframe_fre *fre, *prev_fre = NULL;
> +	struct sframe_fre fres[2];
> +	unsigned long fre_addr;
> +	bool which = false;
> +	unsigned int i;
> +	s32 ip_off;
> +
> +	ip_off = (s32)(ip - sec->sframe_start) - fde->start_addr;

The IP offset (from function start) in the SFrame V2 FRE is unsigned.
The function start address offset (from .sframe section begin) is signed.
Therefore:

u32 ip_off;

ip_off = ip - (sec->sframe_start + fde->start_addr);

> +
> +	if (fde_type == SFRAME_FDE_TYPE_PCMASK)
> +		ip_off %= fde->rep_size;

Following is a patch with the suggested changes, that were required to
make unwinding of user space using SFrame work on s390:

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index bba14c5fe0f5..ea2d491ea68f 100644
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
@@ -136,7 +136,26 @@ static __always_inline int __find_fde(struct sframe_section *sec,
  	to = (typeof(to))__to;							\
  })
  
-#define UNSAFE_GET_USER_INC(to, from, size, label)			\
+#define UNSAFE_GET_USER_SIGNED_INC(to, from, size, label)		\
+({									\
+	switch (size) {							\
+	case 1:								\
+		__UNSAFE_GET_USER_INC(to, from, s8, label);		\
+		break;							\
+	case 2:								\
+		__UNSAFE_GET_USER_INC(to, from, s16, label);		\
+		break;							\
+	case 4:								\
+		__UNSAFE_GET_USER_INC(to, from, s32, label);		\
+		break;							\
+	default:							\
+		dbg_sec_uaccess("%d: bad UNSAFE_GET_USER_SIGNED__INC size %u\n",\
+				__LINE__, size);			\
+		return -EFAULT;						\
+	}								\
+})
+
+#define UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label)		\
  ({									\
  	switch (size) {							\
  	case 1:								\
@@ -149,7 +168,7 @@ static __always_inline int __find_fde(struct sframe_section *sec,
  		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
  		break;							\
  	default:							\
-		dbg_sec_uaccess("%d: bad UNSAFE_GET_USER_INC size %u\n",\
+		dbg_sec_uaccess("%d: bad UNSAFE_GET_USER_UNSIGNED_INC size %u\n",\
  				__LINE__, size);			\
  		return -EFAULT;						\
  	}								\
@@ -163,7 +182,8 @@ static __always_inline int __read_fre(struct sframe_section *sec,
  	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
  	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
  	unsigned char offset_count, offset_size;
-	s32 ip_off, cfa_off, ra_off, fp_off;
+	u32 ip_off;
+	s32 cfa_off, ra_off, fp_off;
  	unsigned long cur = fre_addr;
  	unsigned char addr_size;
  	u8 info;
@@ -179,14 +199,14 @@ static __always_inline int __read_fre(struct sframe_section *sec,
  		return -EFAULT;
  	}
  
-	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
+	UNSAFE_GET_USER_UNSIGNED_INC(ip_off, cur, addr_size, Efault);
  	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size) {
  		dbg_sec_uaccess("fre starts past end of function: ip_off=0x%x, func_size=0x%x\n",
  				ip_off, fde->func_size);
  		return -EFAULT;
  	}
  
-	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
+	UNSAFE_GET_USER_UNSIGNED_INC(info, cur, 1, Efault);
  	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
  	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
  	if (!offset_count || !offset_size) {
@@ -200,7 +220,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
  
  	fre->size = addr_size + 1 + (offset_count * offset_size);
  
-	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
+	UNSAFE_GET_USER_SIGNED_INC(cfa_off, cur, offset_size, Efault);
  	offset_count--;
  
  	ra_off = sec->ra_off;
@@ -210,13 +230,13 @@ static __always_inline int __read_fre(struct sframe_section *sec,
  			return -EFAULT;
  		}
  
-		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
+		UNSAFE_GET_USER_SIGNED_INC(ra_off, cur, offset_size, Efault);
  	}
  
  	fp_off = sec->fp_off;
  	if (!fp_off && offset_count) {
  		offset_count--;
-		UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);
+		UNSAFE_GET_USER_SIGNED_INC(fp_off, cur, offset_size, Efault);
  	}
  
  	if (offset_count) {
@@ -247,9 +267,9 @@ static __always_inline int __find_fre(struct sframe_section *sec,
  	unsigned long fre_addr;
  	bool which = false;
  	unsigned int i;
-	s32 ip_off;
+	u32 ip_off;
  
-	ip_off = (s32)(ip - sec->sframe_start) - fde->start_addr;
+	ip_off = ip - (sec->sframe_start + fde->start_addr);
  
  	if (fde_type == SFRAME_FDE_TYPE_PCMASK)
  		ip_off %= fde->rep_size;

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

