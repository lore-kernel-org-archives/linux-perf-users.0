Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F9C7EE29
	for <linux-perf-users@archiver.kernel.org>; Sat, 10 Jun 2023 01:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFJBck (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 21:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFJBcj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 21:32:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2735BE
        for <linux-perf-users@vger.kernel.org>; Fri,  9 Jun 2023 18:32:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-652d1d3e040so1972671b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jun 2023 18:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686360757; x=1688952757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMoAwEd9SlzlxTzlnGrB3GqIf4l0rMIqn94dDmyDoGA=;
        b=OOm3OhgjZM+KfutyMsF6l5PCN2dehGk7rml7KOoEYV2LPG1G6PnhgikuF+d7n+Rfo0
         srY09o5ZRTX4h+Edx0x979EiH4CeYQHvPdXrYoWpjZAbz4lFTuK6V+dkYYLXYxLoKJF7
         Xjj5sXug6afD45tlamE69r4bKhD1YOZVgwrAldLc4ecC4WK6MCWn9vRto3q+xw+azMVD
         BrIH4uR6n1OVuQqSBq2zHMo4NV1yx8gzika/0NV3i6V1AXMYp5iaTyCpgPI8oyAXN9bN
         SgXXwfc5Y+kcNkNNRX0UrdRhBWTA8Zp8z80ym0R9tXvzrdUnbsyavLDJkEbeyqdlDo6p
         A4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686360757; x=1688952757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMoAwEd9SlzlxTzlnGrB3GqIf4l0rMIqn94dDmyDoGA=;
        b=C6a9aBSQjs+Gc35Xggexl78B41RLKxb1RZI4QmNT3Q5hNTBHRtgO1LE9V+1rJEcexI
         wQvw+tD38egKYLh3pwFHwkM6mN1B3xPWpDkZlhK9e5YtwG2+4R/njj7spbW83hDyAGIq
         f8Io/nAYDB3WxbZYuZmzOHhl1VnRdb5VHWZEA/5yZhyF97l7qWt31XaOawE/BBBa1OmZ
         e4UPrYDHAoz28qai07rJA3OCPKjSu7VAonunx6gRfRzII7f8/1ORK/fUgNa9fQItn4dL
         qdEIXElkf9bwqmRXeGPX+POHCEc8bHixBk++E1YJ18OcHkDPjJYHdJgcliwD7nYmkIl5
         cspw==
X-Gm-Message-State: AC+VfDxLD6ZaX3+ecBP3l0RYPBKzxhr0u/HdtThPg56t/5qfm9Nxj4w7
        MmYuOL3w3gfwFD3GvXjude3iLQ==
X-Google-Smtp-Source: ACHHUZ6F1bMqDS02GmSF45tEnoZN27ZPLrIBrde419+hbZHXY9r32fa9M8hlCOzYq5YAwpP4C88hEg==
X-Received: by 2002:a05:6a20:8405:b0:10d:f812:e4b5 with SMTP id c5-20020a056a20840500b0010df812e4b5mr2858569pzd.35.1686360757014;
        Fri, 09 Jun 2023 18:32:37 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b0063d24fcc2b7sm3210133pfn.1.2023.06.09.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 18:32:36 -0700 (PDT)
Date:   Sat, 10 Jun 2023 09:32:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] perf cs-etm: Make PID format accessible from
 struct cs_etm_auxtrace
Message-ID: <20230610013228.GB174906@leoy-huanghe>
References: <20230608105930.1389276-1-james.clark@arm.com>
 <20230608105930.1389276-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608105930.1389276-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 08, 2023 at 11:59:27AM +0100, James Clark wrote:
> To avoid every user of PID format having to use their own static
> local variable, cache it on initialisation and change the accessor to
> take struct cs_etm_auxtrace.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
