Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBD524C;
	Mon, 28 Oct 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100348; cv=none; b=bV732/f5i6QaNRQavwfxigIFZROw6DCBrWRb1Lwu8qJxxO5JyjThGbdtc5gvqQH3ZcldIQCSS8u3lzmLqA1oBtqzVb90uM0ZjCRjxy2/g4oNIWnXwL8OhualXlWdczm61/pLW66cCX1kQyKOgMabX1wP73jDG+asIwiACKwt0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100348; c=relaxed/simple;
	bh=DlfgfbOFLJSyhy9MbiabcErhB4Sk+ICJGR4zWwL4UMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8FnLle7nLcBB0MQcUZBZW+tbDeUnCjZCQade9m/ZlxdP4mC4qo8liKEDdI/qmpeg23288JS2pRAUNAddd9TZ45L8W/YWjbLZJeBPTmpuYZIzrWNi3jMy7HoHxMjrBwnkfZ5WdeR9SCjPxuyYQ/EYZL20gYJUd2A5Rc/ME6Uk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPdoI2+E; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPdoI2+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730100346; x=1761636346;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DlfgfbOFLJSyhy9MbiabcErhB4Sk+ICJGR4zWwL4UMI=;
  b=WPdoI2+EE5URFIAILMV1EYZL0eMG04r4jVPs2RFezewAvmY8cbcGOY0Z
   F2M32/E3M4yMKm3Fyu/h7vaUmwBOg519MFkcM/6Ku7cLbC5YvsMDxsg4P
   +QeY+KBp7ktEov23ycLp8LXhwJ39ncK9AFz2UqfXxl656ofnjzaZV85YE
   uvyYJ8ADfbW7xKeknnxlUnPFe8Z2kbHR2o0aSukTJir/78rLhOeFb8gD2
   E8P4vaLZVx3y8qmB8d54VfkCG/QJ3W+GIPpRdTEaCswankD4hjmMSu9+X
   UcilpqWg8zWCl9+IiljQI8eXmiQHCvBqVHUa8Op+AJEylFsJaP7cDrLlE
   g==;
X-CSE-ConnectionGUID: 3CWY7UBcTwql+pI9yc3y8g==
X-CSE-MsgGUID: Bcy/QGPeRcuLBE99H/Y+KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29119687"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29119687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:25:45 -0700
X-CSE-ConnectionGUID: EArWpR0eSDKukeWUKhI57Q==
X-CSE-MsgGUID: Pu58TxwVQ8OUNSnKmwCp4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81444865"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:25:41 -0700
Message-ID: <c19ca53b-b0e6-4763-8691-09ee4a095492@intel.com>
Date: Mon, 28 Oct 2024 09:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf cap: Add __NR_capget to arch/x86 unistd
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20241026055448.312247-1-irogers@google.com>
 <CAP-5=fXLL1dB4MEfe7Z+fhp_RzC9DV91gBLBHjjywW-_RXmM-Q@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fXLL1dB4MEfe7Z+fhp_RzC9DV91gBLBHjjywW-_RXmM-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/10/24 09:00, Ian Rogers wrote:
> On Fri, Oct 25, 2024 at 10:54 PM Ian Rogers <irogers@google.com> wrote:
>>
>> As there are duplicated kernel headers in tools/include libc can pick
>> up the wrong definitions. This was causing the wrong system call for
>> capget in perf.
>>
>> Closes: https://lore.kernel.org/lkml/cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com/
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Forgot:
> Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")

Works for me, thank you!

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Thanks,
> Ian
> 
>> ---
>>  tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
>>  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
>>  tools/perf/util/cap.c                       | 10 +++-------
>>  3 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
>> index 9de35df1afc3..63182a023e9d 100644
>> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
>> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
>> @@ -11,6 +11,9 @@
>>  #ifndef __NR_getpgid
>>  #define __NR_getpgid 132
>>  #endif
>> +#ifndef __NR_capget
>> +#define __NR_capget 184
>> +#endif
>>  #ifndef __NR_gettid
>>  #define __NR_gettid 224
>>  #endif
>> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
>> index d0f2043d7132..77311e8d1b5d 100644
>> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
>> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
>> @@ -11,6 +11,9 @@
>>  #ifndef __NR_getpgid
>>  #define __NR_getpgid 121
>>  #endif
>> +#ifndef __NR_capget
>> +#define __NR_capget 125
>> +#endif
>>  #ifndef __NR_gettid
>>  #define __NR_gettid 186
>>  #endif
>> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
>> index 7574a67651bc..69d9a2bcd40b 100644
>> --- a/tools/perf/util/cap.c
>> +++ b/tools/perf/util/cap.c
>> @@ -7,13 +7,9 @@
>>  #include "debug.h"
>>  #include <errno.h>
>>  #include <string.h>
>> -#include <unistd.h>
>>  #include <linux/capability.h>
>>  #include <sys/syscall.h>
>> -
>> -#ifndef SYS_capget
>> -#define SYS_capget 90
>> -#endif
>> +#include <unistd.h>
>>
>>  #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
>>
>> @@ -21,9 +17,9 @@ bool perf_cap__capable(int cap, bool *used_root)
>>  {
>>         struct __user_cap_header_struct header = {
>>                 .version = _LINUX_CAPABILITY_VERSION_3,
>> -               .pid = getpid(),
>> +               .pid = 0,
>>         };
>> -       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
>> +       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] = {};
>>         __u32 cap_val;
>>
>>         *used_root = false;
>> --
>> 2.47.0.163.g1226f6d8fa-goog
>>

