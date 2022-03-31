Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6FC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Mar 2022 05:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiCaFy7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Mar 2022 01:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCaFy5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Mar 2022 01:54:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D02B37ABE
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Mar 2022 22:53:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bo5so1477565pfb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Mar 2022 22:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BrVp20BmQjd9WSbsMvWT5kt24UKCTLgZvgR7hPflW5I=;
        b=J0orAsxOAk3R3htaeofa12dEY09G1ZOT6xFMUw8eRPdblGAX+zKgalF+zG53xNIBfN
         JIdsxH0KeXhELtsIMEfbGGS8jMDN+ePq9zcaypxHtex4s+/DgPdLpCaI+/6Q6+GgWWKs
         KJEdpD76ISx4i9sPdkdNTpnORTU/yyvxrRPlPLbAYPe0AeCjVdFf7yGjU2RhRFTgms2/
         0RYnJfjAzMGceWUdQXG5RxDGdiaQYO94yuq3nKHFmfxpcOlFbLUCujyc7JzsG35ovPBW
         OeK74pluni7ZWl5BfCWtd2/Z/cENsuT48GSGZFcv3nsYh3EjxsvjTQNwnxUySCiQeBAn
         eTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BrVp20BmQjd9WSbsMvWT5kt24UKCTLgZvgR7hPflW5I=;
        b=1Fb32xFAco+i/9fp/VVHgyYW/nbWacC3/Xi9YFCGyKOP4NNCeu/Hh4yB47WV44Eqp/
         83HCXItHSDMj6PIDddEavUCCz1SO6y8S/eui9Tf+7hZI5LEYp4ZiXoSfZPfM3ZAYNarF
         KfCp/d7RRooAuHAv3KC+tJcb8355TYlHN3fFa9jZwWboYNHINQwq9ylBxDRQqvu+1eHb
         lBdd2b/sARPWftqcNOVQOvPS6ODn8GWg8kIsCkxQzyZ6XtHQsXJ74xj9nicPbGIqcpFC
         hiSTG0SMbtR+QocQHYk/P4Vy0HwDWX67llAuqj1zrxFDrTbIoEQcnSx3Zm9HZJfm/59H
         p+fw==
X-Gm-Message-State: AOAM532IqUFWY2wuZOjkFKnrv9P+5c0ec17TXfzdBrgSJNlsLbHXQsAJ
        UxK+kX58VO5fa5Z0BcLYVWTGHA==
X-Google-Smtp-Source: ABdhPJwpnANsxo4xZlJjPDa54Tplqd+KoCrSUKkTKC74/0HoCkJtQWqclS4PEP1Ao1Wh7C3CzDf7gg==
X-Received: by 2002:a63:6f44:0:b0:398:31d6:e37f with SMTP id k65-20020a636f44000000b0039831d6e37fmr9285910pgc.177.1648705990089;
        Wed, 30 Mar 2022 22:53:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n18-20020a056a0007d200b004fdac35672fsm1695461pfu.68.2022.03.30.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 22:53:09 -0700 (PDT)
Date:   Wed, 30 Mar 2022 22:53:09 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 21:15:09 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix fill_callchain return value
In-Reply-To: <20220311065815.9985-1-nikita.shubin@maquefel.me>
CC:     linux@yadro.com, n.shubin@yadro.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, han_mao@c-sky.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nikita.shubin@maquefel.me
Message-ID: <mhng-d348c041-9628-4aa2-af10-51604edbe48c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 10 Mar 2022 22:58:15 PST (-0800), nikita.shubin@maquefel.me wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
>
> perf_callchain_store return 0 on success, -1 otherwise,
> fix fill_callchain to return correct bool value.
>
> Fixes: dbeb90b0c1eb ("riscv: Add perf callchain support")
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>  arch/riscv/kernel/perf_callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 1fc075b8f764..7aca6a238173 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -68,7 +68,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>
>  static bool fill_callchain(void *entry, unsigned long pc)
>  {
> -	return perf_callchain_store(entry, pc);
> +	return perf_callchain_store(entry, pc) == 0;
>  }
>
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,

Thanks, this is on for-next.  Looks like we share some of this code with 
at least arm64, it might be worth refactoring this into something 
generic.
