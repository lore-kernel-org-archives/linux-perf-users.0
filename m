Received: from sg-3-111.ptr.tlmpb.com (sg-3-111.ptr.tlmpb.com [101.45.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F102DAFAF
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135288; cv=none; b=T04Z2LaJxdk1wi8FgcakCAYXozxgZtdN9/0GeiLgDMx0MwWSYY2ejHNvpPPHhHldLCCqwSdgr5X60t8mnYgv78T/e8oQMn+9S3nTcy70689hL2NgnPUB0j5uo039Mgg/KVXQgI9k6LF0phYsKjpeCsvGL4xe7d+0/lHIQxad7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135288; c=relaxed/simple;
	bh=sSp6MLhOmqeIWT+3O5gbxuH5SSeKOnrzo9PcEx5V1NY=;
	h=Subject:From:Date:To:In-Reply-To:Content-Type:References:Cc:
	 Message-Id:Mime-Version; b=oghatNLcTr6d53ZXI1bAvC0QQxhjVPG7AzdXowfW1YUms47aQkaQzJNWCg4rLcxCXvW2Oca2IokJlpS/5SF9rNuSOPCJDltKij3ec7br8EYvJrbeUJdehlmuzzxeN4rDXd94eI41wMyIPrZ/Pddz0JEDDfRdJsAxJRofHQEw4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C55p5K/P; arc=none smtp.client-ip=101.45.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C55p5K/P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778135240; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Id3HhSqMsuj007ocMTNoBu3NERhhoE7fW9r8EVCTOTY=;
 b=C55p5K/PmZ/L5nLJ9Vlo4A7MUvV47ZPEqN6nG3appxKG1FIS180WrHAuUGnwjCco/1dvKt
 hHzU54MVt7uGcjIo3Ri+EtYj8lv9CTYYVOh3/BF781Rc3tnMbvXz6b/Sb8Jxsnmtq9ymlz
 KBS8ocwc3NK4GP77Q2MCrpzBap4LSlQWvU4etj0/tHGaCvN9cwoROxXjj5aZlQlFPzBezq
 FSMNujSWGQadJhBMuZC1esg5iCaMELykBZL3Ozc0Xiv6ZC3SOWwIrXjWsUqxariAcnujDH
 0IJX+xHteL3ruSLLUWv+9MOr/WgXOJ4/h4QjVVi61T49sjBCdlmZwh9O/4xKjQ==
Subject: Re: [PATCH v2] perf: Extract is_mapping_symbol() helper for kernel mapping symbol filtering
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Thu, 7 May 2026 14:27:06 +0800
User-Agent: Mozilla Thunderbird
To: <sashiko@lists.linux.dev>
In-Reply-To: <20260506104305.2D54DC2BCB8@smtp.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
References: <20260506073820.2419087-1-qirui.001@bytedance.com> <20260506104305.2D54DC2BCB8@smtp.kernel.org>
Cc: <linux-perf-users@vger.kernel.org>
Message-Id: <1022995d-b4d2-4352-9b22-c665174e87e6@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269fc30c5+f9f150+vger.kernel.org+qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>

On 5/6/26 6:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Asymmetric mapping symbol filtering leads to map/symbol deletion during ksymbol unregistration.
> - [Medium] Incomplete refactoring leaves ELF mapping symbol logic fragile and inconsistent.
> --
> 
> commit f27956b5bf680b8ef41ba119f6dc5cedae4567f5
> Author: Rui Qi <qirui.001@bytedance.com>
> 
> perf: Extract is_mapping_symbol() helper for kernel mapping symbol filtering
> 
> This patch introduces an is_mapping_symbol() inline helper to consolidate
> logic for filtering out ELF mapping symbols across architectures. It also
> adds the helper to machine__process_ksymbol_register() and
> map__process_kallsym_symbol().
> 
>> The perf tool currently has ad-hoc logic to filter out ELF mapping
>> symbols scattered across multiple files and architectures.  ARM,
>> AArch64 and RISC-V each have their own inline checks in
>> dso__load_sym_internal(), and kallsym processing in map__process_kallsym_symbol()
>> has yet another check for ARM module symbols.
>>
>> This is fragile: adding support for a new architecture or adjusting
>> which prefixes are considered mapping symbols requires touching
>> multiple places, and it is easy for the checks to diverge.  It also
>> does not match the kernel's own is_mapping_symbol() logic, which
>> additionally covers x86 local symbols ('.L*' and 'L0*').
> 
> This commit message claims to convert dso__load_sym_internal() to use the
> new helper. However, this patch does not modify dso__load_sym_internal()
> in tools/perf/util/symbol-elf.c at all, leaving the scattered inline checks
> untouched.
> 
> Because x86 local symbols (.L*) were added to the new helper, does this
> omission introduce a new inconsistency where kallsyms parsing will correctly
> filter x86 .L* symbols, but kernel module parsing via ELF (.ko) will not?
> 

I believe this is not a bug. The is_mapping_symbol() helper is
explicitly
documented as kernel-only:



  /*

   * Ignore kernel mapping symbols, matching kernel is_mapping_symbol()
logic.
   * ...

   * Only use this for kernel symbols (kallsyms, ksymbol events).

   */



The dso__load_sym_internal() function handles both kernel and userspace

symbols. Applying is_mapping_symbol() there would incorrectly filter out

userspace .L* and L0* symbols.



However, I noticed that kernel modules could also benefit from filtering
x86 .L* symbols. I've added the following in dso__load_sym_internal() to
handle this case:



  /*

   * For kernel modules, also reject x86 local symbols (.L* and L0*)

   * to match the kernel's is_mapping_symbol() logic and kallsyms

   * parsing behavior.

   */

  if (kmodule && is_mapping_symbol(elf_name))

      continue;



This ensures:



1. Only kernel modules are filtered (kmodule == true)

2. Userspace symbols are not affected

3. The existing is_mapping_symbol() helper is reused


>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index e76f8c86e62a6..e0dcf8bfb896e 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -729,9 +729,15 @@ static int machine__process_ksymbol_register(struct machine *machine,
>>  {
>>  	struct symbol *sym;
>>  	struct dso *dso = NULL;
>> -	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
>> +	struct map *map;
>>  	int err = 0;
>>  
>> +	/* Ignore mapping symbols in ksymbol events - check early before any state mutation */
>> +	if (is_mapping_symbol(event->ksymbol.name))
>> +		return 0;
> 
> If a PERF_RECORD_KSYMBOL event arrives with the UNREGISTER flag,
> machine__process_ksymbol() routes it to machine__process_ksymbol_unregister().
> 
> Because machine__process_ksymbol_unregister() does not have the same
> is_mapping_symbol() filter, could maps__find() return the enclosing map
> (such as the BPF JIT map or a loaded kernel module's map) that covers the
> mapping symbol's address?
> 
> tools/perf/util/machine.c:machine__process_ksymbol_unregister() {
> ...
> 	map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
> 	if (!map)
> 		return 0;
> 
> 	if (!RC_CHK_EQUAL(map, machine->vmlinux_map))
> 		maps__remove(machine__kernel_maps(machine), map);
> ...
> }
> 
> If so, will the unregister path incorrectly call maps__remove() on that
> parent map, prematurely destroying legitimate tracking state and breaking
> symbol resolution for subsequent samples in that memory region?
> 

You are absolutely right. The is_mapping_symbol() check is missing in

machine__process_ksymbol_unregister(). This could indeed cause the
unregister path to incorrectly remove a parent map when a mapping symbol
address falls within an existing map range.



I will fix this by adding the same filter to
machine__process_ksymbol_unregister():



static int machine__process_ksymbol_unregister(struct machine *machine,
union perf_event *event,struct perf_sample *sample __maybe_unused)
{

      struct symbol *sym;

      struct map *map;


      /* Ignore mapping symbols in ksymbol events */
      if (is_mapping_symbol(event->ksymbol.name))
          return 0;

      map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
      ...
}


I will send a v3 with these fixes.



Thanks,

Rui Qi
