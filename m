Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D893C004D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 18:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjASSN1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjASSNT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 13:13:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30258CE43
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 10:13:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m15so2210120wms.4
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dUVUNtePDymk07LHHbZL1+j0wapkht1KOn5TyXGZvPQ=;
        b=T/96DXA4kEdQquEePG6qSXhpQB9SUG5R33koNP/im7m2ghcsIJYNc+5qzw9IULLerr
         m9KVTYhq1NOpEaLNUAjas3TzVr0Oh9mliXvBDL+rU2qVkaBvEZvgf4K7odP2ecZ2Hb5l
         zDORkc9JjTzrYQjep9NtSZ+dyI+VYlfbJNmjdQHX2bldW98QEbjDivdmUZlxXD5YJ3nA
         CZq+36tdFCP/bq5lJ0SDzYPVzrjYc9/BNHiRV+06VyEDNXyXHX6+bZYPiUEQ7I9O6OnN
         rbtX3LwXH0Skj/QZVETHzp4GwxC6XrzicVL8TfwauyN57nl7fGkpvBKkOsoM3irkrtLq
         P8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUVUNtePDymk07LHHbZL1+j0wapkht1KOn5TyXGZvPQ=;
        b=ez+5QEdYIfZePQM9JGKpadpUxADCFIYThd76ACUFy1g9D3Yg7uivXSCVbxuDz4/ak+
         14v9oQno5ODLCTZjR3gObpkQsxmshxIkyjSr8IlMwyC+Fqt9LGL4bQYb/b2WSLh3Zn+a
         Q2ihy9OgmZH4HGnEoZVw7+0sCWIJTarDJEAKNUxYUQ2c9camhLmHWhssFj15D2S6Tu6G
         CoIy6sKOAZCHtaNofMKZuvgUV0V/jQEDNR5yIaWp/s2o93WAqudqkpc4H94ifa9bET44
         gnbPyRzB1AfyuCwc/dnH5HfDYMTdlP9FH3GnK4Mmppv5jQ5VxBQoZN8aBtoS3fnv+Pwr
         aeKw==
X-Gm-Message-State: AFqh2kopkgCFvmFm3n83btx/2A5VH6UT3bIaks6KFA7Q+fHEq/f8SFZ+
        94jpNQh7dhfOBMn+fgUzOl6D77pQJT3R+sO2QWjQYA==
X-Google-Smtp-Source: AMrXdXvUe2XFZeIHsnnCPOzcFX/icrFzsIk6jcEAVUCYBfg6oTC6+OcaNNAxeHsYVcFJGPUoHtp/lAE+JixZqE4CQ+Y=
X-Received: by 2002:a05:600c:5405:b0:3d0:50c4:432c with SMTP id
 he5-20020a05600c540500b003d050c4432cmr696057wmb.67.1674151987344; Thu, 19 Jan
 2023 10:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8mCLb8t9tYYBCtt@kernel.org>
In-Reply-To: <Y8mCLb8t9tYYBCtt@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 10:12:55 -0800
Message-ID: <CAP-5=fXnzaJfbuNBt=5ETjiNmYzTmkJPc+-iCKr_29mssFRZWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jan 19, 2023 at 9:47 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Anyway, just a data point, I'll check if I'm missing installing it
> > somewhere.
>
> Just asked for libbpf-dev to be installed on the debian:11 container:
>
> [perfbuilder@five 11]$ dsh debian:11
> $ bash
> perfbuilder@589d1572e8cf:/$ ls -la /usr/lib/x86_64-linux-gnu/libbpf.so.0
> lrwxrwxrwx. 1 root root 15 Jan 10  2021 /usr/lib/x86_64-linux-gnu/libbpf.so.0 -> libbpf.so.0.3.0
> perfbuilder@589d1572e8cf:/$ dpkg -l | grep bpf
> ii  libbpf-dev:amd64                   1:0.3-2                        amd64        eBPF helper library (development files)
> ii  libbpf0:amd64                      1:0.3-2                        amd64        eBPF helper library (shared library)
> ii  libpfm4:amd64                      4.11.1+git32-gd0b85fb-1        amd64        Library to program the performance monitoring events
> perfbuilder@589d1572e8cf:/$
>
> - Arnaldo

Right, the old/ancient libbpf-s are gross, but Debian doesn't use
LIBBPF_DYNAMIC which also isn't a default build option. I guess we
could say there's some testing impact from this cleanup, but I'm not
sure we care.

Thanks,
Ian
