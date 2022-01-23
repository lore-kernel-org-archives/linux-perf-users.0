Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1796C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 23 Jan 2022 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiAWTWA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 23 Jan 2022 14:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiAWTV7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 23 Jan 2022 14:21:59 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63881C06173B
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Jan 2022 11:21:59 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i14so12066864ila.11
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Jan 2022 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yZ/H1tgSZ4z/cr1F9MY1Zatfkm83Z/F8mlYqugCzVg=;
        b=U0VHXmSFv8/L9yMsoieqnR/H7TLPU/kW0tuiVSkY3HzkjMOkG1F1vsCASNksSorIAM
         vLyC2G/1C+oXFFRp9ZPn+yGd2xUx7SlpDwG/mXbbXlxicHCpTVuMuu6d7tlOrlJ9kRUI
         lZOOWpNgFhfipG2SnasbP1cDRSFNCbdBeyN1aT00hePgFt6gPyCfz8GkqdG+CJ9Td+VI
         88NMOMt9mx8w/J0I7pg3gbpPVJn11iBSo+Ra7p+D+7rUAsSnTD55O+WPMukKvdhCWLz+
         C7cSXl0yHW6ZnyozpkSLwP6hp0O1SBQO2gx37G8m1Htz6HQkMKWofbxBOwjS8a7vq5Yp
         /pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yZ/H1tgSZ4z/cr1F9MY1Zatfkm83Z/F8mlYqugCzVg=;
        b=Z3X3sQl9zJXpmPcM49JgfAld+NziW7PMtcrUb6Y5zKBb9AZYRakzf55khI+IYgSIOT
         nYn2zxjLTayA0EBDCP9DfQmWm2ROMMuWyV20FsHSuNRVxZ67XexA7Pur/mcw/Qqh7HQ+
         55VN7qNIeqgBjsFEQL6Xmwap/rDm+s3qvaDHaR20yw7tq2uK4wPvb2Risi+ruyFZYQKB
         CJKMY1+E56Ak3BGt4F/kvXLsWhTDs17dxsSXrI4q7PxNcDUogq6xHqJ7Vs1HM7IjIfWU
         fAS7GxzB2sfxA6uPtnPD55jRLj77CaPAtdS9gx+hf2PY377p0A79M9ZZoyj0n/hlPegh
         I2Lg==
X-Gm-Message-State: AOAM532qnJAH4QAxZCn2h/7WXtE4TLVcwyij/xdXart/5i+MtzV4AuLn
        KR2GeonGXiCFSxUdCRsmPxx9/+e25sKKrHf6XOfNg+5Np5sZ+A==
X-Google-Smtp-Source: ABdhPJxmom/+oeKUZpIDSVXzOKR5aPwZr3TlXP7V0Pex8YRXA1qKbRd7W1VJBFz2a1B9HfKh3ZvVcuWf3zMMuq3kz0E=
X-Received: by 2002:a92:c563:: with SMTP id b3mr7260324ilj.150.1642965718664;
 Sun, 23 Jan 2022 11:21:58 -0800 (PST)
MIME-Version: 1.0
References: <YevaTkzdXmFKdGpc@zx-spectrum.none>
In-Reply-To: <YevaTkzdXmFKdGpc@zx-spectrum.none>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 23 Jan 2022 11:21:47 -0800
Message-ID: <CAP-5=fWo6GrV0Ftpn6NU=GdaRSXkL7Z64PXQ6JywC8xYXxPjLg@mail.gmail.com>
Subject: Re: [bug report] --tui should not be silently ignored
To:     xaizek <xaizek@posteo.net>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jan 22, 2022 at 2:19 AM xaizek <xaizek@posteo.net> wrote:
>
> Hello,
>
> (Mind that I'm not subscribed to the list.)
>
> If slang isn't available during compilation time, there is a warning at
> build time.  However, users won't see it and will scratch their heads
> when `--tui` has no effect as I did 5 years ago and just found out that
> it still behaves the same (yes, I didn't report it then).
>
> Please print a warning that `--tui` is being ignored if perf was
> compiled without slang or even make it an error (e.g., don't define the
> option), but don't silently ignore the option.  I had to use strace and
> then grep sources to understand why TUI doesn't work.  Documentation might
> also need an update to mention that availability of `--tui` depends on
> whether slang was found during build.

Thanks for reporting this. The patch:
https://lore.kernel.org/lkml/20220123191849.3655855-1-irogers@google.com/
at least addresses the command line option part of the problem.
Consider trying the patches and supplying a Tested-by :-)

Thanks,
Ian

> Regards,
> xaizek
