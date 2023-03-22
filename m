Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1638EC6FD1F
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Mar 2023 19:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCVTrV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 15:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCVTrU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 15:47:20 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7725A4ECE9
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 12:47:19 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id m5so13450655uae.11
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679514438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08wnh3quRZ6nomUsXV/e3UBTZE3XR+agqVP4qBteAYw=;
        b=oNZ310hl+Q8w/39sMbzqdhg2jrH/AhIcxhCYOei7/P7aHZzP2OAI/tkt6B8Z2AqAGz
         lqIzM3unu5Sc8k0p0htnh7GrfjtG1bv0EAvuoFFQ4lKqvIks9sCiaAY0ytEj5t2hYkJo
         2W9yKBmIp1ONndVwISRfV0K+zz0zhRsPNghHGU8Usf6s/E/2F3z9XHZugwPQOzGFoKha
         T0s88Ia7ub/86GvCOu2/o6D7lJsSoEvCMs4kctsfP5SrdGwwi/XRGWa5dhAVFGmR981i
         +tXDvOCK+X62qYvO3zLImptgXok8lvUHBhk0cZeRqcSLj/5u1qb+4kTq8XFHCxxHW48o
         n/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08wnh3quRZ6nomUsXV/e3UBTZE3XR+agqVP4qBteAYw=;
        b=aeB6zWu7uO0jAOHdgtc8TpSWYCvMv4ksdKk9oVXsOe6IHugMt2erWBLS/WU0kBJCdp
         A++mMCdfCadu5O1RKzPFkseXrdtNZUqDxXKG0PD5pEeAQ2UgRHw+lpox+zsRWf9lu39O
         fO5Ayccbb+tudsVgLD9Om/rrvbJQqlK9caNWPZG3TQdeeZvdoh41KXvy5vabd+kQAPuU
         27l1gFILcYloftGVjUD8w1OvIB4Ovg9dzwtKm1AslcIYoTwl5IY+qJW9Vq25RsGAhDgN
         LE4mXG1z2TT9Ymdvcm4o3QPT5ZNQnZrE4U8KP3EAMz1bxLqsX9A9b+Y2G3W5WKUsop7b
         bvkA==
X-Gm-Message-State: AAQBX9cGt4qTPjITZ6fotBb0plmFurZdSZjw4mXfQWd3WTlvEBtSvP7G
        wlAoBATqsfwywc43VjcWdnUIHBg7LGrLQcY+8xKhP0PdhqQlvg==
X-Google-Smtp-Source: AKy350YH/RwIRzhUOLHjsA692J3PTgoEVLh1fW79IVY3Fj7uFEykjWu1hOzZIC+cL11T8QskfuLE/PZ/45eSNei/0j0=
X-Received: by 2002:a05:6130:215:b0:68b:9eed:1c7d with SMTP id
 s21-20020a056130021500b0068b9eed1c7dmr4556776uac.0.1679514438560; Wed, 22 Mar
 2023 12:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4z=LObbQ-KRRuH__pFsC=1r1jQ2r0e3TbCTeweA9YsDxA@mail.gmail.com>
 <01A1CCF5-C9C0-484B-A1B7-08514CE5453F@gmail.com>
In-Reply-To: <01A1CCF5-C9C0-484B-A1B7-08514CE5453F@gmail.com>
From:   Travis Downs <travis.downs@gmail.com>
Date:   Wed, 22 Mar 2023 16:46:42 -0300
Message-ID: <CAOBGo4zGRSYrq1qCPneEdH8FcOO=4C8DXb49Rk0aaiOE2rk5ZA@mail.gmail.com>
Subject: Re: Cross-arch analysis
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for the quick reply Arnaldo!

As luck would have it, perf-achive.sh is apparently not
packaged by Debian or Ubunutu (and the bugs have gone unanaswered) but
it's straightforward
to grab the script from elsewhere.

On Fri, Mar 17, 2023 at 10:28=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On March 17, 2023 10:02:37 AM GMT-03:00, Travis Downs <travis.downs@gmail=
.com> wrote:
> >Can I run perf record against a binary running on say Arm64, then pull
> >back the perf.data file
> >to an x86 machine and run perf report there?
>
> Yes, and to gather DSOs with samples, use 'perf archive' or point 'perf r=
eport' to a directory with the arm64 OS image using --symfs.
>
> - Arnaldo
