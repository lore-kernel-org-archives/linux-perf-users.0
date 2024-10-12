Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27D189905;
	Sat, 12 Oct 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742879; cv=none; b=R2fO2UOWJoOpbjOaLmiwfT3sYWXck6/OwsCvFXOvj5ouY2YVOp08sOeEOr7NR4HhI8+VGcPfcpmLl+wCpxhvAHGnNGpajBMAEGcOEyB2du/9AGG6lFAiXwoKNMjacwIE1x8n4INJ51PD0c7xN8xN8ryDqVL/jn4LxJJEWrXl5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742879; c=relaxed/simple;
	bh=epfl+o3RiUcg7aZ2+/9YFb3b8qbuphICbRWY0ddwO4E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hERZkbkKwx7IEwYh6X2LzQcfP1RQmspx3gQbG+1tNmGuILYiF8Y3DaeQv/gmFqr+yymfBfrefauI5dFKM+zZtEqsQCQ2WCm0gPUQDeWbAQvtbjVnFOYL+KkgGyuUuwJGWIPDWgLljj2PAuhFP5iOCPy3oDslBu2sqni0Qre7kuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6610DA7;
	Sat, 12 Oct 2024 07:21:45 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A233F71E;
	Sat, 12 Oct 2024 07:21:14 -0700 (PDT)
Message-ID: <d53477c1-9c74-4578-8d74-281b95dee11e@arm.com>
Date: Sat, 12 Oct 2024 15:21:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v1 3/3] perf probe: Generate hash event for long symbol
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Dima Kogan <dima@secretsauce.net>,
 james.clark@linaro.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241007141116.882450-1-leo.yan@arm.com>
 <20241007141116.882450-4-leo.yan@arm.com>
 <20241011003408.f9bacf4e5899e88a94c3d7cd@kernel.org>
 <fab219bc-fabd-42b7-b42f-d92851b1d2f3@arm.com>
 <20241011120733.5660c80f8f93e9659fa5a254@kernel.org>
 <a7d63300-27a2-4121-9327-40426a66afe3@arm.com>
 <20241012143003.eeb8d3eb43e45494193bbfd4@kernel.org>
Content-Language: en-US
In-Reply-To: <20241012143003.eeb8d3eb43e45494193bbfd4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 06:30, Masami Hiramatsu (Google) wrote:

[...]

>> ---8<---
>>
>>  From 3b09a6f89c7e383c6b1d2b7e6bd80c6bfa658d5b Mon Sep 17 00:00:00 2001
>> From: Leo Yan <leo.yan@arm.com>
>> Date: Fri, 11 Oct 2024 07:58:08 +0000
>> Subject: [PATCH] perf probe: Correct demangled symbols in C++ program
>>
>> An issue can be observed when probe C++ demangled symbol with steps:
>>
>>    # nm test_cpp_mangle | grep print_data
>>      0000000000000c94 t _GLOBAL__sub_I__Z10print_datai
>>      0000000000000afc T _Z10print_datai
>>      0000000000000b38 T _Z10print_dataR5Point
>>
>>    # ./perf probe -x /home/niayan01/test_cpp_mangle -F --demangle
>>      ...
>>      print_data(Point&)
>>      print_data(int)
>>      ...
>>
>>    # ./perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
>>      probe-definition(0): test=print_data(int)
>>      symbol:print_data(int) file:(null) line:0 offset:0 return:0 lazy:(null)
>>      0 arguments
>>      Open Debuginfo file: /home/niayan01/test_cpp_mangle
>>      Try to find probe point from debuginfo.
>>      Symbol print_data(int) address found : afc
>>      Matched function: print_data [2ccf]
>>      Probe point found: print_data+0
>>      Found 1 probe_trace_events.
>>      Opening /sys/kernel/tracing//uprobe_events write=1
>>      Opening /sys/kernel/tracing//README write=0
>>      Writing event: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0xb38
>>      ...
>>
>> When tried to probe symbol "print_data(int)", the log show:
>>
>>      Symbol print_data(int) address found : afc
>>
>> The found address is 0xafc - which is right if we connect with the
>> output result from nm. Afterwards when write event, the command uses
>> offset 0xb38 in the last log, which is a wrong address.
>>
>> The dwarf_diename() gets a common function name, in above case, it
>> returns string "print_data". As a result, the tool parses the offset
>> based on the common name. This leads to probe at the wrong symbol
>> "print_data(Point&)".
>>
>> To fix the issue, use the die_get_linkage_name() function to retrieve
>> the distinct linkage name - this is the mangled name for the C++ case.
>> Based on this unique name, the tool can get a correct offset for
>> probing. Based on DWARF doc, it is possible the linkage name is missed
>> in the DIE, it rolls back to use dwarf_diename().
> 
> Can you add the result after applying this patch here?

Sure. The result with this patch is:

   # perf --debug verbose=3 probe -x test_cpp_mangle --add "test=print_data(int)"
     probe-definition(0): test=print_data(int)
     symbol:print_data(int) file:(null) line:0 offset:0 return:0 lazy:(null)
     0 arguments
     Open Debuginfo file: /home/niayan01/test_cpp_mangle
     Try to find probe point from debuginfo.
     Symbol print_data(int) address found : afc
     Matched function: print_data [2d06]
     Probe point found: print_data+0
     Found 1 probe_trace_events.
     Opening /sys/kernel/tracing//uprobe_events write=1
     Opening /sys/kernel/tracing//README write=0
     Writing event: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0xafc
     Added new event:
       probe_test_cpp_mangle:test (on print_data(int) in /home/niayan01/test_cpp_mangle)
                                                                                                                                                                                                                                                        
     You can now use it in all perf tools, such as:
                                                                                                                                                                                                                                                        
             perf record -e probe_test_cpp_mangle:test -aR sleep 1
                                                                                                                                                                                                                                                        
   # perf --debug verbose=3 probe -x test_cpp_mangle --add "test2=print_data(Point&)"
     probe-definition(0): test2=print_data(Point&)
     symbol:print_data(Point&) file:(null) line:0 offset:0 return:0 lazy:(null)
     0 arguments
     Open Debuginfo file: /home/niayan01/test_cpp_mangle
     Try to find probe point from debuginfo.
     Symbol print_data(Point&) address found : b38
     Matched function: print_data [2ccf]
     Probe point found: print_data+0
     Found 1 probe_trace_events.
     Opening /sys/kernel/tracing//uprobe_events write=1
     Parsing probe_events: p:probe_test_cpp_mangle/test /home/niayan01/test_cpp_mangle:0x0000000000000afc
     Group:probe_test_cpp_mangle Event:test probe:p
     Opening /sys/kernel/tracing//README write=0
     Writing event: p:probe_test_cpp_mangle/test2 /home/niayan01/test_cpp_mangle:0xb38
     Added new event:
       probe_test_cpp_mangle:test2 (on print_data(Point&) in /home/niayan01/test_cpp_mangle)
                                                                                                                                                                                                                                                        
     You can now use it in all perf tools, such as:
                                                                                                                                                                                                                                                        
             perf record -e probe_test_cpp_mangle:test2 -aR sleep 1

I have sent out a formal patch (with fixed tag):
https://lore.kernel.org/linux-perf-users/20241012141432.877894-1-leo.yan@arm.com/T/#u

Thanks for review!

Leo
