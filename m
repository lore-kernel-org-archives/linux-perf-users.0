Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B6C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6B3611C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 16:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhIVQhz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhIVQhz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 12:37:55 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E53C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 09:36:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m11so4191616ioo.6
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kojJrobEEtFX01MsPp9CtOWo6Qy1c0vixj00jOo+xw=;
        b=oJURPli559uU2JiYXJlOVIBdreD5ncJ13cAqzsvghBT5ba7+UAw5p/h1zH5MbQnoIQ
         5pgYjDWmEtdu5D9v+fi3zFmFVxKcnOdV3LSeRlBGegyxhU1sAGHCy209HILUTJ6TFFp6
         MBjzrEeR3b9sGBTPSCWCm5cd7OllJbFu9rcpTfpeiL5LmS0M9ctAjmD13vmwoW6bJXP0
         8ISPZocLA3iut8kCl6mYEUB2wDu7NAH3ICyHWLnkVS6jssYzCxnmty3vBadKU3iSphAt
         L62GNq1T6eaPHn8SbN2O0BXH/65kR5/gcmzoO+4w74TdrhKh3j6AE5Dg6KHi0DPQah3m
         W2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kojJrobEEtFX01MsPp9CtOWo6Qy1c0vixj00jOo+xw=;
        b=m+0myw3SGNkcjnLt7EYnEWQwqpmP0PzxaOH/4Kd+ldpHz0jyj+iTBEbGRSzJYrdRIY
         zc3+2yPIQZ6g8Dn24qSaLh4f+bs2BZD5pCvAp3p/S+wd4eD2ybaCJX/loFIRGs6nCMuy
         fMiKom8GtnyfE8kKt/TMF1pesuGOZXwX4+DkZxolQqlCkvP8IOWTKKMt+8PLAy5N8OBV
         1uslUX6MjgAZZ6ZY4bWTtLzaQgH95W6GoPwM9PvABNHL244Wb3Mmd3OKPUt8vjbAxDDB
         /NyKd9USRKrATP7gDx3lR2ABrS0/On/hwTIdRZKUVjW+EXCHzw978/JdGfGYMD+D9KSI
         MMug==
X-Gm-Message-State: AOAM530hwd0Ueweyb9KC8eaD86jkNwrtdmQUXqNpehFnYosz6eGupXxr
        6/qExGUUq8kujxffdPtz1jXOGxFzKpUb0L5wLhfbxQ==
X-Google-Smtp-Source: ABdhPJxNXO6Vmf+IgMpMX4uLIkNmmQKj1o8MpbT0UqyxEhMzqT0rJnq5koqfxRnxuhK0mQhOJsUT6Ilqt1uqwwdUN9c=
X-Received: by 2002:a05:6638:1929:: with SMTP id p41mr649881jal.21.1632328584150;
 Wed, 22 Sep 2021 09:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210922152706.23655-1-mpetlan@redhat.com>
In-Reply-To: <20210922152706.23655-1-mpetlan@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Sep 2021 09:36:11 -0700
Message-ID: <CAP-5=fUN_fYmgm69ruBvp6E+nkLKsTvZwHqGzaRd471MhMRykA@mail.gmail.com>
Subject: Re: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 8:27 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> Certain kernel symbols are purposely hidden from kallsyms. The function
> is_ignored_symbol() from scripts/kallsyms.c decides if a symbol should
> be hidden or not.
>
> The perf test "vmlinux symtab matches kallsyms" fails in case perf finds
> some of the hidden symbols in its machine image and can't match them to
> kallsyms.
>
> Let's add a filter to check if a symbol not found isn't one of these
> before failing the test.
>
> The function is_ignored_symbol() has been copied from scripts/kallsyms.c
> and needs to be updated along with the original.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

It is a shame this can't be a library to ensure the function is kept in sync.

