Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A7C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997E961241
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 10:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKKKKt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhKKKKj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 05:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636625270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O47h4DVVtUaEBtUgssjuQpExDB0fecfhYF5eRGFKZI0=;
        b=iC+vtIQijwBbOvb3EruXNpTVSKTum/xrBLOqrDFUKBfHSEUTBv73he9hsHTCC2DV5/BsWy
        VVkrm6zDHUHNFwnSnlZtt3OIn3pwdwzbXa2vzccCXh6TjeZxJrmC83AtJdlD9UV/dog5de
        4iQbRs07X0V8V5EjR69PBWqHAJASBes=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-hpPQhQCWNNSnMmQhECDHtA-1; Thu, 11 Nov 2021 05:07:48 -0500
X-MC-Unique: hpPQhQCWNNSnMmQhECDHtA-1
Received: by mail-wm1-f70.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso4528820wml.9
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 02:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=O47h4DVVtUaEBtUgssjuQpExDB0fecfhYF5eRGFKZI0=;
        b=53YgPpQxHBNCiaArG5yttAA+N7bEXWjzp9jxLLnAnzhAivpkQQcioDCFtyvJmROBY/
         wa8QLZ/7146lYNAL+ltJf/TI/rU5vNpXGKBGSQoXFbf9plGtHwEZNeaNZzZDH/Amh1R5
         57FX4WCRJFcX4j9OeI7krsPaYN9LaWhcoQ6Y1w7qGRbX+mMGv4Fh7JBaEEkVky/n2oZx
         pJOgWRzVhnyEin7Ysr+sCoHxluT2/FDfEMLfv4fkI9ys7x6a0cIDMhKh/j2gWR+dwiXP
         i1r2QSeV6Wgn3H2dsSOj8opgWggkLi/tpOfow8EOfrrOYDUiVE411hj5j17Hsl/5GmIr
         5pBQ==
X-Gm-Message-State: AOAM531sTE6SYGcWZBMfUVzahayS0Jha/Urf0SZFWfMWb51iS1ja023G
        VdwUpXh5Ov0HVyC4vkFL6mqIZrSpjTqs1Ut86beUA4do40j/kDxKOuJXV1GGNjHQlTD+JsDhjmE
        +qIIoxuTa13ZP4MPYSFT9WYOF+jsvlw==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr7228896wrd.373.1636625267125;
        Thu, 11 Nov 2021 02:07:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIYNQG8t7gWYqwpgZkkzMNqewJnW2iU/frpsF+W0jIDUpjovyfAg40kLr/ApFY0hP+csCBmg==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr7228866wrd.373.1636625266915;
        Thu, 11 Nov 2021 02:07:46 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id g18sm2436886wrv.42.2021.11.11.02.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:07:46 -0800 (PST)
Message-ID: <8be53ae6-b3f9-f3da-afc7-23c8232a7a0a@redhat.com>
Date:   Thu, 11 Nov 2021 11:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/7] samples/bpf/test_overhead_kprobe_kern: make it adopt
 to task comm size change
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
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
 <20211108083840.4627-6-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> bpf_probe_read_kernel_str() will add a nul terminator to the dst, then
> we don't care about if the dst size is big enough. This patch also
> replaces the hard-coded 16 with TASK_COMM_LEN to make it adopt to task
> comm size change.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
>  samples/bpf/offwaketime_kern.c          |  4 ++--
>  samples/bpf/test_overhead_kprobe_kern.c | 11 ++++++-----
>  samples/bpf/test_overhead_tp_kern.c     |  5 +++--
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime_kern.c
> index 4866afd054da..eb4d94742e6b 100644
> --- a/samples/bpf/offwaketime_kern.c
> +++ b/samples/bpf/offwaketime_kern.c
> @@ -113,11 +113,11 @@ static inline int update_counts(void *ctx, u32 pid, u64 delta)
>  /* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
>  struct sched_switch_args {
>  	unsigned long long pad;
> -	char prev_comm[16];
> +	char prev_comm[TASK_COMM_LEN];
>  	int prev_pid;
>  	int prev_prio;
>  	long long prev_state;
> -	char next_comm[16];
> +	char next_comm[TASK_COMM_LEN];
>  	int next_pid;
>  	int next_prio;
>  };
> diff --git a/samples/bpf/test_overhead_kprobe_kern.c b/samples/bpf/test_overhead_kprobe_kern.c
> index f6d593e47037..8fdd2c9c56b2 100644
> --- a/samples/bpf/test_overhead_kprobe_kern.c
> +++ b/samples/bpf/test_overhead_kprobe_kern.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/version.h>
>  #include <linux/ptrace.h>
> +#include <linux/sched.h>
>  #include <uapi/linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> @@ -22,17 +23,17 @@ int prog(struct pt_regs *ctx)
>  {
>  	struct signal_struct *signal;
>  	struct task_struct *tsk;
> -	char oldcomm[16] = {};
> -	char newcomm[16] = {};
> +	char oldcomm[TASK_COMM_LEN] = {};
> +	char newcomm[TASK_COMM_LEN] = {};
>  	u16 oom_score_adj;
>  	u32 pid;
>  
>  	tsk = (void *)PT_REGS_PARM1(ctx);
>  
>  	pid = _(tsk->pid);
> -	bpf_probe_read_kernel(oldcomm, sizeof(oldcomm), &tsk->comm);
> -	bpf_probe_read_kernel(newcomm, sizeof(newcomm),
> -			      (void *)PT_REGS_PARM2(ctx));
> +	bpf_probe_read_kernel_str(oldcomm, sizeof(oldcomm), &tsk->comm);
> +	bpf_probe_read_kernel_str(newcomm, sizeof(newcomm),
> +				  (void *)PT_REGS_PARM2(ctx));

It's a shame we have to do a manual copy here ...

Changes LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

