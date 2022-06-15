Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A373CCA473
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 17:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiFORQZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFORQY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 13:16:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FC8338B9
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 10:16:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w17so8743534wrg.7
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pgZo5n70G6COKkVBdz4qrQNsM7PiGLO+2/SavlFvD8=;
        b=OlnKjl5ow1Oh4S6VXceBiwZX5K4wMjt3PX1ebwQoUU3tJc23zXjCrqR8eK+ejVhILs
         DNcnbZ0kuhp7kiMs+eDMpdWzQVGOfTDd98/0VuAh4vBvkObQkgDvk8aUyOzR9NdiI7vt
         Op8Q2z7fk8EreTJ12dY45XjhgvQh0PrbRd4m9SXYQ3c3tPS4dilVL6MVL4Nl2bAnxp0M
         zjK5AffDw6V4PxMPG1fWY9IJUFEpn+ODsOcfMTAlZEtEsYVctOlW1LM07In0oIQkERTt
         6IB1ZABg1UuWTzQE9gQtSsUMUJ83ndE5LyTOeZGZLxDYj1rorGXCaUCRL+2ZkupGUEVS
         h53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pgZo5n70G6COKkVBdz4qrQNsM7PiGLO+2/SavlFvD8=;
        b=AHEdKjq/AMhho5KuHYH0XxmmujTkH7OWYsBZXBv/60Pou9vHezdA2KS8wBfwE/cT2p
         9r6Q7W7VmBvU3rFICyrxDvL/EJ+PXaUMLWKVZxgiTXfFbPSGqN64qloMMO3PaViLphxG
         1yGz4GyTH8vOMk4BXcxPX3esjruZKqhqWb3Wwlvm8FBK3TIIah6fu32/BO0oe65t8pmI
         MFP2E8SzlCk1ahKuu73lHKPZxz0tgc345oZz4Lz6id5ZP7kuhcihKtKqFMCg+jzWyrni
         fziEebeASZ3ENQDMSj4tCq5LZ59ZS68+NFyzjWl4NCHp4B3EqROMr1xdN4f2YhR7JLt2
         hGzg==
X-Gm-Message-State: AJIora+9SHiWl2F1EPP96Belj5Z5BvwBXqO1W7s2roJ6zPdZ0/7inZqa
        t/by5NAcutoW8vJMVMDSbftoDh4vnYM9F7nhwPjq3cDfKC/odTM6xmM=
X-Google-Smtp-Source: AGRyM1vsZPqghyVs65e8Y4kH4wcX7ZThIYsefgHrj3GBfMAGpNlw4p9fAszMbQJPZdxguC5IL0t0A+b9poC0DohF0r4=
X-Received: by 2002:a5d:598e:0:b0:219:ea16:5a2a with SMTP id
 n14-20020a5d598e000000b00219ea165a2amr778194wri.343.1655313381607; Wed, 15
 Jun 2022 10:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045AqOtn4dbMNnTvNB=2WNVKVRTeshm1jVk2kYPsA9Vmj=jw@mail.gmail.com>
In-Reply-To: <CAP045AqOtn4dbMNnTvNB=2WNVKVRTeshm1jVk2kYPsA9Vmj=jw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jun 2022 10:16:09 -0700
Message-ID: <CAP-5=fU6Jk1+hZARCPjp34jQLo0n+=mLpcPGcR_2uwOLwHX3Dg@mail.gmail.com>
Subject: Re: Why isn't the augmented_raw_syscalls functionality included in
 `perf trace` by default?
To:     Kyle Huey <me@kylehuey.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 15, 2022 at 9:44 AM Kyle Huey <me@kylehuey.com> wrote:
>
> Printing of filenames especially is a massive improvement over the
> output of plain `perf trace`.  Is there a reason this isn't included
> in the main `perf trace` command?

It can be tricky for tools to get things like file names as a pointer
may be to unreadable memory, paged out memory, etc. Perf trace does
support adding this information by way of libaudit but we've proposed
doing it via BPF as a GSoC project [1]. Unfortunately there were no
takers this year.

Thanks,
Ian

[1] https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf

> - Kyle
