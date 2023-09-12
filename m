Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A12CA0EDD
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjILOAU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjILOAT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 10:00:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9C10D0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 07:00:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-414c54b2551so263881cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694527214; x=1695132014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDs/ms03yISSc3Q3UiOqo0nosrYG3nv1ybC8XW7Xs6s=;
        b=Q0jKBbf2iSF/pLXBsx/6oeeYTabX+peWpBY3xbYkux02GSzxR2Ht6JDHZ/KS5PfwG/
         nPbjC6Dd/krLyv+DY1p7BctZxsdR+iorAz65HrtkDwK3cMYRL+P+nXDmU12FTYRiIm0V
         ySUoccYLFO+FOF1z+/WWjk96ASCmIeP22QOCYgiRNJKIU8kXbFw5CgUdUqnmoMD4IrmG
         bvUHts93gX9nZ61Wlz1pIwq1/PZJCvj/9nBey14bRNeX3R9zHeqN5wKwMuYYfWFpp5AB
         5Ca+ij2DUEAeUuhzC4wP3tutXd+Mf6P3Dzz1Q+v6n2EF6Fcct8yDUVvqyRjnZWP35WU1
         Oa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527214; x=1695132014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDs/ms03yISSc3Q3UiOqo0nosrYG3nv1ybC8XW7Xs6s=;
        b=v/AFl4VUEGc3G7rDG0JdR+kJxCN1fWSmWwEdaF7v8C4olgSfKU3zfyNHzjFozFGFXQ
         78sW2p8nuKkG/HT1mDF+vBfSa4b+aBA+RmXmzj5/4kll4lWD+2iYGjhhfmMTsPVaG0G8
         9W+maVMwot/EgoFkbY6Dpb7kadhoxx2S0J79MO+3EkJwL1/egGYZ7l0zNGXeigk6dqvm
         7rar2l3h7uRM3e3Pu/+XYS3YflKGpDRLuTTeIo5fi49JVPfBRceyBy6CUAuN0ycyKNyG
         XZyo7OvBy7GyF/jQMfOzzxkjIyPzv9IJvJoPFiDyXyhdriPe7dsmIZEFcKwfLIDUAk5s
         0oRw==
X-Gm-Message-State: AOJu0YyOgrBeDzmqs7w7Oomm8hZ0XYpBvzLif9El7r6OolmxPZBub7KF
        8G/gUqhsQDX6FTxCJ5QBB+OYCcHSbRwUKDpmw5Yi5w==
X-Google-Smtp-Source: AGHT+IEo8w3504Qe2c4oLczzX+JcbZh6VtZSHm+Cg+yDS5SdjKyydJl6tkOJB8VZGXLP2wgtRLqeFGyfO5BrT0idoz0=
X-Received: by 2002:ac8:7dd5:0:b0:3de:1aaa:42f5 with SMTP id
 c21-20020ac87dd5000000b003de1aaa42f5mr207058qte.15.1694527214305; Tue, 12 Sep
 2023 07:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230912063807.74250-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230912063807.74250-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Sep 2023 07:00:00 -0700
Message-ID: <CAP-5=fU644=VvHf1JcQ1LN7tb_wAkrnrE+n4xCVyWae=UxTFyg@mail.gmail.com>
Subject: Re: [PATCH V3] tools/perf: Add includes for detected configs in Makefile.perf
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 11, 2023 at 11:38=E2=80=AFPM Athira Rajeev
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changelog:
> v2 -> v3:
> Added -include since in some cases make clean or make
> will fail when config is not included and if config-detected
> file is not present.
>
> v1 -> v2:
> Added $(OUTPUT) prefix to config-detected as pointed
> out by Ian
>
>  tools/perf/Makefile.perf | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 37af6df7b978..f6fdc2d5a92f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
>
> +# Use the detected configuration
> +-include $(OUTPUT).config-detected
> +
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
>  else
> --
> 2.31.1
>
