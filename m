Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A67AC77B75
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 03:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEDDIn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 May 2023 23:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDDIh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 May 2023 23:08:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F544E73
        for <linux-perf-users@vger.kernel.org>; Wed,  3 May 2023 20:08:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94ef0a8546fso965052466b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683169711; x=1685761711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1sPdfgjBQddTLtJgPwbyySVZe+LzD0cP2bpBXFDlJY=;
        b=GI1uAfvg7dD9hOcX2Y9S0pg3SrRAf2vMWXvWhfS9StmqC6CrAIUL9ngekJKiWskDTW
         jW/VGuQxCYJg5QS71BCPmi1LU7Qyc3Zy3Lzv+o0Y9SIMh4i5ilwJTOu/B98mbIzbApqk
         6U8TYnpNmE6Rf/bDu+S7N9OeR6hVlq7VkaJHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683169711; x=1685761711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1sPdfgjBQddTLtJgPwbyySVZe+LzD0cP2bpBXFDlJY=;
        b=lHZNlaSOhu0arfdtSUcxF4XF4c+WILgnwmOsEORn/g75aEp+gXESskSUWuV0SB0+Hi
         7sB4GJojwzqzKIMCFpGDwYLMo7hZZSjzjnt5rWpWaW6SF/BmPomKOPX/odTt3Lo7VqxH
         /goY6aKuXy0hb3TLLXCxYHXPUU6hozvDZ2soK/z6y2+VnRWiP0ZxtcEpIVsnh6P6wwWT
         EIf2/GpNCXY0fEkWaQh4H6foRIT/of7ZeSSafeYzYkDe43WWZxgRzgqNHHbq8OXhW90G
         3cSKKArndO28l2UM/9MSm3vmdfUltNMy6cN/Q7hh5DproKORzBoCjEFQ8kCpESstUrhs
         NXqA==
X-Gm-Message-State: AC+VfDw+nelnT0NgSaXx7z8PQBrtaXxBVHau4iLM4Pw1qei82BL5mVno
        5I+OZofyJwLCucdG3pmJEWgJME4q7P13rX7ruHUzWXYd
X-Google-Smtp-Source: ACHHUZ4oQgt8BJkwjyrOhmT8S0JU9grWM+Tek234yM4dWddtTh+SDUEKHe0uWXnrMAQtXODjNIaoJA==
X-Received: by 2002:a17:906:99c5:b0:94a:97dd:aed9 with SMTP id s5-20020a17090699c500b0094a97ddaed9mr4894397ejn.70.1683169711474;
        Wed, 03 May 2023 20:08:31 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id qw16-20020a1709066a1000b00959b3c30f2csm13412652ejc.222.2023.05.03.20.08.30
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 20:08:31 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so59079795e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 20:08:30 -0700 (PDT)
X-Received: by 2002:a17:907:98b:b0:94d:69e0:6098 with SMTP id
 bf11-20020a170907098b00b0094d69e06098mr4661982ejc.45.1683169226391; Wed, 03
 May 2023 20:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org>
In-Reply-To: <20230503211801.897735-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 20:00:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
Message-ID: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 3, 2023 at 2:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
>         Please consider pulling,

I did consider it, but the end result doesn't even build, so I unpulled aga=
in..

I get some libbpf error, and I'm just not interested in trying to
debug it. This has clearly not been tested well enough to be merged.

  libbpf: failed to find '.BTF' ELF section in /home/torvalds/v2.6/linux/vm=
linux
  Error: failed to load BTF from /home/torvalds/v2.6/linux/vmlinux: No
data available
  Failure to generate vmlinux.h needed for the recommended BPF skeleton sup=
port.
  To disable this use the build option NO_BPF_SKEL=3D1.
  Alternatively point at a pre-generated vmlinux.h with VMLINUX_H=3D<path>.

the build system assumptions are clearly completely broken.

              Linus
