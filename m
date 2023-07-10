Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10247EB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 21:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGJVWa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGJVW2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 17:22:28 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AD1AB
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 14:22:23 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-635decc135eso28664306d6.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689024142; x=1691616142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/AHnLRjSLfFE9cPgB0m1arr9qA/D4bUxDLvGm185g4=;
        b=p5bEh9YpRBSvdjZQX8rMsK7yK10d4+t79qj0lXTV1iANI6Zi8/7mfKnUVPneSAWGET
         ocTlr4vlq45Nf+fvDaKYPrSTPBYfUMtsHoEqbWVHyWwlcRUgZ9oCYjxSSudPXmEL0vQ6
         fE3BP/WKikO8G8l0OLD/RFGA82qdICWixK1tuplEuNXFFkaLuv2dTqJpTlTvhbmLG+3S
         ip4z8zyBOTNeMBaEqdcwVyvKXYwYLVouJpqAIRs8TdYl9HzCrCcKvHx1PvH1+7W3jDfk
         9Fe1T81re8u4E2XdgUAOawq6VYTSS/Y5WnEmPyoNPnZ0F/9QnAAQRw+HOlENg4ZLEMcs
         0SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689024142; x=1691616142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/AHnLRjSLfFE9cPgB0m1arr9qA/D4bUxDLvGm185g4=;
        b=fXvbP2ZtyRmep93x64pqet802feiq5j2I4MPqMz6VWFnPabsxDN994ZL//U+uRESR4
         agrbhnpXd+NddpGF8kRzq65F/x0SwHob0NdkJYwDwM37zGmv+ZR9nef6j6JG4OhWZvfz
         LU35Mh/l8c8oanpKLDvvQiqpR3SyNgVOWXXIAc1ucUOkKUZteR1a/fF8lrNiKAC88gjB
         h5L6tKu5EEFK7DnvojwogEGrQIkDV5aBGyFYfHbSHOU+4P/dkM1zkkk7IyjcaNnFKBSO
         c0SIpVGFWLV2BVpDaW2jVCWc5F+xehSZjIT5H9v/IWV6xKGzHMDGsyI1U+qbBsxbxoI2
         ERbA==
X-Gm-Message-State: ABy/qLa5HsIbhWBBfq4r/k3Bj+ApqfOaM3PisWDzDJqzilAGg4GCYRjz
        1LGoKk/FNaY74gX+/pqZZeQI+v/UiQbkNQ3+AI+9og==
X-Google-Smtp-Source: APBJJlEyTl3gs/z6eTnepp8nz5+pFBwJ2K0VEGAzQIoNlATKxCwU0usk0HgClb+WScNXShjcKaBO3hflJJH/vIj4QtA=
X-Received: by 2002:a0c:9701:0:b0:634:97ed:9a5f with SMTP id
 k1-20020a0c9701000000b0063497ed9a5fmr14901888qvd.26.1689024142302; Mon, 10
 Jul 2023 14:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com> <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
 <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com> <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
 <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com> <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
 <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com> <5c077e61-c206-812f-1cb9-d47785e8176f@amd.com>
In-Reply-To: <5c077e61-c206-812f-1cb9-d47785e8176f@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Jul 2023 14:22:11 -0700
Message-ID: <CAKwvOdm9SAQ5i74JUzWP4Q1WW3aHq+3Jo7hqfie+oMxjnKqxSA@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jun 25, 2023 at 10:45=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> Hi Nick,
>
> On 23-Jun-23 9:53 PM, Nick Desaulniers wrote:
> >>> On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
> > Hi Ravi,
> > Sorry, I'm not able to load a custom kernel image on my employer
> > provided workstation, and I never got approval to expense hardware for
> > testing this otherwise.
> >
> > Was there ever any update on this? I'm on 6.1.25 now and still cant run
> > $ perf record -e cycles:pp --call-graph lbr <any command to profile>
>
> Per-process precise sampling on AMD platforms should work from 6.2-rc1
> onward.

Ok, I can wait for my employer to ship 6.2 on our workstations.

> However, --call-graph=3Dlbr is not supported on AMD (hw limitation).

On any AMD uarches? Is there an equivalent? LBR encoding is compact
which makes working it much faster than DWARF or stack frame
unwinding.
--=20
Thanks,
~Nick Desaulniers
