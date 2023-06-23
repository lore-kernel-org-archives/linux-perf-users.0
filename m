Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E0EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 16:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFWQEW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjFWQEV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 12:04:21 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579EE271B
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 09:04:19 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-630074df712so7617496d6.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1687536258; x=1690128258;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkCU27YeWYPr1I8vi2zgnQGLek516NQOwJppe/zcLRQ=;
        b=adyk15Rey22YW24kQvynUdQZpNYqgF7LlhsDAWedX+3rCdpjtOLZ8DFTsDSozH2N35
         typD0VRNKPBMXizi1O93czEa68cFdaLH4Qnu6bfhx+xDr5BpOvdxqXSfQVHzjHpCrN7b
         5DIu1BGKHJiA0WF1DumHBLLRu3XV8yuMZBSdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536258; x=1690128258;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkCU27YeWYPr1I8vi2zgnQGLek516NQOwJppe/zcLRQ=;
        b=IN9xuxNd9Yc3zLdVtT3qF4+1LbMwWKTu1pCq+ptlqhB5V0X0bvOsa5wjDnx/1cXlO4
         l1ZlLX0AqWa2vhyhKQ2inomCVCM0W2o1R14mdp8QmvvCPQ3R7sDAnCo4HC/YK017nmeu
         RlgGtDS5Sc5g2XF8hS7IeRYaBDugZkdlzbdclHzIz2KCbBi/wNRb1stEMfFr45fWRZ0h
         NCnvQqV/j9MC0EsEv5yLkpYdevpt/B55Z+ZZwsg3wAHxPzQ53rtmtBFZ6nBSiH9somJG
         /GyPMezu3e0DyOyQ4dss/EN8AweChS8rVnJuATqWXA/IpsnWQwbhPN/N5pwtpM+wsULK
         fofA==
X-Gm-Message-State: AC+VfDyH8w1Pz25GujUe6KOve80/ov8XkHVPCQArVR9sJhURJ3lOia0t
        OsCwr6LnGL4qvbKsyc7t0QjPFA==
X-Google-Smtp-Source: ACHHUZ54R98ZBjwGvQadwUU6bIFsyMXtmyOo/WfF0ahv3XFa+m6/YpMz+OenWDUllWtc8BgqaqEIwg==
X-Received: by 2002:ad4:5b81:0:b0:626:94f:6044 with SMTP id 1-20020ad45b81000000b00626094f6044mr25988971qvp.2.1687536258328;
        Fri, 23 Jun 2023 09:04:18 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id z14-20020a0cda8e000000b006255bcfca88sm5192184qvj.7.2023.06.23.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:04:17 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 23 Jun 2023 12:04:13 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v2 07/12] perf vendor events intel: Update icelake to
 1.19
In-Reply-To: <20230623151016.4193660-8-irogers@google.com>
Message-ID: <ac3b4a0c-7984-8b15-a7ed-9c0428bdb027@maine.edu>
References: <20230623151016.4193660-1-irogers@google.com> <20230623151016.4193660-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 23 Jun 2023, Ian Rogers wrote:

> Updates were released in:
> https://github.com/intel/perfmon/commit/f3d841189f8964bc240c86301f4c849845630b5b
> A number of events are deprecated and event descriptions updated. Adds
> events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and DECODE.LCP.

why are the events marked as deprecated rather than just being removed?

Vince Weaver
vincent.weaver@maine.edu
