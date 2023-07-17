Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19465EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 10:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGQK0f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGQK0e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 06:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BBD1A8
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZxqwFcIYi400ycUN1jF1UBiOV7Go/IiKqR9OlilEKQ=;
        b=SfykH/ii3gUCTwlyPuuCth+cz001fCWo95eWHJiSUOn65rniv0I8nUqum9T2TOTs9h0f/8
        YGi6pYFViNM1FtuYbUvoywXkP25N53QuE15VHpDDSb8eO792EaoINwhwjmRGMQ47lVVkCQ
        c+j9coZwgS0ZIcR7yWBv3h+UhR4T6rg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-hNb-iYVMNP-3an8b9Yd4yg-1; Mon, 17 Jul 2023 06:25:46 -0400
X-MC-Unique: hNb-iYVMNP-3an8b9Yd4yg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314326f6e23so2365839f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 03:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589545; x=1692181545;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZxqwFcIYi400ycUN1jF1UBiOV7Go/IiKqR9OlilEKQ=;
        b=I9ylG1iC+yEE2JRLxzp72cX1IZexlJmkKr0I0icKN6WTNEQsbgB9Hj3Kfj0JO+vKNi
         wj4n68lja1mQEEASGdfwsOlUKwjXK3tV4eV/mAfL8L8/t5vYuF8zX41lSf2PokTTqgG0
         A9jn+NobmFgVk9s7sFZBMeqBcAASt9TxQH13wwE6nAVJDSeHwg50+tcGKfG6l1ZwErwN
         2Dqr0Y0B62B0GWWFhfzecDVml7Ok1Z1RfnXkz4xLQshTmOPBDzsA6ACMXJwM+jFzQVh6
         KyelAcJ5S3+IHYRG8z1KtXMlACn3Dtg+NAF4utu9H2cW/abVRMEMmBYfdkxxO76hpqRf
         mxxA==
X-Gm-Message-State: ABy/qLb2CLhoYcbTP8bPAgCqpSftFMuQbd7Q9H5LzuQWQNmYLXRrpQnn
        HfFQx9CdB8I8Clm/5oCvLZ9USDGauLSn/UYYYOrGWZCGrzWGbOe5eVp0EjYRNM6vpwvC/9xUhoW
        Ec+Hp1dC7zzxwB/v1zKKvzD7/GWr5zg==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id i1-20020a5d6301000000b00313f54825b9mr10182299wru.40.1689589545445;
        Mon, 17 Jul 2023 03:25:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWwgj2gvrTcZVcFzDTLfBjRjMXpKrSXg5bhLw4PXADJbZO+n+htRPdtsID+emCjARx8zYmVw==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id i1-20020a5d6301000000b00313f54825b9mr10182288wru.40.1689589545080;
        Mon, 17 Jul 2023 03:25:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4641000000b0031434936f0dsm18732085wrs.68.2023.07.17.03.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:25:44 -0700 (PDT)
Message-ID: <2000511c-d551-5b3d-a9a9-adb4ba3be1f1@redhat.com>
Date:   Mon, 17 Jul 2023 12:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] mm: use vma_is_stack() and vma_is_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-3-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712143831.120701-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12.07.23 16:38, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   fs/proc/task_mmu.c   | 24 ++++--------------------
>   fs/proc/task_nommu.c | 15 +--------------
>   2 files changed, 5 insertions(+), 34 deletions(-)
> 

Please squash patch #1 and this patch and call it something like

"mm: factor out VMA stack and heap checks"

And then, maybe also keep the comments in these functions, they sound 
reasonable to have.

-- 
Cheers,

David / dhildenb

