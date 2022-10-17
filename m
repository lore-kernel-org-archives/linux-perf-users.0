Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D1C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Oct 2022 09:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJQJ5x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJQJ5w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Oct 2022 05:57:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F650070
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 02:57:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z20so10277481plb.10
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONqZkMmZ1RpKkSjyeSmUqOZbaL3fytox8E3NE9aS+vI=;
        b=Dh5HYh8Eg2672pS57xSCxoeD9g+WV0n9UUC8Pb2aEsEzs6VNArFAK0NfGETEfVjtrj
         JxK7P/VgFEMtcI6MfUH68sy0r34mKz/qFREYvuFey+EPTIw+K3HA9xwRPcN1I6ee8A99
         ou1Vx7Mr7cfXyZEV2nJ8CtdJag25aWYh+eDQYkjc0ECCRfXis3+vb1ot5nNQugJpt3V9
         XTukHpwjQ+ljrpJroZ2gb2WrM8duKT9pdYSG84Zyl4pEdPKb9gV3Ztdo5pkVJUzyoJYa
         HsnmQPpkhM4Dt4xmvi+GP/34/fSWQvTDCs1I0ptq5MdZKtjKlvkBvkI+iRGhIqa2TFWX
         C7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONqZkMmZ1RpKkSjyeSmUqOZbaL3fytox8E3NE9aS+vI=;
        b=vKeqk90q482rMtYWAwSrCWwtXDQlKfNlh18OCb2+rg4+OPgrwO+kPRbz6RogliMaZ6
         wdAI1+f1JI5prR2Sb4dK3h4DGKRRO9sOllP5tWLNyolpV0mbqxs6LVBDPB8VOpcI6k5b
         bABoDBEokS1Tnttx1ByQMHwn1FA/ceGhiqhsoV5itlJhEsF6H8v4G1DTQWSG2dJmRHmX
         mOZyH7/mcaIgVBhaxK1LQnLv47+3fQWVYsDzNUE/hntak0HV19Cf1vReViSxogIErNyk
         casoeV2f/iPiIaYloct+QEWkyiyWoosH7BuMsmqzC7TkpR/xgY52ygEnJm2v0ah0/YAH
         3kGQ==
X-Gm-Message-State: ACrzQf14VLWqQEug/4+Ua6RX20NfgVxe6s2P97lLcsDeSjmkc3Lj0l0M
        RZaczSr2yogGEn1utLhhrS7Isw==
X-Google-Smtp-Source: AMsMyM4j9wyEPf5v9ECWaO6yORb0mmdYcQCja+PZVGyFZS1r6b8wdYSvOWkB3WxjgZtvgj9suycKXw==
X-Received: by 2002:a17:902:ab89:b0:17a:67c:b9e9 with SMTP id f9-20020a170902ab8900b0017a067cb9e9mr11084858plr.55.1666000671541;
        Mon, 17 Oct 2022 02:57:51 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.17.194.16clouds.com. [45.78.17.194])
        by smtp.gmail.com with ESMTPSA id h22-20020aa796d6000000b00561b455267fsm6705742pfq.27.2022.10.17.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:57:50 -0700 (PDT)
Date:   Mon, 17 Oct 2022 17:57:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, suzuki.poulose@arm.com,
        linux-perf-users@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Sven Schnelle <svens@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@foss.arm.com>
Subject: Re: [PATCH] perf tools: Fix man page build wrt perf-arm-coresight.txt
Message-ID: <Y00nFxrcV7TVqmJO@leoy-yangtze.lan>
References: <a176a3e1-6ddc-bb63-e41c-15cda8c2d5d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a176a3e1-6ddc-bb63-e41c-15cda8c2d5d2@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 17, 2022 at 12:35:49PM +0300, Adrian Hunter wrote:
> perf build assumes documentation files starting with "perf-" are man
> pages but perf-arm-coresight.txt is not a man page:
> 
> asciidoc: ERROR: perf-arm-coresight.txt: line 2: malformed manpage title
> asciidoc: ERROR: perf-arm-coresight.txt: line 3: name section expected
> asciidoc: FAILED: perf-arm-coresight.txt: line 3: section title expected
> make[3]: *** [Makefile:266: perf-arm-coresight.xml] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [Makefile.perf:895: man] Error 2
> 
> Fix by renaming it.
> 
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Fixes: dc2e0fb00bb2 ("perf test coresight: Add relevant documentation about ARM64 CoreSight testing")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for fixing, Adrian.  The change LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  .../Documentation/{perf-arm-coresight.txt => arm-coresight.txt}   | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename tools/perf/Documentation/{perf-arm-coresight.txt => arm-coresight.txt} (100%)
> 
> diff --git a/tools/perf/Documentation/perf-arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> similarity index 100%
> rename from tools/perf/Documentation/perf-arm-coresight.txt
> rename to tools/perf/Documentation/arm-coresight.txt
> -- 
> 2.25.1
> 
