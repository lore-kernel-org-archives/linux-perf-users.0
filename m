Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC2302163;
	Tue, 11 Aug 2026 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415245; cv=none; b=Ns0SDqIJ3ITQ3CjMAXTwE3Lxv6TZhygDmJmr5F971AsKdHy5+XFQTMp6xnwZsHRtH9RUZ1602xHsWYLDgO2+0GWvWvriqETprQzSKTzHMPLGkM9sO81Y/yZYiDYFDDamVJeMUNXttj+iC7ON6qgzMk2CffQvb1Qvuyv4LBjxJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415245; c=relaxed/simple;
	bh=FwVOB05kl/9oe0jZhYgptEYAb/t6L3gQc/YooONbt9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlfD4tVDiO745GebWk0mwACy3QAjTFRYeATFfgv+5mWbjMJ/Z4G2q6eHBnMyJEM1QPbBHy7F6HeBQkK8hn0hqLymWZWI2CCjZ1hV/kq5KfqAldf5YkxunSG/AlH81s4X0GpR0GUkPEMC3Smw3vNlVTx81++i05nljqRH4yBoNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hJwVw06btzKHMSh;
	Tue, 11 Aug 2026 10:27:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5ACD44057B;
	Tue, 11 Aug 2026 10:27:19 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAnkomFiHpqEkKMBw--.43021S2;
	Tue, 11 Aug 2026 10:27:19 +0800 (CST)
Message-ID: <244d8775-5318-4678-a392-b1416acc78af@huaweicloud.com>
Date: Tue, 11 Aug 2026 10:27:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
To: Shuai Xue <xueshuai@linux.alibaba.com>, Namhyung Kim
 <namhyung@kernel.org>, james.clark@linaro.org,
 Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-2-wutengda@huaweicloud.com>
 <1b7e48ec-66a0-4727-b533-ff87f54df057@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <1b7e48ec-66a0-4727-b533-ff87f54df057@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnkomFiHpqEkKMBw--.43021S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1xtr18AF1UCw13Zw4rGrg_yoW3Cr1Dpr
	1kArW5JrWUJrn5Jr1UJr1UXFy5Ar18J3WDJr18XFyUArsrAr1jgryUXryq9r1UJr48Jr1U
	Jr1UZrnxZrnxJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Shuai, thank you for your time.

On 2026/8/10 21:08, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> The jump and adrp instructions parsed by libcapstone currently lack
>> symbolic representation and use a '#' prefix for addresses. This
>> format is inconsistent with objdump's output, which causes subsequent
>> parsing in jump__parse() and arm64_mov__parse() to fail.
>>
>> Example mismatch:
>>    Current: b #0xffff8000800114c8
>>    Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>
>>
>>    Current: adrp x18, #0xffff800081f5f000
>>    Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
>>
>> Fix this by implementing extended formatting for these arm64
>> instructions during symbol__disassemble_capstone(). This ensures
>> the output matches objdump's expected style, including the raw
>> address and the associated <symbol+offset> suffix.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   tools/perf/util/capstone.c | 136 +++++++++++++++++++++++++++++++++----
>>   tools/perf/util/disasm.c   |   5 ++
>>   tools/perf/util/disasm.h   |   1 +
>>   3 files changed, 130 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
>> index 74213daf8786..fb8a2bc5558f 100644
>> --- a/tools/perf/util/capstone.c
>> +++ b/tools/perf/util/capstone.c
>> @@ -3,6 +3,7 @@
>>     #include <errno.h>
>>   #include <inttypes.h>
>> +#include <stdlib.h>
>>   #include <string.h>
>>     #include <dlfcn.h>
>> @@ -31,6 +32,10 @@
>>   #define CS_MODE_RISCVC   4
>>   #endif
>>   +#if CS_VERSION_MAJOR < 4
>> +#define ARM64_GRP_BRANCH_RELATIVE  7
> 
> Please add a comment explaining where '7' comes from
> (CS_GRP_BRANCH_RELATIVE in capstone v3), otherwise it reads like an
> arbitrary magic number.
> 

Um, this was done following Namhyung's approach. That said, adding a
comment would certainly make this definition clearer -- will add it.

