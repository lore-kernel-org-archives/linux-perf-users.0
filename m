Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 17:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbhLWRrq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLWRrp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 12:47:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7AC061401
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Dec 2021 09:47:45 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r2so4783443ilb.10
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Dec 2021 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dg99kfWjFGh3eYKA0oxg4PGME+1LXKYN6VD+tZm1TM=;
        b=CXb7SNO/9FiFQUektVeCG5IjnPeqk1oQkjjcAKQcsLqTVaKWfofqMrAOEeSePUi5LV
         JrZJ6b8fVYcDQxIaMzYuN5kbIVYGUQFRKMTLjKFbXEAyzXeiKh1eeCZbOCjnj2ylwl1y
         r4qhZ3pWC5pdlVYOGEABuuiMf6hIZ6qw/r5SdzJyJx5iI5+7gf3rDouJP57ubPUtpsoT
         0Iedc2NpcrNp3pw2ivWV0TxUjtGC0jPskV3j/MvTUepuVOBJ4kiHj0Atetpu3R69lTKd
         wzQvg9CcUhEmDUJaO+M2EkcuQmT8U8RekQVZ+x5a0SzvTMut4lh8zzndeYvLeE8j8ptt
         Actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dg99kfWjFGh3eYKA0oxg4PGME+1LXKYN6VD+tZm1TM=;
        b=bZhloVC9i2lXxYjwfveF7x9HNLvSgiO68llSGhIIfloxHpm5PuYto4xQpFot1krEMs
         74CiMUZQ66euOxoL0puwUxw9kUpGm5ESHQ7WR5tEfuKk4BmORZwbmpN+UW7Y5cqwCDwk
         fxqE51eABguvw2A5XNs/qYqi10cN46+JU3qXRQu33dqFnD9u1dw0U8VBmZdoi98eZu8i
         MRpNQqE+7UEN/hA6xv1dKmKMNEiZekxNq2A6QnUYrPo4jUZ1zvpgajRSE4QYK9PGy+LK
         Mw3hwarGY4esFCgaj+a7vT4qMNYX0yHznBmNcjCP1VNQagN2a2pJ6ODC9FdjGlZE8BBX
         HjdA==
X-Gm-Message-State: AOAM530BsA5ztRHY/jWRgxLTzyYAGgFeC44G1knufhwrpXaQUtkCjpFF
        lb+UUR9GMN3DSkhdwp0kBRO9WLVjMWUtzew19fCkEjUM1Y8=
X-Google-Smtp-Source: ABdhPJw40TL9gleHPB0HujeS3jGvhTpel2J+osVT4iusX7PtNAlVSzQ8F+/ltfIuJAonK+ZzkBqtB9EFg8yB3TH3npY=
X-Received: by 2002:a05:6e02:19cd:: with SMTP id r13mr1619244ill.89.1640281664797;
 Thu, 23 Dec 2021 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <OFF9778928.59F62D85-ON002587B3.00757F55-882587B3.00766874@ibm.com>
In-Reply-To: <OFF9778928.59F62D85-ON002587B3.00757F55-882587B3.00766874@ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Dec 2021 09:47:33 -0800
Message-ID: <CAP-5=fVrvfU==zp+OzKbJrUi4p9gKvSifnNEmYdk9gU8P_wF_Q@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix perf-record manual typo
To:     Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 22, 2021 at 1:34 PM Kevin Grigorenko
<kevin.grigorenko@us.ibm.com> wrote:
>
> From: Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
> Date: Wed, 22 Dec 2021 13:21:44 -0800
> Subject: [PATCH] perf: Fix perf-record manual typo
>
> Signed-off-by: Kevin Grigorenko <kevin.grigorenko@us.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt
> b/tools/perf/Documentation/perf-record.txt
> index 3cf7bac67239..52f98d53a97e 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -258,7 +258,7 @@ OPTIONS
>         Call Frame Information) or "lbr" (Hardware Last Branch Record
>         facility).
>
> -       In some systems, where binaries are build with gcc
> +       In some systems, where binaries are built with gcc
>         --fomit-frame-pointer, using the "fp" method will produce bogus
>         call graphs, using "dwarf", if available (perf tools linked to
>         the libunwind or libdw library) should be used instead.
> --
> 2.33.0
>
>
