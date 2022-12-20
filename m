Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD1C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Dec 2022 01:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiLTB6I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLTB6H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 20:58:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09D104
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 17:58:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gt4so10948585pjb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 17:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwWABKvuFP4RgmKS9H+uBuAFTn5t+z05sqc7dXE4FnI=;
        b=WlxZAD8qAm28cyRXiJvdf65gW9mHlAcE5IzwgdaHfa9fKNhIKBJThlEwzMwfjOWQlf
         DsD47j/ZJYPxxNRlrv0CGcok80iKMWlmhVX6yGbP1YoDxDb/1N1wXHKSjZtW1rRYDVHQ
         1yqsVlKncERtngYYNPrJ5v/PGG20EvMmK5KEG4v5maJboXDfBzwkcvJZR5tNxYdyyLMh
         kaKU8Hpzc8oP6zHLHwZiG8DIXSxqO6CUhE+oVk6d1AbFTGAN6/LevE/I2j5CqI/xHCUi
         8Ti1T3ai4EpQq4pfE7oEFWu7GhIwmVx9Z/ECxH2Zuk/8sM4k/wvHdVU0k86N2Ya1MUzT
         LabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwWABKvuFP4RgmKS9H+uBuAFTn5t+z05sqc7dXE4FnI=;
        b=vdoSivNXMdy7qID3nwlRvObqUrVlnerBrhtImsw/mFaeh+XRCbammBVbsmJ/z9wv0C
         4/cLz++ALWNCS6YZGfJSWMnYWVd9Dtu4Vdmu1zM+JwbFj65MDy4OPpMLV5LNxbLvFFyY
         7lBar3dnVIoQZNPka80qhks84jgBzQxUI29baQLVJ16k1wAPxGQslCa+xqgZv1VYJzmx
         FvYq00CQ/sCNXhqpQ4rXzYqa7IhWRx/1+60RWTA3tXWfqhDXVl4bh8A672i8iv/iF+o2
         JKrR0A41XGrg/brDQxfsA+FVWcE9KNADjSfbHRQ7T9lBf9sFXZWld8fQW8DXfb2HNyb3
         y/Dw==
X-Gm-Message-State: ANoB5plpnF9ZameLy8RlTcCXKfHLuvJsqT8w6Ohma7ouCyUFu1Pkl2T2
        42OojO14BxT6Goqf62ILEB/SCg==
X-Google-Smtp-Source: AA0mqf7TEFRuP19SHHJukzG4DJ/R9b3xcfnbq9/jCxFjJgqXPnpx7FEw1hzVVUm8h1VO1jj3hM4PuQ==
X-Received: by 2002:a05:6a20:4d92:b0:ac:16ae:f46 with SMTP id gj18-20020a056a204d9200b000ac16ae0f46mr51694192pzb.15.1671501485512;
        Mon, 19 Dec 2022 17:58:05 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id e35-20020a631e23000000b004784cdc196dsm6975692pge.24.2022.12.19.17.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:58:04 -0800 (PST)
Date:   Tue, 20 Dec 2022 09:57:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH] perf: makefile: add .DELETE_ON_ERROR special target
Message-ID: <Y6EWpXikuoxLnajU@leoy-yangtze.lan>
References: <20221217225151.90387-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217225151.90387-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Dec 18, 2022 at 06:51:51AM +0800, Changbin Du wrote:
> As kbuild, this adds .DELETE_ON_ERROR special target to clean up
> partially updated files on error. A known issue is the empty vmlinux.h
> generted by bpftool if it failed to dump btf info.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
