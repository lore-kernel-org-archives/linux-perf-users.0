Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ABAC43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiFBUyq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFBUyp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 16:54:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437133EB4
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 13:54:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x65so4593873qke.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=6LjIkUGm3TVDX5vb/9qpUYyhJA5G8H8BVUBqEgDd3+0=;
        b=K4BLbcoX/U1d5DJy0Fie0u2XxILrsmwY37n4f4m3obW8BgIV9K6IMQ336R1HqxtKYJ
         099ADrHwc/doAy8ssKpWYGZT+pXduNfZgFSpRjQSxnSn6mWo2vqeTeh068WPsggWN546
         ngdtgoGCRxxlMQu+pIgdP2X5g6mVTEzDF0288=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=6LjIkUGm3TVDX5vb/9qpUYyhJA5G8H8BVUBqEgDd3+0=;
        b=7hPkTzTJvOsmhzT97Suf0TsZ58gZUT8QRZCCexI6DWMxBOXn3vLD2OSvvMYHPfJhFv
         3i81CYuF71Z40vX67m7P+5YncUHUZVuoo0LYXVPBw6oeZru7ebDcx9U3yW/j3SJY1CgY
         MouW30XDlutOVPSYanwVHOdTGdYFzcNs3IAnxXTZNo8o7rX86sPuBYzWeT1RQeHmJr1F
         QQBWUpBqSDMRDbUqg3BMizRaMlJI6CUXIFySP0OTasXV6b4Q8Fx58gL8b/8/0lbOBhQm
         oRMM5Z6+eRxeyjiB/2LrhcRwGM93tAltsRfvoB3MD133CVqlREhT5KIL+FKIgd0ExowR
         uQqw==
X-Gm-Message-State: AOAM533e40OGkVyksTfGVsnUF8KiQRo711ro3yxEtf1InM46BEy2j1eJ
        VljNS1FUANIdJEdqwrPyjKrAtw==
X-Google-Smtp-Source: ABdhPJySN8sV3owZc1gaDwMxXMUjTjGitab2FoDpySxmg+fsJ0CGADiXVU343143pwgQJQAaaz50wQ==
X-Received: by 2002:a37:a285:0:b0:6a5:c3e4:59a1 with SMTP id l127-20020a37a285000000b006a5c3e459a1mr4679278qke.346.1654203283239;
        Thu, 02 Jun 2022 13:54:43 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm3782457qtk.2.2022.06.02.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 13:54:42 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 2 Jun 2022 16:54:31 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: a few libperf questions
In-Reply-To: <CAP-5=fVeDJJ_HD=AeK0XSpsY52H58ZynRnnEpOB-z478=NxaiA@mail.gmail.com>
Message-ID: <c41fb7e-41a4-65e0-342-9f8de9a4b31@maine.edu>
References: <5842751-f5a2-4469-53f2-57ef1362568@maine.edu> <CAP-5=fVeDJJ_HD=AeK0XSpsY52H58ZynRnnEpOB-z478=NxaiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 2 Jun 2022, Ian Rogers wrote:

> >         1. What's the licensing of libperf?  Is it GPLv2?
> >
> >                 PAPI is BSD licensed.
> >                 This is something that actually pushes us to libperf
> >                 because if I wanted to (for example) implement the new
> >                 ARM rdpmc code I can't just copy it in to PAPI but
> >                 would have to re-implement from scratch
> 
> I believe that as code in libperf was copied from perf it retains the
> GPL-2.0-only license. Some new code is "LGPL-2.1 OR BSD-2-Clause",
> which makes more sense and would align libperf with libbpf. We've
> talked about rewriting this code in Rust, perhaps when that is done
> the more permissive license could be used.

I was looking into this more, the various files have different licenses

linux.git/tools/lib/perf$ cat *.c Makefile | grep SPDX | uniq
// SPDX-License-Identifier: GPL-2.0-only
// SPDX-License-Identifier: GPL-2.0
# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

and this disagrees with what the documentation says:

linux.git/tools/lib/perf/Documentation/libperf-counting.txt 

LICENSE
-------
libperf is Free Software licensed under the GNU LGPL 2.1


I don't know which of these needs to be fixed to be more consistent.

Vince Weaver
vincent.weaver@maine.edu


