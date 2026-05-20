Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A12D3EC1;
	Wed, 20 May 2026 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284368; cv=none; b=WMWX5hsMguPq1sdN5nvHo6TKAbouvbedIMkZRStrwDpY0iwJKw5IY2Tq+G0KI66nKHqFIZbjEpJuj+tKQPhz/qzK6+2+bGVtHCoNezvle4fDBHT0Ha1HVWF7Wln6mtfmxh/OB/oP341jJKNgK2MN/yRWUmJKvaX3DrUgLFaKihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284368; c=relaxed/simple;
	bh=TMOgDKly1jM+ugJBxGWHqK2y/guiA6NHbvUw0WTT4rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo3WtsshE7mYGttmu6LC1O5uWY0GQZNliARq5W3l5gS8a20bU73H4wDGE+k+2zyoRQ9E5bKzjvxKuBb3ABQFM0oHHxXzOX5EtpbXPoJ3OdLnJy95+uMn1T7wGRV0LBIdI68FvW1hN24+1h+bKGu4+u0sdu3aXCfQQD34vUjIe9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZNgg3aTU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNgg3aTU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K1WnO44141466;
	Wed, 20 May 2026 13:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+OMfLN
	4veRE/5ClATh/wM/aZ3+JgSp3mZBiomWQVCQc=; b=ZNgg3aTUXKS5K5Jx4KB3hQ
	Ia9HpeCI3kDO12cCc4a8j+RPePaCT4U3XAV8cFhEN0HqP4l5OcvvaKBun0fip8Gv
	rm540GCz3vXFqvc/F8dn0EUPPGzsKOvC832Yp+P2DY6PQ+KSTWnQ4TXxWWcHeqaV
	tyijz4AHSRQfoezYifVFqKeSCj5IEngWomZMjvE2LI0Mysiy7nG/uxVV8E/9Xr3Y
	/LCPmoe61bvOxxWmbZGolk5UNkxMwHHAmCh/I/nmHvH5SHApgjxrCJ4B72zrFKNK
	jHCdJYtqei+KsqgMll++9xEGdiy/rBYtB9qZrEkwxwh4jTOc780J5iUhbEFw0bpw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw99y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 13:38:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KD9AYT026310;
	Wed, 20 May 2026 13:38:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq7rs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 13:38:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KDcntC31850834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 13:38:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFE7C2004D;
	Wed, 20 May 2026 13:38:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3144820040;
	Wed, 20 May 2026 13:38:49 +0000 (GMT)
Received: from [9.111.38.205] (unknown [9.111.38.205])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 13:38:49 +0000 (GMT)
Message-ID: <26791984-36c3-441b-b48a-208c078aaf76@linux.ibm.com>
Date: Wed, 20 May 2026 15:38:48 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
To: Jan Polensky <japo@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520125637.105681-1-japo@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260520125637.105681-1-japo@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMiBTYWx0ZWRfX/prrJWRUhwzZ
 u6izwPjtBeiiF5OfgmCoQvPXmI3Qv7VsfTXNTIj5WjVHKlalPSK2xjbrsH5Zcv5NndxSLw2Npne
 uD/QraEl3Fh30cfNmSUU7G29NItwpXqG7ielpkiBV57yY4OuFaOmZbVzV+/pPCYswJmnTVL4JKM
 uN3AJzMMraoFwT8OHpNrTvxcmxgy1UWT7VDWIfScyyCDibRIusynZH6dAqmR3J00EFNXGZE1ime
 q70wMKkkYcsjL9KBKnpsQeESKsrqRQTPiv7VimbwASSfjbCH7ZA51rFjfbuvyWJ8Sn/OApGSAYa
 pFhi9Bfr/5BvCej+r4TwKpUi3qq+NYKa2lUaL5tt7kx0fHzVjkTiPgfWwxt1Vor98W8VjxpSQ+c
 /bFiaPEqFwhPxwrRereAgx7xh7eToGP7d+IH8UJ1r80pEY6eAu9//M4ieBjD9RGPiLBfww2urEH
 xXVARBGvrXK90caCVag==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0db96c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=A_xE9neWC7oelr5L_vQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 64YMTORJCq5Xj-yU4XQMdNeEcoyik3Ag
X-Proofpoint-GUID: 5h3xx0850QwFIP6oDg3g4daDH58HWfCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200132

On 5/20/26 14:56, Jan Polensky wrote:
> The Python extension build fails with modern GCC versions (16+) due to
> the new hardening feature that prevents dynamic relocations in read-only
> segments:
> 
>   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>   collect2: error: ld returned 1 exit status
> 
> This occurs when building the perf Python bindings because the linker
> enforces stricter security policies by default.
> 
> Add -Wl,-z,notext to LDSHARED to explicitly allow text relocations in
> the Python extension shared object. This is necessary for the Python
> C extension to link successfully while maintaining compatibility with
> the Python build system.
> 
> The flag only affects the Python extension build and does not impact
> the security of the main perf binary or other components.
> 
> Tested on Fedora 44 with GCC 16.1.1 20260501 (Red Hat 16.1.1-1) and
> Python 3.14.4 on s390x architecture.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index bfb37f527241..12af424dd5c1 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
>  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>  
>  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
> -	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> +	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
>          CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  --quiet build_ext; \

Thanks for fixing this.

Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
