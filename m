Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3309C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 10:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FC76128E
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 10:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhKKKGr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:06:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232671AbhKKKGr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 05:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636625038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgI+Fga244qRdHsv3NfTmj/X0PIXJLU6JdJEs2Lnikc=;
        b=faDHT2GCPeamj3341q69FIyWgPzPlifrnJS3jd0fIoKVOMgnpvCn8OBW60nqXrck+5ka19
        ADVu5evIotKGZ6hTnnvQ5ZukaXe30IQAHRYMPGmOnhdh3IqrogY3NjJyU2YXUB+egTwga2
        ycO9iAHnolbqbqMBNwisQUaa3+BiYgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-88XamY4WNOyPvT40DSYkaQ-1; Thu, 11 Nov 2021 05:03:57 -0500
X-MC-Unique: 88XamY4WNOyPvT40DSYkaQ-1
Received: by mail-wm1-f70.google.com with SMTP id m1-20020a1ca301000000b003231d5b3c4cso4539541wme.5
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 02:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=RgI+Fga244qRdHsv3NfTmj/X0PIXJLU6JdJEs2Lnikc=;
        b=ShkycrW1FDoelTk3CxJAGwi8jeqVVOjkjhZYX/8lxjFjtQmMlxEFrAWSJyFsNUtapc
         jOuHEZMtzi4LVTXpvZBUrF9Y6wy8S2Z/YD6B9p0oL/iLoi813kTwfR+iRMxmy6J+MtqU
         W4WUuSjCzdANv2aWpMPQDq6JSVzRVV8aAm+pOTMGU558X9D/MBR1ekDI69VEGZ2G6Bar
         WeDCMLdFgEyhbHA/6u705JRUrWnIcsgVjhmAO/6r8ERxTYaNtYgnP3jecm/6eLU5J7cp
         UmgsNv220Dnk6VpE9fOYkPadjZ3sJP+vaSgGs61jjbG7qfhPCMCOyBLPGZrlS0KDk8db
         W+Dw==
X-Gm-Message-State: AOAM531MSPPNWu638F5k31Q45S6Z3qEzPqsBZsPxqAqw/hhY1bg023rs
        rvf+Sa/o4Ns6c/keJblu5qIfaZxJK63hDLr8iqG529Zun/zWKhZFUlRVecXBkimDlw0U7Tu4reB
        eeWtvQ43M2MCsDXoCwPj7UnlHzHKLSQ==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr6795118wmi.167.1636625036007;
        Thu, 11 Nov 2021 02:03:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbEOMfOu1BPHyGDT4lSs2gwzkWRkK6yYNIJ1XKpWm1ValPzCs+UlG7aY+RgLlSJjV/OSwWfA==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr6795079wmi.167.1636625035774;
        Thu, 11 Nov 2021 02:03:55 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id h3sm2362194wrv.69.2021.11.11.02.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:03:54 -0800 (PST)
Message-ID: <a13c0541-59a3-6561-6d42-b51fef9f7c8b@redhat.com>
Date:   Thu, 11 Nov 2021 11:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/7] fs/binfmt_elf: use get_task_comm instead of
 open-coded string copy
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-5-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> It is better to use get_task_comm() instead of the open coded string
> copy as we do in other places.
> 
> struct elf_prpsinfo is used to dump the task information in userspace
> coredump or kernel vmcore. Below is the verfication of vmcore,
> 
> crash> ps
>    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>       0      0   0  ffffffff9d21a940  RU   0.0       0      0  [swapper/0]
>>     0      0   1  ffffa09e40f85e80  RU   0.0       0      0  [swapper/1]
>>     0      0   2  ffffa09e40f81f80  RU   0.0       0      0  [swapper/2]
>>     0      0   3  ffffa09e40f83f00  RU   0.0       0      0  [swapper/3]
>>     0      0   4  ffffa09e40f80000  RU   0.0       0      0  [swapper/4]
>>     0      0   5  ffffa09e40f89f80  RU   0.0       0      0  [swapper/5]
>       0      0   6  ffffa09e40f8bf00  RU   0.0       0      0  [swapper/6]
>>     0      0   7  ffffa09e40f88000  RU   0.0       0      0  [swapper/7]
>>     0      0   8  ffffa09e40f8de80  RU   0.0       0      0  [swapper/8]
>>     0      0   9  ffffa09e40f95e80  RU   0.0       0      0  [swapper/9]
>>     0      0  10  ffffa09e40f91f80  RU   0.0       0      0  [swapper/10]
>>     0      0  11  ffffa09e40f93f00  RU   0.0       0      0  [swapper/11]
>>     0      0  12  ffffa09e40f90000  RU   0.0       0      0  [swapper/12]
>>     0      0  13  ffffa09e40f9bf00  RU   0.0       0      0  [swapper/13]
>>     0      0  14  ffffa09e40f98000  RU   0.0       0      0  [swapper/14]
>>     0      0  15  ffffa09e40f9de80  RU   0.0       0      0  [swapper/15]
> 
> It works well as expected.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a813b70f594e..138956fd4a88 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1572,7 +1572,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
>  	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
>  	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
>  	rcu_read_unlock();
> -	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
> +	get_task_comm(psinfo->pr_fname, p);
>  
>  	return 0;
>  }
> 

We have a hard-coded "pr_fname[16]" as well, not sure if we want to
adjust that to use TASK_COMM_LEN?

Anyhow

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

