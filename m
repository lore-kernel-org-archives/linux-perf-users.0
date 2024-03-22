Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AA3C684
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Mar 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104462; cv=none; b=sSuEABw2UKbzzOIii5DjEYsEesVOKcQmlAf0CVTrooJsLwbir/OgreVqPtwSZq8GL6eGw7a00gCirKfsAmQl9U31Hd1aqMIb6CjOLg+qbSJjpANIRsaZGlyykfnFkbvkoD2jKhN8Y6IGZ/jSYJyQ0A+v5Hc9E1fXs+ymR6fBE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104462; c=relaxed/simple;
	bh=nXaX0i4yt0E4JeoZBEiIVDV2mitoGttqqFOxRA0QiZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=symHOMuc/3d/0rrPWN+gvUKC8vPWqbTmYk/lENHQ1p9kg8bT8Wg6Jo3n2s6iME3iT59xUu+qIUSz0mMqA4+yehj603YZRoKufVKE5tvX0AT6b0U65tWKVBU25ly9K34lcDGNleUyZAz62y/MJUpkDxLyPm7IGsbIhamLu18xp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=blw1l+s9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="blw1l+s9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M8k3FI020593;
	Fri, 22 Mar 2024 10:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U62Ouj8Pb+T+sVrEBtW9rJOmTOyoyk7Vvc7/loTweT8=;
 b=blw1l+s9HpJlSMvVYNDFJvQo48E5IgGnDL3LeVHtxd8x2BABgB+DKpmUETE3Q9RGigw4
 B7BEXbZgZMbsDzWyOhSvLMvT/0xL0bNaqVyktVgfRzBw3P+fX7y+SZWSrA5DCcyEdQfT
 Y/vZc3Fe3b5y6V9iUp0QHejILoMFrJUOq8vvP4pFA3n/j7uMsq+1mgTjbGguVcqc4OWN
 meD10f3XpiqPoaF4b/ys7bPgShwVRJrhM8yjsEFL5RFLvYg+5gjGIz8QaQZlRrAp9fSK
 /T1lBS+hX4IRRvCgyMla/x46PqV8TxwGmwK9zVzDlT1iozLZho2bMy8TvWactXhplQtZ OA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x15d30dqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:47:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAlRBs026103;
	Fri, 22 Mar 2024 10:47:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x15d30dqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:47:27 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M8nV7k032084;
	Fri, 22 Mar 2024 10:47:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x16k78s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:47:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42MAlMme38338820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:47:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D63A2004F;
	Fri, 22 Mar 2024 10:47:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ABF820040;
	Fri, 22 Mar 2024 10:47:22 +0000 (GMT)
