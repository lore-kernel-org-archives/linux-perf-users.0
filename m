Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD7EE49AF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 07:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHWHLu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjHWHLt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 03:11:49 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63CE8FB
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 00:11:47 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8BxJvExseVksSIbAA--.55934S3;
        Wed, 23 Aug 2023 15:11:45 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ80vseVk7BphAA--.38222S3;
        Wed, 23 Aug 2023 15:11:45 +0800 (CST)
Message-ID: <87932484-40c3-429c-b3be-6c28313dc3bd@loongson.cn>
Date:   Wed, 23 Aug 2023 15:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf/tools: Allow to use cpuinfo on loongarch
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
References: <cover.1692694595.git.siyanteng@loongson.cn>
 <fbb71a04bf3b19b1d1b239e464c1acbcc572e9a8.1692694595.git.siyanteng@loongson.cn>
 <ZOT1c/MRwkaPaqf1@kernel.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZOT1c/MRwkaPaqf1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ80vseVk7BphAA--.38222S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw43AFW7Ar43Gw1UWF1UXFc_yoW8CF13pr
        WkCayUta1UGF90kasavwn0qF43Xrs2qFy3Gr4DKw15Zrn2kr17KFyxXrs8KFW7Z34qgw1I
        vr1DWr1qvFW8trXCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
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
        0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


在 2023/8/23 01:50, Arnaldo Carvalho de Melo 写道:
> Em Tue, Aug 22, 2023 at 05:32:07PM +0800, Yanteng Si escreveu:
>> Define these macros so that the CPU name can be displayed
>> when running perf report and perf timechart.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   tools/perf/util/header.c    | 2 ++
>>   tools/perf/util/svghelper.c | 7 ++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
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
>> index 5c62d3118c41..0259715ad6a6 100644
>> --- a/tools/perf/util/svghelper.c
>> +++ b/tools/perf/util/svghelper.c
>> @@ -322,6 +322,11 @@ void svg_waiting(int Yslot, int cpu, u64 start, u64 end, const char *backtrace)
>>   
>>   static char *cpu_model(void)
>>   {
>> +#if defined(__loongarch__)
>> +#define CPU_TYPE	"Model Name"
>> +#else
>> +#define CPU_TYPE	"model name"
>> +#endif
>>   	static char cpu_m[255];
>>   	char buf[256];
>>   	FILE *file;
>> @@ -331,7 +336,7 @@ static char *cpu_model(void)
>>   	file = fopen("/proc/cpuinfo", "r");
>>   	if (file) {
>>   		while (fgets(buf, 255, file)) {
>> -			if (strstr(buf, "model name")) {
>> +			if (strstr(buf, CPU_TYPE)) {
> Isn't it better to just switch to strcasestr()?

OK!


Thanks,

Yanteng

>
> - Arnaldo
>
>>   				strlcpy(cpu_m, &buf[13], 255);
>>   				break;
>>   			}
>> -- 
>> 2.31.4
>>

