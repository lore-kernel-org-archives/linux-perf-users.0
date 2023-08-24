Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B34C3DA66
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 02:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbjHXCXu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 22:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjHXCXj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 22:23:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA6A171E
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 19:23:18 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8BxbOoFv+Zkul8bAA--.28569S3;
        Thu, 24 Aug 2023 10:23:01 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM4Bv+ZksehhAA--.41658S3;
        Thu, 24 Aug 2023 10:22:58 +0800 (CST)
Message-ID: <51632871-2e84-4c53-b4c0-647aea5c49dc@loongson.cn>
Date:   Thu, 24 Aug 2023 10:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf/trace: Fix mmap_flags for archs use generic
 mman.h
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
References: <cover.1692694595.git.siyanteng@loongson.cn>
 <03ddc1c0e01518df63aac88e561cd0ec3c1e0028.1692694595.git.siyanteng@loongson.cn>
 <ZOT4Tuc6JGrbDqFW@kernel.org>
 <8ead439a-63aa-434e-9d1e-3b1b05b6347b@loongson.cn>
 <ZOXvUbQL67bdWfNz@kernel.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZOXvUbQL67bdWfNz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM4Bv+ZksehhAA--.41658S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGryfXr47ZFy5Gr1fCrW8Xwc_yoW5Gr47pr
        4rAayDGa1DXr15tw1IvFZ0qFs8K3sFqFy5uF1DWrs7GF98KF17Gr93AF4a9FyrXws8J3y2
        9rWUur18KF4kZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


在 2023/8/23 19:36, Arnaldo Carvalho de Melo 写道:
> Em Wed, Aug 23, 2023 at 03:11:01PM +0800, Yanteng Si escreveu:
>> 在 2023/8/23 02:02, Arnaldo Carvalho de Melo 写道:
>>> Em Tue, Aug 22, 2023 at 05:32:06PM +0800, Yanteng Si escreveu:
>>>> Silence this warning:
>>>>
>>>> grep: /root/linux-next/tools/arch/xxxxx/include/uapi/asm//mman.h:
>>>> No such file or directory
>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>> ---
>>>>    tools/perf/trace/beauty/mmap_flags.sh | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
>>>> index 3022597c8c17..d035b29fc5ec 100755
>>>> --- a/tools/perf/trace/beauty/mmap_flags.sh
>>>> +++ b/tools/perf/trace/beauty/mmap_flags.sh
>>>> @@ -19,7 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
>>>>    printf "static const char *mmap_flags[] = {\n"
>>>>    regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
>>>> -grep -E -q $regex ${arch_mman} && \
>>>> +([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
>>>>    (grep -E $regex ${arch_mman} | \
>>>>    	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
>>>>    	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
>>> Humm, wouldn't this be simpler without that extra subshell? Like this:
>>>
>>> diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
>>> index 3022597c8c178f21..0ac1886a83b5aceb 100755
>>> --- a/tools/perf/trace/beauty/mmap_flags.sh
>>> +++ b/tools/perf/trace/beauty/mmap_flags.sh
>>> @@ -19,6 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
>>>    printf "static const char *mmap_flags[] = {\n"
>>>    regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
>>> +test -f ${arch_mman} && \
>> The following lines have already used the [ ! -f ${arch_mman}, so let's stay
>> consistent？
> Well, we can make it consistent by simplifying the other places where
> the long, equivalent test is being done, which I think is the way to go,
> agreed?

I agree, but this is not suitable to be done in the fix patch, I will 
split it out and make a new patch.


Thanks

Yanteng

>
> - Arnaldo
>   
>> Thanks,
>>
>> Yanteng
>>
>>>    grep -E -q $regex ${arch_mman} && \
>>>    (grep -E $regex ${arch_mman} | \
>>>    	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \

