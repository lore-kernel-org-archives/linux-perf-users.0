Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3720BC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED4561269
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhKKHc6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:32:58 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37738 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKHc6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 02:32:58 -0500
Received: by mail-lf1-f44.google.com with SMTP id c32so12113142lfv.4;
        Wed, 10 Nov 2021 23:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bdxh8C8Ix0fdeZSOa9W/5X4HmbH4M0dJAJ3EvFO+DoU=;
        b=JiVmdCnIgm1mtkK0KWPrLKWeEHMoI8cg5dOwafqF0W9IIb4/kjEw89cHZ6WdtXAYCs
         o/YNEdF2XvYrqy6YT3QJH6ewN09M2j+gZhdLrxLXHQpq6LuHWN6rH37FdDwJrG8Iuf1f
         S0pbE9d34i3XCwlGWbwMw9UpHdiXQK0wkcrxc7YGGj3a30iABZzzFzjJfxVTslKzWSvf
         yGhRvaUA7b6C5BlgeR7pwIb/cOmYJRB7vEUZYWeXOwh3d9eKUHGOYOI+TkOI+TFwWSvu
         nEmrArqpxcudh028gsspYVw5uf4I6lY7KNvEJr8fdvVQQZFnneYa2QxPnvJE42pot+dv
         Do6g==
X-Gm-Message-State: AOAM532K22g/jqlA6DGoHXzFDLeti/Rz/ZOFs5UeoYrTuHMBnMEUiQBz
        PiRLxhqu5lX2QV0mdHNmLrzwW0sxtBfg7FjUlmE=
X-Google-Smtp-Source: ABdhPJwdFtwVuWwSDWa9Ba9hQaay0HoSXzvGaVC1CveRB2r2L4hp/bkgEec89sZo6iISNCXsTko2o1xTOcGEcMJ+udE=
X-Received: by 2002:a05:6512:b8c:: with SMTP id b12mr4750174lfv.99.1636615808214;
 Wed, 10 Nov 2021 23:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20211109115020.31623-1-german.gomez@arm.com> <20211109115020.31623-3-german.gomez@arm.com>
 <20211111071815.GA102075@leoy-ThinkPad-X240s>
In-Reply-To: <20211111071815.GA102075@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Nov 2021 23:29:57 -0800
Message-ID: <CAM9d7ci_iFk5n_0WECGAsyGjgqRCSH4UG_AECDSeO-0i4FMuNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf arm-spe: Update --switch-events docs in perf-record
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 10, 2021 at 11:18 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Tue, Nov 09, 2021 at 11:50:18AM +0000, German Gomez wrote:
> > Update perf-record docs and Arm SPE recording options so that they are
> > consistent. This includes supporting the --no-switch-events flag in Arm
> > SPE as well.
> >
> > Signed-off-by: German Gomez <german.gomez@arm.com>
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
