Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F816938C;
	Mon, 22 Jul 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654517; cv=none; b=uAp0a1wKk8EdoRiJoCYhyMh3dxOk6I1Ij2xPIpACYqd7I7axhND1W935JZDJfSUdFMAdgYXhn+O68mO5wVjDQtYvWNykU1WCFbYZ8PVs1dhLBf7dLTE7KaHWth8PK9OJz2VjMT3PJAmuWrR/oQ6rwE0E5rwW0T8MttUF4SY9QF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654517; c=relaxed/simple;
	bh=1vJOalqPs9gOtVB5xXuL0vKmb83B5xaZIYuNaKLZ/NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgBERyhS1XOCrwAnV6RTR2ZLQeKba+IOS+VofNV2DvqJTfO1nxm4TTYN/eQI9lrv2sLDyBIMxmXXboY4iM4x2U901UdKMZZL27eL5SK3/X069+6jNaYcuxJ9km20VGY8jyHZdj+AhQGJz6xQr+mhVfDl4Ob44BMLLB2ufES4MEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DD3nB2jY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DD3nB2jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721654515; x=1753190515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1vJOalqPs9gOtVB5xXuL0vKmb83B5xaZIYuNaKLZ/NQ=;
  b=DD3nB2jYctSqea2kM7l9fq+R+azAyCluzmPBU0tkHmq38Ip74R1LMrNB
   Py3HibPDocsktBebpVI5qCrEkqfEJH3Le7JbO6zu8U/o7q8j6uf9UzdiC
   h87wdNVuxkQunsG08i/ZX6TojCcIxCDChAxH6IDnGUk7nDsvxinedQzVy
   IyLbLsJykkvr4Ad5HxGMoSpXfnyp8WiO2JlUjZqRjtxxtgBbTeL5iRaKz
   MINU00CbYCst4et8xC+wWq0lFFt1TViqaU0VsVb3gt7DUIBZ3DlLfHhhl
   x+nOGcJ2vjdUiRQLnog0Hqt/IaYinX5OA7UaZB1DaTIYwFPUuAAfLEQNf
   g==;
X-CSE-ConnectionGUID: hqdEVa3aTQGlg8dNhv4ikg==
X-CSE-MsgGUID: GoEx5Bf4Q7+R9YDSwiymjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19350832"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="19350832"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 06:21:54 -0700
X-CSE-ConnectionGUID: MwsEo92TSNm2uceUqllnrA==
X-CSE-MsgGUID: Gid4Vo0kTeCtr+L+fHmSgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="51541362"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 06:21:50 -0700
Message-ID: <22bee274-23e1-4298-a936-50bebd802482@intel.com>
Date: Mon, 22 Jul 2024 16:21:46 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] perf: build-id: name debugging vdso as "debug"
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "Wanghui (OS Kernel Lab, Beijing)" <hw.huiwang@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
 <20240702041837.5306-5-changbin.du@huawei.com>
 <14afba8e-cb85-4d7d-96e4-d65fd8ebc2d5@intel.com>
 <8a7156281b45450ebf0511373f65afa7@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8a7156281b45450ebf0511373f65afa7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/24 15:08, duchangbin wrote:
> On Thu, Jul 18, 2024 at 08:03:07PM +0300, Adrian Hunter wrote:
>> On 2/07/24 07:18, Changbin Du wrote:
>>> As normal objects, we will add debugging vdso elf to build-id cache later.
>>> Here we name the debugging one as "debug".
>>>
>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>> ---
>>>  tools/perf/util/build-id.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
>>> index 83a1581e8cf1..15530af2bad9 100644
>>> --- a/tools/perf/util/build-id.c
>>> +++ b/tools/perf/util/build-id.c
>>> @@ -259,8 +259,8 @@ static bool build_id_cache__valid_id(char *sbuild_id)
>>>  static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
>>>  					    bool is_debug)
>>>  {
>>> -	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : (is_debug ?
>>> -	    "debug" : "elf"));
>>> +	return is_kallsyms ? "kallsyms" : (is_debug ? "debug" : (is_vdso ?
>>> +		"vdso" : "elf"));
>>>  }
>>>  
>>>  char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>>
>> To actually add "debug", this also needs:
>>
>> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
>> index 15530af2bad9..b5bd02a1ad0f 100644
>> --- a/tools/perf/util/build-id.c
>> +++ b/tools/perf/util/build-id.c
>> @@ -701,7 +701,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>>  	 * file itself may not be very useful to users of our tools without a
>>  	 * symtab.
>>  	 */
>> -	if (!is_kallsyms && !is_vdso &&
>> +	if (!is_kallsyms &&
>>  	    strncmp(".ko", name + strlen(name) - 3, 3)) {
>>  		debugfile = build_id_cache__find_debug(sbuild_id, nsi, root_dir);
>>  		if (debugfile) {
>>
>>
>>
> This is done by later patch named "perf: build-id: try to search debugging vdso
> and add to cache". I split the changes into two patches.

With the above, the split is more functionally logical:
	1. Add support for build-id cache vdso debug
	2. For vdso, extend build_id_cache__find_debug() to find
	local kernel build files

> 
>> With that perf will populated the "debug" entry in the build-id cache.
>> Currently, when adding to the build-id cache, perf only looks in
>> /usr/lib/debug/.build-id (refer build_id_cache__find_debug()), for
>> example:
>>
>>
>> $ sudo ln -s /lib/modules/6.9.2-local/build/arch/x86/entry/vdso/vdso64.so.dbg /usr/lib/debug/.build-id/cf/702469f4637840fd6ba1a8d8a628ff83253d04.debug
>> $ ls -l ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/
>> total 8
>> -rw-r--r-- 1 ahunter ahunter    0 Jul 18 13:33 probes
>> -rw------- 1 ahunter ahunter 8192 Jul 18 13:33 vdso
>> $ perf record uname
>> Linux
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.010 MB perf.data (2 samples) ]
>> $ ls -l ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/
>> total 40
>> -rwxrwxr-x 2 ahunter ahunter 32760 May 27 17:42 debug
>> -rw-r--r-- 1 ahunter ahunter     0 Jul 18 13:33 probes
>> -rw------- 1 ahunter ahunter  8192 Jul 18 13:33 vdso
>>
>>
>> Note, perf will anyway find the debug object in /usr/lib/debug/.build-id
>> so the benefit is if perf-archive is used to copy from the buildid-cache
>> to take to another machine.
>>
>>
> 

