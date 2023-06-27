Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA42BEB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjF0TxX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF0TxU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC62727
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 12:53:16 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401f4408955so63271cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895595; x=1690487595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLuI5nD00PYdmR0TV738RD1rmcrLwafP6/VBiaRjU1Q=;
        b=cSzqkm1d1b4AFhkJhViS8sDaJIf+PxUmJXSE1RGhTP6iCCCv38N0BIynlZA09gF4vP
         CpD6cB948INT3shzg+B7IOADAv1mqcb/d284GyeFR7u9Nxq4fDQ/N55DBiaX1FAvlzfk
         Diqjm5prhKaUtRZovQzs1wF6v5Q6+/PTGp2bJ1qMeOcIgAPHCQA7qRmQdIafxnNqmWqw
         MmjY3XWZjlu7Udq8ZL4PTQmd0SnSMlK0whx7TLERo3Mx3XYKbbGU17QRSaLVpQvt3Swx
         Vpc3OrS2B1C1fo8P7o8jU3KS9Lj2Cj+HHmHBerMNwmv6JLhJCO1FQ9ZNhdOIV5ceoHUs
         sJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895595; x=1690487595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLuI5nD00PYdmR0TV738RD1rmcrLwafP6/VBiaRjU1Q=;
        b=QVh031N8BdXZ/7C/gbgJXSf89uYdoV0cyBeBFVmTzdlP10DyF7lKyH9fMIP1Q0liT0
         h/iVdsWuwM16NnH6G/20X4V1M23PCZONpU7f7oTg19M632NMG4M9QdrQxPI2/1maMZ0m
         hWYDzJ8DZirRITYh+O0BUnEp5jkcn/s/+44UuILGo7TJmi+iLjp0GxuZly6CeJW39yWR
         Q+kwZpquOMDldm9wwP8CiBKX/ZyC3xfJot2kYlk4ijeB6ljEsllrOrPi7PN25xqsAawZ
         celjIAJmRuo1m10E1c4VjiwZcYThhKqCMCsxCbseS/28kXYXlfLweHZAQNU1XTEoh5jn
         6dBw==
X-Gm-Message-State: AC+VfDy6FFWWA4kjUwXoXcAI/iPD5Y7mx6D5jlHe+K/X5HzbCxSlzNZt
        B/RWU6P9L7Q1nhbX0XXNIQP+11TDONhtKQHKyXuM1Q==
X-Google-Smtp-Source: ACHHUZ4WywyCYGtPMuvdFcpW2dqCRu0tWKd63P8E6CytwoFeUoTgkNgf73pWryoHaPsc+KPEWJlGKZA+hMjAqZ0nE+U=
X-Received: by 2002:a05:622a:285:b0:3f8:175a:4970 with SMTP id
 z5-20020a05622a028500b003f8175a4970mr37184qtw.18.1687895595463; Tue, 27 Jun
 2023 12:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230624002708.1907962-1-maskray@google.com> <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
 <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
In-Reply-To: <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 27 Jun 2023 12:53:04 -0700
Message-ID: <CAFP8O3L_fGJWAcNEhFGBZF4mRi6ObOyupto5o4z80Zaa3x7PDw@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace deprecated -target with --target= for Clang
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 27, 2023 at 12:29=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> =
wrote:
>
> Hi Fangui and Yonghong,
>
> On Sun, Jun 25, 2023 at 11:25=E2=80=AFAM Yonghong Song <yhs@meta.com> wro=
te:
> >
> >
> >
> > On 6/23/23 5:27 PM, Fangrui Song wrote:
> > > -target has been deprecated since Clang 3.4 in 2013. Use the preferre=
d
> > > --target=3Dbpf form instead. This matches how we use --target=3D in
> > > scripts/Makefile.clang.
> > >
> > > Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de=
0a68135afc7f95def6277
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
>
> After 10 years of deprecation, time to change. :)
>
> Applied to perf-tools-next, thanks!

Thank you!


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
