Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA76C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 17:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKORIF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiKORIB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 12:08:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06820983
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 09:07:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y16so25375681wrt.12
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 09:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8fug7Pycg9JGMbjUFO9hC6GowCXluQVSRide/mfbKV4=;
        b=Fqig9DykvDToXp4VOoUg+TL3umy+3m+nL4Oq3oZnGLtH7N4FnPI3bscxXcJWaiFRT3
         InnvQBKLCRobV7j80oAlqToIiYAOCeiUYuLwMrGebwVzq2vnxIeVR1I6aOCWdXVjbix4
         JxRVkKgmVkp1IZHT2J1BQo6hz3e4XF115alxG2cgfZEXel0QBjw/3Ny2NWsYEytQFdCb
         Dxd2uIWfTyviMjoJgpbMp1U2/5PfY+ggKJENDDNWZ7r95Kg66sCVNSZi0TaBYsCpnWk1
         1TTn6VocENxiVCeO2/U4UHAWEXg7ZecmLzbzTQp/9H/Hs++lmquNfqhp3S6pB0ueP0+D
         HF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fug7Pycg9JGMbjUFO9hC6GowCXluQVSRide/mfbKV4=;
        b=2Mi/ae0aPdGjWJFBp52uIpPkwBGUinzz0xrHe8G6izDDk1kfkpkykwLG0p1gUYcJv3
         CXv0y7WOAMSvIEXdGGWNXENDsxj+CWlWUY6V26LOtxcL1Szor3b+S+K5fAA9aZO89q/R
         dz3ZbNshJPqSPgsQkO8nT0pk8LnZQ3PNmpr0nXGHpKm5yul6gkj/1c3vqF5e7QSzC9ZL
         MCDV20wOvU8hmvq3CaRlIbxTStPzHZNyb6XFbzKmodKPJ+R5TgwFQfyFvIp76GeMGIzL
         sT2BcQ0YtKsId571cNOlo/yPRiRPx8QpLp0tn9DQSJdbx04COsc+FEQMEXEhbloMdLVn
         pM8A==
X-Gm-Message-State: ANoB5pkgLWlTfwxv/ENFLog1PFouTNEEG5LrEbdncEO796bp8WDKQLMj
        aE/Oi0BvwcTFxTZHN0WofbE39GrZpNPdJeNvns0fUA==
X-Google-Smtp-Source: AA0mqf6ycia/7g/I5oSSKfElMOZhmmAn+pqp77oswR34srY/+gsl33BKvscRc6o3RH+n9LXpyPu4IPl2WoJMYPYCco4=
X-Received: by 2002:a5d:58c1:0:b0:22e:34ee:c67d with SMTP id
 o1-20020a5d58c1000000b0022e34eec67dmr11207928wrf.300.1668532075915; Tue, 15
 Nov 2022 09:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
In-Reply-To: <20221115093904.1799-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 09:07:44 -0800
Message-ID: <CAP-5=fXq-YNKogH4DYQuf7rz8TZhu8=QnEsA2pvzj6YS_DQO7g@mail.gmail.com>
Subject: Re: [PATCH] perf/amd/ibs: Make IBS a core pmu
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 15, 2022 at 1:39 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> So far, only one pmu was allowed to be registered as core pmu and thus
> IBS pmus were being registered as uncore. However, with the event context
> rewrite, that limitation no longer exists and thus IBS pmus can also be
> registered as core pmu. This makes IBS much more usable, for ex, user
> will be able to do per-process precise monitoring on AMD:
>
> Before patch:
>   $ sudo perf record -e cycles:pp ls
>   Error:
>   Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'
>
> After patch:
>   $ sudo perf record -e cycles:pp ls
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

This is awesome!
Ian

> ---
> Note:
> This patch is dependent on the event context rewrite patch which is
> already present in a tip tree:
>   https://git.kernel.org/tip/tip/c/bd27568117664
>
>  arch/x86/events/amd/ibs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3271735f0070..fbc2ce86f4b8 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -631,7 +631,7 @@ static const struct attribute_group *op_attr_update[] = {
>
>  static struct perf_ibs perf_ibs_fetch = {
>         .pmu = {
> -               .task_ctx_nr    = perf_invalid_context,
> +               .task_ctx_nr    = perf_hw_context,
>
>                 .event_init     = perf_ibs_init,
>                 .add            = perf_ibs_add,
> @@ -655,7 +655,7 @@ static struct perf_ibs perf_ibs_fetch = {
>
>  static struct perf_ibs perf_ibs_op = {
>         .pmu = {
> -               .task_ctx_nr    = perf_invalid_context,
> +               .task_ctx_nr    = perf_hw_context,
>
>                 .event_init     = perf_ibs_init,
>                 .add            = perf_ibs_add,
> --
> 2.37.3
>
