Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8B2C3258
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828218; cv=none; b=DeyWqyGwBhi5MQF7XfY4QxxYmbMmf6hZvDKsIa+9bAu23KLNX1bEBQZmFhQCoto4dsFze8LcHluBzjAolhaFcBlPFbPGYnw6iAfy2xbgpJvqswIGFCvkh7PfLFsSFusUa5XbJm5hslXJyyPvb4BJnerW6BuiXKuV4vH4XVIMmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828218; c=relaxed/simple;
	bh=xkurHUrHiDvxiaLEkzB8GFBV/iCz22WvC9ERFE1fsyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzqZtUglA5FZKE18bLIXUPKWxNH7/4WWbZCEUoqdYCI3FFNukajQxhWzj3Dw/OYz01/yYoeh1kiV67zVq5TjNiYpOV2NebPu9jSiH8cL+WQp0bsTrEhPTuw/KWUiv+m6kBGskuWRzkuN94UCrUqwAdiDQXXu40DR8LuE5rnFYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEkE620G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEkE620G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f755aso46053155e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759828214; x=1760433014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A5grJalUNQTGqrKuVDzibQGrnaKKNODDxPG9phNRc4=;
        b=VEkE620GO+P0p3Kl0IhNLbTLGXNiylhm8Uzo2xfxp8/jOR0WuAqG3sUNL8PjADOo20
         oTHtrtITiaAt19/OqyVmJ6KL88ECRkSOP+WeDv45m32kT5hFYQzz+w/7q75P1GLpr+fW
         bGB898LsHqpTqCVNcuPixVkdPeHqcpANCed3u9dOjEY3Fuj/Yl/WV2PsLoNajvO9lp/5
         cucyxZmvPN5yNmTz/o2K26DMspSXS1xs0xnlDnA7VWMX8C0NSwdjiAgGwy+EAvu4i+hZ
         Z1FORkaW6COnrX75lZiC8o3Tg0iJqddDh0s4CQcp/s8Jc+No+lUWATBmpgQNZQdTAPp3
         CFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828214; x=1760433014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1A5grJalUNQTGqrKuVDzibQGrnaKKNODDxPG9phNRc4=;
        b=uzm9xCfi6MbwuzwpkzeFV5gu49Yv3uvdQU4fGl11bgSCR61c1xj5l4T/mZbWoTQlRk
         fDxTC/zk7Bym/RSMURPjXG7Vuf+qNboDheu3n06aUl2cV34K35c/kcOhQtWJAz0ZrIkG
         veXAkJ20loBWlrAveBf1YFVQaq0MWf6nExcfDE1K2+F0XJXt3rCYV1RLLhQl4DUEtnVx
         LlOx679m6FV3veSvHzt9ku+BNv6KDehgr8ysJ/6OgzP9Ln/B8Yt9ueuRVoNhW9MT+8UP
         V5Bnqs3e5rk0ZTp80jv92pPgSNu2VosfNV4K6OG5Eo6jLLDTOTFFGOCYWAw+mvQLuzyd
         UJyg==
X-Forwarded-Encrypted: i=1; AJvYcCVZKTEjDUpl4iPXC+DN0rID25XtmHq6aBrEUcFH9HpuOrToOzNs8T450ze1MB+lcj7Lf7bq0OgFNDeN7KZcXEvc@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFUDMCg3G9pmEnSWmp8ZEtwIjJ6XWtpZUGWaqAMOFQO/NoaJC
	hfAkLlAQ7Gmok39xDHAPuleAW8bUeNxZcx/diG1wPRJPx/gAWY+Cr7SdxO7j3Fn8Yq4=
X-Gm-Gg: ASbGnctU9hQKRGtgiG71AZ6utxkrjC7wOWzTq5bcAtF2sNvb98FhKG3/2SFI6J21H4g
	QQbfVRmoZJl54Y/3hFBhPt/bvMv48Cqm17Ow+7PRS8i6fbJNF30Mzc9fsiAEwxXx7FRCyDP4CWd
	5DMvBXkZgEOOzpvZZGx8jfJx8UCog93oSpdwf6RFfdiuQGj0p+UVJBd8zqh8J8edW5DqgbJ0bBS
	1kC5kWUD3zQsokeH60JJy92nvbbtBuCJAJRt5si6KKFIXoE58eioS3q1dw4RfXMoTIQr7r34Ng4
	j7vpEweTfxRPOG7x9l8wTeGisWim2NoBe7Jc0+F31tay69MdSLGEC0AI9MvWMOmBNOh1LIfW/2p
	OO6qntSyi2BRR9T0PWRQtygxNdjx7eIzizET/nU2w7nRMPxEkSBTpcnQP
X-Google-Smtp-Source: AGHT+IGMFiVKJp39q+pMns0W0NskfICt/r26mga3cpyM8uAPmyuedwXmOqFinHFTEHYx9lKQOrElfw==
X-Received: by 2002:a05:600d:41f3:b0:46e:4a78:dea9 with SMTP id 5b1f17b1804b1-46e71145dc7mr133486085e9.17.1759828213740;
        Tue, 07 Oct 2025 02:10:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c396esm292761625e9.8.2025.10.07.02.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:10:13 -0700 (PDT)
