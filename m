Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B511A23B8
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356519; cv=none; b=nAJsHb4ArkyAEtvWnq1vYYcSYh0kgoInHxWI3Txl2vh/UwTEO5XzJsrP1yRN7ZOxSJQi9MBQl6n/Ah4CaoU6J6WYilmqtjvNvjn43+c37VckRo8g7y241hLP057KR6fAqrzvSqrIp70TspVtLwEV9EtDvolmPwlLVaRUVqb8PaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356519; c=relaxed/simple;
	bh=xm1cEY3KvwKqStAa+Yy2uWmgmfK7o+LQ5iXlmYAgpq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aARkBfpyM3AlRXppwobMLgfiRWtuJdmjHfzjM8FXD5tJfBo/0v3XC5DLCfz6YehOPdu8SR9M2HktcAt/s2ZONbLZsRfNruTjLylgbc5miBzrpJrJbhk8TszxJxzc0WmZgaqZS+na6KSkhKy1F/qVWDlOgG4GMiW7N8y01OGimLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlO1NCGk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlO1NCGk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso11707495e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741356515; x=1741961315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Tt+eT6BYf0saFm5TM2MPjblnQBAgamLURcgDILGg5M=;
        b=ZlO1NCGkc8EvSZw88zB/nWtakrcGazEbFYX0cVJH67E6QFEVASYb3tzvhBu8M99GkV
         J7Q/N0Bw0GxpjOCGGaSu5jD3Ov30AAAuywC1wZ+WgoqxTWuTKaHEPj+KsvwVSCkxKx/q
         /xQUtP7UtTF+BZCMp70PsFr2VdH8hhJqNNtqkKYLEx2XMAiG2b8Ht50c/YQ+T3tYG8yD
         qUu2w14aQpZEQskAigW4KKb+Uedsf84OeEndkQi5G0BDpbZwPlY3AL4nDNI5eMHLMgs8
         ljsHrdU3BdlcCuQxudkcB0mMbkQ0vWweLYmkfYQf3UutJwHgA8x2zoiUzdUUB/vapfCh
         Wn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356515; x=1741961315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tt+eT6BYf0saFm5TM2MPjblnQBAgamLURcgDILGg5M=;
        b=BkkmEfOW6sn4vNFZVm6yFGLLg4zsfmj4E0DGqyYMFu75e+I6bx47Thx8oELAlkSX8J
         cmSdFf9zlbGHYR/ufPxe1WkbnELwQ9RN1pJYjJ1lADrbCMbh27Sv0Yoxb074FUHpTQcz
         90ovGrDJbCE3XxtJzlz7g6EzbxubstJtoPglFUQ2Ynx3Ma7WV+ecKpL90NAexllmD75/
         fj6I2ZNrxwKt7gHXJJP1p0tU32NugxWH/KljpUKVa7LouZOQ9zczWw5dSpDL45AxvNsq
         8jYi/xvJut/vW1FDgPOU1HIUR4EcOTCHl5Y+UZMLDgS2UhGRDycBqhu8UpKZEnFWKFHU
         Oheg==
X-Forwarded-Encrypted: i=1; AJvYcCXy2LK1/RkqVwHpAvD4fEe3IJCVDWXZja+MRPwgN8zkqFSC4nP3619wopKsX313AJAXlf7Sc/V22j3gBWPFgiw1@vger.kernel.org
X-Gm-Message-State: AOJu0YzH08P+SZBzsfSomBVGpl0J7tWhKnUweXIW0rusJV6lWi0K49+F
	4GQmvTkOUHv5grGjm6+iY+hYcDxZs1XsuvxclUSkdBSNtIEa052q/ELfQgTg7R4=
X-Gm-Gg: ASbGncs5J+ca54EqW8dTfJzVdiWk7pGm4Uv6hb59B/u2I45TwzRUzYMEICZ74S3g3KP
	5T5wdIyzS/N3g6pmRKR454kpn8udfkydf7Bnghej5HSrmm3EdSe+rytxhWxv3sKKB955b54HTOr
	/GMd/xgAAPRenJfhhTLbaC9nVtgZLIccgCGKdnWA/9Up6M5307HHj/MpZCcx7/42VR97YCInYGZ
	lQ94cW5PG8eyoIKSd/Z14Odza4fUr3A4OdV2QZAD4z01BUcWmXOhEcqYp2HiK8m+C71y3rcESCf
	BSe4tBvzdYZoHz+aNZquVLhSFgrz71edZg3WwocJUnUAXiPnldKHbA==
