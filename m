Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F444C07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 03:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8736113B
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 03:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbhGTCsO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 22:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbhGTCr4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 22:47:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68820C061762;
        Mon, 19 Jul 2021 20:28:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j4so4601834pgk.5;
        Mon, 19 Jul 2021 20:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D86blkjNHKioN25R04XcYte58T6pb5DQYVQYgurli6Y=;
        b=sZ83FT/uYsaywhpvb6rqo0lNjDavwpJ0/Id0igA1lKTbijfq+XEWHxqNAIRP91zn2Z
         wPLiiJRPz98+vq7MGPOT8Ni2vjfd8pCwKR5n0/zI/kByD/2mRhJEacvwWjBAfVnBfC3s
         qXMrVLfLlqsw+ajNmRwlCthwvcgg6n/nOKmdtgs1S5K3HJyOwCUe+hQDaegeXEqIL074
         4+Gi6zJ2XvBGiAxfCLO6cfBnTSCPcQq5GygbP1kRd5yKTpvDhaOyHwCmfxMAP/PGsQD9
         SUonr0Y6r7gmXl50jk21a+7YzWUM0bvuT9bddRYj0A4UU1KEjiwGTf0OLXLfCoEPpNlE
         RvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D86blkjNHKioN25R04XcYte58T6pb5DQYVQYgurli6Y=;
        b=DcfcwiGNPoUl/i4oc5XhAfjC//DL+HdVJ/kla52bc8dfGPT/Znzkc/zfUlzpIxjeXO
         /o241HybXvGyJ3Hx05AxU7mj8g3A2PpK8VUXaIxKIlC9Ur93yxSXT1Oql6s09bmpG8g3
         zlHj4GzZ349bOXbf3a4GFVgVQKjaqHcYUNC/Bixvmm7Y90QjEldN03sQBYKJCjOmDypw
         uY7a4o4Y/fori38Le+Sv1pRfou5TykkwaHM/E0a4H7y4b+Jyi61jX40fA07xayS/MEzs
         PqRaUUH58jeSrdNRu26JtR3srf53SYza8+YZp/rZGX47pjAnwKYx/C2oF1QnDXe7YASC
         ed2Q==
X-Gm-Message-State: AOAM530o8RNloHW1SRNV3x6vIiA5KSH1U4/VIMVMxy6FYGA90J2GUd1o
        R+NsXssKb9Rp63HmC0AdJFzHzsn/qn7NRycL
X-Google-Smtp-Source: ABdhPJxOqjtMd2iZm414Gw/g3s/4B6+7cGFr46qbXy9AAMu7ATkAd3WUwRgjNv88g3QcdMQ32rsUVg==
X-Received: by 2002:a63:67c3:: with SMTP id b186mr7184478pgc.384.1626751713979;
        Mon, 19 Jul 2021 20:28:33 -0700 (PDT)
Received: from Likes-MacBook-Pro.local ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g5sm1380557pfj.212.2021.07.19.20.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:28:33 -0700 (PDT)
Subject: Re:
 0001-perf-x86-amd-Do-not-touch-the-AMD64_EVENTSEL_HOSTONL.patchFrom
 9f724a38754d3f99a1b332c11e72e9dd213289d7 Mon Sep 17 00:00:00 2001
From:   Like Xu <like.xu.linux@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210720032048.90815-1-likexu@tencent.com>
Message-ID: <38c206c9-ffc2-95f1-8590-5f14b7cdcfcf@gmail.com>
Date:   Tue, 20 Jul 2021 11:28:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720032048.90815-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The subject should be:

"perf/x86: Do not touch AMD64_EVENTSEL_HOSTONLY bit inside the guest"

Sorry for the noise.
