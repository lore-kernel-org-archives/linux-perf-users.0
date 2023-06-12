Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0677DC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 10:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjFLK1L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 06:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjFLK1A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 06:27:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE536E37
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 03:06:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6537d2a8c20so3266673b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564308; x=1689156308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBOb/U0RqfC5AxKUFvKlMDVQJb0zRdeSC6F/8xGEJFw=;
        b=LBQ3BljnQGxIzf87eWYR5E5Qak8frDZ78Lod4++Bh8iZ4VII5iXjAoj4BhKBnrAk3J
         veJthmMisy1tJoT50qACfrqjypIPLD+ncUDbLjtIo20RJlhRXrzggnO3OEOyJrVKrQ4K
         Az1yBCopvMuCCnRUlcXpb1eK3v2QNQ+FzU5yocBH9KhR3La53av/CM5HSHJQULbHIi1q
         dm+pkp9bjgLGDeNDTFXDXC6IQKsgr7g/8zy3lgqZeBPh166HySqNtzgFBLdAVTvlytJI
         f1RUtjZwqTlwXSgSoiPZLY4dQsiS19fLQYwckxmdM1EpWf30zOf/bm9JbCuSD0soEsXK
         uXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564308; x=1689156308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBOb/U0RqfC5AxKUFvKlMDVQJb0zRdeSC6F/8xGEJFw=;
        b=GPAHioL3cVny6+QrNVkLYk/TPxyxxYTSKHE/Pq7nORla3Iv6XMXiPLmmwbSdsPip55
         iEWZc+JEsNJBDtlGM3xaTYS86cT9UcOeORAcbiHEYh7JDNMDYgYh1fbs81oHN3kgxhRJ
         sFJJhILqH5movJ4eNWwHamBRlWD+ms9LFPwbJ/K3RVKv3LhyKK8i6A626GtK5bysZ5SH
         cC/W5zUuDsAhS2ZI0L9pI90VgIfZKg5DXNF+Ne6in04ivcag+cLo7gQ7t6sSXL2w0R3O
         qYa+roLEr2Q8rR+qcvg4QI7W1bvHuAiwe8PIkxmrpZ3AIjal5bzrsFygU6h2QYTAb0qW
         NfaA==
X-Gm-Message-State: AC+VfDzm2W82ftksKqzaCKdzGycaekG5E13Y1Vod4joVy5/E/VfOVM9Z
        8scrKjGawGguV+GB3TC/LFudiUx3D+vQborWwsrUTWT8
X-Google-Smtp-Source: ACHHUZ4KCzP/G4lYu52oALkIYWunkw8ZVaCyIXstDCU3a451MIoJ4eGWvKOqUJaHFn+xmbS8zXrglA==
X-Received: by 2002:a17:902:daca:b0:1ae:5b7:e437 with SMTP id q10-20020a170902daca00b001ae05b7e437mr7314292plx.4.1686564307842;
        Mon, 12 Jun 2023 03:05:07 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id u24-20020a170902a61800b001ae5d21f760sm7832848plq.146.2023.06.12.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:05:07 -0700 (PDT)
Date:   Mon, 12 Jun 2023 18:05:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] perf/core: Bail out early if the request AUX area is
 out of bound
Message-ID: <20230612100502.GE217089@leoy-huanghe.lan>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-2-xueshuai@linux.alibaba.com>
 <20230612073821.GB217089@leoy-huanghe.lan>
 <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 12, 2023 at 04:35:07PM +0800, Shuai Xue wrote:

[...]

> > Furthermore, I believe the AUX trace pages are only mapped for VMA
> > (continuous virtual address), the kernel will defer to map to physical
> > pages (which means it's not necessarily continuous physical pages)
> > when handling data abort caused by accessing the pages.
> 
> I don't know why the rb->aux_pages is limit to allocated with continuous physical pages.
> so I just add a check to avoid oops and report a proper error code -EINVAL to
> user.
> 
> I would like to use vmalloc() family to replace kmalloc() so that we could support
> allocate a more large AUX area if it is not necessarily continuous physical pages.
> Should we remove the restriction?

As you said, we are now able to support a maximum AUX trace buffer
size of up to 2GiB, and AUX trace buffer is per CPU wise.

Seems to me, 2GiB AUX buffer per CPU is big enough for most tracing
scenarios, right?  Except you can provide profiling scenario which
must use bigger buffer size.

Another factor is the allocation of buffers from kmalloc() offers better
performance compared to allocation from vmalloc(), this is also
important for perf core layer.

Thanks,
Leo