Also, I couldn't find CS_GRP_BRANCH_RELATIVE in v3. From what I can see,
it was originally introduced in v4, together with ARM64_GRP_BRANCH_RELATIVE
(see https://github.com/capstone-engine/capstone/commit/a09a81813c83).
So the comment might look something like this:

  #define ARM64_GRP_BRANCH_RELATIVE  7  /* = CS_GRP_BRANCH_RELATIVE */

Is this acceptable?

Thanks,
Tengda

>> +#endif
>> +
>>   #ifdef LIBCAPSTONE_DLOPEN
>>   static void *perf_cs_dll_handle(void)
>>   {
>> @@ -225,6 +230,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
>>            * on x86 by investigating instruction details.
>>            */
>>           perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>> +    } else if (arch == CS_ARCH_ARM64) {
>> +        /*
>> +         * Same as x86: arm64 needs instruction details to resolve
>> +         * symbolic addresses.
>> +         */
>> +        perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>>       }
>>         return 0;
>> @@ -299,10 +310,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>>       struct map *map = args->ms->map;
>>       struct symbol *sym;
>>   -    /* TODO: support more architectures */
>> -    if (!arch__is_x86(args->arch))
>> -        return;
>> -
>>       if (insn->detail == NULL)
>>           return;
>>   @@ -354,6 +361,116 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>>       }
>>   }
>>   +static int print_default_format(struct cs_insn *insn, char *buf, size_t len)
>> +{
>> +    return scnprintf(buf, len, "       %-7s %s",
>> +             insn->mnemonic, insn->op_str);
>> +}
>> +
>> +static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
>> +                     size_t len, struct annotate_args *args,
>> +                     u64 addr)
>> +{
>> +    int printed;
>> +
>> +    printed = print_default_format(insn, buf, len);
>> +    buf += printed;
>> +    len -= printed;
>> +
>> +    print_capstone_detail(insn, buf, len, args, addr);
>> +}
>> +
>> +static bool is_pc_relative_insn(struct cs_insn *insn)
>> +{
>> +    int i;
>> +
>> +    if (insn->id == ARM64_INS_ADR || insn->id == ARM64_INS_ADRP)
>> +        return true;
>> +
>> +    if (insn->detail == NULL)
>> +        return false;
>> +
>> +    for (i = 0; i < insn->detail->groups_count; i++) {
>> +        if (insn->detail->groups[i] == ARM64_GRP_JUMP ||
>> +            insn->detail->groups[i] == ARM64_GRP_CALL ||
>> +            insn->detail->groups[i] == ARM64_GRP_BRANCH_RELATIVE)
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
>> +                       size_t len, struct annotate_args *args)
>> +{
>> +    struct map *map = args->ms->map;
>> +    struct symbol *sym;
>> +    char *last_imm, *endptr;
>> +    u64 orig_addr, addr;
>> +    struct map *found_map = NULL;
>> +
>> +    print_default_format(insn, buf, len);
>> +    /*
>> +     * Adjust instructions to keep the existing behavior with objdump.
>> +     *
>> +     * Example conversion:
>> +     * From: b #0xffff8000800114c8
>> +     * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
>> +     */
>> +    if (is_pc_relative_insn(insn)) {
>> +        /* Extract last immediate value as address */
>> +        last_imm = strrchr(buf, '#');
>> +        if (!last_imm)
>> +            return;
>> +
>> +        orig_addr = strtoull(last_imm + 1, &endptr, 16);
>> +        if (endptr == last_imm + 1)
>> +            return;
>> +
>> +        addr = map__objdump_2mem(map, orig_addr);
>> +
>> +        /* Relocate map that contains the address */
>> +        if (dso__kernel(map__dso(map))) {
>> +            found_map = maps__find(map__kmaps(map), addr);
>> +            if (found_map == NULL)
>> +                return;
>> +            map = found_map;
>> +        }
>> +
>> +        /* Convert it to map-relative address for search */
>> +        addr = map__map_ip(map, addr);
>> +
>> +        sym = map__find_symbol(map, addr);
>> +        if (sym == NULL) {
>> +            map__put(found_map);
>> +            return;
>> +        }
>> +
>> +        /* Symbolize the resolved address */
>> +        len = len - (last_imm - buf);
>> +        if (addr == sym->start) {
>> +            scnprintf(last_imm, len, "%"PRIx64" <%s>",
>> +                  orig_addr, sym->name);
>> +        } else {
>> +            scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
>> +                  orig_addr, sym->name, addr - sym->start);
>> +        }
>> +        map__put(found_map);
> 
> 
> This whole sequence (objdump_2mem -> kmaps relocation -> map_ip ->
> find_symbol -> scnprintf the "<sym+off>" string) is almost identical to
> what print_capstone_detail() does for x86 RIP-relative operands.  Could
> you factor out a common helper so the two paths don't diverge over time?
> 
> Thanks.
> Shuai

