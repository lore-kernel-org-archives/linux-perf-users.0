Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A06EE4993
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 07:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjHUHLl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHUHLk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 03:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D2BAC
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692601853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7U5bfl+8GkQX2Ru+1ERv9dMSPVsL01uB88Kl7XRSQnE=;
        b=U711aD/ZpG/mH3vriXVATmj62kXd59uI6af3T0QbsljVVA6vxIlqAdR2iOyvsv20McSUTv
        ZXZqY2nE+oL5S0wcZ8bAI3u9Bp4KbSxwhBeR5xnrKf2SKwsjXvWdrgRze7a+eEeojQ7DLb
        KB+lI5uE98KFQe3pG9A6dghGCbnabVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-qnr2m92vPaGjBEUA5hzi1w-1; Mon, 21 Aug 2023 03:10:50 -0400
X-MC-Unique: qnr2m92vPaGjBEUA5hzi1w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe661c0323so19977215e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 00:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692601849; x=1693206649;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U5bfl+8GkQX2Ru+1ERv9dMSPVsL01uB88Kl7XRSQnE=;
        b=TmEYPqgd0795rupyTlLAJDN8lAguMiC/mQewaXG68PhIdSuq7U0H6YYgpjAnb7b4Fp
         sM2n29HTcj2EAk4BfFVh2ZVDxVY0FHk3hD3xXeMW6biP7PWWebRdKAqQewoYDhrIjFS7
         hpBiC+iIdrJvcYr4z5W47MDZMmS6djlkCQPb0GkXIQZN4rpHMP7Gu2jyWuEPwl2VyxN/
         VyqFPrD8WjpWh9ivUmvpvDe3s83vcBK1+u6GoQHalbZ/LEoInFtYqwZZ7H6+h1v2qfKG
         tW0Lo/NfhG89fvI2We6469BiGJqA0u5auLzYygeV3ncktcg+fFp1BZkxCL7WIIK5JkSZ
         +EfA==
X-Gm-Message-State: AOJu0YzAmanCcZIkXUa+5VCWnClUDlPoq8LMhNTZIFuvi4s+68ZeuBQz
        G0GDz58CVCaCHATnr4MYA7BW6Ukk/N6zg+/kaQyOhPUJ4e1K6OQrD/Y/M5ENPCNOfPzvsQ2ZVtM
        Y2Ay9Oi5TqFaieeEnL2ITIxbbmqjZtQ==
X-Received: by 2002:a05:600c:2117:b0:3fa:8c68:4aba with SMTP id u23-20020a05600c211700b003fa8c684abamr4085876wml.25.1692601849232;
        Mon, 21 Aug 2023 00:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7uYYKxazl0gdDW5+jbhdr1DMO67F+xV44FYK5z06H//ahedGsx1xXBk2h+YLibTlrepAj3A==
X-Received: by 2002:a05:600c:2117:b0:3fa:8c68:4aba with SMTP id u23-20020a05600c211700b003fa8c684abamr4085861wml.25.1692601848880;
        Mon, 21 Aug 2023 00:10:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:5e00:f3e5:9995:b58b:3782? (p200300cbc7155e00f3e59995b58b3782.dip0.t-ipconnect.de. [2003:cb:c715:5e00:f3e5:9995:b58b:3782])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fe1afb99a9sm11649923wmi.11.2023.08.21.00.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:10:48 -0700 (PDT)
Message-ID: <064da477-2348-9f55-b5c4-bdda60ee0fe3@redhat.com>
Date:   Mon, 21 Aug 2023 09:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: Add vmalloc_user_node()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230820194031.1395870-1-willy@infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230820194031.1395870-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20.08.23 21:40, Matthew Wilcox (Oracle) wrote:
> Allow memory to be allocated on a specified node.  Use it in the
> perf ring-buffer code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> I was looking at the perf ringbuffer code for other reasons, and I noticed
> that everything else gets allocated on the specified node ... except
> there's no way to do this for vmalloc.  I assume it'd be helpful here too.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

