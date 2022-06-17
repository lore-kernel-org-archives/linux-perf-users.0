Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC7C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Jun 2022 20:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbiFQULi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiFQULh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Jun 2022 16:11:37 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009120BD1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 13:11:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i17so1321333qvo.13
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=IX2PByp4AaPYCaHsl6YaKxCQDBLcbzVfewb/i5gDZJp4jC5hZnUusDaeihpND2VR3b
         2sZT0iz0pv92t3hD0zp1TvJBu9l8dLLbEi7+msWg7AfZOIXgxBr5+apxMEFg4MuWs2ty
         lLkNS/F1s2iGiJZURZjQDd3QjCpnH5JBlqEoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=D+BptFnEJoLUCx5y6vj6GK8fKL2pc7g1D3mp+sD9SNiPSY8lKP/uLhhzKKG2A7qjal
         /XwPQnLKyo3RmJJZXwv4xx7bxNb1B2OhUzbyDWTb7LztYuLU0OzNJLM/UsCC0sXHIzJP
         HadkNnT4iXXrVlvNQ0DSE+y6Ul5fFQkUrBVe7kMe8uX8pX3ew0kVvFuhCP73/MNDhjh9
         rv5ksQCqUSFcmFi1EOY3VbkhIMekV/3xi4/bAlJdbEjKXraLS66JaIt69dA/zsVsfa2t
         YBpJGlwjRiIlpthQcItESKc7cR+65ijlv17j14nkLkbWpB2lUXyxx367dc2XxHK579bq
         XjbA==
X-Gm-Message-State: AJIora/5Nw9HTixx5c7VYCeJJyx+ZY6DrSa/XIfytel0OxVCRDprpG6C
        L5udS+NJLbXutmdswub86fDFx+NLDRWMhA==
X-Google-Smtp-Source: AGRyM1uH6N33lIH+urBS+pxdMchukdpm2KfvwVdoRWcIoCCFoYOXcO7VRs/OEyCpGYrMfI3DsYiOlg==
X-Received: by 2002:ac8:5e4f:0:b0:305:1e3d:b829 with SMTP id i15-20020ac85e4f000000b003051e3db829mr10040332qtx.471.1655496695881;
        Fri, 17 Jun 2022 13:11:35 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006a3325fd985sm5011152qkj.13.2022.06.17.13.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:11:35 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 17 Jun 2022 16:11:34 -0400 (EDT)
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>
Message-ID: <db2031ec-cf4-4323-9d3-8262849add3d@maine.edu>
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