> ---
>  tools/perf/tests/vmlinux-kallsyms.c | 102 ++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> index 193b7c91b4e2..4f884aabc7f4 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -3,6 +3,7 @@
>  #include <linux/rbtree.h>
>  #include <inttypes.h>
>  #include <string.h>
> +#include <ctype.h>
>  #include <stdlib.h>
>  #include "dso.h"
>  #include "map.h"
> @@ -14,6 +15,102 @@
>
>  #define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
>
> +static bool is_ignored_symbol(const char *name, char type)
> +{
> +       /* Symbol names that exactly match to the following are ignored.*/
> +       static const char * const ignored_symbols[] = {
> +               /*
> +                * Symbols which vary between passes. Passes 1 and 2 must have
> +                * identical symbol lists. The kallsyms_* symbols below are
> +                * only added after pass 1, they would be included in pass 2
> +                * when --all-symbols is specified so exclude them to get a
> +                * stable symbol list.
> +                */
> +               "kallsyms_addresses",
> +               "kallsyms_offsets",
> +               "kallsyms_relative_base",
> +               "kallsyms_num_syms",
> +               "kallsyms_names",
> +               "kallsyms_markers",
> +               "kallsyms_token_table",
> +               "kallsyms_token_index",
> +               /* Exclude linker generated symbols which vary between passes */
> +               "_SDA_BASE_",           /* ppc */
> +               "_SDA2_BASE_",          /* ppc */

Do values like this belong behind an architecture #ifdef? I know
that's not currently the case in scripts/kallsyms.c.

> +               NULL
> +       };
> +
> +       /* Symbol names that begin with the following are ignored.*/
> +       static const char * const ignored_prefixes[] = {
> +               "$",                    /* local symbols for ARM, MIPS, etc. */
> +               ".LASANPC",             /* s390 kasan local symbols */
> +               "__crc_",               /* modversions */
> +               "__efistub_",           /* arm64 EFI stub namespace */
> +               "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
> +               "__AArch64ADRPThunk_",  /* arm64 lld */
> +               "__ARMV5PILongThunk_",  /* arm lld */
> +               "__ARMV7PILongThunk_",
> +               "__ThumbV7PILongThunk_",
> +               "__LA25Thunk_",         /* mips lld */
> +               "__microLA25Thunk_",
> +               NULL
> +       };
> +
> +       /* Symbol names that end with the following are ignored.*/
> +       static const char * const ignored_suffixes[] = {
> +               "_from_arm",            /* arm */
> +               "_from_thumb",          /* arm */
> +               "_veneer",              /* arm */
> +               NULL
> +       };
> +
> +       /* Symbol names that contain the following are ignored.*/
> +       static const char * const ignored_matches[] = {
> +               ".long_branch.",        /* ppc stub */
> +               ".plt_branch.",         /* ppc stub */
> +               NULL
> +       };
> +
> +       const char * const *p;
> +
> +       for (p = ignored_symbols; *p; p++)
> +               if (!strcmp(name, *p))
> +                       return true;
> +
> +       for (p = ignored_prefixes; *p; p++)
> +               if (!strncmp(name, *p, strlen(*p)))
> +                       return true;
> +
> +       for (p = ignored_suffixes; *p; p++) {
> +               int l = strlen(name) - strlen(*p);
> +
> +               if (l >= 0 && !strcmp(name + l, *p))
> +                       return true;
> +       }
> +
> +       for (p = ignored_matches; *p; p++) {
> +               if (strstr(name, *p))
> +                       return true;
> +       }
> +
> +       if (type == 'U' || type == 'u')
> +               return true;
> +       /* exclude debugging symbols */
> +       if (type == 'N' || type == 'n')
> +               return true;
> +
> +       if (toupper(type) == 'A') {
> +               /* Keep these useful absolute symbols */
> +               if (strcmp(name, "__kernel_syscall_via_break") &&
> +                   strcmp(name, "__kernel_syscall_via_epc") &&
> +                   strcmp(name, "__kernel_sigtramp") &&
> +                   strcmp(name, "__gp"))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         int err = -1;
> @@ -169,6 +266,11 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
>                          * such as __indirect_thunk_end.
>                          */
>                         continue;
> +               } else if (is_ignored_symbol(sym->name, sym->type)) {
> +                       /*
> +                        * Ignore hidden symbols, see scripts/kallsyms.c for the details
> +                        */
> +                       continue;
>                 } else {
>                         pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
>                                  mem_start, sym->name);
> --
> 2.18.4
>