X-Google-Smtp-Source: AGHT+IFv3ZWkQBAl7pxVWHLyCnChXW5lJR6L0SvM/U2DM8kLwLDkCWqD/65ICUXzzSG1u4G37rxXMg==
X-Received: by 2002:a05:600c:314f:b0:439:9a5b:87d4 with SMTP id 5b1f17b1804b1-43c5a60e966mr25656295e9.13.1741356514934;
        Fri, 07 Mar 2025 06:08:34 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1037b4sm5481987f8f.92.2025.03.07.06.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:08:34 -0800 (PST)
Message-ID: <12da919e-5674-4b12-a51d-ed767cc0b1ac@linaro.org>
Date: Fri, 7 Mar 2025 14:08:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
 <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/03/2025 9:40 pm, Ian Rogers wrote:
> On Tue, Mar 4, 2025 at 5:50 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Instead of showing multiple line items with the same event name and
>> description, show a single line and concatenate all PMUs that this
>> event can belong to.
>>
>> Don't do it for json output. Machine readable output doesn't need to be
>> minimized, and changing the "Unit" field to a list type would break
>> backwards compatibility.
>>
>> Before:
>>   $ perf list -v
>>   ...
>>   br_indirect_spec
>>         [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
>>   br_indirect_spec
>>         [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a57]
>>
>> After:
>>
>>   $ perf list -v
>>   ...
>>   br_indirect_spec
>>         [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,armv8_cortex_a57]
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/builtin-list.c      |  2 ++
>>   tools/perf/util/pmus.c         | 75 +++++++++++++++++++++++++++++++++++++-----
>>   tools/perf/util/print-events.h |  1 +
>>   3 files changed, 70 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>> index fed482adb039..aacd7beae2a0 100644
>> --- a/tools/perf/builtin-list.c
>> +++ b/tools/perf/builtin-list.c
>> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
>>                  .print_event = default_print_event,
>>                  .print_metric = default_print_metric,
>>                  .skip_duplicate_pmus = default_skip_duplicate_pmus,
>> +               .collapse_events = true
> 
> So collapse_events is put in the callbacks but isn't a callback. I
> think skipping duplicates and collapsing are the same thing, I'd
> prefer it if there weren't two terms for the same thing. If you prefer
> collapsing as a name then default_skip_duplicate_pmus can be
> default_collapse_pmus.
> 

I can use the existing callback and rename it. That does have the effect 
of disabling this behavior in verbose mode which may be useful or may be 
unexpected to some people. But it seems pretty 50/50 so fewer callbacks 
are probably better.

>>          };
>>          const char *cputype = NULL;
>>          const char *unit_name = NULL;
>> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
>>                          .print_event = json_print_event,
>>                          .print_metric = json_print_metric,
>>                          .skip_duplicate_pmus = json_skip_duplicate_pmus,
>> +                       .collapse_events = false
>>                  };
>>                  ps = &json_ps;
>>          } else {
>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>> index 4d60bac2d2b9..cb1b14ade25b 100644
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void *b)
>>          /* Order by PMU name. */
>>          if (as->pmu == bs->pmu)
>>                  return 0;
>> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>> +       ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Order by remaining displayed fields for purposes of deduplication later */
>> +       ret = strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
>> +       if (ret)
>> +               return ret;
>> +       ret = !!as->deprecated - !!bs->deprecated;
>> +       if (ret)
>> +               return ret;
>> +       ret = strcmp(as->desc ?: "", bs->desc ?: "");
>> +       if (ret)
>> +               return ret;
>> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
>>   }
>>
>> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
>> +enum dup_type {
>> +       UNIQUE,
>> +       DUPLICATE,
>> +       SAME_TEXT
>> +};
>> +
>> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struct sevent *b)
>>   {
>>          /* Different names -> never duplicates */
>>          if (strcmp(a->name ?: "//", b->name ?: "//"))
>> -               return false;
>> +               return UNIQUE;
>> +
>> +       /* Duplicate PMU name and event name -> hide completely */
>> +       if (strcmp(a->pmu_name, b->pmu_name) == 0)
>> +               return DUPLICATE;
>> +
>> +       /* Any other different display text -> not duplicate */
>> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
>> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
>> +           a->deprecated != b->deprecated ||
>> +           strcmp(a->desc ?: "", b->desc ?: "") ||
>> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
>> +               return UNIQUE;
>> +       }
>>
>> -       /* Don't remove duplicates for different PMUs */
>> -       return strcmp(a->pmu_name, b->pmu_name) == 0;
>> +       /* Same display text but different PMU -> collapse */
>> +       return SAME_TEXT;
>>   }
>>
>>   struct events_callback_state {
>> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
>>          return 0;
>>   }
>>
>> +static void concat_pmu_names(char *pmu_names, size_t size, const char *a, const char *b)
>> +{
>> +       size_t len = strlen(pmu_names);
>> +       size_t added;
>> +
>> +       if (len)
>> +               added = snprintf(pmu_names + len, size - len, ",%s", b);
>> +       else
>> +               added = snprintf(pmu_names, size, "%s,%s", a, b);
>> +
>> +       /* Truncate with ... */
>> +       if (added > 0 && added + len >= size)
>> +               sprintf(pmu_names + size - 4, "...");
>> +}
>> +
>>   void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
>>   {
>>          struct perf_pmu *pmu;
>> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>          struct events_callback_state state;
>>          bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
>>          struct perf_pmu *(*scan_fn)(struct perf_pmu *);
>> +       char pmu_names[128] = {0};
>>
>>          if (skip_duplicate_pmus)
>>                  scan_fn = perf_pmus__scan_skip_duplicates;
>> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>          qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>          for (int j = 0; j < len; j++) {
>>                  /* Skip duplicates */
>> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &aliases[j + 1]))
>> -                       goto free;
>> +               if (j < len - 1) {
>> +                       enum dup_type dt = pmu_alias_duplicate_type(&aliases[j], &aliases[j + 1]);
>> +
>> +                       if (dt == DUPLICATE) {
>> +                               goto free;
>> +                       } else if (print_cb->collapse_events && dt == SAME_TEXT) {
>> +                               concat_pmu_names(pmu_names, sizeof(pmu_names),
>> +                                                aliases[j].pmu_name, aliases[j+1].pmu_name);
>> +                               goto free;
>> +                       }
>> +               }
> 
> I think a label called 'free' is a little unfortunate given the
> function called free.
> When I did things with sevent I was bringing over previous `perf list`
> code mainly so that the perf list output before and after the changes
> was identical. I wonder if this logic would be better placed in the
> callback like default_print_event which already maintains state
> (last_topic) to optionally print different things. This may better
> encapsulate the behavior rather than the logic being in the PMU code.
> 

