Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C7AC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 21:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCTVlX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCTVlW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 17:41:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9EE393
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 14:40:47 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ddbf70d790so334331cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679348389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7bUIqqPSkOdKE/QUFapYRZ6AQqknKxD1e9cPy+gENc=;
        b=ZFhHXWpbbAsBnj5tgd+/fQka5nC40wyw5X7vX06CbOqQtAx3imrImdpCzXJNWPW+cP
         w5bodTlKvXpSArYk/pqbC6jcry+HUk17Os005zgm9Qzdg4CAk0LXBj97bubnxumcR/nw
         DN1vzVCojmo3YJWxc3O92+WBjR7Vx5WN1kOD0+p+TDMVKAaOGk+5AotfJj7PMprRIMlA
         5jN1g+M6iPVdvuqsUPc1gAdWY3gkz0ir4NzxFvuHug7ll/OXC/hMQPkJqybvwGO/aA4o
         tCR5a7rfK/SqGxFnqb1sIgX/0NyeaxYZKyC+Io1M8UxPcijr2liPb6bDXe0xM2faYPmv
         otjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679348389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7bUIqqPSkOdKE/QUFapYRZ6AQqknKxD1e9cPy+gENc=;
        b=muZgQSJjuopLdWFM8WXRVK60Rpa9fKa+4htR5yVW7sl3YUnCR53OML1u9qX+YdoF8D
         o2OSOz9w2OCZUVnSU9WwmkM5IFHOlW8q5dVM/DYolSDH4sDYCjIaQvk9a4y0BB55ukio
         8+Uhnf87w60Sgus0d3/2ApUx9oe350zpDrYGWAtwUQfuGIDTf+7cH09zi/dZ16IbyYHi
         cRTfHL7NeRfn0yIn1zGCgjThYLUFbWMKUW0B9emXYwOq5SRbSET8QMYfDE7SyGSmjoNP
         cGOIWkwXo1Sfn5kbI38W88YSYrU7jG/AZqV4Sd9sl5JxWKd5oaL7ZftfR0DL26pepZzi
         /aCA==
X-Gm-Message-State: AO0yUKXATmmickgZuwEjxVH21Dn+DJdoRdjTd5tdU1wFRWP0axdFIAUA
        SvdQFTEnJNXqlyzlkJzqZsnASYaG8Q+Ou8uWMyBwkQ==
X-Google-Smtp-Source: AK7set/A9W//HEAlO3s4Q5Gpait/HW/x17AEGWfovWI6dJiEksGxiksvyrvnO5+TabKW4+YQyCqJHtLTA4gfL/RAsig=
X-Received: by 2002:ac8:5c52:0:b0:3e2:3de:3732 with SMTP id
 j18-20020ac85c52000000b003e203de3732mr38172qtj.7.1679348388679; Mon, 20 Mar
 2023 14:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230320201841.1133-1-bwiedemann@suse.de> <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
 <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
In-Reply-To: <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 14:39:37 -0700
Message-ID: <CAP-5=fXsY2BTkk2ugwq86n7OgqVXzG+n=pBGGpVDTixqyMC_Uw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Sort list of input files
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Cc:     Ben Hutchings <benh@debian.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 20, 2023 at 2:30=E2=80=AFPM Bernhard M. Wiedemann
<bwiedemann@suse.de> wrote:
>
> On 20/03/2023 21.48, Ian Rogers wrote:
> > I think this may already be addressed by sorting prior to output:
> > https://lore.kernel.org/r/20220812230949.683239-5-irogers@google.com
> >
> > Could you confirm?
>
> Hi Ian,
>
> I was testing on 6.2.6 which includes that patch and it was still affecte=
d.
> The trouble with sorting at the end is, that there can be influences of
> ordering in earlier processing steps, that don't get ironed out by the
> sort later.
>
> Some more experimenting showed that only the ftw scandir needed sorting,
> which allows to further simplify the patch to
>
>       """Replicate the directory/file walking behavior of C's ...
> -    for item in os.scandir(path):
> +    for item in sorted(os.scandir(path), key=3Dlambda e: e.name):
>         action(parents, item)
>
>
> Without the patch, a random diff in pmu-events.c starts with
> -static const struct compact_pmu_event pme_amdzen2[] =3D {
> +static const struct compact_pmu_event pme_silvermont[] =3D {
>
>
> While I'm testing on scratch ext4 filesystems where dirindex causes
> randomness, you could also use the disorderfs FUSE-filesystem with its
> shuffle mode to give you random order.
>
> Ciao
> Bernhard M.

Thanks Bernhard!

Acked-by: Ian Rogers <irogers@google.com>

I wonder about determining the order from the mapfile.csv, but that's
another problem for another day.

Thanks,
Ian