Message-ID: <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>
Date: Tue, 7 Oct 2025 10:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/10/2025 4:21 pm, Ian Rogers wrote:
> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> wrote:
>>
>> We already only test each kcore map once, but on slow systems
>> (particularly with network filesystems) even the non-kcore maps are
>> slow. The test can test the same objump output over and over which only
>> wastes time. Generalize the skipping mechanism to track all DSOs and
>> addresses so that each section is only tested once.
>>
>> On a fully loaded Arm Juno (simulating a parallel Perf test run) with a
>> network filesystem, the original runtime is:
>>
>>    real  1m51.126s
>>    user  0m19.445s
>>    sys   1m15.431s
>>
>> And the new runtime is:
>>
>>    real  0m48.873s
>>    user  0m8.031s
>>    sys   0m32.353s
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
>> ---
>>   tools/perf/tests/code-reading.c | 119 ++++++++++++++++++++++++++++------------
>>   1 file changed, 85 insertions(+), 34 deletions(-)
>>
>> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
>> index 9c2091310191..4c9fbf6965c4 100644
>> --- a/tools/perf/tests/code-reading.c
>> +++ b/tools/perf/tests/code-reading.c
>> @@ -2,6 +2,7 @@
>>   #include <errno.h>
>>   #include <linux/kconfig.h>
>>   #include <linux/kernel.h>
>> +#include <linux/rbtree.h>
>>   #include <linux/types.h>
>>   #include <inttypes.h>
>>   #include <stdlib.h>
>> @@ -39,11 +40,64 @@
>>   #define BUFSZ  1024
>>   #define READLEN        128
>>
>> -struct state {
>> -       u64 done[1024];
>> -       size_t done_cnt;
>> +struct tested_section {
>> +       struct rb_node rb_node;
>> +       u64 addr;
>> +       char path[PATH_MAX];
>>   };
>>
>> +static bool tested_code_insert_or_exists(const char *path, u64 addr,
>> +                                        struct rb_root *tested_sections)
>> +{
>> +       struct rb_node **node = &tested_sections->rb_node;
>> +       struct rb_node *parent = NULL;
>> +       struct tested_section *data;
>> +
>> +       while (*node) {
>> +               int cmp;
>> +
>> +               parent = *node;
>> +               data = rb_entry(*node, struct tested_section, rb_node);
>> +               cmp = strcmp(path, data->path);
>> +               if (!cmp) {
>> +                       if (addr < data->addr)
>> +                               cmp = -1;
>> +                       else if (addr > data->addr)
>> +                               cmp = 1;
>> +                       else
>> +                               return true; /* already tested */
>> +               }
>> +
>> +               if (cmp < 0)
>> +                       node = &(*node)->rb_left;
>> +               else
>> +                       node = &(*node)->rb_right;
>> +       }
>> +
>> +       data = zalloc(sizeof(*data));
>> +       if (!data)
>> +               return true;
>> +
>> +       data->addr = addr;
>> +       strlcpy(data->path, path, sizeof(data->path));
> 
> nit: perhaps strdup rather than having 4kb per tested_section.
> 
> Thanks,
> Ian
> 

Oh yeah that would have been better, not sure why I didn't do it that 
way. Although the max sections I saw was around 50, and it's usually a 
lot less so it's probably not worth the churn to change it now that 
Arnaldo's applied it?

Thanks
James

>> +       rb_link_node(&data->rb_node, parent, node);
>> +       rb_insert_color(&data->rb_node, tested_sections);
>> +       return false;
>> +}
>> +
>> +static void tested_sections__free(struct rb_root *root)
>> +{
>> +       while (!RB_EMPTY_ROOT(root)) {
>> +               struct rb_node *node = rb_first(root);
>> +               struct tested_section *ts = rb_entry(node,
>> +                                                    struct tested_section,
>> +                                                    rb_node);
>> +
>> +               rb_erase(node, root);
>> +               free(ts);
>> +       }
>> +}
>> +
>>   static size_t read_objdump_chunk(const char **line, unsigned char **buf,
>>                                   size_t *buf_len)
>>   {
>> @@ -316,13 +370,15 @@ static void dump_buf(unsigned char *buf, size_t len)
>>   }
>>
>>   static int read_object_code(u64 addr, size_t len, u8 cpumode,
>> -                           struct thread *thread, struct state *state)
>> +                           struct thread *thread,
>> +                           struct rb_root *tested_sections)
>>   {
>>          struct addr_location al;
>>          unsigned char buf1[BUFSZ] = {0};
>>          unsigned char buf2[BUFSZ] = {0};
>>          size_t ret_len;
>>          u64 objdump_addr;
>> +       u64 skip_addr;
>>          const char *objdump_name;
>>          char decomp_name[KMOD_DECOMP_LEN];
>>          bool decomp = false;
>> @@ -350,6 +406,18 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>>                  goto out;
>>          }
>>
>> +       /*
>> +        * Don't retest the same addresses. objdump struggles with kcore - try
>> +        * each map only once even if the address is different.
>> +        */
>> +       skip_addr = dso__is_kcore(dso) ? map__start(al.map) : al.addr;
>> +       if (tested_code_insert_or_exists(dso__long_name(dso), skip_addr,
>> +                                        tested_sections)) {
>> +               pr_debug("Already tested %s @ %#"PRIx64" - skipping\n",
>> +                        dso__long_name(dso), skip_addr);
>> +               goto out;
>> +       }
>> +
>>          pr_debug("On file address is: %#"PRIx64"\n", al.addr);
>>
>>          if (len > BUFSZ)
>> @@ -387,24 +455,6 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>>                  goto out;
>>          }
>>
>> -       /* objdump struggles with kcore - try each map only once */
>> -       if (dso__is_kcore(dso)) {
>> -               size_t d;
>> -
>> -               for (d = 0; d < state->done_cnt; d++) {
>> -                       if (state->done[d] == map__start(al.map)) {
>> -                               pr_debug("kcore map tested already");
>> -                               pr_debug(" - skipping\n");
>> -                               goto out;
>> -                       }
>> -               }
>> -               if (state->done_cnt >= ARRAY_SIZE(state->done)) {
>> -                       pr_debug("Too many kcore maps - skipping\n");
>> -                       goto out;
>> -               }
>> -               state->done[state->done_cnt++] = map__start(al.map);
>> -       }
>> -
>>          objdump_name = dso__long_name(dso);
>>          if (dso__needs_decompress(dso)) {
>>                  if (dso__decompress_kmodule_path(dso, objdump_name,
>> @@ -471,9 +521,9 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>>          return err;
>>   }
>>
>> -static int process_sample_event(struct machine *machine,
>> -                               struct evlist *evlist,
>> -                               union perf_event *event, struct state *state)
>> +static int process_sample_event(struct machine *machine, struct evlist *evlist,
>> +                               union perf_event *event,
>> +                               struct rb_root *tested_sections)
>>   {
>>          struct perf_sample sample;
>>          struct thread *thread;
>> @@ -494,7 +544,8 @@ static int process_sample_event(struct machine *machine,
>>                  goto out;
>>          }
>>
>> -       ret = read_object_code(sample.ip, READLEN, sample.cpumode, thread, state);
>> +       ret = read_object_code(sample.ip, READLEN, sample.cpumode, thread,
>> +                              tested_sections);
>>          thread__put(thread);
>>   out:
>>          perf_sample__exit(&sample);
>> @@ -502,10 +553,11 @@ static int process_sample_event(struct machine *machine,
>>   }
>>
>>   static int process_event(struct machine *machine, struct evlist *evlist,
>> -                        union perf_event *event, struct state *state)
>> +                        union perf_event *event, struct rb_root *tested_sections)
>>   {
>>          if (event->header.type == PERF_RECORD_SAMPLE)
>> -               return process_sample_event(machine, evlist, event, state);
>> +               return process_sample_event(machine, evlist, event,
>> +                                           tested_sections);
>>
>>          if (event->header.type == PERF_RECORD_THROTTLE ||
>>              event->header.type == PERF_RECORD_UNTHROTTLE)
>> @@ -525,7 +577,7 @@ static int process_event(struct machine *machine, struct evlist *evlist,
>>   }
>>
>>   static int process_events(struct machine *machine, struct evlist *evlist,
>> -                         struct state *state)
>> +                         struct rb_root *tested_sections)
>>   {
>>          union perf_event *event;
>>          struct mmap *md;
>> @@ -537,7 +589,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
>>                          continue;
>>
>>                  while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>> -                       ret = process_event(machine, evlist, event, state);
>> +                       ret = process_event(machine, evlist, event, tested_sections);
>>                          perf_mmap__consume(&md->core);
>>                          if (ret < 0)
>>                                  return ret;
>> @@ -637,9 +689,7 @@ static int do_test_code_reading(bool try_kcore)
>>                          .uses_mmap   = true,
>>                  },
>>          };
>> -       struct state state = {
>> -               .done_cnt = 0,
>> -       };
>> +       struct rb_root tested_sections = RB_ROOT;
>>          struct perf_thread_map *threads = NULL;
>>          struct perf_cpu_map *cpus = NULL;
>>          struct evlist *evlist = NULL;
>> @@ -773,7 +823,7 @@ static int do_test_code_reading(bool try_kcore)
>>
>>          evlist__disable(evlist);
>>
>> -       ret = process_events(machine, evlist, &state);
>> +       ret = process_events(machine, evlist, &tested_sections);
>>          if (ret < 0)
>>                  goto out_put;
>>
>> @@ -793,6 +843,7 @@ static int do_test_code_reading(bool try_kcore)
>>          perf_thread_map__put(threads);
>>          machine__delete(machine);
>>          perf_env__exit(&host_env);
>> +       tested_sections__free(&tested_sections);
>>
>>          return err;
>>   }
>>
>> ---
>> base-commit: a22d167ed82505f770340c3a7c257c04ba24dac9
>> change-id: 20251006-james-perf-object-code-reading-9646e486d595
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

