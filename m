Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCB139B;
	Thu, 30 Jan 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253883; cv=none; b=ZbQUppxqwEJBrtpAKckao2ARrCK7MJlDzxhIv11GT2v1M8xCOs7MHCY8zogFpzScLw2Z1gKt0mHP4qWfjaaq4MlYvHf5G6awGj9EC0nrohG4vrWVu+eGqCvynijjx5nL8UIIHtSV5jYWuf/5prwc8N6dlkaWyVJn9NumZgAKwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253883; c=relaxed/simple;
	bh=S4S2u3bfSglH+71zm4Wvz5COoS2wmHDDIUDA8s2ggvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5GNUwfvHtXSd3RaEfNIw2pUZLgXXjDD5GrYij5DfvRoTBNmYIcjao/sqknx0edulB0f5X1jcjBW9WKsDcVoIlri7h7mk3eZPclnA3u7M9ZANn7BdcpbsjKuHGdf5vAg11nArvO62Ap3enAfHbuARGiyYh0oP2ewP3YcY6ybq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O1rmSlQf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O1rmSlQf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDoBqW030334;
	Thu, 30 Jan 2025 16:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ONa1jU
	BR1+S0gYygAhKAHl182u525Nr6+dP3anCG3us=; b=O1rmSlQfBhyNmx1ErVkuL9
	LMRIxB//hmxP7LEOQRRwiDUq0JNcEqeYROetLvniZQ2JLgvhuoJVL1uwEUv4doVX
	64gn9GKxooZfE2/3847gLC2vuF2qkuIhYZZbeE1bGe1nWhGKrG6sU79SMNI4b4v/
	TSlB8rGbnZOSBVijT4J++91JT+/Nsa2vCvN4QwyWnnfZRwiGVTI402/msJdIVZ1z
	wI+725ELhgCzlXKIqfFnu5HElSKnpXjvSf6xOxsVR1BSUTRwUE3vbb84gqD1bAbV
	RJpiCXa0epUSmCZQ5CQHskWa8vEsXpkslJEe1VNqWmSXXBuRlze+m+g+K1rBgbJw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9bsuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 16:17:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50UGGJT6015503;
	Thu, 30 Jan 2025 16:17:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fyg9bsu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 16:17:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UFwaRE028072;
	Thu, 30 Jan 2025 16:17:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskpvfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 16:17:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UGHYrH52167156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 16:17:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE69C20040;
	Thu, 30 Jan 2025 16:17:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 521A520063;
	Thu, 30 Jan 2025 16:17:34 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 16:17:34 +0000 (GMT)
Message-ID: <c9ba301e-8451-441d-8212-2913a76ff32d@linux.ibm.com>
Date: Thu, 30 Jan 2025 17:17:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/39] unwind_user/sframe: Show file name in debug
 output
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
 <7bfb7ffad5fe384fe3dbe6c8ca985f35b98b48bb.1737511963.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <7bfb7ffad5fe384fe3dbe6c8ca985f35b98b48bb.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FuReBaQPsBGrG3b7x7hTPr8i33NIuhFq
X-Proofpoint-GUID: wyvY3VdNH6x-f8eeALSpEObel0t6_amh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_07,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300121

On 22.01.2025 03:31, Josh Poimboeuf wrote:
> When debugging sframe issues, the error messages aren't all that helpful
> without knowing what file a corresponding .sframe section belongs to.
> Prefix debug output strings with the file name.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h

> +static inline void dbg_init(struct sframe_section *sec)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +
> +	guard(mmap_read_lock)(mm);
> +	vma = vma_lookup(mm, sec->sframe_start);
> +	if (!vma)
> +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
> +	else if (vma->vm_file)
> +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
> +	else if (!vma->vm_mm)

This condition does not appear to work for vdso on s390.  The following
does:

	else if (in_range(sec->sframe_start, current->mm->context.vdso_base, vdso_text_size()))

> +		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
> +	else
> +		sec->filename = kstrdup("(anonymous)", GFP_KERNEL);
> +}

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

