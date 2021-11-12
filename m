Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C2C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 06:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF6060F45
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 06:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhKLGhf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhKLGhf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 01:37:35 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C3C061766
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 22:34:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id f9so9857985ioo.11
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 22:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n3ifJSINa0atqhGFbDnEA/eHioYq+9ivXhqmcnOaCOc=;
        b=frih+Khmg6MlUW11KvJ840mRuqwQpjSyXASGUoFDAV0MpRrlCJkejbDFcTQN0Hhpum
         EKIUsgatEJSZleCcNAhqlt0vb0mOPV5d8a7oQejgRvFvfyk3JP8BgxYm90XNiT39++7M
         VuRqX0e8rJkbwVHrqUm78sl9z1vCp0H6S3o4HiSpzeeoLQhiGmaQUqEmHUgVoXZpiyW2
         ylngfVuk+RqHW8qsa9exqmdoL12CknGKBdCaZ9ScAMTWRdg+QVcj4Ro/ZUCIe/JnQCnV
         IZ5OSYBzhy5puwb2jlwXt9vVXn0llsSpIpc80lhxAzwU+Vxe8bsAvEs4k88Il9YY5kXU
         gLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n3ifJSINa0atqhGFbDnEA/eHioYq+9ivXhqmcnOaCOc=;
        b=m8lUwvUuqcnO8cMToaRJBKDLUnPmOsrtRQCIF/VKQpvkI3nJjITWFR8bn84o/n4pij
         /0XV22C2BeKKo9GGIJ9eW0OEvv/yw5unOQXvVVQ731lq+dWD9dZQ5CAo+sdoBvTEqtOg
         XOrqZW6y5pzJ6Mk3ATF5DHYmBBOevasxV2ydJpwk4yAuDFwpY4YrwojtCuZm51wyWn2e
         ObEJRnzuOASp4/EVK3v3PkdiFmeog4Vyl69/yNccWgSBjtAK6vgsi+ApKcRFVe1PSBYD
         P5GmkyOtS9AmQEtBkOU9ENphss6lEuYM8BlS4jrxZeuG+3vvLolLflWyMrgl4hWPWVpn
         z69g==
X-Gm-Message-State: AOAM530H1zAqeVNpaBEWUm57Vbe8iqiYW5xL2LhFjRw1usdasZionwxo
        xZWi0oa4K0uDEsCKd+hMRRWFnRiT/w2VLKn6Uwu9sK8wStvkFA==
X-Google-Smtp-Source: ABdhPJzw0Cyy1WDEvtLmHRlnuCXEb8CUCoZ+n0od9hkN3ceGgQSBBgeIsG5wFhVGvPuwo//T5HRxx4sdqluPJsGjIfk=
X-Received: by 2002:a05:6602:2a42:: with SMTP id k2mr8961933iov.97.1636698884619;
 Thu, 11 Nov 2021 22:34:44 -0800 (PST)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 11 Nov 2021 22:34:33 -0800
Message-ID: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
Subject: Getting the latest and greatest Linux perf features on every Debian kernel
To:     debian-kernel@lists.debian.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

(Apologies, resending in plain-text to allow linux-perf-users to
follow along - the 1st e-mail bounced)

Hi,

Debian currently tries to match the Linux perf tool to the version of
the kernel that it is being run upon. Reaching out to Ben Hutchings,
he explained to me that this was done back in 2010 due to kernel and
Linux perf incompatibilities. This was likely the case, but it was a
bug in the Linux perf tool that should have been fixed. It is the goal
of the tool to be backward compatible. A problem with matching the
tool to the kernel version is that users miss out on new features and
fixes (this topic came up in a recent interview of the maintainer
Arnaldo Carvalho de Melo [1]).

Ben Hutchings informs me that making it so that Debian ships the
latest Linux perf tool requires updates both to the linux-base and
linux source packages. The Linux perf tool also has many other often
optional dependencies, like libunwind, libbpf, libpfm4, libtraceevent,
etc. In general, having the dependency will unlock more features.
Linux tools has its own copies of libbpf and libtraceevent, and so
these may pose some versioning issues.

I think it'd be great to get Debian shipping the latest version of
Linux perf for its users. Hopefully we can agree to change how Debian
packages perf currently and then work out the best way to package and
keep it up-to-date. I look forward to everyone's help and input.

Thanks in advance,
Ian Rogers

[1] https://youtu.be/aUDtN0qjxD0?t=5869
