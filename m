Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BE95F3
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 00:05:26 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8CxtPBDiG1lbbE+AA--.60598S3;
	Mon, 04 Dec 2023 16:05:23 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxH91BiG1lbQ5UAA--.56868S3;
	Mon, 04 Dec 2023 16:05:22 +0800 (CST)
Message-ID: <330725e4-cc4e-49f4-bf8c-f12da92beff5@loongson.cn>
Date: Mon, 4 Dec 2023 16:05:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] objtool/perf: Fix malloc call for new -Walloc-size
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 Sun Haiyong <sunhaiyong@loongson.cn>
References: <20231202023256.3398906-1-siyanteng@loongson.cn>
 <CAM9d7cjFhVag8nTjtkJvz63vgm+-NbKRhf1Z7OVRWUfgLWCgVA@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAM9d7cjFhVag8nTjtkJvz63vgm+-NbKRhf1Z7OVRWUfgLWCgVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxH91BiG1lbQ5UAA--.56868S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4rKr4UZry5Ar4DGryrXwc_yoW8Xr4fpF
	s7Ca4Yya15JF1UAa1IyFZaqF1UW397WF9Yv3y0qw1q9rsrWwnrtasIqFyY9FyxZr48Ka10
	kFyvgr45AF4rAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2023/12/3 08:56, Namhyung Kim 写道:
> Hello,
>
> On Fri, Dec 1, 2023 at 6:33 PM Yanteng Si <siyanteng@loongson.cn> wrote:
>> From: Sun Haiyong <sunhaiyong@loongson.cn>
>>
>> GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
>> like:
>> ```
>> builtin-top.c: In function ‘prompt_integer’:
>> builtin-top.c:360:21: error: allocation of insufficient size ‘0’ for
>> type ‘char’ with size ‘1’ [-Werror=alloc-size]
>>    360 |         char *buf = malloc(0), *p;
>>        |                     ^~~~~~
>>
>> ```
>>
>> So, just cast type to char, silence this error.
> No, please do not.  I'm not sure if it silences the error.
> The buf is to be passed to getline() so you can set it to
> NULL instead.
>
>    char *buf = NULL, *p;

OK!


Thanks,

Yanteng

>
> Thanks,
> Namhyung
>
>> Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   tools/perf/builtin-top.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index ea8c7eca5eee..29191d966522 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -357,7 +357,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
>>
>>   static void prompt_integer(int *target, const char *msg)
>>   {
>> -       char *buf = malloc(0), *p;
>> +       char *buf = (char *)malloc(0), *p;
>>          size_t dummy = 0;
>>          int tmp;
>>
>> --
>> 2.42.1
>>