Received: from [9.179.23.66] (unknown [9.179.23.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 10:47:22 +0000 (GMT)
Message-ID: <5399c3b2-a1f0-41c6-ba91-a6a6692629dd@linux.ibm.com>
Date: Fri, 22 Mar 2024 11:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf, capstone: Support 32bit code under 64bit OS
To: Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc: changbin.du@huawei.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240308170611.719794-1-ak@linux.intel.com>
 <b56cd2db-3bd8-480e-b5ad-5e413c8ccbe3@intel.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <b56cd2db-3bd8-480e-b5ad-5e413c8ccbe3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GspE5pt1h-82OOtYKnpoH0Klrb1pByYf
X-Proofpoint-ORIG-GUID: lTr0WGSCsY5ipohfXj2i_svhVv8tAuI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220077

On 3/22/24 11:21, Adrian Hunter wrote:
> On 8/03/24 19:06, Andi Kleen wrote:
>> Use the DSO to resolve whether an IP is 32bit or 64bit and use that to
>> configure capstone to the correct mode. This allows to correctly
>> disassemble 32bit code under a 64bit OS.
>>
>> % cat > loop.c
>> volatile int var;
>> int main(void)
>> {
>> 	int i;
>> 	for (i = 0; i < 100000; i++)
>> 		var++;
>> }
>> % gcc -m32 -o loop loop.c
>> % perf record -e cycles:u ./loop
>> % perf script -F +disasm
>>             loop   82665 1833176.618023:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>>             loop   82665 1833176.618029:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>>             loop   82665 1833176.618031:          7 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>>             loop   82665 1833176.618034:         91 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>>             loop   82665 1833176.618036:       1242 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> Comma in subject is slightly odd, otherwise:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>>
>> ---
>>
>> v2: Factor out DSO lookup into separate function
>> v3: Pass down al
>> v4: Simplify is64bitip
>> ---
>>  tools/perf/builtin-script.c  |  9 +++++----
>>  tools/perf/util/print_insn.c | 24 ++++++++++++++++++++----
>>  tools/perf/util/print_insn.h |  2 +-
>>  3 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 37088cc0ff1b..0299b1ed8744 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -1517,7 +1517,8 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
>>  static int perf_sample__fprintf_insn(struct perf_sample *sample,
>>  				     struct perf_event_attr *attr,
>>  				     struct thread *thread,
>> -				     struct machine *machine, FILE *fp)
>> +				     struct machine *machine, FILE *fp,
>> +				     struct addr_location *al)
>>  {
>>  	int printed = 0;
>>  
>> @@ -1531,7 +1532,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>>  	}
>>  	if (PRINT_FIELD(DISASM) && sample->insn_len) {
>>  		printed += fprintf(fp, "\t\t");
>> -		printed += sample__fprintf_insn_asm(sample, thread, machine, fp);
>> +		printed += sample__fprintf_insn_asm(sample, thread, machine, fp, al);
>>  	}
>>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
>> @@ -1606,7 +1607,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>>  	if (print_srcline_last)
>>  		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
>>  
>> -	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
>> +	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
>>  	printed += fprintf(fp, "\n");
>>  	if (PRINT_FIELD(SRCCODE)) {
>>  		int ret = map__fprintf_srccode(al->map, al->addr, stdout,
>> @@ -2259,7 +2260,7 @@ static void process_event(struct perf_script *script,
>>  
>>  	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
>>  		perf_sample__fprintf_bpf_output(sample, fp);
>> -	perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
>> +	perf_sample__fprintf_insn(sample, attr, thread, machine, fp, al);
>>  
>>  	if (PRINT_FIELD(PHYS_ADDR))
>>  		fprintf(fp, "%16" PRIx64, sample->phys_addr);
>> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
>> index 459e0e93d7b1..8e4e3cffd677 100644
>> --- a/tools/perf/util/print_insn.c
>> +++ b/tools/perf/util/print_insn.c
>> @@ -12,6 +12,8 @@
>>  #include "machine.h"
>>  #include "thread.h"
>>  #include "print_insn.h"
>> +#include "map.h"
>> +#include "dso.h"
>>  
>>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>>  {
>> @@ -28,12 +30,12 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>>  #include <capstone/capstone.h>
>>  
>> -static int capstone_init(struct machine *machine, csh *cs_handle)
>> +static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
>>  {
>>  	cs_arch arch;
>>  	cs_mode mode;
>>  
>> -	if (machine__is(machine, "x86_64")) {
>> +	if (machine__is(machine, "x86_64") && is64) {
>>  		arch = CS_ARCH_X86;
>>  		mode = CS_MODE_64;
>>  	} else if (machine__normalized_is(machine, "x86")) {
>> @@ -93,17 +95,31 @@ static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>>  	return printed;
>>  }
>>  
>> +static bool is64bitip(struct machine *machine, struct addr_location *al)
>> +{
>> +	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
>> +
>> +	if (dso)
>> +		return dso->is_64_bit;
>> +
>> +	return machine__is(machine, "x86_64") ||
>> +		machine__normalized_is(machine, "arm64") ||
>> +		machine__normalized_is(machine, "s390");
>> +}
>> +
>>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
>> -				struct machine *machine, FILE *fp)
>> +				struct machine *machine, FILE *fp,
>> +				struct addr_location *al)
>>  {
>>  	csh cs_handle;
>>  	cs_insn *insn;
>>  	size_t count;
>>  	size_t printed = 0;
>>  	int ret;
>> +	bool is64bit = is64bitip(machine, al);
>>  
>>  	/* TODO: Try to initiate capstone only once but need a proper place. */
>> -	ret = capstone_init(machine, &cs_handle);
>> +	ret = capstone_init(machine, &cs_handle, is64bit);
>>  	if (ret < 0) {
>>  		/* fallback */
>>  		return sample__fprintf_insn_raw(sample, fp);
>> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
>> index 465bdcfcc2fd..6447dd41b543 100644
>> --- a/tools/perf/util/print_insn.h
>> +++ b/tools/perf/util/print_insn.h
>> @@ -10,7 +10,7 @@ struct thread;
>>  struct machine;
>>  
>>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
>> -				struct machine *machine, FILE *fp);
>> +				struct machine *machine, FILE *fp, struct addr_location *al);
>>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
>>  
>>  #endif /* PERF_PRINT_INSN_H */
> 
> 

Acked-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

