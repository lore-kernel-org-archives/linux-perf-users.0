Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C71ADC94;
	Fri, 24 Jan 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736571; cv=none; b=rKUDHsf2w2ONbSfmQhMZJlXp326XprOboIrV3psglxTnqHcIOOFPnbCZN/+OzpFggTi32PtBq7LWEKmIhqaGH9pymQ/ZDc6j6866ky+7F82u0SoXdqD1kMK3aXzqPR0Zi+EkrC+yMedT+1Qf1uTLSxSYHMtYIwrrxSuadYm/Vx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736571; c=relaxed/simple;
	bh=tNVLeUM3XTviFOr2YEez6LDY1Fdk/eM7gXLAANlefmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRgEuZ2weuuIaPXY2XU59+oxIlA344yUA3bVFh9cKhxwYJzLj9xYOUolohTJSD1LLMtj8GhK/2ans7Y72mtKmeqxK1v3p0O8tmN5mKHIX90X2tQPN4sLG4pmfSI9nMFVLMCVi0wQdqSbEKVpnykrctOH3Jqevqce+wPY5G4++uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2TQJvLm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2TQJvLm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7X4Dq021407;
	Fri, 24 Jan 2025 16:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SQhOk7
	v8vddWYS4CVstgu6C9iSchJ1oXmu8l3Io2E7I=; b=T2TQJvLmyNcxaPAOalhrI3
	BNdEipq1Gf8qKw7uf/gk9YixD+jlOe0L+QVdujEBrio79KhXYNkG2C27hxgqObHC
	xA9/ryo1msQHtcVC5irGqQqLWTn3peJIKR+Hy1MxxEiaRwZh313Oa3lHXmaHjTMr
	6C1omjHXpqENI1CXDobNzuWFcUQ/QaDFwdoq/jUiwvW5lo2UrOAZ2swmgS2t499a
	fxfXjJlrjzx/Pb5afLmyDEQmUqHGcb2LaFwD1lyV+ySEoPd70g9I+8uBW+A2gqCb
	RshYxCEuUBuob66/F9sfYJKrekOVKQ6n9svuG3CSET2uyvlwjEoEKvOzBE2wzMUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnjd36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:35:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50OGYsTV017048;
	Fri, 24 Jan 2025 16:35:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnjd34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:35:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OClIQS029594;
	Fri, 24 Jan 2025 16:35:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnvakw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:35:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OGZknD60293404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 16:35:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F5C02004E;
	Fri, 24 Jan 2025 16:35:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E0972005A;
	Fri, 24 Jan 2025 16:35:45 +0000 (GMT)
Received: from [9.171.221.90] (unknown [9.171.221.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 16:35:45 +0000 (GMT)
Message-ID: <30483278-c065-4851-b709-8d1dcfa1fe5e@linux.ibm.com>
Date: Fri, 24 Jan 2025 17:35:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
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
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iyKlXvT2vSCU9xjJiMnlbErXOVlxZpyb
X-Proofpoint-ORIG-GUID: NqaWkLXwn9UqEWzDCm9lvAV4uJY1fjZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240116

On 22.01.2025 03:31, Josh Poimboeuf wrote:

> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h

> +#ifdef CONFIG_UNWIND_USER
> +
> +void unwind_task_init(struct task_struct *task);
> +void unwind_task_free(struct task_struct *task);
> +
> +void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
> +int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
> +bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work);
> +
> +static __always_inline void unwind_enter_from_user_mode(void)
> +{
> +	current->unwind_info.cookie = 0;
> +}
> +
> +#else /* !CONFIG_UNWIND_USER */
> +
> +static inline void unwind_task_init(struct task_struct *task) {}
> +static inline void unwind_task_free(struct task_struct *task) {}
> +
> +static inline void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) {}
> +static inline int unwind_deferred_request(struct task_struct *task, struct unwind_work *work, u64 *cookie) { return -ENOSYS; }

static inline int unwind_deferred_request(struct unwind_work *work, u64 *cookie) { return -ENOSYS; }

Otherwise this does not compile on architectures that do not enable
UNWIND_USER.

> +static inline bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work) { return false; }
> +
> +static inline void unwind_enter_from_user_mode(void) {}
> +
> +#endif /* !CONFIG_UNWIND_USER */

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

