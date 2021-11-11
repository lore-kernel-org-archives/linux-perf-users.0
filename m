Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB81C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 08:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEA361212
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 08:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhKKItT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKKItT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 03:49:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BFC061767
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 00:46:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so3880290pjb.5
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X9IP5stMcpgy5gXCqX9WjtPNwYi8lKxGc0A+5eLNygg=;
        b=CNiAPKPOiMBHgpW43nm09SBn5/Bmpj8JIF8iR7UEYJZvzNvwJUjpk4XE7wWuOqOVzm
         0YnF3WP6krIxWDbY6vq6woejuw1WhfmDS0LLzx0p4RfIMyg17cvi+W6F1ijAGTDy/AQP
         Z55SeuY9UlHTcBkkhtX9HCcNQ5C6I2wS0v2xbllP9VPmvPZ07FqFoxoY1q1BdZVY4GYs
         BszFpBwGDwzob8jeIRmFcFvxkjeln8OX7w4RmoyVcIZbPknk+HkMNrcK0DVovmzJUYh6
         PAmeqAVYFkZg0vVdqT/F4fOuQfPneCLrv+eOyqJDA+x59Z+FjQNkGSyk1781AliT95dp
         D44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X9IP5stMcpgy5gXCqX9WjtPNwYi8lKxGc0A+5eLNygg=;
        b=El5iB0ZPYHCvOWdTrmlUTP3YcOfno+1BpePjCNhGAsOM+88lwhcGzKLw+aSNsQUGxc
         CZ8iOi8QmH+uuvw1nKIgUlSQsZkljndFjc5lwb22GV1xUl3+Kh5qUq5f9fjcEG4zZh6w
         +bFKuZUd3PwXbgaiQeBVJJRladLLZz3IblaLBaTaq4VoGaf6ls8P1MPB2e70alxDvkPY
         JRPpZ2kIEAq5g6pmGp/s/schMqQ/BT+rPvZU6cml/CLtS/Dionh6Qe1z4BJfk8SOdoOA
         QVdWKBojtw/s8+O3GoTkFoPJguCE8NAHrYb5Yi72YmmZ1qZhk169aBeFzVkPIrF5nypm
         ASjQ==
X-Gm-Message-State: AOAM533OO0s8VTp13IZARx1m0ufTIHMvu0ggTQ8W5Ag6EU2nJnKAvlm4
        GBskbFeq7DAhxcTlR6b4qAfnKw==
X-Google-Smtp-Source: ABdhPJw0g0ToYV0M2YMiLzuBLbDuk5PxfEXneXKZZqYsGl0dLARwgp4aWHhfLpm+6YzO8Ie14KDf0w==
X-Received: by 2002:a17:902:9694:b0:143:6f27:29ad with SMTP id n20-20020a170902969400b001436f2729admr6002968plp.46.1636620389862;
        Thu, 11 Nov 2021 00:46:29 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id h23sm2215233pfn.109.2021.11.11.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:46:29 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:46:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] perf arm-spe: Add snapshot mode support
Message-ID: <20211111084621.GC106401@leoy-ThinkPad-X240s>
References: <20211109163009.92072-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109163009.92072-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Tue, Nov 09, 2021 at 04:30:06PM +0000, German Gomez wrote:
> This patchset adds snapshot mode support for arm-spe.
> 
>   - [PATCH 1/3] implements the minimal callbacks to support recording in
>     snapshot mode.
>   - [PATCH 2/3] implements the find_snapshot callback in order to handle
>     wrap-arounds in the AUX buffer.
>   - [PATCH 3/3] adds a test for spe snapshot mode.

I have verified this patch set on Hisilicon D06 board, please consider
to pick up:

root@ubuntu:/home/leoy/linux/tools/perf# ./perf test -v 85
85: Check Arm SPE trace data recording and synthesized samples      :
--- start ---
test child forked, pid 17083
Recording trace with snapshot mode /tmp/__perf_test.perf.data.MI2iX
Looking at perf.data file for dumping samples:
Looking at perf.data file for reporting samples:
SPE snapshot testing: PASS
test child finished with 0
---- end ----
Check Arm SPE trace data recording and synthesized samples: Ok

BTW, you could see German has another patch set for enabling pid/tid
for Arm SPE tracing [1].  I confirmed that the pid/tid patch set and
current patch set have no conflit, and don't need worry the dependency
between these two patch sets (so you could apply two patch sets in any
ordering).

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20211111072714.GB102075@leoy-ThinkPad-X240s/T/#m932fd26d54278208331d4e3c32597cf63b6d4341
