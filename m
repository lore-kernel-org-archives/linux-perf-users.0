Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiFBPiD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiFBPiD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 11:38:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A7AE463
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 08:37:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id el14so3780286qvb.7
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=BS87HRd7bxhANXTBmrFb2MZziyzcmwF7iT3CVf8tHcw=;
        b=KGCRGHqMoL8fsColu4XBNL6nF+xyv0W0vQSvQ8WWGGJtVR84ZKeQScQFBli3jSK1uR
         qs34iG7HPkObiV0xvQk9zAWREgczacwQ/lyfdsX0JqLGGMPOF6FdZBCEKqiD0kIk+/dX
         pVmIVp9tfgxvymBNYsvCpZHK60GGkQdq/j5MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=BS87HRd7bxhANXTBmrFb2MZziyzcmwF7iT3CVf8tHcw=;
        b=1OXOS0BKR6zHsoU6t3DOLMsUTegyXGwAVwYzUQUFy+wfA1KYrzL3CNvgudw86B/gzS
         URL7tPAiuG+k2YcHCMzziAF1VJ/qnU9ZpXoF64DsApNGa9XSzMfQRY2Tdwyi9HWLIJmY
         rUC5+5iuvjEXRPR/WJ6qwhIfXEoyMrJZJfaoU9tx7PkvH1/zFmyXfwxhGBP84llmqpWK
         FrLQ7cHQKtPkoN/IcXFX3U0LFVF9vhxPYYmGRmYCqxIz8iz4LutT+TsD5g6k7X0tQZGw
         dav63EbtGJfiAekAfvurlZrpOSKIFEnWx6tX/SRuSSG6f2csi/hTV1/2YOsOgMBgPc52
         49GA==
X-Gm-Message-State: AOAM530+F5X47kenZwMQ072eLAoh7VRTU8tYeMblqzhfVSSlDTZqSKIu
        x/9CxOgDfejiYMRy61epl759rDzdf6JnUQ==
X-Google-Smtp-Source: ABdhPJwg/JaGgeYNWtmFR9n27tFJTN2GoPIGhlXOi9qG/ZIrsaIASU5SO2Q7KjEkpvQ/TZwCgDYnjg==
X-Received: by 2002:a05:6214:2aab:b0:461:bb29:6f2 with SMTP id js11-20020a0562142aab00b00461bb2906f2mr59036037qvb.38.1654184276915;
        Thu, 02 Jun 2022 08:37:56 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 13-20020a37090d000000b006a36059ed59sm3258163qkj.27.2022.06.02.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:37:56 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 2 Jun 2022 11:37:55 -0400 (EDT)
To:     linux-perf-users@vger.kernel.org
cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: a few libperf questions
Message-ID: <5842751-f5a2-4469-53f2-57ef1362568@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello

I work on various perf-related tools in the HPC community, most notably 
the PAPI performance library.

Currently PAPI maintains its own independent code for working with 
perf_event_open(), but with the advent of libperf I was looking into maybe 
linking against libperf to avoid all the code/work duplication.  So I had 
a few questions.

	1. What's the licensing of libperf?  Is it GPLv2?

		PAPI is BSD licensed.
		This is something that actually pushes us to libperf
		because if I wanted to (for example) implement the new 
		ARM rdpmc code I can't just copy it in to PAPI but
		would have to re-implement from scratch

	2. Is it expected that distributions will start shipping
		libperf?  As part of perf or otherwise?

		Telling HPC users they need to dowload an entire
		kernel tree just to build libperf is seen as a huge
		obstacle for many, and just including a snapshot
		of the code into our code tree again starts having
		licensing issues.

	3. Is libperf planned to be backwards compatible with old kernels,
		or will it be tied to whatever kernel it is shipped with?
		Will it have ABI-stable releases?

		Sort of like with perf, I know only supporting the most
		recent kernel makes life easier for the kernel developers
		but it does make for a library versioning nightmare
		especially if trying to support people on older
		distro releases.

I'm going to try to see if I can get a libperf backend for PAPI going and 
maybe try to get some of the other HPC parties involved (they tend to not 
want to deal with kernel development directly for some reason) but I'm not 
sure if they're going to like how closely bound libperf is to 
the kernel tree.

Vince Weaver
vincent.weaver@maine.edu
