Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A02C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Jun 2022 22:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiFMWCy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFMWCy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Jun 2022 18:02:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD3A275DB
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 15:02:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w20so10964756lfa.11
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSZAOUc7jDHG2RZNVp8mc5S+xeoioWqOft0dihIfjPA=;
        b=A+epGxaCSLgfadqz8qkKfJUDb2SI2zjLi4019IM7FloS0RQWHRPZNxzbLQMJlYHhJA
         LkBd/b2ghI9kdqlzIPw/rCmur9tWA7y/YMZlScR/0Nlp9pqmRRkZZatNtaN10p8rHlbF
         0IZ/D0VHG06/9BtY2soYa+1hqcqKEkSUCfKfbGiVJNlnuZmqnVBTkd/+BHmLx+izwhwg
         ni9fQ6NTHAbZdVEDqVdkkMUQCma7SIQRuvCN1c+Dud2I2Q47kTqmofIP2l1kaGPdzcUq
         ACIR8xR+sp1rf9g5ljwGD+TgYad1/a8trC4+yzcQnQunq+u/Kuqi7NYGg2OaceiEz2pD
         +aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSZAOUc7jDHG2RZNVp8mc5S+xeoioWqOft0dihIfjPA=;
        b=hXvvIDHzXp9b1FeIytW18e93SFYJBVBF0s5dEz/KUZ1FGZAngUYDkxK6yZg1rzgdLx
         +yPmx0+WpVZLXVFn3nlbXJnC9Xy8sk7FbYk3+YHrpSy/Xd4CSI8xHfrzXfRNP2JQNzNF
         g1GWvU/Mfd8bSk7Mr310rXg5zsh7aLbyF9M6IR3fic2jzHzpC0pDR+VJ0qF+PzYcPOzK
         1g/MwRSAi1c0zXppa8f6vUNmUAPbke5bsV4llD1CTOWsaeqDbBIPCll8mzQgC6Dpbxup
         YXv8aaWASI7qul7PyVOhRYM6Ph6bNkxI3XRq7BRdjyQ6u1bnvLNQQb5pcB3wBctDODWT
         g4Tw==
X-Gm-Message-State: AJIora9GpQUzq+9pDb5sCgC4hIf3Cg3VQrGQJ1acpQ45HpTljWngo0IE
        Tr2NCPIhwd1Y/hYjgwLLaYwdexbr13TZSpGUY9AYEg==
X-Google-Smtp-Source: AGRyM1tGbOk/N5Z0kR13FxIphP5KV5gSzMr3/W2uaDx+YVqR8fYtvcJm57MYyAfnMFouPXDniHgmcveY+sMcdwMrOko=
X-Received: by 2002:ac2:4a69:0:b0:479:7c24:c3e2 with SMTP id
 q9-20020ac24a69000000b004797c24c3e2mr1129822lfp.487.1655157771232; Mon, 13
 Jun 2022 15:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220607191550.4141024-1-blakejones@google.com> <YqZmSRS8UPQJzWFE@krava>
In-Reply-To: <YqZmSRS8UPQJzWFE@krava>
From:   Blake Jones <blakejones@google.com>
Date:   Mon, 13 Jun 2022 15:02:39 -0700
Message-ID: <CAP_z_CgkJ8RgWevJnDiq-+JjB=ni0OzJ3npwW+S9RZ66i0Y3Kg@mail.gmail.com>
Subject: Re: [PATCH RESEND] Add a "-m" option to "perf buildid-list".
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for taking a look at this!

On Sun, Jun 12, 2022 at 3:18 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> why 'modules' ? it shows all maps (including kernel)
> so perhaps -m/--maps would be better?

 I called it "modules" because it only operates on the kernel. Calling it
"maps" would suggest to me that it might also be able to show
information about the maps in perf.data files, which it can't (just as the
"-k" option only operates on the kernel). Given that, does it still seem
like "maps" would be more appropriate?

> also please state that it's from running kernel

Happy to make this change.

> any reason why not use the dso fields directly?

I was just following my general software engineering instincts to
encapsulate implementation details, so that e.g. the caller doesn't need to
know about details such as the "has_build_id" boolean. I haven't made
changes to perf before, so if that's not the preferred style, I can do it
a different way.

Blake
