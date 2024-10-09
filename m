Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97097199230
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Oct 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487495; cv=none; b=iRdUA5qyEZMU6/+HK1/hFvPlHWyzTND/jx9Nr3ONDUs9Ys24G881A+NGjudo2AtI4C5aDf+Td9tYVtMcvgDUdAEp/Ycy2tsyJruK9cdLin2kvkvN+A9cxTM3+dugDqKd3ouSXptDGuAiKDjzA26UJ+LksOOYQpNl3LCsJvv2UkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487495; c=relaxed/simple;
	bh=E31LuZEf02ukV1YBFjmUncbLxZ1RakdcCVVCX9F8R8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoT8X4mZ6lMqyOloriuWkKjgRR1WS9z6oNan3bAWkVFsfWVZiUxhnpsZEprejHKb8rFsE9qpVylpFkvBdrJiwdvFhaXSYlVxEC0iYyc+aPuAlCceOgm7Km5CZAMwyKg8CgLx1BJIYK/9vbPoMRAMjUCdwFX9jBohlpCbdV9xC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467F5FEC;
	Wed,  9 Oct 2024 08:25:22 -0700 (PDT)
Received: from [10.1.34.26] (PF4Q20KV.arm.com [10.1.34.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911A13F64C;
	Wed,  9 Oct 2024 08:24:51 -0700 (PDT)
Message-ID: <b484a69a-534f-4274-a000-94edf4d2521d@arm.com>
Date: Wed, 9 Oct 2024 16:24:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Namhyung Kim <namhyung@kernel.org>,
 Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: james.clark@linaro.org, mike.leach@linaro.org, suzuki.poulose@arm.com,
 ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <ZwTIbRbAX2EX31X8@google.com>
 <c2b1d122-83e5-4392-9009-2d22e59aa14a@os.amperecomputing.com>
 <ZwWdhvud5f7tRxkW@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZwWdhvud5f7tRxkW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Namhyung,

On 10/8/2024 10:00 PM, Namhyung Kim wrote:

[...]

> On Tue, Oct 08, 2024 at 11:24:45AM -0700, Steve Clevenger wrote:
>>
>> Hello Namhyung,
>>
>> Sorry your question is so late. I don't include the ELF headers here,
>> but the problem can be seen with a perf.data packet dump of user
>> instruction trace capture. The problem is with the non-zero pgoff. The
>> arm-cs-trace-disasm.py script was never passed pgoff information to
>> adjust the start/end disassemble range passed to objdump. This patch
>> distributes the fix between perf and the arm-cs-trace-disasm.py script.
>>
>> Here's a brief excerpt from an e-mail I sent to James Clark describing
>> the patch before I submitted it.
> 
> Oh, is it applied to the coresight tree already?

No.

> I don't think I got> any notification for that.  Please make sure to notify
perf maintainers
> (and hopefullly to get Ack's) when you touch non-coresight part of the
> code.
> 
> Also I think we need to clarify how to route coresight tool patches.  I
> thought they are going through the perf-tools tree.  But it doesn't seem
> to be the case?

AFAIK, in most cases, Arm patches for the perf will be picked up via
perf-tools tree, including this patch series.

[...]
>> Fedora 39:
>>
>> 4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
>> 18229/18229: [0xffffa5512000(0x1d000) @ 0x10000 103:04 161 4093340249]:
>> r-xp /usr/lib/ld-linux-aarch64.so.1
>>
>> 4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
>> 18229/18229: [0xffffa554f000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
>> 4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
>> 18229/18229: [0xaaaade7e0000(0xb000) @ 0x10000 103:04 536876423
>> 421616320]: r-xp /usr/bin/dd
>> 4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
>> 18229/18229: [0xffffa5360000(0x11f000) @ 0x30000 103:04 536873199
>> 2415801053]: r-xp /usr/lib64/libc.so.6
>>
>> The arm-cs-trace-disasm.py script never gets to see the text offset into
>> the dso binaries, so has no opportunity to adjust the start/end address
>> range passed to objdump. This wasn’t a problem on Fedora 37 and below
>> since there’s no start/end adjustment for a zero text offset. On Fedora
>> 38/39 distros, the instruction trace shows unconditional branch
>> instructions which do not branch to the target address, the clearest
>> indication of trouble.
> 
> Ok, thanks for sharing this.  I'm ok with exposing pgoff to the python
> script itself.  But I'd like to make sure if it works correctly with
> PIEs that have non-zero page offsets in other places (probably ok).

Fair point. The 'pgoff' is exposed from the kernel's VMA info, it is a runtime
value after the DSO loading. After set the MAPPING_TYPE__IDENTITY type for PIE
DSO, the 'pgoff' will be ignored in both the perf tool (see map__map_ip()) and
the script.

Sorry that I missed this part when reviewed the change. I understood Steve
have verified the script result. Seems to me, the critical question is kernel
has an offset for PIE DSO but why ignore it in the tool.

@Steve, if you have more info, could you explain a bit what is the reason for
ignoring pgoff for PIE DSO?

Thanks,
Leo
