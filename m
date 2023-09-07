Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D154AEC875E
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 23:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjIGXL6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjIGXL5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 19:11:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF21BDB
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 16:11:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414c54b2551so76921cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694128302; x=1694733102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iOwyz8CzNzxeEbnqXiR5e1k7kQJndb/v6qGP/KlU5c=;
        b=PGwst7yZ+9YC15ETlTIunfT/AXA0zYfCs9SVfgHQ/UTp//jzihb+Hr6lmoYfzyzqzv
         wbfRHdQ0pOHXY9TCXLXIf5w70dKRsDtUmiYyQjO0guHccSEQqrrlz7zF1cIjvnKT6WJ9
         H3F760stkcH+9mZncG9a122PjBIYRSAOhoHX1VDp6G/xjLfd763UJq3i0q9Dp8nS2jb5
         yl+CscTLEj4OeQIihOA8Dy0QGLp13zgTzQmhhQ6/fY+u5kyfCusIoEeN7qXssO3iXheh
         E2qUWrVf51yuHLLz62VTZKC+ykldjHFpBk2m8vXMohgNr+GHKR/jpHOO0+a2lKCYhydT
         UyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694128302; x=1694733102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iOwyz8CzNzxeEbnqXiR5e1k7kQJndb/v6qGP/KlU5c=;
        b=PeF0bXkh/Fgeu5ELzC64n/gFniOAiuxiPFyP6lWt0VDnaqJxR6uRE1REbPppNaPjj2
         QomF3RVDrxdfXvFIrM/mLNuUTuWpphZXsj0SvBLuJmmxN3K/AsSaZGZ/cNi4uajcuWAC
         7pLvUTBgzYnpBa4wVIZmq2soycO2zCnIWSL7tMFrFzcXdwviM4N7PzovNmA760WL7xCe
         APi7BPu5psERN0iTMEVZXnJqt2osWTrLjajyl94OMrs+U2ldB/lWC2zNZ1lbaAQk4o9q
         Q3Fq/rg1a1k+Kgw4xYOOwVD+B8CrJov5hFwvjuJr2W5GVehm9YGdIpyMzd9EXp6qz+mq
         SSnQ==
X-Gm-Message-State: AOJu0YyF4VCWrkJ5T9M+CXd6nfB2e0cT9yvvCX5fG48ijM6jVRYTNC+5
        wHCuEudeacW0ChOJY9zF3jBL0Uwj4nkGwGBacqs9yjZOhU3KAtgNDTgDGw==
X-Google-Smtp-Source: AGHT+IHqjOGGOf03SUyJXcNjq12YhvYgwirQdUZbUw/yPbr8VokjKW/iOtKeXXObOST3yIVdnPwATDNCyhEvKF+hOeM=
X-Received: by 2002:ac8:7f44:0:b0:3de:1aaa:42f5 with SMTP id
 g4-20020ac87f44000000b003de1aaa42f5mr60853qtk.15.1694128301642; Thu, 07 Sep
 2023 16:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230907171944.36953-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230907171944.36953-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Sep 2023 16:11:29 -0700
Message-ID: <CAP-5=fXSAzpdf0dH4kdPKRVjonC2wBF2oD56_=2NE0iBs96EOA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Add includes for detected configs in Makefile.perf
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 7, 2023 at 10:19=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Makefile.perf uses "CONFIG_*" checks in the code. Example the config
> for libtraceevent is used to set PYTHON_EXT_SRCS
>
>         ifeq ($(CONFIG_LIBTRACEEVENT),y)
>           PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-source=
s)
>         else
>           PYTHON_EXT_SRCS :=3D $(shell grep -v '^\#\|util/trace-event.c' =
util/python-ext-sources)
>         endif
>
> But this is not picking the value for CONFIG_LIBTRACEEVENT that is
> set using the settings in Makefile.config. Include the file
> ".config-detected" so that make will use the system detected
> configuration in the CONFIG checks. This will fix isues that
> could arise when other "CONFIG_*" checks are added to Makefile.perf
> in future as well.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/Makefile.perf | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 37af6df7b978..6764b0e156f4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
>
> +# Use the detected configuration
> +include .config-detected

Good catch! I think it should look like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/build/Makefile.build?h=3Dperf-tools-next#n40

Thanks,
Ian

> +
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
>  else
> --
> 2.31.1
>
