Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4882C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Feb 2022 04:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbiBCEJT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Feb 2022 23:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiBCEJS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Feb 2022 23:09:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919EC061714
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Feb 2022 20:09:18 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id v67so2183890oie.9
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Feb 2022 20:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNpgGGyNaiVTheYe+aGFEhE+FqzS7hSuUksFg02bOcQ=;
        b=lbJSw+Ko0HiPcRW6en6Y/BD0/90a7EUEzZg3GymILedtJgVTTmxNrOEdxfyNUwYMsP
         5tLvaqGoSZhiezHuRDSa9zed3RjOsXXtF0N4FqEi7hNUgHlvkiBQdvCYU5Et0cdyJjx9
         vk2vOYBtU7VfPdIDEnBCI7otqO+r1aCo7/gxChi7ifKXuPYc7NgJzm87WpbbEKHgxwRH
         7YG8S5MZZ3r/0whgdmX3TIh5c56vM8tflMgk9UvcVG6H7f6mpk4jF8UvvWYRrn/7laIa
         +8MtzfdySzAyy90F01L8g3N4fiqvo7MZoidmPu0pkzbtfe3P7pljV3LE0mEA1SUxslho
         b4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNpgGGyNaiVTheYe+aGFEhE+FqzS7hSuUksFg02bOcQ=;
        b=2fUxa1mXOkFrzEBv5L/Xrth4y18Uy+jIHJzHxP+7Q/97gf3TUkCl9adW+PD07zaknc
         7tkJ9ejQadwAlG31nH9Co10JHs5KABYX4gKRX0aflIiR3eW53HxNcThT+hz79KHrGcx4
         QYNekmVZ9LvIpuem8bh/nW3FUNyfY7cygJb08uZvHz8raqvqf+GCfBB/HYZZlRDXH+JA
         DewoKJUXsoEVl6tXTz28KFWKsKLiue68OoVtwCh6HKVtc7XMssr/QVLyfw8Hgc6NmWaE
         yYtdMxA2VBqGhUvlIc+ZxYjLPWR95oKqXDSrBT5JhhdlVKXxklXIZnAKySdeT6U2L3wI
         LRJA==
X-Gm-Message-State: AOAM530MktE1fsb0YDJ9BPQCcRsMtVmJAhQl39VaREJ9Psf8xSudJTSd
        jFdX6+fshZPSBhCA5WAtowtK8YYEYmWYxswerUHs4g==
X-Google-Smtp-Source: ABdhPJyQwFoZnLDFxDvgTHU+V140CVA4cMeRLD6SWjWSDISgD0mNHRy6KSQxmL/k4Ariz4fLDc2L6fUwoEGWfPZl2v0=
X-Received: by 2002:a05:6808:21a5:: with SMTP id be37mr7096243oib.339.1643861356188;
 Wed, 02 Feb 2022 20:09:16 -0800 (PST)
MIME-Version: 1.0
References: <2e96421f-44b5-c8b7-82f7-5a9a9040104b@amd.com> <20220202105158.7072-1-ravi.bangoria@amd.com>
In-Reply-To: <20220202105158.7072-1-ravi.bangoria@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Feb 2022 20:09:05 -0800
Message-ID: <CALMp9eQHfAgcW-J1YY=01ki4m_YVBBEz6D1T662p2BUp05ZcPQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf/amd: Implement erratum #1292 workaround for F19h M00-0Fh
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     like.xu.linux@gmail.com, eranian@google.com,
        santosh.shukla@amd.com, pbonzini@redhat.com, seanjc@google.com,
        wanpengli@tencent.com, vkuznets@redhat.com, joro@8bytes.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kvm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
        kim.phillips@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 2, 2022 at 2:52 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Perf counter may overcount for a list of Retire Based Events. Implement
> workaround for Zen3 Family 19 Model 00-0F processors as suggested in
> Revision Guide[1]:
>
>   To count the non-FP affected PMC events correctly:
>     o Use Core::X86::Msr::PERF_CTL2 to count the events, and
>     o Program Core::X86::Msr::PERF_CTL2[43] to 1b, and
>     o Program Core::X86::Msr::PERF_CTL2[20] to 0b.
>
> Note that the specified workaround applies only to counting events and
> not to sampling events. Thus sampling event will continue functioning
> as is.
>
> Although the issue exists on all previous Zen revisions, the workaround
> is different and thus not included in this patch.
>
> This patch needs Like's patch[2] to make it work on kvm guest.

IIUC, this patch along with Like's patch actually breaks PMU
virtualization for a kvm guest.

Suppose I have some code which counts event 0xC2 [Retired Branch
Instructions] on PMC0 and event 0xC4 [Retired Taken Branch
Instructions] on PMC1. I then divide PMC1 by PMC0 to see what
percentage of my branch instructions are taken. On hardware that
suffers from erratum 1292, both counters may overcount, but if the
inaccuracy is small, then my final result may still be fairly close to
reality.

With these patches, if I run that same code in a kvm guest, it looks
like one of those events will be counted on PMC2 and the other won't
be counted at all. So, when I calculate the percentage of branch
instructions taken, I either get 0 or infinity.

> [1] https://bugzilla.kernel.org/attachment.cgi?id=298241
> [2] https://lore.kernel.org/lkml/20220117055703.52020-1-likexu@tencent.com
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
