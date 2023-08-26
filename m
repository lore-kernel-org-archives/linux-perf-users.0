Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D145C83F16
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Aug 2023 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHZJT3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjHZJT2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Aug 2023 05:19:28 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60CA171A
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Aug 2023 02:19:24 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8DxVuiaw+lkKiMcAA--.21945S3;
        Sat, 26 Aug 2023 17:19:22 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax98yXw+lkgR5kAA--.26083S3;
        Sat, 26 Aug 2023 17:19:20 +0800 (CST)
Message-ID: <e8dc81f6-2a2b-4647-9835-3fdeee6a1be1@loongson.cn>
Date:   Sat, 26 Aug 2023 17:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf/tools: Allow to use cpuinfo on LoongArch
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
References: <cover.1692962043.git.siyanteng@loongson.cn>
 <db968a186a10e4629fe10c26a1210f7126ad41ec.1692962043.git.siyanteng@loongson.cn>
 <ZOiwbNrwaodRfbSN@kernel.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZOiwbNrwaodRfbSN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax98yXw+lkgR5kAA--.26083S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWrWFWkZw4rCrWDtryktFc_yoWrWr4fpr
        Wqkay3Kw4xKay5t3Z7trs5uan2qw43Jw47WF4DKr1DZry29r9rG34IqF4Y9rWxX3W3Ww1a
        kr4UJrnrZFyrXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
        IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


在 2023/8/25 21:45, Arnaldo Carvalho de Melo 写道:
> Em Fri, Aug 25, 2023 at 07:28:02PM +0800, Yanteng Si escreveu:
>> Define these macros so that the CPU name can be displayed
>> when running perf report and perf timechart.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   tools/perf/util/header.c    | 2 ++
>>   tools/perf/util/svghelper.c | 5 ++++-
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 52fbf526fe74..c6e19192bd28 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -456,6 +456,8 @@ static int write_cpudesc(struct feat_fd *ff,
>>   #define CPUINFO_PROC	{ "Processor", }
>>   #elif defined(__xtensa__)
>>   #define CPUINFO_PROC	{ "core ID", }
>> +#elif defined(__loongarch__)
>> +#define CPUINFO_PROC	{ "Model Name", }
>>   #else
>>   #define CPUINFO_PROC	{ "model name", }
>>   #endif
>> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
>> index 5c62d3118c41..5744a3036b01 100644
>> --- a/tools/perf/util/svghelper.c
>> +++ b/tools/perf/util/svghelper.c
>> @@ -331,7 +331,10 @@ static char *cpu_model(void)
>>   	file = fopen("/proc/cpuinfo", "r");
>>   	if (file) {
>>   		while (fgets(buf, 255, file)) {
>> -			if (strstr(buf, "model name")) {
>> +			if (strcasestr(buf, "Model Name")) {
>> +				strlcpy(cpu_m, &buf[13], 255);
>> +				break;
>> +			} else if (strcasestr(buf, "model name")) {
>>   				strlcpy(cpu_m, &buf[13], 255);
> Hey, the point of strcasestr() is to do a case _insensitive_ substring
> search, so all we need is:
>
>> --- a/tools/perf/util/svghelper.c
>> +++ b/tools/perf/util/svghelper.c
>> @@ -331,7 +331,10 @@ static char *cpu_model(void)
>>   	file = fopen("/proc/cpuinfo", "r");
>>   	if (file) {
>>   		while (fgets(buf, 255, file)) {
>> -			if (strstr(buf, "model name")) {
>> +			if (strcasestr(buf, "model Name")) {
>>   				strlcpy(cpu_m, &buf[13], 255);
>>   				break;
Thanks a million！
> Right? I'm doing this change while applying your patches.
>
> See:
>
> [acme@five c]$ grep -m1 "model name" /proc/cpuinfo | ./strcasestr "Model NAME"
> needle=Model NAME
> haystack=model name	: AMD Ryzen 9 5950X 16-Core Processor
>
> found: model name	: AMD Ryzen 9 5950X 16-Core Processor
> found[13..]: AMD Ryzen 9 5950X 16-Core Processor
> [acme@five c]$ grep -m1 "model name" /proc/cpuinfo | ./strcasestr "model name"
> needle=model name
> haystack=model name	: AMD Ryzen 9 5950X 16-Core Processor
>
> found: model name	: AMD Ryzen 9 5950X 16-Core Processor
> found[13..]: AMD Ryzen 9 5950X 16-Core Processor
> [acme@five c]$ grep -m1 "model name" /proc/cpuinfo | ./strcasestr "Model Name"
> needle=Model Name
> haystack=model name	: AMD Ryzen 9 5950X 16-Core Processor
>
> found: model name	: AMD Ryzen 9 5950X 16-Core Processor
> found[13..]: AMD Ryzen 9 5950X 16-Core Processor
> acme@five c]$ echo "Model Name : AMD Ryzen 9 5950X 16-Core Processor" | ./strcasestr "model name"
> needle=model name
> haystack=Model Name	: AMD Ryzen 9 5950X 16-Core Processor
>
> found: Model Name	: AMD Ryzen 9 5950X 16-Core Processor
> found[13..]: AMD Ryzen 9 5950X 16-Core Processor
> [acme@five c]$ echo "MODEL NAME : AMD Ryzen 9 5950X 16-Core Processor" | ./strcasestr "model name"
> needle=model name
> haystack=MODEL NAME	: AMD Ryzen 9 5950X 16-Core Processor
>
> found: MODEL NAME	: AMD Ryzen 9 5950X 16-Core Processor
> found[13..]: AMD Ryzen 9 5950X 16-Core Processor
> [acme@five c]$
> [acme@five c]$ cat strcasestr.c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <string.h>
>
> int main(int argc, char *argv[])I will send v3
> {
> 	char *needle = argv[1], haystack[128], *found;
> 	printf("needle=%s\n", needle);
> 	fgets(haystack, sizeof(haystack), stdin);
> 	printf("haystack=%s\n", haystack);
> 	found = strcasestr(haystack, needle);
> 	printf("found: %s", found);
> 	printf("found[13..]: %s", found + 13);
> 	return 0;
> }
> [acme@five c]$

I see. I will send v3.


Thanks,

Yanteng


