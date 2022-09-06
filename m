Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA442ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 21:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiIFVRT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiIFVRT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 17:17:19 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1623B8F24
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Sep 2022 14:17:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g16so9155504qkl.11
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Sep 2022 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date;
        bh=iphfHBoIMOL1lNTHRr252fzN2iLvPwqaZYRfa0FBIl0=;
        b=chgn4pbDbcOp3ZbEZ0S3NHjfUXE16m4I6KQGo5MTe7zZewnaoKHfkshoAk8SQR2Wj/
         Lf3bH9ZA+yPsCOdwrmnauTe8etrWFMzUhP/ePs9pWiM0lnoGIYNe76MgkiXNzpzgOuLQ
         p74cCqKyLqxws1X/4yHYvVnREU6i1eAM3FLHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=iphfHBoIMOL1lNTHRr252fzN2iLvPwqaZYRfa0FBIl0=;
        b=is8OJ7suHtTsc/EsIGLHZGoQ8q4se4dGeN4p9QzMz3XlkgbfykzkuOC6mxuB8IYlIH
         /zfJKNYDOTx8ugxXFn3lxCANhlS3smvLnFVERJiZZXA42Lwadiv9fR+fb/hw4qVpku8t
         2DC6OKqvq3wDQCcJh6q6iDc61Ata/RbuS7eeeKamYaG5kCridF8YbXdwou19uSFxYzQV
         fJ/OdCfs/WiGEksN98PxHgymQt7k1wh0sCdx0X3rmapYYc6eB6N60bU2ojQsE2W3SCdO
         QYvbskUdXpOL9cyCxpK500H0NMXljaOBZxY+kMIN24NHfQimxjPz7tAXQ9SPPNhPQuqK
         /+mg==
X-Gm-Message-State: ACgBeo1K3oHMOAlzhbXymwSPx+4c1qc+XCZ9TMeYWjUjrONSW/hA4OR0
        s+M4sSx7sb0kk/tbkeIVHrRQs9qUD/RGPw==
X-Google-Smtp-Source: AA6agR6naAyf9NJUVt1eu65uLtRd9YOTQnBFylX4LLJ88vMlQ4yZsGYOqgew0EWn3OLhCnCBmlX5DQ==
X-Received: by 2002:a05:620a:4e1:b0:6bb:5c0e:ab58 with SMTP id b1-20020a05620a04e100b006bb5c0eab58mr504151qkh.730.1662499036977;
        Tue, 06 Sep 2022 14:17:16 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id y22-20020a37f616000000b006b893d135basm11381881qkj.86.2022.09.06.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:17:16 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 6 Sep 2022 17:17:14 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for multi-threaded
 targets
In-Reply-To: <CAP-5=fW3MLdzA01gWRx7yH-b=J4oqUTj9KMtrB0ZDpb0wucZ4A@mail.gmail.com>
Message-ID: <69bf3c5b-e3e8-9099-bd7b-b05beea7bd1f@maine.edu>
References: <20220905114209.8389-1-adrian.hunter@intel.com> <YxdEQkmkZjBC6wGb@krava> <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com> <CAP-5=fW3MLdzA01gWRx7yH-b=J4oqUTj9KMtrB0ZDpb0wucZ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 6 Sep 2022, Ian Rogers wrote:

> > >>                              perf_evlist__set_mmap_first(evlist, map, overwrite);
> > >>              } else {
> libperf CPU map code as I'd like to propose we start a libperf2 (with
> LPC coming up it'd be a good place to discuss this, there's also the
> office hours on Thursday). What I hope for libperf2 is that we can
> make its license the same as libbpf, so the code can be more widely
> included in projects.

If you did plan to do this, it might be nice to include some 
representatives from groups that would be likely to use such a library.  
This might include the PAPI library developers, and there are various 
other tools (especially in the HPC area) who are coding to 
perf_event_open() directly but probably would like to use a library 
instead if possible.

Vince Weaver
vincent.weaver@maine.edu
