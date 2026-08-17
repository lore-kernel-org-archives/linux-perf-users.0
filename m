Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D34449992
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982283; cv=none; b=syQJgmJPzWgCMj3o4Z/3Oi61+8zVzgwza0dw6AdBp96fEVpKrM9iw3Job+5iZM9yiT5Rvw48kXIFdvB1J8iriOh/R3sq7gQbim+k0NmPR1ybHHJ0yvtcuRL8KAklv3OAw/URa7ama1FR6zqcguZROm8wPJO1tEj0CHrU4ZMdE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982283; c=relaxed/simple;
	bh=n/fHe03KdJDf8h9CK7pfXeHrlRpg6VLPvk/IjXsxbEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7RB1WGZXutOZYjXk5hoOX3eItEtQivV2B2xCX7l7YjjcynFUfQ2F+2qzjn2YAzgGGkYx2ZpXxo4thiw8aHWl842PrroS/6dOv+Ziw7N9VZyw8P9Bi/2lDfgkDK37Hyk7iemjhpWUXc0nOkKwPOr7Q/Yvit2xokBX05bhYoYzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIeuAQFi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIeuAQFi"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f71156e1aso1531878f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786982279; x=1787587079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjMDqxlK+BRn8Js0eyrOoPLsp9IBlPLG3MAMIL5r6gQ=;
        b=WIeuAQFiiO8FIYem7l0Dn9TLsTyfwG9h3OnPGxC75pdLOUMnXxB/LtAKwse6UT03bq
         4JYK7aQGeweJ6xqPQvS9P3gajMO5jCCQ6J1GtFGgs2m3hbBpyhVrfejQs5AKJcard5oj
         AqVdCK7HNt5gk+tXngNQs52Ktn2uKO30ifTgtKEK3TzEtTZZtv8e4OG9iV9PNZWP4iao
         I1am8A+Vu9EPrE3Q2xxCe2Qlkp6S9g/4YICj6Cb7kWcNlje50+SIgblLPeicLTMYrYCH
         uQQQhFcTSKxK/+uJXM+FK+a4KxFuzzk13SsGZhF+qLRQfpJc2RAVNy1SuVK/YQD6+bmK
         OS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982279; x=1787587079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjMDqxlK+BRn8Js0eyrOoPLsp9IBlPLG3MAMIL5r6gQ=;
        b=EBFt6KtAh7F9bsljSCDUEdp7B39XkoUHupzAn82LqbCDs8TBoi7iwf7BstMqiEqYM3
         Z49AefK7tPLG+7OJ60yUYfdDzNd0L1URZJVrGvotU2D25Y5zW/QwcnUtUYXaV4q7Zh8v
         tGjm8mByty4YT8eDY5tPBzuN2+MzZH1MbeqSXprpB0PEQe1AUQ5fkfx1OPeOQcEGnDn+
         XqiIw0peXr/LWMJ8zZTqOCR+ggqnqLr/pwDYDgZde6MFu707TxRRUTqvW02GGUSSCmmx
         YM4K2bJduQnZV3pl4wk3KdszQv3JwI/Hs07GcbbQjK/NU6jFX6sOuYN0xzOulPjC5znH
         WGvg==
X-Forwarded-Encrypted: i=1; AHgh+RrC8F2IDEvOCMtExYcAMQMtWbgbBHc/A+U93KKLbRpUygGElobtd+XopSXH32AnS7WHld8dlpP9nVvz6NSUOWTL@vger.kernel.org
X-Gm-Message-State: AOJu0YzADSYIf/IeVubxXNlXzYJ/V4B3t7V77T/todxgKA8KrEYLqWhM
	YQqf9COImi2rN+c8lIRTpbj112YhmwZsubMydf5g36HYvQb9fSGB+sKcqju9YgEn1d0=
