Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DC0C53210
	for <linux-perf-users@archiver.kernel.org>; Sun,  8 Jan 2023 06:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjAHGah (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 8 Jan 2023 01:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAHGag (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 Jan 2023 01:30:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B386BF62
        for <linux-perf-users@vger.kernel.org>; Sat,  7 Jan 2023 22:30:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso6086301pjo.3
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Jan 2023 22:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/O5w3F4C5T+vEj5//f116/Kvuf4mDqzw2DY/aDGU70=;
        b=h0YZfr1bGIqdGNdQnNWhbUC97ssSwwwFneGaJtyVjLjsLRb3Uzk+VbR6g492/J8RRu
         2V5w4tgT7C/xPpwL41UaPb+EL1hae7lmQcT49ixbMORvxjjUKeTvdPbIvVfN+IePO7Ot
         H0XYWy8MwTo6f6075ef2swYDHzhr8HNJRdcvvwCZ89bh67oQNE3reMQDI0PHe68w50GA
         SYjhxrxf0Mnf1rjPjhgBb3dxnDhurilsIH3ZjL+qX6/4XXfdTONytAO7hzb6mKi5dEq5
         0QGoLQSsNV6wEVjEp+jHM5mHiexb7hjxPSlPMLg43uaDIICCOC2CzFSUGEvGDYM4HP+h
         g/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/O5w3F4C5T+vEj5//f116/Kvuf4mDqzw2DY/aDGU70=;
        b=NVQACdYqu143x3TMPehMOrDH6R3H887yBrlyjD3mswlQwEdaTvm9HJj4WlytQMB8UG
         saC3gwYuhxt88vGC1Mvm4eu2o+ILYsLZPCWq86ItUlY2bqakCO0o8PLBrKegxAElPy4T
         vWHy2RXrDud86ex5o2pvM/QcAqmDoBgLd2bi+/47FWU9ANu3TaPRfaNBEZbuyqbQrDVo
         L1y5oDErKo9yiKGr8VOcyhwqL3vSeIZ68H8ehKgzSxDBhtenesr5EdQ5rQi6Zzece9n3
         vgaxUuiif45/sVIly0ZiAJjSOC0hIodtrKFEVZNCq+Y5XJO2l4pah19xqfcL/ddl+1+x
         +RNQ==
X-Gm-Message-State: AFqh2krzESIs6lnfTf+dkNl7boFuj7BQHjAryVZO6+JYCh3raAk3DsBW
        H5HMXNZV1WKIQM+5Mq+vYVKQmQ==
X-Google-Smtp-Source: AMrXdXvjD+zi3bYx2lRVs1KMakFn0Uys4QbCo6cqleQ1wQoWRBBEuDdsSLrxsPRqzF6lYr6pbuaRLA==
X-Received: by 2002:a17:902:7287:b0:192:e0ab:a4c8 with SMTP id d7-20020a170902728700b00192e0aba4c8mr16267512pll.22.1673159434493;
        Sat, 07 Jan 2023 22:30:34 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b0017f48a9e2d6sm3569125plh.292.2023.01.07.22.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 22:30:33 -0800 (PST)
Date:   Sun, 8 Jan 2023 14:30:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
Message-ID: <Y7pjBRFR6tYr/flM@leoy-yangtze.lan>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org>
 <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
 <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com>
 <Y7haGk30muVMjRhF@kernel.org>
 <Y7heE/e+g9IbefmO@kernel.org>
 <Y7jxZZ+jVrldfcPx@leoy-yangtze.lan>
 <b8adcc62-a403-bbb0-8540-4feea189ddc2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8adcc62-a403-bbb0-8540-4feea189ddc2@suse.cz>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jan 07, 2023 at 07:41:25PM +0100, Vlastimil Babka wrote:

[...]

> > But I am confused for removing Fixes tag, this leads us to have no
> > chance to backport this patch to any stable kernel branches, right?
> 
> Agree that leaving Fixes: would be appropriate to help anyone
> backporting the original patch to notice they should consider this fix
> too (although there's some disconnect between kernel and perf), it can't
> hurt.

Thanks for the confirmation, Vlastimil.

> Thanks everyone for fixing the fallout. I did expect some 3rd party
> tools would need update to work with the slab tracepoints change, but
> didn't realize it would be perf itself as well.

No worries, have sent a patch set to fix perf:
https://lore.kernel.org/lkml/20230108062400.250690-1-leo.yan@linaro.org/

Thanks,
Leo
