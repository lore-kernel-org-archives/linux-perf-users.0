Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459CCC0015E
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 10:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGQK1p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQK1o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 06:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890631A8
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcjXX5GWlegc91aegHozDG5ys9NXk4J7QfyGnNAR82g=;
        b=XrpZPjAsl8mA7ZAChOz1BPW2utDsrTt6W0f0wLIkGDy7RKO8FekuySZ6xmU+/0l2b/WrdZ
        UbDp1rDD2Ylm2q5KuxrTEwqeHD3q0mvKAOj3Vqf2Aqfhw9UT8z5BAoZAEHiY2fMGnK29HR
        ZktIiR5/LJDY0BS79YUN8cln1t31U0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-52ms2MI0PBuHerKTMAsVJA-1; Mon, 17 Jul 2023 06:27:02 -0400
X-MC-Unique: 52ms2MI0PBuHerKTMAsVJA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb34f7224so25315615e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 03:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589621; x=1692181621;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcjXX5GWlegc91aegHozDG5ys9NXk4J7QfyGnNAR82g=;
        b=h7vcEkH8R2uMe/hgqnkH95ecScrBD6BaBx/gKBbxpJ+3un+S7iHCWD3YTAf60GBQou
         caI99MeoKdKzmWcXAuqj+fSGUc4d34n9ex8q7JoZDUCuEhQgFzXRMoMrP17eZ+f+wCf5
         kvO+gierK6O+rusmkXNFS5yJGIttg0mMATE+gcXeI5hZ+fRXK38xxOjCji23f7Pmdevq
         1QjWW29ecTPS1YHH6JVvkKQ1JI0yzDbRz290jAQtmXj4Hi3tPcP7AuCNdvQliIWFAhSt
         zdKlZAhCTDRTBy9SmV9gaQp7zlykMWx1dlPX20yRUDRp4EAxhvwxyi5cnaXnTvnRydMW
         Afig==
X-Gm-Message-State: ABy/qLY1e43ThSzfTn+VdyCDmO011psIayCQbclWxH8HFUalBZ+gsuXN
        lf2qq0GHQqYv69tljd4UXE7GPvWxxa8rZ1n8n3EgYrjwlBn6apYOctM65XPEOLdWHM7GdxdB86B
        t2jqBClsxheZXzj7WMa/HwZJxcZCxgA==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id t9-20020a5d6a49000000b003142c17d921mr10297822wrw.38.1689589621623;
        Mon, 17 Jul 2023 03:27:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHg4QSrt7ASwOV1fEBcNK4Q/NKk0aYoKscyfvU06BxfjAob7ZBV5ewkV0pAvLD46ImkfH0r8w==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id t9-20020a5d6a49000000b003142c17d921mr10297812wrw.38.1689589621295;
        Mon, 17 Jul 2023 03:27:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b003143be36d99sm18839549wrq.58.2023.07.17.03.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:27:00 -0700 (PDT)
Message-ID: <4a7feeb3-0c9e-0dba-1023-4f0ae1bfe471@redhat.com>
Date:   Mon, 17 Jul 2023 12:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5] mm: introduce vma_is_stack() and vma_is_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-2-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712143831.120701-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12.07.23 16:38, Kefeng Wang wrote:
> Introduce the two helpers for general use.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/mm.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1462cf15badf..0bbeb31ac750 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -926,6 +926,18 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
>   	return !vma->vm_ops;
>   }
>   
> +static inline bool vma_is_heap(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->brk &&
> +		vma->vm_end >= vma->vm_mm->start_brk;
> +}
> +
> +static inline bool vma_is_stack(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->start_stack &&
> +	       vma->vm_end >= vma->vm_mm->start_stack;
> +}
> +
>   static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>   {
>   	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);

Looking at the comments in patch #3, should these functions be called

vma_is_initial_heap / vma_is_initial_stack ?

-- 
Cheers,

David / dhildenb

