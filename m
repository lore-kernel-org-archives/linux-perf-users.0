Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EEC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 May 2022 23:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiEBXzD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 May 2022 19:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiEBXyO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 May 2022 19:54:14 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4390A6
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 16:50:44 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id a23-20020a4ad5d7000000b0035ee70da7a9so851557oot.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7Cw+Kh2PwkVaz2CcLvmIqjqnZHIcRL3vzxNDm28vQI=;
        b=qUJMJzIghsthGyWraON5sQRLlRKSCoeCtBLqhKJxW+nZKX+BqUjkWgnilkYzSgnBqs
         ZgN1/gkwEi+9c2RnHpNtWioNpP/BXFLJBZdzymI1P+EuPoyeJWQL/nxy1AnvGQ159gqR
         zXwryGn81LW3dUC6mRtWsiyH4qnVUV+qCk+lcynIagdTX4YkYsJ3A6WfUAZnf2QV0BKv
         kWxI50BXL7mFaYi67tBF1BlWawAv+ZAAsnLzMI0Vdw3tg7DP8ChWMB7X3AnzKqttwNpo
         E7TF149IXP7bGqe9ftVMsqI8K5u+dBCsBKqJT/UeB3z3AIs17lfGrqtomLhC/oR0QrF5
         ZgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7Cw+Kh2PwkVaz2CcLvmIqjqnZHIcRL3vzxNDm28vQI=;
        b=CjDibAv/be6xGZrfJS6B6krUCMQYBjjIofaoM+ZAvffkDl8wn4qdZFSYWjqJS0qxDi
         JgmevUJSUjYoOaHMRHWlgPJYTwVKfYzFGlcvIY74juvJe/VUzGChg4jdUL7ark4n+72H
         JDwxKpV1dpVQW6K9QwLMu0yYei3/RgUxy6boZRulI0AfBKuByokAfSnk5eze0GwksxjK
         DgPFdanl9Op3u1SlAM+Ik92a+aQX06lyGOjK0vUOIoEhLNqEdYKx6VC/nIVQZDrDzOrh
         NdlhHecHWHSWpW2+F+sI0r5bYVnlDpdRqPFPBVjd/whL99+xCerLamCu6b5r5LgZCZGO
         ZpzQ==
X-Gm-Message-State: AOAM531WQLqHpUKTit5TqjonjpU/pcyldWl/Z6qFgllqROJwYU3NWbUv
        8IJOr5fa4weEPh4DyhjbWoIGmdUjMcXMAGeYvg/0JQ==
X-Google-Smtp-Source: ABdhPJwXgvnATQa1rZ5EKOQDBk3E5T5DKJmlC3FwomnAmQjTyGDvBY73DuXdqDwMNiO01v0nBWKkIHXKLl9A2AM2Jpw=
X-Received: by 2002:a4a:bb10:0:b0:35e:d6a9:3208 with SMTP id
 f16-20020a4abb10000000b0035ed6a93208mr4306723oop.85.1651535443613; Mon, 02
 May 2022 16:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651058600.git.sandipan.das@amd.com> <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
In-Reply-To: <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 May 2022 16:50:32 -0700
Message-ID: <CALMp9eSdUW6et2Us1if-j2Do6cv9ssyT4C2KPiyomFd7i_Dc1Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, like.xu.linux@gmail.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 27, 2022 at 4:34 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> On some x86 processors, CPUID leaf 0xA provides information
> on Architectural Performance Monitoring features. It
> advertises a PMU version which Qemu uses to determine the
> availability of additional MSRs to manage the PMCs.
>
> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
> the same, the kernel constructs return values based on the
> x86_pmu_capability irrespective of the vendor.
>
> This leaf and the additional MSRs are not supported on AMD
> and Hygon processors. If AMD PerfMonV2 is detected, the PMU
> version is set to 2 and guest startup breaks because of an
> attempt to access a non-existent MSR. Return zeros to avoid
> this.
>
> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/kvm/cpuid.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 4b62d80bb22f..e66ebb747084 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                 union cpuid10_eax eax;
>                 union cpuid10_edx edx;
>
> +               if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {

Should this be checking kvm_cpu_cap_has(X86_FEATURE_ARCH_PERFMON) instead?

> +                       entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +                       break;
> +               }
> +
>                 perf_get_x86_pmu_capability(&cap);
>
>                 /*
> --
> 2.34.1
>