X-Gm-Gg: AR+sD11vhzNAbdxzCYQNt4lfyB/M3FidOeW/MNPT0LV3rgBBvSOZQnCP9XUAKxRk47r
	c/O5lyLbM6Tam6o3RBT4HQzFdMnDYVWpbgexg1JoBPWwXB7FQM13b6eksuc28O73lKKA30RY2C+
	uC6///WxrlcY2255km4H7D7uuVwRGubm+K10pltwVPKjqaQsbY87pOfJWQJQB5ax1Wx3RSDDqmd
	R0kP7oc3NrK4yykP8q35Do9hdYP4cRT/dZjCfrWmt1JSwIXkRsZWYYF4kwGNELjA2gELOVbcAlx
	EEQjLQwnwfqyBNSpXbtyGQjsBCHN/xGm71H0+mskymbn4FLHnNGcZttWJkmtZHqVko/8sEb85mt
	tNBqiuoMKy5hjz6eeA6yjr7NUkC9CWtZZErguRTtl5MjaZvREGOPG7YzyacOArbFIUTMMQwO7C0
	Y2mgB0TCgNzTY+tfyt4VTe+obwIv3HlKxOj3xrSNEO8vKK9f6mJsmKfhdNBee+tGcmGQ==
X-Received: by 2002:a05:6000:41ed:b0:482:a9d6:a803 with SMTP id ffacd0b85a97d-482a9d6a821mr545065f8f.30.1786982279197;
        Mon, 17 Aug 2026 08:57:59 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7bc6esm5505157f8f.19.2026.08.17.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:57:58 -0700 (PDT)
Message-ID: <6177272a-e9a0-4f82-9e0b-17e60fb49ca1@linaro.org>
Date: Mon, 17 Aug 2026 16:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf tests: mmap-basic: fix user rdpmc detection logic
To: Michael Petlan <mpetlan@redhat.com>, Qiao Zhao <qzhao@redhat.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, leo.yan@linux.dev,
 namhyung@kernel.org, acme@kernel.org
References: <20260302055557.3708296-1-qzhao@redhat.com>
 <CAATMXfmK73HSM=DZMBHGcoqu=79ftqhYNNtcpUGF-76Ydp9KMA@mail.gmail.com>
 <CAATMXfnDxRdLJRo9LEiM6iGXooQGUFWrj+2=rd8=KL7GUK9Rbw@mail.gmail.com>
 <4181fd3b-1e22-4884-c349-63c5abfb814d@redhat.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <4181fd3b-1e22-4884-c349-63c5abfb814d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/08/2026 11:43, Michael Petlan wrote:
> Hi James and Ian,
> 
> what do you think about the v3? Can we get it merged? Thanks.
> 
> Regards,
> Michael
> 

Hi Michael,

I left comments on the V3 resend and Qiao said he would send another 
version but I didn't see one.

Upon testing I saw a few more bugs so I just sent a V4 myself, if you or 
Qiao could take a look.

Thanks
James

