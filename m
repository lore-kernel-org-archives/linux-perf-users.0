Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2C5C76196
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjDCIbQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjDCIbP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 04:31:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168549D2
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 01:31:13 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id oe8so20570472qvb.6
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680510673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ0DRg2iKfm5iL+YlhoQY3E/L2p8vxrwzgcX6elJoOY=;
        b=ROR5l8dvyTWoMCO0cc7BmYFaq/2ylHHx0ZpzjX8+1fQXCNWVKpll74qwB/GYHFuhKc
         6oM77oDDgI6cRb7RFbgFWUDihVasuxz5T9m1kYgVJ1oCDo+MncEw6TBcFnMHs6xNmI17
         qEzXWZY07aPrwAMKtIzk8BFN7T/hFI3vSoZ6xEeWynJidDVdDbvO6G7SpYm0dZfBS2SH
         RqrDYAhpY5iAVliQhgA9c9SnGcchPGZumwHGTj+x/tpbnhYbkZhjYTO4lMWwEGw3LscG
         G2i0aQmFWqssTp4gk/UnPFp5+4alvzMymT4xLuWwKdoa4yvi6QxwqnmwAbubHKBI+2on
         /SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ0DRg2iKfm5iL+YlhoQY3E/L2p8vxrwzgcX6elJoOY=;
        b=gwa96mCXSEAnDPoJR9hYJ8nmweF2WRtiJhy1tjDzwZecuJ6syxeCLjyWzdoKDQrc81
         WEEcaInr3hFChsCsIB9pCYJB4zVyd2tNfR8HyXpiLqpy3zLPaVA6fcykMg8GSFO+TM2L
         F/1buhteQ0b07QgTA6vD6aEXQFz/IOHH+pLkKObSX81TQdc4OZjuOqkrBjMTtZdk/icO
         KmPY6G+E3yN+WRB4KPB9HctO9NVz5mkzsi+qXNDpZkyMpX5p0HWfLgfs7weTBEfI9xKV
         OBcUDn4uRP2Gogbc4QLgi/SzuuVpx45/DqML7/W9PMqe8F9scZhiOJ4gZpGbqU2Mcg9f
         KXlg==
X-Gm-Message-State: AAQBX9cVLHsMbtzixpPvGlqQ8tgEnZre43/2Nnu81PRsl3xM2SuPp88b
        e65MP0QGSpPP4GaLs9MhZQIDGo57+d0ib71Dahe93Q==
X-Google-Smtp-Source: AKy350aSOduAGL8S6XLBrtGq+FcLxHEaGPlm3BOindsWMG/sF4glPJ9xsWf1dsiiZ5MxLb0u+chBHnmy71Hmxsv5iWk=
X-Received: by 2002:a05:6214:a53:b0:5a5:bce5:ec52 with SMTP id
 ee19-20020a0562140a5300b005a5bce5ec52mr6926174qvb.9.1680510672842; Mon, 03
 Apr 2023 01:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230327122527.3913496-1-peternewman@google.com> <ZCp/HX4YQLyOp0TE@FVFF77S0Q05N>
In-Reply-To: <ZCp/HX4YQLyOp0TE@FVFF77S0Q05N>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 3 Apr 2023 10:31:02 +0200
Message-ID: <CALPaoCjVnBnXpinpxBvZFrdqRd2OKuvpHaqjdCYJGOjFxVUMzA@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        will@kernel.org, catalin.marinas@arm.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 3, 2023 at 9:24=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Mon, Mar 27, 2023 at 02:25:27PM +0200, Peter Newman wrote:
> > Based-on: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
> > Based-on-patch-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Peter Newman <peternewman@google.com>
>
> Thanks for reworking the patch; the patch itself and commit message look =
good
> to me.
>
> I'd like to keep my S-o-b here for the code itself; could we please make =
the
> tags:
>
>   Co-Developed-by: Stephane Eranian <eranian@google.com>
>   Signed-off-by: Stephane Eranian <eranian@google.com>
>   Co-Developed-by: Mark Rutland <mark.rutland@arm.com>
>   Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>   Co-Developed-by: Peter Newman <peternewman@google.com>
>   Signed-off-by: Peter Newman <peternewman@google.com>
>   Link: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
>
> That follow the conventions documented in:
>
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Yes, of course. I'll send an update shortly.

Thanks!
-Peter
