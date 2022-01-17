Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C6EC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jan 2022 16:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiAQQPg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jan 2022 11:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiAQQPg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jan 2022 11:15:36 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31734C06161C
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jan 2022 08:15:36 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a18so8800422ilq.6
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jan 2022 08:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOqHWchatt5g8LQ6tiHWZuW3qrtBqidrAEVGHswprK4=;
        b=pKW0lDNlxW1ui407vjgP3I+caIBdEJj+bixd0VwKJOE+jSPTp1NtI81MY/6T86oSLp
         bwVS3I3SGa+VB+lO0dxUxMkthKFJGaNtoOIColfYShFvbgNtgPUJMFvquWJT9LWv7u9D
         8PxI1i646w+JEDiJ/NjetZgv3zFnCfsb5rmQrPsQSzfg6n2KEZCLyxUnR8llUuO/bXiJ
         v79Hm9G/R1gn2FhxM1BoyNj8fNw4A76yWPL9KcPV5D555mDaJ7tekgwel/tC/v7Snbcj
         +fM5dMYrzbuDp3I3Khyj7NgSfptxC0fG1FkSnlrEBUDqSmaYEP9bYYNiUFzj2BIM3Nhd
         CRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOqHWchatt5g8LQ6tiHWZuW3qrtBqidrAEVGHswprK4=;
        b=aalPUDP8kCP2xlE5FoexmlVLiMz1Qkfa06fRRpa4eT+B99tntQ1DXdD7SfxzU6CN84
         cVCRvq9GXjfXP/gyUnvArpIIEN5MKfQpN+vqbHnewYdD1T+nvEubbh9Dyi5H+aaHqi6/
         J75q9sPGxHeHYxs3rEwlhySym0clBBveYjjOidNVx5HH4w+BGFZslI7Jjg+00P93Dajh
         KH28kiUq47GI37mWhDRDB2YRk21i18NA6U4W9cfaID7gQJaap4BxiXJNZaKG01vIlFij
         DTHYLk0hWvwPyJBUOmyRxmC/dmzFeMAtZb3UXaIGz3sNttjTQhNcpersMBq4LlItDraS
         W3LA==
X-Gm-Message-State: AOAM530L651qnRVIkEWQGIzgKeCE2DyjFc/+NfRsTMByDLAkWp21Dhp1
        5+GYJfZtjlOX4Yv+9MuZ+FBzuK9GjkG0mKc3PzYEuQ==
X-Google-Smtp-Source: ABdhPJxB1EeBheee6wLop1uGwnOHf1BlPR6yindpHuSJ3PoQyLwIeukkHczavQv1JwYDItqpnbZ59M9BwbLSfNLXvuo=
X-Received: by 2002:a92:cda7:: with SMTP id g7mr116355ild.53.1642436135473;
 Mon, 17 Jan 2022 08:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20220117160931.1191712-1-acme@kernel.org>
In-Reply-To: <20220117160931.1191712-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jan 2022 08:15:22 -0800
Message-ID: <CAP-5=fWuEphP5Q1H2Na0qbodOUdgPebVxLq+kLz38xxgLyacvQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf tools: Remove needless affinity setup/cleanup
 for pid targets
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 17, 2022 at 8:09 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         Continuing with the removal of needless affinity setup/cleanup
> for pid targets, please ack.

The whole set:

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> - Arnaldo
>
> Arnaldo Carvalho de Melo (4):
>   perf affinity: Allow passing a NULL arg to affinity__cleanup()
>   perf stat: No need to setup affinities when starting a workload
>   perf evlist: No need to setup affinities when enabling events for pid
>     targets
>   perf evlist: No need to setup affinities when disabling events for pid
>     targets
>
>  tools/perf/builtin-stat.c  | 17 ++++++++++-------
>  tools/perf/util/affinity.c |  8 +++++++-
>  tools/perf/util/evlist.c   | 28 ++++++++++++++++++----------
>  3 files changed, 35 insertions(+), 18 deletions(-)
>
> --
> 2.34.1
>
