Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D46AEE8019
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 16:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbjIHQP6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjIHQP5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 12:15:57 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9667B1739
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Sep 2023 09:15:53 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34f3dd14b66so132465ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Sep 2023 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694189753; x=1694794553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQEJvDuRs3UkoD1b56O/pI7tuDGHQtmDCny6dwGdlzI=;
        b=ysnoAqyWeJunZyTctGNLL61QuwrVoM9O9bGCOzM7pO9+UYVfqUJsPrBlT/wi+t7da7
         wRIgDp2/xCbpaM9GnV07gAaMXZeOj/BNeqoD/DqIOiLKX+urXA3/lWaM3RjC9cK1fvF0
         iVGNuS/gGiWUQwBsuPreEtqBYsltDEuQQbHTgOEhfzEAkA3t7zYW8HvQLSitnNW6XzfQ
         Gtb3Rmra1XONtzZ8rzJVHwlOpT9hyW2PyUFUc1GBlI0Ty5L+35Omgu4XFee4bRdJDjY+
         v9/0FtfSVx+VyM6Z8/5n/L+if/ory/VBw0VE+w0CfvELfFZMCbHGWPyeep+EPSM+mWC8
         0EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189753; x=1694794553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQEJvDuRs3UkoD1b56O/pI7tuDGHQtmDCny6dwGdlzI=;
        b=QMNDLZGEKoTd6ziePe1su9l17p+VTQdk/a8POioEWWwHe+i6qbiBpFtMGrFo/Mv0af
         yz9BIvs3AVE/czFo+JuqaBmTV5ypXvuHTrxUi1mW1pUsb/fZsI2etjV29RVxHVqTMQ71
         npIMfmg1nH6zQb23eoTNFG9svm8q/Hzrta20R30mBAwAxfj5SasYA+HmJtWZRPMwhge5
         NureKn2cswvZNgs7HP6y+geJavZBmAYY8ZSkNl0ICCawxgDXXA4cP8WOSggwzbJG1XRq
         B3N/kaojBshUp4xRuXMpfcqlueTnW2Z3losdb6KaFD5Y5UgPVA4mc6tOof545LuuKAhm
         XfYw==
X-Gm-Message-State: AOJu0YwhbQlvIcedVW4l6+yBl5hbWpf4vYdZLVvz/ZGG7W/yjHt2M6p+
        hN42NALoXRMPNoC+I9HgLnaqxvePILWYCQJmFqGX5A==
X-Google-Smtp-Source: AGHT+IFdl02AUmaxNkylaUSkhXBIdzRaYxZPDMOHsucFGY/+tT+qzQzwY8yH6GcE4mmVkzJEkzHPv9t4YhNmE7YaT0k=
X-Received: by 2002:a92:c569:0:b0:34f:21e9:7239 with SMTP id
 b9-20020a92c569000000b0034f21e97239mr232372ilj.23.1694189752833; Fri, 08 Sep
 2023 09:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230908145045.47408-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230908145045.47408-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Sep 2023 09:15:38 -0700
Message-ID: <CAP-5=fVZacRGiU2e1_vW8WWd4tF6f2msbBvA7+U7VqkRinR31w@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf: Add includes for detected configs in Makefile.perf
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

On Fri, Sep 8, 2023 at 7:51=E2=80=AFAM Athira Rajeev
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
> Changelog:
>  v1 -> v2:
>  Added $(OUTPUT) prefix to config-detected as pointed
>  out by Ian
>
>  tools/perf/Makefile.perf | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 37af6df7b978..66b9dc61c32f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
>
> +# Use the detected configuration
> +include $(OUTPUT).config-detected

The Makefile.build version also has a "-include" rather than "include"
in case the .config-detected file is missing. In Makefile.perf
including Makefile.config is optional:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.perf?h=3Dperf-tools-next#n253

and there are certain targets that where we don't include it:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.perf?h=3Dperf-tools-next#n200

So playing devil's advocate, if we ran "make clean" we'd remove
.config-detected:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.perf?h=3Dperf-tools-next#n1131

If we then ran "make tags" then we wouldn't include Makefile.config
and so .config-detected wouldn't be generated and I think the build
would fail due to a missing include here. So I think this should be
-include or perhaps:

ifeq ($(config),1)
include $(OUTPUT).config-detected
endif

Thanks,
Ian

> +
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
>  else
> --
> 2.31.1
>
