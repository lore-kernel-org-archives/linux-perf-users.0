Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B069EEE3F00
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 17:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjILRx7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjILRxh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57B1708
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 10:53:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-414ba610766so34471cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694541211; x=1695146011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teQTF4kOu+EBEnO4U103r77jmPI7i82xWX4kX0n2Qr4=;
        b=DdSJwJ9tmDAOZoPr+BshZsQoRwzjyemC+GGchoZOuVDPz8x47sDbiKLAQpWUFSqMe+
         7VVVvIgtT2pk7kjBe/bEx1tFeZ5n2dErN4lWiPOjKxC0d4A14CDJzc+D9x/QT9aicL/0
         9WxgPvPOaZ6V7qPgzP2BmUs+UW4TdDslmhTF9CbxSrtSwsk9pS/e5IN+g0hff9YQrA5K
         LCJg2+ZRFqor/MQRc6G3FEEzXE1j19t44hAgFm9v5g2aYSVG7X9a4rc45oIoIaedmcR4
         GKBota6Jq6MuQkntpCYs/d8grd1/4SUpY+iJJIlK6Sg4J8WK2zlWjCuAHyEWN36y+elc
         n1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541211; x=1695146011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teQTF4kOu+EBEnO4U103r77jmPI7i82xWX4kX0n2Qr4=;
        b=ioPJfhdeI8vg/nk3JKqdnYs3uhu+2st7h5C9xjcy8nM8AHDz/AVdBSXhM0TU4CcCj7
         v9rZqGCOaXFNUln26uLWSj7UtruBcC8f+WkPbdPkWKPpbOANJt1lz1UbSHS91KeDL1NK
         ntJPli6CuuVoI9jHAycuM9m2DsB9sSUkohN5C1k38rA10ipb5pVmeUVDp126Pr4dzb/O
         wR0QxTD+nUUmAITth9fAdzK2uRAIub7j83m+79V5t+3ndTZ6WYwCXF7dMqnKv2rdiYOP
         huAemR2yG/4D+ZCOyddyWZ/K4WzJHqGyC/0f4JheNt59pLdnE3lklfUrwFS+HJ7gIKNH
         BPkw==
X-Gm-Message-State: AOJu0Yw4QNlNeACySBlMOT58suP8bmNuuG3j6YVK7ARk06cQY2IFd2mO
        9rhfeL8xrTFwfuaorU2C5M6pF4jUl5aEwwTyNgwt5A==
X-Google-Smtp-Source: AGHT+IE7D9FXAEWA42mKg/EyM5QdanIqKuoAZfYeqVQ8yKNbbOa4UOn7Fc/6SHhsuCknZhdbyHqlWQJMQDGHu2u1MEQ=
X-Received: by 2002:ac8:5802:0:b0:410:385c:d1e0 with SMTP id
 g2-20020ac85802000000b00410385cd1e0mr785qtg.25.1694541210743; Tue, 12 Sep
 2023 10:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230912133318.18103-1-mpetlan@redhat.com>
In-Reply-To: <20230912133318.18103-1-mpetlan@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Sep 2023 10:53:18 -0700
Message-ID: <CAP-5=fU5aofaXOtR=5JU2BocrjZVDRkm9uSqe_fyjOeoQRmQYQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/core: Rename branch-brs event to not break
 the parser
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        ravi.bangoria@amd.com, peterz@infradead.org, namhyung@kernel.org,
        sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 12, 2023 at 6:35=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> The problem is described in detail in 146edff3d7ed ("perf test: Parse
> events workaround for dash/minus"). In short, although perf-list offers
> "branch-brs" event to be used, when used with "-e" switch, the parser
> does not accept it and needs to be enclosed to "cpu//", such as:
>
> ```
>   $ perf stat -e branch-brs true
>   event syntax error: 'branch-brs'
>                              \___ parser error
>
>   $ perf stat -e cpu/branch-brs/ true
>
>    Performance counter stats for 'true':
>
>               46,179      cpu/branch-brs/
> ```
>
> This is confusing for the users.
>
> Rename the event using underscore instead of dash to avoid the problem.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

I rewrote the event parsing and this was fixed in 70c90e4a6b2f ("perf
parse-events: Avoid scanning PMUs before parsing"):
https://lore.kernel.org/r/20230502223851.2234828-19-irogers@google.com
which was included in the perf tool in Linux 6.5.

Thanks,
Ian

> ---
>  arch/x86/events/amd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index abadd5f23425..f4c5d4100035 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1286,21 +1286,21 @@ amd_branches_is_visible(struct kobject *kobj, str=
uct attribute *attr, int i)
>  }
>
>  static struct attribute_group group_caps_amd_branches =3D {
>         .name  =3D "caps",
>         .attrs =3D amd_pmu_branches_attrs,
>         .is_visible =3D amd_branches_is_visible,
>  };
>
>  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
>
> -EVENT_ATTR_STR(branch-brs, amd_branch_brs,
> +EVENT_ATTR_STR(branch_brs, amd_branch_brs,
>                "event=3D" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
>
>  static struct attribute *amd_brs_events_attrs[] =3D {
>         EVENT_PTR(amd_branch_brs),
>         NULL,
>  };
>
>  static umode_t
>  amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  {
> --
> 2.18.4
>
