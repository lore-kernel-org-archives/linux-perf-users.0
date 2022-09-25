Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29174C6FA82
	for <linux-perf-users@archiver.kernel.org>; Sun, 25 Sep 2022 01:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIYBIu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Sep 2022 21:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIYBIt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Sep 2022 21:08:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D136425
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 18:08:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3645578pjh.3
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 18:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PhYmVB1w36C/PuUoDl2/ladnwSSfZaMzinnoUgX1eNo=;
        b=ikpk6CG433w/+FCBSg6RWG95VvaV0TRxFgaoE3Vpz+u0BwT+rVpd+MvXRG61hmZ2B2
         zIU0qNDRojPu9fUAVbVthhtuDw0bUX5zL9F31CRnMH+edm/lkLit5P/1FhWa4ZfT8rcn
         /U5TvOK52Y0r3Iun50h9VK385z8VwbE3X9iso+LwA4ekff70veJVHiOdTcgOIGSedfMX
         g8isPVSglaFU/91idvV4bF1NuX3jTFP+WDl8o9QslJ4GCqwi7uoWsS3F+3SAPYGG4kzy
         3LGScMjouHRcwD6Dgj1x+GaTuh4L0y6XA4Wsmz2bcs43gWCK32/KprHLMK7qGJTzEY3K
         YRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PhYmVB1w36C/PuUoDl2/ladnwSSfZaMzinnoUgX1eNo=;
        b=ANmDCvAyi8yV9GbtQFzyrZBnFfidwG1QlWkSA4tA/WzD8LTgI4QDR0eeLobLh4T72Z
         1myZYEh0YJDxRVX6bm2QggN4Ao/01BLYHdDMM3QS2mqk38Rm5BKF9DaLn4xgZ6Ef3XFl
         CBAmg2CfNS7UGsTK8grPvYE0YNiF/uHaMwSeQAO4Rj8pZlA6zXvuY220X2dQvlCWd9Bb
         J7AwtLGsdt6JTyJrg1cdSucnsmkK1Y9H4xlkQh7/JcKYBGv3iTCqlJzvUEiYvC4b0fkA
         zRKKsrA4c/9HkdPpXnArQxNIYS3pSRKfXw8OWHb8fLnOw4RrHvr3pRdesvCl1lWqcFdz
         xGrA==
X-Gm-Message-State: ACrzQf0+WDhDa5vYSWoqJHVlmvMqJ5F2KxKzOsTY8T67ty5WjmTndwZm
        1lcEZs/MCwyEft3jvbPDcvueNA==
X-Google-Smtp-Source: AMsMyM697y5FG2rsu83zl7DtVPWN9etmXPv9zr3Vvwio9iWq3t53M8DZ4aAK7TSwLCtmResFyPD+Mw==
X-Received: by 2002:a17:902:d54d:b0:178:a62d:d4e6 with SMTP id z13-20020a170902d54d00b00178a62dd4e6mr15823961plf.73.1664068128154;
        Sat, 24 Sep 2022 18:08:48 -0700 (PDT)
Received: from leoy-huanghe ([39.144.40.86])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902bb9400b001635b86a790sm8356951pls.44.2022.09.24.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 18:08:47 -0700 (PDT)
Date:   Sun, 25 Sep 2022 09:08:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/4] perf record: Fix a segfault in
 record__read_lost_samples()
Message-ID: <Yy+p41f19aiwi/cd@leoy-huanghe>
References: <20220923173142.805896-1-namhyung@kernel.org>
 <20220923173142.805896-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923173142.805896-2-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 23, 2022 at 10:31:39AM -0700, Namhyung Kim wrote:
> When it fails to open events record__open() returns without setting the
> session->evlist.  Then it gets a segfault in the function trying to read
> lost sample counts.  You can easily reproduce it as a normal user like:
> 
>   $ perf record -p 1 true
>   ...
>   perf: Segmentation fault
>   ...
> 
> Skip the function if it has no evlist.  And add more protection for evsels
> which are not properly initialized.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Leo Yan <leo.yan@linaro.org>
