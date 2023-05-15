Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B97BC7EE22
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 03:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjEODIP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 May 2023 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbjEODIL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 May 2023 23:08:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3434171F
        for <linux-perf-users@vger.kernel.org>; Sun, 14 May 2023 20:08:07 -0700 (PDT)
Received: from loongson.cn (unknown [223.106.25.146])
        by gateway (Coremail) with SMTP id _____8Bx7eoWomFkLbMIAA--.15101S3;
        Mon, 15 May 2023 11:08:06 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.106.25.146])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx08QSomFkX75eAA--.33837S3;
        Mon, 15 May 2023 11:08:03 +0800 (CST)
Message-ID: <fb01aa38-6b05-d319-d134-a3c2793026ae@loongson.cn>
Date:   Mon, 15 May 2023 19:08:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/17] tools perf: fix build warnings
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <ZFvPAB4Lrcl1CcPz@kernel.org>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZFvPAB4Lrcl1CcPz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx08QSomFkX75eAA--.33837S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFWfJF1rur1DCFyrJFW7CFg_yoWrZF4DpF
        1S9FZYka1DWrWfZ3ZxCr4UZFyrCws3J3WYgry3Wr9xXa1Y9r1rAw1xCF17KFnrtrZ7WF4j
        9FW7WF15KFykZw7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b9xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l87I20VAvwVAaII0Ic2I_JFv_Gryl8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv04
        87Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IY
        x2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
        x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxU3db1UUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 2023/5/11 01:06, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 10, 2023 at 06:21:43PM +0800, Yanteng Si escreveu:
>> v2:
> So had to drop the ones I explicitely replied due to build failures and
> then some more because this is usually done when the window closes, i.e.
> for v6.4, so that when it is finally released we don't have warnings
> building perf.
Oh yes, I see what you mean.
>
> The ones I applied:
>
> ⬢[acme@toolbox perf-tools]$ git log --oneline 558423699d9b37de..
> 79ae55cb5aa77ac2 (HEAD -> perf-tools) tools arch x86: Sync the msr-index.h copy with the kernel sources
> d48eb7d03dcd623a tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel sources
> 14665fa481b7c947 tools include UAPI: Sync the sound/asound.h copy with the kernel sources
> 42252bb99c0eab81 tools headers UAPI: Sync the linux/const.h with the kernel headers
> fcee73a84ed92b77 tools headers UAPI: Sync the i915_drm.h with the kernel sources
> 82fed3e30b2319e5 tools headers UAPI: Sync the drm/drm.h with the kernel sources
> a7919a256f89bea6 tools headers UAPI: Sync the linux/in.h with the kernel sources

Thank you very much!


Thanks,

Yanteng


> ⬢[acme@toolbox perf-tools]$
>
> - Arnaldo
>   
>> * Drop <tools arch s390: Sync the ptrace headers with the kernel sources>
>>     Because ptrace.h has been fixed in other tree, detail see:
>>      selftests/bpf: Remove not used headers
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f265d2aea0d
>>      tools headers: Remove s390 ptrace.h in check-headers.sh
>>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed4da0d3de1e
>>
>> * BTW, I made these patches in the next tree, so most of the warnings haven't appeared in the perf tree yet. :)
>>
>>
>> v1:
>> * When I try to build perf, a lot of warnings are output, let's fix them.
>>
>> Yanteng Si (17):
>>    tools headers UAPI: Sync the linux/in.h with the kernel sources
>>    tools headers UAPI: Sync the linux/prctl.h with the kernel sources
>>    tools headers UAPI: Sync the drm/drm.h with the kernel sources
>>    tools headers UAPI: Sync the i915_drm.h with the kernel sources
>>    tools headers UAPI: Sync the coresight-pmu headers copy with the
>>      kernel sources
>>    tools headers UAPI: Sync the linux/const.h with the kernel headers
>>    tools headers UAPI: Sync the linux/perf_event.h with the kernel
>>      headers
>>    tools include UAPI: Sync the sound/asound.h copy with the kernel
>>      sources
>>    tools headers UAPI: Sync the linux/mman.h with the kernel sources
>>    tools headers UAPI: Sync the unistd with the kernel sources
>>    tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel
>>      sources
>>    tools arch x86: Sync the disabled-features with the kernel sources
>>    tools arch x86: Sync the memcpy_64 with the kernel sources
>>    tools arch x86: Sync the cpufeatures with the kernel sources
>>    tools arch x86: Sync the msr-index.h copy with the kernel sources
>>    tools arch x86: Sync the prctl headers with the kernel sources
>>    tools arch arm64: Sync the perf_regs headers with the kernel sources
>>
>>   tools/arch/arm64/include/uapi/asm/kvm.h       | 36 ++++++++++++
>>   tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++--
>>   tools/arch/x86/include/asm/cpufeatures.h      | 28 +++++++--
>>   .../arch/x86/include/asm/disabled-features.h  | 24 +++++++-
>>   tools/arch/x86/include/asm/msr-index.h        |  2 +
>>   tools/arch/x86/include/uapi/asm/kvm.h         |  3 +
>>   tools/arch/x86/include/uapi/asm/prctl.h       | 20 +++++++
>>   tools/arch/x86/lib/memcpy_64.S                | 35 ++++--------
>>   tools/arch/x86/lib/memset_64.S                | 47 ++++-----------
>>   tools/include/linux/coresight-pmu.h           | 13 -----
>>   tools/include/uapi/asm-generic/unistd.h       |  5 +-
>>   tools/include/uapi/drm/drm.h                  | 57 ++++++++++++++++++-
>>   tools/include/uapi/drm/i915_drm.h             | 25 +++++++-
>>   tools/include/uapi/linux/const.h              |  2 +-
>>   tools/include/uapi/linux/in.h                 |  1 +
>>   tools/include/uapi/linux/kvm.h                | 12 +++-
>>   tools/include/uapi/linux/mman.h               | 14 +++++
>>   tools/include/uapi/linux/perf_event.h         |  3 +-
>>   tools/include/uapi/linux/prctl.h              |  2 +
>>   tools/include/uapi/sound/asound.h             | 14 +++--
>>   .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
>>   .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
>>   22 files changed, 258 insertions(+), 99 deletions(-)
>>
>> -- 
>> 2.31.4
>>

