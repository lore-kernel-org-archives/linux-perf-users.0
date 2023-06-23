Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68951EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 17:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFWRtv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFWRtu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 13:49:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BF2136
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 10:49:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so22781cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687542588; x=1690134588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r04BHlizhRZLGJ1YZnjcXjNiI+FB4SYaUpufMSPzSIE=;
        b=Gcp3kwGQyU3wA/vQ7aCv7MRv0XTVapDae5NZtzgFVedTbdrcJUaJz/bZdQC/JTySlY
         /WyOUT9NJOrfv6gibmSVPo+2sU7pFYNem1RtsBEtbpUja0NfbYrbFnVQsHq5XJrVLoyp
         KcmkPbP3C8RCXpxCu1M2SUHkVDSaUsIPqn99FEPpxTnorn4/s0wYGsgvE+8YyzNCS4Y8
         gTrG7ySEQHxqD5roj6JWDnnMwej3hqCstHziPKOP82pbctAuqupXqp3O+iZqCzDJJCF6
         b+NcF4197s9B1ZxKzE7+nH7vJn3UyytaLhzEa1xGdB0r+1AIZq1bQ6glV5swngbEosUu
         fEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542588; x=1690134588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r04BHlizhRZLGJ1YZnjcXjNiI+FB4SYaUpufMSPzSIE=;
        b=UQL55SRu8MkAaaqUujEDVH5Sgmp4YBhlSdKMDkbWb90uEOHqRKX1qNGAmdL3vjEixV
         xyqAGQkBKl15TF6WUap/hhMRMKkjBHCXVcr2+peoE7Xs9ymiRYRpXMm5CEe9fNM87S9u
         uv8Y9ay4tPKuSO39V8K9mVveP2LS1YiGj3Afzyncl+ww7KaNFyYkuK8zzXwzKBDYP5l2
         uJLNgDCmEJiup4BOC2r//IqBhDUuj1Av9CGYLctqQDmhWAGlyclQNRN6lqAktGQYAJA4
         uEIZNIaTfnOG67YKjm7nX5LOzZPER8ydCWjOiNubWNxvbrkdbKN7iOKvw/sg5ZHE+/C5
         jkZw==
X-Gm-Message-State: AC+VfDwi0xV2N0W2quA1lArHXgncEpUja/2aACTrtG0yJr+nixl/BwTH
        uj+YOTVfH9rbN8JBbaxHPYvwQHbRORSqSQqgHzOYmQ==
X-Google-Smtp-Source: ACHHUZ6m/vWb35pDLix63PiACTwBXg9BkP9Fk2MLVjV9iOth64o30KyhWZFkO7nM6JqfHIAfxUoZnjZzPMfCx0PFqn8=
X-Received: by 2002:a05:622a:18a4:b0:3f8:99c1:52a1 with SMTP id
 v36-20020a05622a18a400b003f899c152a1mr191040qtc.10.1687542588054; Fri, 23 Jun
 2023 10:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230623043107.4077510-1-irogers@google.com> <64741e8e-e81a-afb9-9ce3-9c2d6baab44a@web.de>
In-Reply-To: <64741e8e-e81a-afb9-9ce3-9c2d6baab44a@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 10:49:36 -0700
Message-ID: <CAP-5=fVwhiGJEqTST2bfX8cUALpnTxELSHrvKtyJEPjqQjOacQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf unwind: Fix map reference counts
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 9:18=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > v2. Add missing map__put when dso is missing.
> > ---
>
> Please omit such version information from the change suggestion.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4-rc7#n698

ah, tldr. Will correct in the future.

>
> How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

In general we've not been adding Fixes as there is a danger a backport
will introduce a use-after-free.

Thanks,
Ian

> Regards,
> Markus
