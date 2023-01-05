Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E0C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAEO57 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 09:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjAEO5u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 09:57:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250AC762
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 06:57:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so2584029wml.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2023 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JoYtJ7uGlKoHKYFnL3jriXo1935cWEoE6OmWnPXw6M=;
        b=cbr8UcqVh5GcLcO8/2MY6UKBQJkha6VA29sN446RrkY1oO3iIkABX3gRhczO1z+SGu
         PTpOI8brx3MxdVFeTM73YSB5C71B9rDQSEu38/6oK2Zcjd77jjhmWqwZzUaqk4gwsNc7
         D1k7YugnKbAQ0V0WwYBJyXknSqDWlCDpUjUP+9YS+jfH4Lvi1lIhLWmxUanfzBzq8bJi
         3liieGFfhwyvv4+sEYILrLI6b+BVXE3aRG9Nj5U40n67cvx9rqpXwqtIU62JJWTrCuUs
         Nr01U2yomFgtPCsHODZasXZiOQ/UtohREisqWqMT5K2UMIiZTi4t4Q5kHhS5vNum8Au4
         H6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JoYtJ7uGlKoHKYFnL3jriXo1935cWEoE6OmWnPXw6M=;
        b=eQCg74gl1bQH+TB3xYV6mcbJ3wCcm0cmni8gl0OqhbNN8z43LMmv29N0ZUBtOE361+
         oVQBYByPA1eObTGjftcUEJdlfSDuq/j7DrS4uKkBbC6sXQlKux7i74jsUnsl9xDf8W+P
         DN9i5JMNymt2TAQq3vyS3E29PxMRfSNjlwUZH2CiFfkFmAHByYKkrhwl0xI3tZhN0UxT
         2Bg7XDXca9hLyTb41EASKzq1JDiOor4pq5nQ+N5TaoZJzJuIeLXwWWPIJwEjQ2MSzmUx
         j4CoTRrA6X+G/5W2shA6gsVGVeMV9mYniiFohOXJEzsG/upittxrY8dkQID1icR0zPtQ
         Amvg==
X-Gm-Message-State: AFqh2kqdtZnEzBTjspQUEH3wKGgrgUotVPMIJPtuHDT3TDRS299pXloI
        PmmLhE7GbyiIO//Fg0YMWcwbEA==
X-Google-Smtp-Source: AMrXdXuOOZJm67XpxP09RxO6taRCMm7SSoPQ0WZ/c0ocRC9D7XPBS29SZLb6vwXcgd46G/M76GExfA==
X-Received: by 2002:a05:600c:358f:b0:3d9:7847:96e2 with SMTP id p15-20020a05600c358f00b003d9784796e2mr27329730wmq.2.1672930667922;
        Thu, 05 Jan 2023 06:57:47 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003cf5ec79bf9sm2799587wmb.40.2023.01.05.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 06:57:47 -0800 (PST)
Message-ID: <bbb463c4-6dc4-26b7-7ac2-6ebf98f61322@isovalent.com>
Date:   Thu, 5 Jan 2023 14:57:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
 <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
 <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
 <ea02357d-c5c7-aeff-e045-d639315d87e9@isovalent.com>
 <CAEf4BzZMJGrRhNeQeWB0fRsuRYUv01aZGhvDeFV2o5zdpRbR-w@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzZMJGrRhNeQeWB0fRsuRYUv01aZGhvDeFV2o5zdpRbR-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

2023-01-03 15:46 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Tue, Jan 3, 2023 at 7:03 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2022-12-20 16:13 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> On Tue, Dec 20, 2022 at 3:34 AM Leo Yan <leo.yan@linaro.org> wrote:
>>>>
>>>> On Tue, Dec 20, 2022 at 09:31:14AM +0800, Changbin Du wrote:
>>>>
>>>> [...]
>>>>
>>>>>>> Now will print below info:
>>>>>>> libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
>>>>>>
>>>>>> Recently I encountered the same issue, it could be caused by:
>>>>>> either missing to install tool pahole or missing to enable kernel
>>>>>> configuration CONFIG_DEBUG_INFO_BTF.
>>>>>>
>>>>>> Could we give explict info for reasoning failure?  Like:
>>>>>>
>>>>>> "libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
>>>>>> please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".
>>>>>>
>>>>> This is vmlinux special information and similar tips are removed from
>>>>> patch V2. libbpf is common for all ELFs.
>>>>
>>>> Okay, I see.  Sorry for noise.
>>>>
>>>>>>> Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
>>>>>>
>>>>>> This log is confusing when we can find vmlinux file but without BTF
>>>>>> section.  Consider to use a separate patch to detect vmlinux not
>>>>>> found case and print out "No such file or directory"?
>>>>>>
>>>>> I think it's already there. If the file doesn't exist, open will fail.
>>>>
>>>> [...]
>>>>
>>>>>>> @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>>>>>>>   err = 0;
>>>>>>>
>>>>>>>   if (!btf_data) {
>>>>>>> +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
>>>>>>>           err = -ENOENT;
>>>>
>>>> btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
>>>> section, therefore, bpftool dumps error string "No such file or
>>>> directory".  It's confused that actually vmlinux is existed.
>>>>
>>>> I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
>>>> better choice?) to replace -ENOENT at here, this can avoid bpftool to
>>>> outputs "No such file or directory" in this case.
>>>
>>> The only really meaningful error code would be -ESRCH, which
>>> strerror() will translate to "No such process", which is also
>>> completely confusing.
>>>
>>> In general, I always found these strerror() messages extremely
>>> unhelpful and confusing. I wonder if we should make an effort to
>>> actually emit symbolic names of errors instead (literally, "-ENOENT"
>>> in this case). This is all tooling for engineers, I find -ENOENT or
>>> -ESRCH much more meaningful as an error message, compared to "No such
>>> file" seemingly human-readable interpretation.
>>>
>>> Quenting, what do you think about the above proposal for bpftool? We
>>> can have some libbpf helper internally and do it in libbpf error
>>> messages as well and just reuse the logic in bpftool, perhaps?
>>
>> Apologies for the delay.
>> What you're proposing is to replace all messages currently looking like
>> this:
>>
>>         $ bpftool prog
>>         Error: can't get next program: Operation not permitted
>>
>> by:
>>
>>         $ bpftool prog
>>         Error: can't get next program: -EPERM
>>
>> Do I understand correctly?
> 
> yep, that's what I had in mind
> 
>>
>> I think the strerror() messages are helpful in some occasions (they
>> _are_ more human-friendly to many users), but it's also true that
>> they're not always precise. With bpftool, "Invalid argument" is a
>> classic when the program doesn't load, and may lead to confusion with
>> the args passed to bpftool on the command line. Then there are the other
>> corner cases like the one discussed in this thread. So, why not.
> 
> maybe the right approach would be to have both symbolic error name and
> its human-readable representation, so for example above
> 
> Error: can't get next program: [-EPERM] Operation not permitted
> 
> or something like that? And if error value is unknown, just keep it as
> integer: "[-5555]" ?
That would be great, we'd have both the error name for savvy users and
the (more or less accurate) interpretation for others.

>> If we do change, yeah I'd rather have as much of this handling in libbpf
>> itself, and then adjust bpftool to handle the remaining cases, for
>> consistency.
> 
> we can teach libbpf_strerror_r() to do this and if bpftool is going to
> use it consistently then it would get the benefit automatically
Sounds good to me.
