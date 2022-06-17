Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E4C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Jun 2022 20:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiFQUNb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiFQUN3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Jun 2022 16:13:29 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0C5C358
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 13:13:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q104so7966461qvq.8
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=dH4hwY+JUwHqWAOnAMYh+qe4C+Zef5b8t/2v0ZWIpDQgfFra8a1MhYCcJimdS4//xt
         NrDPCFSEbNQwuuksbTvqwPZg5hVEasYajGDsYCNSDtGEt4irD7DmKtmemXhMKCZ30Ulm
         u8EpbvZhHMmUQlD6ngiG4FiwhmzGXOlFK6tLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=th8+k83LRNdnl8DY/jro9eehq46gsL4Fq+eUsX2fumO4pcijdnLjEdO2jJLgKwEb7d
         Nqtze0gikZySJflcjKUGh815wegvDSAzypGiQew2Tm9ofZd6py/scn9WlSiQDQhp8RmF
         C7uZGY8S4b/oPzHUeLqEDCgMWaGVIuodaWqPbhFF0JAbwGdItf1drhvhXegIqinbMF8L
         NZ+dikX6wapw32OLKt5fm8J8qijW3jbvbBzIjnuOTaY/HhA9Keu8KzIKNCo3uUsXsxaZ
         q7TlDqxYXs31gh6B5aQtfMirV8rGzjRhAMc4rjpJC9ApBvX/RYLTlt/pM8JQ8TF4aflL
         GXMA==
X-Gm-Message-State: AJIora9KCATBKwDkBb5vYVY1O5bvtrd4a//eFaN/u05Z3qwYMVnwwofx
        bVtgipIIycKUIo6s6GwxVpfKXw==
X-Google-Smtp-Source: AGRyM1tdf19qGWMpde/NBHQopZashJ9qk17WLUuCuLkBlXiGaKUuDFYm2QcKkO7kpZg8vxf89UK7pA==
X-Received: by 2002:ad4:5bc1:0:b0:42c:531c:ef12 with SMTP id t1-20020ad45bc1000000b0042c531cef12mr9984516qvt.15.1655496804161;
        Fri, 17 Jun 2022 13:13:24 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id z13-20020a05622a060d00b00304eb8e880dsm5689926qta.23.2022.06.17.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:13:23 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 17 Jun 2022 16:13:22 -0400 (EDT)
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: READ_ONCE() usage in perf_mmap_read_self()
Message-ID: <f26be5e-af31-a996-9c7-86d9d1ed4b2@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello
 
Is the perf_mmap__read_self() interface as found in tools/lib/perf/mmap.c
the "official" interface for accessing the perf mmap info from
userspace?
 
Are the READ_ONCE() calls required?  If they are left out, will accessing 
the mmap interface potentially fail?  Has this ever been seen in practice?
 
Part of why I am asking is both
 	tools/lib/perf/mmap.c
and
 	tools/linux/compiler.h (which defines READ_ONCE)
have SPDX headers indicating they are GPL-2.0 licensed, which means it 
seems like it would not be possible to easily use the perf mmap interface 
from BSD-licensed code.  Would it be possible to get those two files 
re-licensed?
 
The (BSD-licensed) PAPI is currently using a mmap reading interface 
based on early documentation for the feature, but it isn't 100% the same 
as the version from libperf (and isn't using READ_ONCE).  Life would be 
easier if we could use the perf version of the code because then we would 
have one less variable to deal with when trying to track down issues.
 
Vince Weaver
vincent.weaver@maine.edu
