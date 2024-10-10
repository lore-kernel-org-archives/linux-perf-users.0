Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DC18FDAB;
	Thu, 10 Oct 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575591; cv=none; b=EO8ib0HcW6PMx+xbnxIBIwYtrXxLQyNmOrL3k49dbU2n18IPSpT/GEKAeI9bsKlL3U+p402gseqkLa5OlvhPDIaK9UPGilpk9SCYFAnWsJhbGWDGeQfANpgi/ow33IqQHiVZADTV27RR3TIMz8rfZT6BEEyn6R7d402u7V0/hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575591; c=relaxed/simple;
	bh=Hy8FRACZpCu1JFvItoY2fQZ0RbdPqdFK99taSUkGCBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpFR94i1lIzMdJ+pLKKzMaD1Icpu/wZv2dZkktR3Ei5PTzNt83UbrPBCD4kfi1ZTj/dfpSZwh2eJphRP3pQqUA/NawqTP0g6e1RwYqPTv6qY4ytqAi7ngOVRz6kaNPZ19i5FZSmgTv/2P2YGaFKXvHw7ZG1HR/Nzck0R8kdYlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49763497;
	Thu, 10 Oct 2024 08:53:38 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77033F58B;
	Thu, 10 Oct 2024 08:53:06 -0700 (PDT)
Message-ID: <fab219bc-fabd-42b7-b42f-d92851b1d2f3@arm.com>
Date: Thu, 10 Oct 2024 16:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241011003408.f9bacf4e5899e88a94c3d7cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 10/10/24 16:34, Masami Hiramatsu (Google) wrote:
> 
> 
> On Mon,  7 Oct 2024 15:11:16 +0100
> Leo Yan <leo.yan@arm.com> wrote:
> 
>> If a symbol name is longer than the maximum event length (64 bytes),
>> generate an new event name with below combination:
>>
>>    TruncatedSymbol + '_' + HashString + '__return' + '\0'
>>      `> 46B        + 1B  +   8B       +    8B      + 1B   = 64 Bytes.
>>
>> With this change, a probe can be injected for long symbol.
>>
>> Before:
>>
>>    # nm test_cpp_mangle | grep -E "print_data|Point"
>>    0000000000000cac t _GLOBAL__sub_I__Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
>>    0000000000000b50 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzR5Point
>>    0000000000000b14 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
>>
>>    # perf probe -x test_cpp_mangle --add \
>>          "_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
>>    snprintf() failed: -7; the event name nbase='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long
>>    Error: Failed to add events.
>>
>> After:
>>
>>    # perf probe -x test_cpp_mangle --add \
>>        "_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
>>
>>    Probe event='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long (>= 64 bytes).
>>    Generate hashed event name='_Z62this_is_a_very_very_long_print_data_abcdef_91f40679'
>>
>>    Added new event:
>>      probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679
>>      (on _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi in /mnt/test_cpp_mangle)
>>
>>    You can now use it in all perf tools, such as:
>>
>>        perf record -e probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679 -aR sleep 1
> 
> OK, personally, I recommend you to specify event name instead of generating
> long event name in this case. But I understand sometimes this kind of feature
> is good for someone.

Sometimes, users try to add probe for long symbol and returns error, but there 
  have no clue for proceeding.

Either we automatically generate a hashed name, or a guidance in the failure 
log for setting event name would be helpful. If you have concern for hashed 
name, maybe we can refine the log to give info for setting event name?

> BTW, I would like to confirm. Can't we demangle the symbol name and parse it?

I did test for C++ demangle symbols with the command:

   perf probe -x /mnt/test_cpp_mangle -F --demangle

The command doesn't work as I cannot see it output correctly for demangled 
symbols. But I don't look into details why this does not work at my side.

Thanks for review.

Leo