> On Wed, 11 Mar 2026, Qiao Zhao wrote:
>> Hi James, Ian,
>>
>> Just a gentle ping on this patch.
>> Could you take a look when convenient?
>>
>> Thanks,
>> Qiao
>>
>> On Thu, Mar 5, 2026 at 11:08 AM Qiao Zhao <qzhao@redhat.com> wrote:
>>>
>>> Hi James, Ian,
>>>
>>> Do you mind reviewing this v3 change?  Thanks a lot!
>>>
>>> - Qiao
>>>
>>> On Mon, Mar 2, 2026 at 1:56 PM Qiao Zhao <qzhao@redhat.com> wrote:
>>>>
>>>> The mmap-basic test incorrectly determined rdpmc availability in
>>>> several environments, leading to unexpected failures on arm64 and
>>>> other architectures.
>>>>
>>>> Previously the rdpmc capability decision lived in test_stat_user_read(),
>>>> which caused inconsistent behaviour when:
>>>>   - perf_user_access sysctl state is unknown
>>>>   - architectures expose cap_user_rdpmc differently
>>>>   - arm64 platforms where rdpmc semantics differ from x86
>>>>
>>>> As suggested during review, move the rdpmc capability decision into
>>>> set_user_read() so that the user_read state and expected behavior
>>>> are decided in a single place.
>>>>
>>>> Changes in v3:
>>>>   - Moves perf_user_access handling into set_user_read()
>>>>   - Simplify test_stat_user_read() expectation logic
>>>>   - Use unified rdpmc_supported calculation
>>>>   - Handle USER_READ_UNKNOWN consistently
>>>>
>>>> v2:
>>>> https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@redhat.com/
>>>>
>>>> Note:
>>>> A potential cleanup around perf_event.h mentioned during review is
>>>> intentionally deferred and will be handled in a follow-up change
>>>> to keep this fix minimal and focused.
>>>>
>>>> Tested on:
>>>>   - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
>>>>   - X86(include hybrid): all mmap-basic tests pass
>>>>   - IBM Power9: all mmap-basic tests pass
>>>>
>>>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
>>>> ---
>>>>   tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++----------
>>>>   1 file changed, 39 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
>>>> index 3313c236104e..3633e7c87dc1 100644
>>>> --- a/tools/perf/tests/mmap-basic.c
>>>> +++ b/tools/perf/tests/mmap-basic.c
>>>> @@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_s
>>>>   {
>>>>          char buf[2] = {0, '\n'};
>>>>          ssize_t len;
>>>> -       int events_fd, rdpmc_fd;
>>>> +       int events_fd, fd;
>>>>          enum user_read_state old_user_read = USER_READ_UNKNOWN;
>>>>
>>>>          if (enabled == USER_READ_UNKNOWN)
>>>>                  return USER_READ_UNKNOWN;
>>>>
>>>> +       // Try the PMU rdpmc sysfs interface or similar
>>>>          events_fd = perf_pmu__event_source_devices_fd();
>>>> -       if (events_fd < 0)
>>>> -               return USER_READ_UNKNOWN;
>>>> -
>>>> -       rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
>>>> -       if (rdpmc_fd < 0) {
>>>> +       if (events_fd >= 0) {
>>>> +               fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
>>>> +               if (fd >= 0) {
>>>> +                       len = read(fd, buf, sizeof(buf));
>>>> +                       if (len == sizeof(buf))
>>>> +                               old_user_read = (buf[0] == '1') ?
>>>> +                                       USER_READ_ENABLED :
>>>> +                                       USER_READ_DISABLED;
>>>> +
>>>> +                       if (enabled != old_user_read) {
>>>> +                               buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
>>>> +                               len = write(fd, buf, sizeof(buf));
>>>> +                               if (len != sizeof(buf))
>>>> +                                       pr_debug("%s write failed\n", __func__);
>>>> +                       }
>>>> +                       close(fd);
>>>> +                       close(events_fd);
>>>> +                       return old_user_read;
>>>> +               }
>>>>                  close(events_fd);
>>>> -               return USER_READ_UNKNOWN;
>>>>          }
>>>>
>>>> -       len = read(rdpmc_fd, buf, sizeof(buf));
>>>> -       if (len != sizeof(buf))
>>>> -               pr_debug("%s read failed\n", __func__);
>>>> +       // Fallback: perf_user_access interface (arm64, riscv, or similar)
>>>> +       fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
>>>> +       if (fd < 0)
>>>> +               return USER_READ_UNKNOWN;
>>>>
>>>>          // Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
>>>>          // all the core PMUs.
>>>> -       old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
>>>> +       len = read(fd, buf, sizeof(buf));
>>>> +       if (len == sizeof(buf))
>>>> +               old_user_read = (buf[0] == '1') ?
>>>> +                       USER_READ_ENABLED :
>>>> +                       USER_READ_DISABLED;
>>>>
>>>>          if (enabled != old_user_read) {
>>>>                  buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
>>>> -               len = write(rdpmc_fd, buf, sizeof(buf));
>>>> +               len = write(fd, buf, sizeof(buf));
>>>>                  if (len != sizeof(buf))
>>>>                          pr_debug("%s write failed\n", __func__);
>>>>          }
>>>> -       close(rdpmc_fd);
>>>> -       close(events_fd);
>>>> +
>>>> +       close(fd);
>>>>          return old_user_read;
>>>>   }
>>>>
>>>> @@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>>>                          goto cleanup;
>>>>                  }
>>>>
>>>> +#if defined(__aarch64__) || defined(__riscv)
>>>> +               rdpmc_supported = pc->cap_user_rdpmc;
>>>> +#else
>>>>                  if (saved_user_read_state == USER_READ_UNKNOWN)
>>>> -                       rdpmc_supported = pc->cap_user_rdpmc && pc->index;
>>>> +                       rdpmc_supported = pc->cap_user_rdpmc;
>>>>                  else
>>>>                          rdpmc_supported = (enabled == USER_READ_ENABLED);
>>>> +#endif
>>>>
>>>> -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
>>>> +               if (rdpmc_supported && !pc->cap_user_rdpmc) {
>>>>                          pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
>>>>                                  pmu->name, pc->cap_user_rdpmc, pc->index);
>>>>                          ret = TEST_FAIL;
>>>> --
>>>> 2.49.0
>>>>
>>
>>

