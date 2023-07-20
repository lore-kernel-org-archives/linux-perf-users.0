Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D0EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 21:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGTVQc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGTVQb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 17:16:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1942D40
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 14:16:26 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3b7fafd61so883500b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689887785; x=1690492585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG+ThjVmfgJOgCEH3FGED5B6h6SrS5o6Axcjc3bwSOI=;
        b=PlsOhuAwUTnsUHdCrAacS252UIxiMGOunaN7sjGqk6IdEDvWSfDkeAaUkUyPQ8TsWM
         dSwDx1M0yS6cP18SL/J1e1PXgjFT+K9g6o5oDfjX5KtL6NSbkgGERWclg4dqpb5RXbRk
         mgSxD4tswhi0vnWZ7QVrXYqDP0D8ob9/9QUQ6YAxjdxcpwGDgQkVMpn2oIljVP+8n250
         Cvgx17BBdzoeGzK2qImORkfKCzx9ew4k1bBToLGVABe29MENH0fq/kJj3qouvSeuyZdO
         /Z1VN2fJikHf9jRa4qnEkTjqz53WsvY8WrwXfru0TXBwVShYekLaJiGmdg8c8HjFud4b
         s4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689887785; x=1690492585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG+ThjVmfgJOgCEH3FGED5B6h6SrS5o6Axcjc3bwSOI=;
        b=Et92ujphxZ4QJeXD8i5axP951OCUwnQGf6O1oHyEAfeZ+dsE96Q2mm0ws9KqwTY7aD
         Oo6Q7rIRl8Cug7YtyNtDypG6bLQYsdiTB4/c2qY5oyb30suPNC6nitX1XNjDxWBRWtMW
         ycw/edLaT80aBokVa53VftFvkO2v05sUVqTNYMsq149Z0yfgGfrKH8u/DXMxJdMfvdyF
         YnUDEPRnr7x+ymX/9grcVV0AJNaDS3YS3oDViaX0rPuaR3KyqkQ1j9oHu97jFu6hTruh
         KSmYZUTSy+r7OTXVSZQWwB7l4MKwM04U6PwzH3NZtK3F8F9IHpZkJEIr4n0Ww8d7ZpJo
         ZGbw==
X-Gm-Message-State: ABy/qLZTQe68cvVEyCMhJHHCInQTz7adm2eYvKKpabW7Dmog7qsoNSxS
        L9XQUYev7za3RuMpA6NAq+seXyMg7g/dOSz73nQR
X-Google-Smtp-Source: APBJJlEhgxTXc1qyzkAvHpHuXwIG3OtHxUZ6QwrqTdkR8L2OyhsuJu/aP2P2r4S2KF4Tr6uErZhsPZjFCuLra+hXwe4=
X-Received: by 2002:aca:1218:0:b0:3a4:8e9b:e5cb with SMTP id
 24-20020aca1218000000b003a48e9be5cbmr84720ois.1.1689887785358; Thu, 20 Jul
 2023 14:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-4-wangkefeng.wang@huawei.com> <CAJ2a_DfGvPeDuN38UBXD4f2928n9GZpHFgdiPo9MoSAY7YXeOg@mail.gmail.com>
 <dc8223db-b4ac-7bee-6f89-63475a7dcaf8@huawei.com> <CAHC9VhQzJ3J0kEymDUn3i+dnP_34GMNRjaCHXc4oddUCFb0Ygw@mail.gmail.com>
 <1e839238-c78d-71e0-28ae-7efff0e04953@huawei.com>
In-Reply-To: <1e839238-c78d-71e0-28ae-7efff0e04953@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Jul 2023 17:16:14 -0400
Message-ID: <CAHC9VhRBxQmxegjLQ73J7zMOTpsOOBTj9PwZ6BptV=6ToC+1BA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 20, 2023 at 4:28=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
> On 2023/7/19 23:25, Paul Moore wrote:
> > On Wed, Jul 19, 2023 at 6:23=E2=80=AFAM Kefeng Wang <wangkefeng.wang@hu=
awei.com> wrote:
> >> On 2023/7/19 17:02, Christian G=C3=B6ttsche wrote:
> >>> On Wed, 19 Jul 2023 at 09:40, Kefeng Wang <wangkefeng.wang@huawei.com=
> wrote:
> >>>>
> >>>> Use the helpers to simplify code.
> >>>>
> >>>> Cc: Paul Moore <paul@paul-moore.com>
> >>>> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>>> Cc: Eric Paris <eparis@parisplace.org>
> >>>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>> ---
> >>>>    security/selinux/hooks.c | 7 ++-----
> >>>>    1 file changed, 2 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>>> index d06e350fedee..ee8575540a8e 100644
> >>>> --- a/security/selinux/hooks.c
> >>>> +++ b/security/selinux/hooks.c
> >>>> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_a=
rea_struct *vma,
> >>>>           if (default_noexec &&
> >>>>               (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> >>>>                   int rc =3D 0;
> >>>> -               if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> >>>> -                   vma->vm_end <=3D vma->vm_mm->brk) {
> >>>> +               if (vma_is_initial_heap(vma)) {
> >>>
> >>> This seems to change the condition from
> >>>
> >>>       vma->vm_start >=3D vma->vm_mm->start_brk && vma->vm_end <=3D vm=
a->vm_mm->brk
> >>>
> >>> to
> >>>
> >>>       vma->vm_start <=3D vma->vm_mm->brk && vma->vm_end >=3D vma->vm_=
mm->start_brk
> >>>
> >>> (or AND arguments swapped)
> >>>
> >>>       vma->vm_end >=3D vma->vm_mm->start_brk && vma->vm_start <=3D vm=
a->vm_mm->brk
> >>>
> >>> Is this intended?
> >>
> >> The new condition is to check whether there is intersection between
> >> [startbrk,brk] and [vm_start,vm_end], it contains orignal check, so
> >> I think it is ok, but for selinux check, I am not sure if there is
> >> some other problem.
> >
> > This particular SELinux vma check is see if the vma falls within the
> > heap; can you confirm that this change preserves this?
>
> Yes, within is one case of new vma scope check.

Thanks for the confirmation.

--=20
paul-moore.com
