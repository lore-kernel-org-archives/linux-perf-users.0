Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8913C43219
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 09:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24266134F
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 09:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKKBN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232855AbhKKKBH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 05:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636624698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WfCXGbrfuPcyNxfHFWFibzfvtpe2j1zKl+DzGNBc4s=;
        b=BXfyKjNdGsFD7VO56TXscMOjAnwuhKqgJwyXk92evB6z03/0d5Nox6KEMukhkL/FP2QZzu
        grZPq2xLSGH5jMJiJWCdODhMbOKuLPr76K8W2LOoZS62JUTcEYJp1GDqEFuEiXQU26VCxa
        BPjjVZXqQpObs+qKosaW/H7jaCtXDSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-LqUnuW2cNPWkqdu_onRiaQ-1; Thu, 11 Nov 2021 04:58:16 -0500
X-MC-Unique: LqUnuW2cNPWkqdu_onRiaQ-1
Received: by mail-wm1-f71.google.com with SMTP id a67-20020a1c7f46000000b00333629ed22dso971114wmd.6
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 01:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=2WfCXGbrfuPcyNxfHFWFibzfvtpe2j1zKl+DzGNBc4s=;
        b=zjmOB4yJrtyVaX449QG9/bVZm266Loi9F+C7nSnC+BD0SUyINhyko/LyeIYltRDMXQ
         aKDfvaG8sE/83sPLSjU/vIxugUHf0NM4ynUEZPKARjUcHlU3TgiuI3lOPHHiaVwBaoXF
         9WfskCtFyWb6lNZZ5Dm29wdoUjAngafZC9cSI9oPP2HaeJxyS6rQ84YQwI9TGlPGOQIA
         M7MWLSDrc4LSVaN8ggQti3t0/VND/B39cKZ62MdOtz+yGolNV4W/tpbG0FnvFvkFIUdV
         DyNbkiE7iNW1mjMZHKwuCRhzst9QPcxbj8Xwe1CLNrAAKhD/qC7w9XqMTvEJ1CHaQkPt
         FybQ==
X-Gm-Message-State: AOAM533TekUtfwQOv9ScSW+bPiOtu7uTFY4OxtB9oX9uIToiPZ8EKebe
        WzUwk+/vWzHYadbXrMRmIy9Vdjhz6pW09fRAUjulgrQnuD2W+HO0E3H13u/m+O2BbdtR4wIT/Yc
        XVO1C+2mse0RNwlIrp8T1xaqYsqEohA==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr2503853wmj.76.1636624695803;
        Thu, 11 Nov 2021 01:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrulQBQPuRy6L+qz74whcjWLY8u+rgH1OO6eX2oTETTCSbO+kpZ6/tGPnb1PaeF7ZEn/lzpw==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr2503832wmj.76.1636624695641;
        Thu, 11 Nov 2021 01:58:15 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id 4sm3186059wrz.90.2021.11.11.01.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 01:58:15 -0800 (PST)
Message-ID: <3526ab88-afa3-e87b-d773-72807a27a88d@redhat.com>
Date:   Thu, 11 Nov 2021 10:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/7] fs/exec: make __set_task_comm always set a nul
 terminated string
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-2-laoar.shao@gmail.com>
 <c3571571-320a-3e25-8409-5653ddca895c@redhat.com>
 <CALOAHbCexkBs7FCdmQcatQbc+RsGTSoJkNBop0khsZX=g8Ftkg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CALOAHbCexkBs7FCdmQcatQbc+RsGTSoJkNBop0khsZX=g8Ftkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10.11.21 10:05, Yafang Shao wrote:
> On Wed, Nov 10, 2021 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.11.21 09:38, Yafang Shao wrote:
>>> Make sure the string set to task comm is always nul terminated.
>>>
>>
>> strlcpy: "the result is always a valid NUL-terminated string that fits
>> in the buffer"
>>
>> The only difference seems to be that strscpy_pad() pads the remainder
>> with zeroes.
>>
>> Is this description correct and I am missing something important?
>>
> 
> In a earlier version [1], the checkpatch.py found a warning:
> WARNING: Prefer strscpy over strlcpy - see:
> https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> So I replaced strlcpy() with strscpy() to fix this warning.
> And then in v5[2], the strscpy() was replaced with strscpy_pad() to
> make sure there's no garbade data and also make get_task_comm() be
> consistent with get_task_comm().
> 
> This commit log didn't clearly describe the historical changes.  So I
> think we can update the commit log and subject with:
> 
> Subject: use strscpy_pad with strlcpy in __set_task_comm
> Commit log:
> strlcpy is not suggested to use by the checkpatch.pl, so we'd better
> recplace it with strscpy.
> To avoid leaving garbage data and be consistent with the usage in
> __get_task_comm(), the strscpy_pad is used here.
> 
> WDYT?

Yes, that makes it clearer what this patch actually does :)

With the subject+description changed

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

