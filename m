Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43243C433C1
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Mar 2021 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037B46191F
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Mar 2021 18:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhC2SXs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhC2SXX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Mar 2021 14:23:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5436C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Mar 2021 11:23:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g25so7114222wmh.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Mar 2021 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8XUSkDZ19dxLREQWZkVVz+bxF/N6TKoOh1ws335Y/s=;
        b=oYraa0Pd0BiKDacdstcZ+26hLscyUJh7+f8Inn2c9SLcLf5MFQbOqWHKx894BrAp0f
         G4cqrV8pW1mBzkzRw2oAFbIcW5sR/C5Znb3BkRghCcILGaZ/nQuqktwdkAiBdYhcZYTP
         Xnx+92A+1h3hAXyzjOOLyHBqinSFycmZnN0vNe460hT95u1khvWbGNOsYsNJZ9Cm/au/
         y8/n/xjuBkk7KYLWZ95fPcfgec6g+fJWSwsnj7FxmplkulvWC5ib3lnqZCKVMouQ8SJZ
         93En1UPlvFW9xxTXTCOO7RqBP0gu7+zUfiNJObnvOzxegol1moqM4gzJFZEcCjkNGga6
         GV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8XUSkDZ19dxLREQWZkVVz+bxF/N6TKoOh1ws335Y/s=;
        b=jSclJphOWEdub3RFhfpMC+z1KOQ4uO+iDl+qwX/IYL212NO0c1WNsZEaIvp1fxCwe+
         DjxQUwGrMiN3J/Fs2Nm3JYoGy4tf1xBwsp+XdVMFEAdF+pzSdcylwNdcG4qVumZphu6i
         ZLyqOHtAckE8qIDyUxlAmEuCDDYFvQ4fTxdsZgML3CAqoqxkcxnJ/5qhQt4gH1RSJS2M
         YqEnB2wE1uMFwDlRVHnLoThWkeMqqoxPfLORKStuT1bo1VmVedEGbM29YsaA5Ik+nP6U
         ncce+eBOGoqWLIs8d5dyaj6wtkFZI2LWoWmqiWGxh22Nt4D3cslVXxFiENQFzrmI3oyA
         gjNg==
X-Gm-Message-State: AOAM53349LGv3dIirZqGyHJf4vEnn6NQFYJXAFlghsN/R2UCNAWp74Sj
        IH6BjndBL1hCmoRrML0OtPBZprydj7BsUPFNRRpCjA==
X-Google-Smtp-Source: ABdhPJxYhDYsQa3LcRFKl5cchR7LtX5mKzFRRyFZJIznwp+YRaFuQexGChGrdXCtVQkqeQQOu+GVe6TmA3nguT9QAoM=
X-Received: by 2002:a05:600c:acf:: with SMTP id c15mr358489wmr.124.1617042201368;
 Mon, 29 Mar 2021 11:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHb-xauBfO+Ted+0e-rGQaz-Tq3hqbbrFUCdSpOkWBvrWkZdXQ@mail.gmail.com>
In-Reply-To: <CAHb-xauBfO+Ted+0e-rGQaz-Tq3hqbbrFUCdSpOkWBvrWkZdXQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Mar 2021 11:23:10 -0700
Message-ID: <CAP-5=fU6Nxy+O65xGgG6z43AdfJCK5nrzPspnDRj0rJmzbi48w@mail.gmail.com>
Subject: Re: [Question] Cannot sample lbr callchain on qemu-kvm guest machine
To:     rainkin <rainkin1993@gmail.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 10, 2021 at 12:39 AM rainkin <rainkin1993@gmail.com> wrote:
>
> Hello~
>
> My config:
> ===============
> Host:
> CPU: i7-10700
> Kernel (5.8.0-41-generic)
> Ubuntu (20.10)
> Qemu (5.0.0, Debian 1:5.0-5ubuntu9.6)
> ===============
> Guest:
> CPU: host-passthrough (qemu -cpu host,migratable=on)
> Kernel: 5.4.0-66-generic
> Ubuntu: 18.04
> perf: 5.4.86
> ===============
>
> I try to collect lbr callchain on a virtual machine.
> Thus I execute the following commands on the virtual machine:
> "sudo perf record -e cycles --call-graph lbr"
> and get the following errors:
> " cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
> Try 'perf stat' "
>
> Does anyone know the reason?

There needs to be kernel support and it looks this hasn't landed yet.
From reading:
https://lore.kernel.org/lkml/f5847034-e720-b8ce-905b-04e2cfb7661b@intel.com/

Thanks,
Ian

> Thanks
> Rainkin
