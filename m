Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4BFC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbiEYVwM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 17:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbiEYVwL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 17:52:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7819E9F8
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 14:52:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so44210712ejj.10
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyinZ5fnsRrQlBB9/BEXUkJe52nbvOp0IA1YT1qNZLQ=;
        b=DYNbNTHCGA3+q6Jyj3+tG7U4DthPafd2+ejUYADAkRfzOcAkHUzjIKAcspioJJXPTI
         68yacIqrEwW9LHvc3A9zE7xMxV3ffJlLhmMe4cPgxySxntvd2KdLuqsUuoIvMQGQj2AD
         /ZFSdTaAD7ARVQTbB18QRd9WTMBNqNrE2fVh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyinZ5fnsRrQlBB9/BEXUkJe52nbvOp0IA1YT1qNZLQ=;
        b=F4PpgfktfqFj3Absos8GW+ciY6C2JBeli0Erz5fYE2nz2Fhkv1Abnn7EonuvX3dY96
         2/WILUZ7zuliZHmpUhpJnB7E/EqXqe4WrOH8m7zScmAK04Yo4rlYAhMbtRW4h8FkglNN
         XQTJWdCx2vHvfGOY2nVUT9skGvQqI748XqruIP31Wyk+QFhDGmWlJR6MZ4naojva8N6j
         lFFQ93VEtzqm9+5DKzXuLtqtFvMn8Ph6vYqtqd39kRUbb8zUI9s77DAbT4obuW6oSw+A
         zfdIB2W378Td43jH+AF7t3xIssdh0O98bxRn3jipOiYrWo6nAgLm9WmLdD2NMxw+MZhW
         7J6A==
X-Gm-Message-State: AOAM533H+KgAaF6YJb5bKgdRRYfJ9k5xzFanxE1VWyEfkbKDsu7uudV3
        +Zn58QFn0LYrDJahaTa3/on8GfXysxHLDB6Fqdo=
X-Google-Smtp-Source: ABdhPJzPix4UwhpXHJQmbXsI7Fxe5fUQ1/2V5vaHvp6g7wZo8oewIEuTfH0ArddebIwAvUmw9vf5EQ==
X-Received: by 2002:a17:906:590e:b0:6fe:9c69:c5ec with SMTP id h14-20020a170906590e00b006fe9c69c5ecmr28654311ejq.486.1653515529115;
        Wed, 25 May 2022 14:52:09 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id e22-20020a50d4d6000000b0042bb229e81esm1604621edj.15.2022.05.25.14.52.07
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 14:52:07 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id p10so13214362wrg.12
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 14:52:07 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr26364386wrr.442.1653515526783; Wed, 25
 May 2022 14:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220524014938.46153-1-acme@kernel.org>
In-Reply-To: <20220524014938.46153-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 14:51:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3kZ19JRu_sYft5-=JYUa82ZW6BnfyU8FzU2uXmnJtjQ@mail.gmail.com>
Message-ID: <CAHk-=wh3kZ19JRu_sYft5-=JYUa82ZW6BnfyU8FzU2uXmnJtjQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.19: 1st batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 23, 2022 at 6:49 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>   - debuginfod support improvements.

Does this mean that things don't silently come to a screeching halt
because you don't have some debug info, and it takes half an hour to
download it all, and you spend the next hour trying to figure out why?

I'm not bitter about it. No sirree. I enjoy wondering why something
isn't responding.

                      Linus