Yeah I can have a look at putting it in one of the callbacks. But in the 
end builtin-list.c is the only user of perf_pmus__print_pmu_events() 
anyway so makes you wonder if the whole thing can be moved to 
builtin-list and open coded without the callbackyness.

>>
>>                  print_cb->print_event(print_state,
>>                                  aliases[j].topic,
>> -                               aliases[j].pmu_name,
>> +                               pmu_names[0] ? pmu_names : aliases[j].pmu_name,
>>                                  aliases[j].name,
>>                                  aliases[j].alias,
>>                                  aliases[j].scale_unit,
>> @@ -553,6 +611,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>                                  aliases[j].desc,
>>                                  aliases[j].long_desc,
>>                                  aliases[j].encoding_desc);
> 
> The encoding_desc will have a PMU with the suffix removed as per
> skipping duplicates:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n1954
> So I think something like:
> ```
>    br_mis_pred_retired
>         [Instruction architecturally executed,mispredicted branch. Unit:
>          armv9_cortex_a510,armv9_cortex_a710]
> ```
> Would have an encoding of `armv9_cortex_a510/.../` without the a710
> encoding being present. That said, I'm not sure anyone cares :-)
> 
> Thanks,
> Ian
> 

Ah, in that case I'll disable it for --detailed as well as --json. I 
could compare encoding_desc in pmu_alias_duplicate_type() but they'll 
always be different because of the PMU name, so there's no point. And 
displaying multiple encoding_descs would be fiddly too.

>> +               pmu_names[0] = '\0';
>>   free:
>>                  zfree(&aliases[j].name);
>>                  zfree(&aliases[j].alias);
>> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
>> index 445efa1636c1..e91f9f830a2a 100644
>> --- a/tools/perf/util/print-events.h
>> +++ b/tools/perf/util/print-events.h
>> @@ -27,6 +27,7 @@ struct print_callbacks {
>>                          const char *threshold,
>>                          const char *unit);
>>          bool (*skip_duplicate_pmus)(void *print_state);
>> +       bool collapse_events;
>>   };
>>
>>   /** Print all events, the default when no options are specified. */
>>
>> --
>> 2.34.1
>>

