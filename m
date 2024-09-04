Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF8140E29
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476797; cv=none; b=dyCQvyVnXM5O+BWdZ+grzEaYP2vaOxQINtBgTVPfg9Vqe7f6ZsyjGSR/mU0NdEXthVWs2WigvIPIwlSYIarplhidemCtNFdIqpEgvCxFaxRRtNdoM8yatNTt4M9Bh1E1xN8rvmH6f8E4W8VvbtbbGOsFlKvOiBMJInY8Dd0mfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476797; c=relaxed/simple;
	bh=MXbpB/TaDSNknfOAx3pfF5HCCcoMyi3REZOuGrc6g5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nPVthIF89/XlsI8gj7PFWIxCut0HRCRa+KFltYvPCwiZe8Es96lgpXvD4ZrGVydN+b89HaTOGm7vmqJ+4srksE6mrutuz7mREkMueVolWHpJgLFRXi3jwd8WneESbzJVddf6UuuAPnU+xYaRY7OAmnZAwv2PXBiikf/1yqhrQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gKWCtJiC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gKWCtJiC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484CH4Gh004097;
	Wed, 4 Sep 2024 19:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	8mibvGy4zs6+BL3ppJr4WRQGF8TjZoxm1Iv2KuYONmQ=; b=gKWCtJiCGL1u42Sy
	qoted5tMNy6pV6b/X1KYg0AzCqT2wmTPvYC7esGpGloK6wCh7ryopzTlJ2PKNnkW
	A+H3n5gyaMMxm1wVEAf9hyqm5jN7lM2mWvomdfKmHxnnEHXvkq2zhsQBXlInFVpx
	+WrxVC3xcJuZllSNLfGfiNbSHESTxY5Tda20i7/BMyBIgy27m0SIQXQzA1TU+Ey3
	4fUO3hlVtVR5AjvZUR6M3AQRU3wH+u99xYRBvdVuwczrJ7Iess4P3hVqiTA4gAEa
	LTLOoiGUHdgaQV/y4xamWuFYd2c997eG7CW5VJLCI2V8zp/V0U9W7EOdK9E+zH5g
	T/9nrQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqw7ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:06:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 484J6WST008070;
	Wed, 4 Sep 2024 19:06:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqw7kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:06:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 484GgMW2018437;
	Wed, 4 Sep 2024 19:06:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw19aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:06:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484J6RWb42795286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 19:06:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA01020040;
	Wed,  4 Sep 2024 19:06:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B5720043;
	Wed,  4 Sep 2024 19:06:22 +0000 (GMT)
Received: from [9.39.16.11] (unknown [9.39.16.11])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 19:06:22 +0000 (GMT)
Message-ID: <b48b172e-d465-4dc5-abd6-7da7a47e5c9c@linux.ibm.com>
Date: Thu, 5 Sep 2024 00:36:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/7] perf version: Update --build-options to use
 'supported_features' array
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240904061836.55873-1-adityag@linux.ibm.com>
 <20240904061836.55873-4-adityag@linux.ibm.com> <ZthbFDYPX3Opb8Ij@x1>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ZthbFDYPX3Opb8Ij@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z54yGWFjic3GZoCxYZxqIBc82xI6Q8Gh
X-Proofpoint-ORIG-GUID: p_l9eyuf2sa3oaByA4b3UNMR5Ch7V7Pl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_17,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040144

Hi Arnaldo,

On 04/09/24 18:35, Arnaldo Carvalho de Melo wrote:

> On Wed, Sep 04, 2024 at 11:48:32AM +0530, Aditya Gupta wrote:
>> Now that the feature list has been duplicated in a global
>> 'supported_features' array, use that array instead of manually checking
>> status of built-in features.
>>
>> This helps in being consistent with commands such as 'perf check feature',
>> so commands can use the same array, and any new feature can be added at
>> one place, in the 'supported_features' array
> So I tested and applied the first two patches, but it is failing for
> this 3rd, please rebase from what is in the tmp.perf-tools-next branch
> at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

Thank you !

I have rebased the patches in v15.

Patch #1 & #2, are same as already applied in tmp.perf-tools-next 
branch, so they can be ignored or even if applied git am should ignore them.

- Aditya Gupta
> - Arnaldo
>   
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: Kajol Jain <kjain@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   tools/perf/builtin-version.c | 43 +++++++-----------------------------
>>   1 file changed, 8 insertions(+), 35 deletions(-)
>>
>> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
>> index 398aa53e9e2e..e149d96c6dc5 100644
>> --- a/tools/perf/builtin-version.c
>> +++ b/tools/perf/builtin-version.c
>> @@ -46,45 +46,18 @@ static void status_print(const char *name, const char *macro,
>>   	printf("  # %s\n", macro);
>>   }
>>   
>> -#define STATUS(__d, __m)				\
>> -do {							\
>> -	if (IS_BUILTIN(__d))				\
>> -		status_print(#__m, #__d, "on");		\
>> -	else						\
>> -		status_print(#__m, #__d, "OFF");	\
>> +#define STATUS(feature)                                   \
>> +do {                                                      \
>> +	if (feature.is_builtin)                               \
>> +		status_print(feature.name, feature.macro, "on");  \
>> +	else                                                  \
>> +		status_print(feature.name, feature.macro, "OFF"); \
>>   } while (0)
>>   
>>   static void library_status(void)
>>   {
>> -	STATUS(HAVE_DWARF_SUPPORT, dwarf);
>> -	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
>> -#ifndef HAVE_SYSCALL_TABLE_SUPPORT
>> -	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
>> -#endif
>> -	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
>> -	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
>> -	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
>> -	STATUS(HAVE_LIBELF_SUPPORT, libelf);
>> -	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>> -	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>> -	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
>> -	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
>> -	STATUS(HAVE_SLANG_SUPPORT, libslang);
>> -	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
>> -	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
>> -	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
>> -	STATUS(HAVE_LIBCAPSTONE_SUPPORT, libcapstone);
>> -	STATUS(HAVE_ZLIB_SUPPORT, zlib);
>> -	STATUS(HAVE_LZMA_SUPPORT, lzma);
>> -	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
>> -	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
>> -	STATUS(HAVE_AIO_SUPPORT, aio);
>> -	STATUS(HAVE_ZSTD_SUPPORT, zstd);
>> -	STATUS(HAVE_LIBPFM, libpfm4);
>> -	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
>> -	STATUS(HAVE_BPF_SKEL, bpf_skeletons);
>> -	STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
>> -	STATUS(HAVE_CSTRACE_SUPPORT, libopencsd);
>> +	for (int i = 0; supported_features[i].name; ++i)
>> +		STATUS(supported_features[i]);
>>   }
>>   
>>   int cmd_version(int argc, const char **argv)
>> -- 
>> 2.46.0
