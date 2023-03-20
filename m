Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD73BC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 18:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCTSsD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCTSrm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 14:47:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCA812CF9
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 11:40:48 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ddbf70d790so306481cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679337617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpfaYXXDDOEU7faI8DiWKFieDk8XViRrjAK2ROVtZfQ=;
        b=I3kz/xOalPWbO/CR0ar9RYajhPuyAIKh9PYpDyCPNsPdV5sXhr8iNhDH0/n4vf1wKT
         3ftX29zVpCdXHaAc0Q9jW5TjyfCPJFw4/rkgJRNQNxych78v3ao8588qev5rSgzYH+A+
         h+F7D/s8c9JL/onYI2CGK+IafaREheyO7KVfXhAcaU2EtwjBNAtjyk/MFeOcqlgMRtZO
         O6yjcJf/GAGz6c8gr+x8NwkDNWWOCMg+l6C5vcDpqVLADLGT41WM/VoLR566Dohe1gUm
         o3KCyqYLlMdgdXCkHArTRKJv2sI65703X5gptwa1JgDWnp/i8F8NbMmVBF8ZXVjz5RO3
         jF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpfaYXXDDOEU7faI8DiWKFieDk8XViRrjAK2ROVtZfQ=;
        b=pkS7lY2dhG1mhkFGWtO6zB9b5sBlwRiY74Ex/wqtrmQjFQyI0TuwOl32k/V6gdFpqO
         tSL3/SQta6rwDaMrhY6dP+xkvH37Ahmj6knoTYYArpmPY2KSnrxZ+GCDooYGU1bmNs5i
         IsOcdJeIgo7FVbthqTl32ffPHkqhzRyzLg63r+7mzBKbPA6BGneG96r62hPhNU7z8/C1
         aAgdHfDMfMjEgW+iMpgDV4pLZfwYRx3LQEcMF/iP2KfiQMdJWw6BdDLgGiSBllP9l/NE
         4zRpKODlB0VlQO3Lafd8DzckOtmmluZqzg2Er04Ym7Nu2gaE4FYhfKHzA0WTketkpRmQ
         PZXA==
X-Gm-Message-State: AO0yUKU01pW6DIfnw6LY5vj/kVY+3jUmzakCeSLsLfjHA/x9Ro+xJe7A
        lLx1FCYcvNjqYWrK1Mm6LExeE1guO+2IUuC6yheYtw==
X-Google-Smtp-Source: AK7set8QOk2DntJh7mcqwgfwttG/x+ZqIbXeJT8XqeAa/MNCDZE02/eXTofY/4kq/8hAg5VuU7IvQlqYrxUypdskMzA=
X-Received: by 2002:a05:622a:1a13:b0:3de:1aaa:42f5 with SMTP id
 f19-20020a05622a1a1300b003de1aaa42f5mr19529qtb.15.1679337617388; Mon, 20 Mar
 2023 11:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230320183517.15099-1-adrian.hunter@intel.com>
In-Reply-To: <20230320183517.15099-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 11:40:06 -0700
Message-ID: <CAP-5=fU56Kx_K1jQq9b5TpbW-AKTHRAUeQRxfrAvnX7d_zgZkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf intel-pt: Small updates
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

On Mon, Mar 20, 2023 at 11:35=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Hi
>
> Here are 2 small updates for Intel PT.
>
> The first is just a couple of new event type names.
>
> The second is a small change to Intel PT as it relates to
> Intel FRED.  The patch is standalone but, for anyone
> interested, you can search LKML for FRED to find out more
> about Intel FRED implementation.
>

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Adrian Hunter (2):
>       perf intel-pt: Add event type names UINTR and UIRET
>       perf intel-pt: Add support for new branch instructions ERETS and ER=
ETU
>
>  tools/perf/arch/x86/tests/insn-x86.c                   |  4 ++++
>  tools/perf/builtin-script.c                            |  2 +-
>  .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 18 ++++++++++++=
++++++
>  .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.h |  2 ++
>  4 files changed, 25 insertions(+), 1 deletion(-)
>
>
> Regards
> Adrian
