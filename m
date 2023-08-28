Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15927C83F1C
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Aug 2023 02:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjH1Cmw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 22:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjH1Cmi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 22:42:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE49E188
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 19:42:30 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Cxh+iVCexk+W4cAA--.22447S3;
        Mon, 28 Aug 2023 10:42:29 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSOSCexkYlhlAA--.30260S3;
        Mon, 28 Aug 2023 10:42:27 +0800 (CST)
Message-ID: <06fa9006-243c-4aac-9101-5c66251faa02@loongson.cn>
Date:   Mon, 28 Aug 2023 10:42:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] perf/trace: Use "test -f" instead of "[-f FILE]"
To:     Xi Ruoyao <xry111@xry111.site>, acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
References: <cover.1693040967.git.siyanteng@loongson.cn>
 <b9fc1affbca15cbf18cc23905f823047b4e2f1b6.1693040967.git.siyanteng@loongson.cn>
 <ef11874aca952984d67ad5fb65b7fc1e265e2ef2.camel@xry111.site>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ef11874aca952984d67ad5fb65b7fc1e265e2ef2.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXSOSCexkYlhlAA--.30260S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryfWr1Uur13ur1rXF4UKFX_yoWruF1fpa
        n5Aas8GFW7Xr18Gw1xXFn8XFW5G3s2q3W5ur1kAFZrGr1UGry2qrWDZwnI9F15Xwsaq3yI
        934Dur10vr1IqrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2023/8/26 17:49, Xi Ruoyao 写道:
> On Sat, 2023-08-26 at 17:40 +0800, Yanteng Si wrote:
>> It will be simpler without that extra subshell, so
>> let's use "test -f".
> Sorry for duplicated reply (I replied to v2 minutes ago), but I cannot
> understand this sentence.  [ ... ] has nothing to do with subshell, it's
> just a syntax variant of "test".
>
Sorry, I mean is that "[" is part of the shell builtin test (and a 
synonym for it),

  not a link to the external command /usr/bin/test.

Using the "test" is simpler because it avoids a lot of "[]".


I'm going to write that in v4, agree?


Thanks,

Yanteng

>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   tools/perf/trace/beauty/mmap_flags.sh | 9 ++++++---
>>   tools/perf/trace/beauty/mmap_prot.sh  | 5 +++--
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/trace/beauty/mmap_flags.sh
>> b/tools/perf/trace/beauty/mmap_flags.sh
>> index d035b29fc5ec..6ecdb3c5a99e 100755
>> --- a/tools/perf/trace/beauty/mmap_flags.sh
>> +++ b/tools/perf/trace/beauty/mmap_flags.sh
>> @@ -19,7 +19,8 @@ arch_mman=${arch_header_dir}/mman.h
>>   
>>   printf "static const char *mmap_flags[] = {\n"
>>   regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+
>> )[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
>> -([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
>> +test -f ${arch_mman} && \
>> +grep -E -q $regex ${arch_mman} && \
>>   (grep -E $regex ${arch_mman} | \
>>          sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
>>          xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef
>> MAP_%s\n#define MAP_%s %s\n#endif\n")
>> @@ -28,12 +29,14 @@ grep -E -q $regex ${linux_mman} && \
>>          grep -E -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
>>          sed -r "s/$regex/\2 \1 \1 \1 \2/g" | \
>>          xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef
>> MAP_%s\n#define MAP_%s %s\n#endif\n")
>> -([ ! -f ${arch_mman} ] || grep -E -q
>> '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*'
>> ${arch_mman}) &&
>> +( ! test -f ${arch_mman} || \
>> +grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-
>> generic/mman.*' ${arch_mman}) &&
>>   (grep -E $regex ${header_dir}/mman-common.h | \
>>          grep -E -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
>>          sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
>>          xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef
>> MAP_%s\n#define MAP_%s %s\n#endif\n")
>> -([ ! -f ${arch_mman} ] || grep -E -q
>> '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*'
>> ${arch_mman}) &&
>> +( ! test -f ${arch_mman} || \
>> +grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-
>> generic/mman.h>.*' ${arch_mman}) &&
>>   (grep -E $regex ${header_dir}/mman.h | \
>>          sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
>>          xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef
>> MAP_%s\n#define MAP_%s %s\n#endif\n")
>> diff --git a/tools/perf/trace/beauty/mmap_prot.sh
>> b/tools/perf/trace/beauty/mmap_prot.sh
>> index 49e8c865214b..4436fcd6e861 100755
>> --- a/tools/perf/trace/beauty/mmap_prot.sh
>> +++ b/tools/perf/trace/beauty/mmap_prot.sh
>> @@ -17,12 +17,13 @@ prefix="PROT"
>>   
>>   printf "static const char *mmap_prot[] = {\n"
>>   regex=`printf
>> '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:spac
>> e:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
>> -([ ! -f ${arch_mman} ] || grep -E -q
>> '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*'
>> ${arch_mman}) &&
>> +( ! test -f ${arch_mman} \
>> +|| grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-
>> generic/mman.*' ${arch_mman}) &&
>>   (grep -E $regex ${common_mman} | \
>>          grep -E -vw PROT_NONE | \
>>          sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
>>          xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef
>> ${prefix}_%s\n#define ${prefix}_%s %s\n#endif\n")
>> -[ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman} &&
>> +test -f ${arch_mman} && grep -E -q $regex ${arch_mman} &&
>>   (grep -E $regex ${arch_mman} | \
>>          grep -E -vw PROT_NONE | \
>>          sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \

