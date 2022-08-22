Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22DDC28D13
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Aug 2022 16:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiHVQrV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiHVQpW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2022 12:45:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B8D18393
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 09:45:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so14669561edd.13
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hcFkdybpCNy+TrLwiiJNxRWM75St/es/Q6qYC3rPfCE=;
        b=gbP+Fv762ay8jKmLRSPptjSIc7rRdqRUlpV0zkkJmVORzUkMFDQa+RsU1RpPbEGCyq
         qSIQ4z2kdlsk6NLqzqS5cR6LOGKHKUHJJ9gP6RxlZbRpkQqNxnrLbvvTsBWZB7+MdOoY
         govbZ7BTknWj6L2kw+EBz9fvMd64Xnie6B1aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hcFkdybpCNy+TrLwiiJNxRWM75St/es/Q6qYC3rPfCE=;
        b=XzWVW/ECVOOwlf75a/wh+Zykid8IGk4qrYctuIUT8QYGWqmxQK77MDiVs2XFtpzA0W
         rtSesFHEEGI53TwbYqRGgTgJjXUbqOQFC6DK/xE00asn5PFih2D+qSWmnwEjpjQD+Vtf
         Q32Z124WQENNgvCIhBcpjQPnvq70bHSSsHIukj84K2swDyJ0IJMx0awGiymlSJlTf5T9
         TfLGzu2UZExOHQFBkUadZ87TXsauve21zGAKmzNmzy0QoS1PLW/D8oH6wQFPfkwxxwf4
         dkWDPeC6ZPiV6h5m54QHUunmtiwz5a3ekS55tampk9X6Ec55aaobtldXiWyNxQIpk+9H
         7fhg==
X-Gm-Message-State: ACgBeo0CLGaj1PJBZeAXpX4GDvf0oQva7kZYWxeDji37COaLvqQWOAdw
        3VXZ2z9NS+sE6mEHQ/mq4EHbbPNmaNF+dJ7B
X-Google-Smtp-Source: AA6agR4Fa44aJhxS/f/B/IJOWrFhdlTin/deCj8tG7jsGxjBooDa2yP5DxM8CQ2/mijHcJ2wEgTmIA==
X-Received: by 2002:a50:ff13:0:b0:43e:76d3:63e1 with SMTP id a19-20020a50ff13000000b0043e76d363e1mr25793edu.271.1661186720471;
        Mon, 22 Aug 2022 09:45:20 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b0073d7c35fea8sm2178386ejz.59.2022.08.22.09.45.18
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:45:18 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso6342579wmb.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 09:45:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr12375309wme.8.1661186718159; Mon, 22
 Aug 2022 09:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220822092557.210209-1-yangjihong1@huawei.com>
 <YwNcgdk/p18Cr+uv@gmail.com> <YwOBKwPmW/FX6hSS@kernel.org>
In-Reply-To: <YwOBKwPmW/FX6hSS@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Aug 2022 09:45:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRLxmiTWiy4f1wa4S3NRK1kdZoAind_AtBGvNx=CdhYg@mail.gmail.com>
Message-ID: <CAHk-=wjRLxmiTWiy4f1wa4S3NRK1kdZoAind_AtBGvNx=CdhYg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix compile error for x86
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>, bp@suse.de,
        ndesaulniers@google.com, nathan@kernel.org,
        alexandre.belloni@bootlin.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 22, 2022 at 6:14 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Linus, I'll prep a pull req later today or you can apply this so that we
> can reduce the window where tools/perf/ isn't building.

Ok, I took that patch directly. Thanks,

              Linus
