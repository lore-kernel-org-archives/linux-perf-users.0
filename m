Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303CEC6FD1F
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Mar 2023 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPVV3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCPVV2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Mar 2023 17:21:28 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A8C48B1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 14:21:27 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3184514d31eso13195ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679001687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sed8mBQa+lDJxDv12thn4n6WdTH+ovGBkrm+trscL6A=;
        b=HTnshhdiEiXyeKl4aXg09OlYc6L0l5aXKBxe+SSC8s1UqdOiifd5GvbIZKnKLvIpgA
         hmv7dcTXYgl1H4YfNtUB/hCKvG0Gk30ZPmFbvTnOHpDj/rNAwbSYgmpb27mFIlItu8gR
         Q67ZxNxJsXc1x64otXi64FYctPeHvD9uVdlOwF4QSc4xQUYxAatEhAKJbxFKsf2YzalK
         xlroQyV/d4OgufRs+/hfTzoy9gWEKHt7e0UMYMfIJDeVwX6qxIDozSSORu+6XoPsqG8S
         UI58g7w7eOSfEoC3NZz/XiW75sujncvLf402RgG8b+TbJ2xJwEy33cNyYH1RErdF5f0F
         cIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679001687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sed8mBQa+lDJxDv12thn4n6WdTH+ovGBkrm+trscL6A=;
        b=iD58hNfBxVwrteKuEthjLrC9uut2p2PtWPYmxbo3cQOARkC34qykYpKyEVCbctp5Az
         CPD7VBaKEcMhKbzqftWPL5IY6fBskTtAPIM3LXQs9kPey0ogQ+7LYYb1heQN3RpZOMtH
         VEZRs3yDx1JCnjNqCzB8G7InGlAHrjQYdfzt1j50I6vJhoLrQ8y7ZneRltFGWxM7eCyV
         MfCwg1ZK1XA7uO2kMbxxt8U3nNEt3NU5ZufxM0aYV1/CmsyFqO6/TDQThJMphiZm+29i
         vnd0oszgEDlJGKQ72qhnPljB5/U9GRNKWDn9jxt/ry+82qqzD5cxIxu/nw2ETnabP3M1
         cfnA==
X-Gm-Message-State: AO0yUKVDDEaaos2nt2d6AOOh/LUyObPwJ3o96kqKw3+X4RjPfjIKHht5
        7fI9EmSbkbbn/gHmJh/28g1OUCI2wZlm4yk5RRuPkQ==
X-Google-Smtp-Source: AK7set98LyaF+G5c4cnoCd0UiaU3BqlTvVBEFgHA8CSTx/7bwOpAfyueD2HfNo/QxkqsC9+iUNNK8oXMFvgA+KpjHA0=
X-Received: by 2002:a05:6e02:1c8f:b0:322:c06b:50c0 with SMTP id
 w15-20020a056e021c8f00b00322c06b50c0mr33534ill.11.1679001686705; Thu, 16 Mar
 2023 14:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230316194156.8320-1-adrian.hunter@intel.com>
In-Reply-To: <20230316194156.8320-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Mar 2023 14:21:12 -0700
Message-ID: <CAP-5=fV8HsLWzXSV-mov+s1doKNFvAPqpep9dhnoAbS3bdir5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Address fixes
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 16, 2023 at 12:42=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Hi
>
> Here are 3 small fixes resulting from a report from a
> kernel test robot:
>
> https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
>
> Issues were revealed due to the use of build
> option:
>
>         EXTRA_CFLAGS=3D"-fsanitize=3Dundefined -fsanitize=3Daddress"
>
>
> Adrian Hunter (3):
>       perf symbols: Fix use-after-free in get_plt_got_name()
>       perf symbols: Fix unaligned access in get_x86_64_plt_disp()
>       perf tools: Avoid warning in do_realloc_array_as_needed()

All 3:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/util/symbol-elf.c | 10 ++++++++--
>  tools/perf/util/util.c       |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
>
> Regards
> Adrian
