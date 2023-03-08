Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EAC64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 11:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjCHLtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCHLs7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 06:48:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6F892722
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 03:48:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so1199046pjb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 03:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678276138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbBcsqGyig8XUhyEekjutChTUpott8WGc/M9C4QYgbI=;
        b=WnsiV5uBCELk4P3T0IyLpAHcF96t0ImUA4Iz09igsq0xEO4mGiqFwqe9IqmzR9dd8C
         U4cB+IBWcXtQpeW3jivyzfoHzRAtkUt0/rulIoFXhzmrXV3OmYxtAzuuTIk3sINNrKCT
         sNi7YauNaEZye1WN+K4dj9tnDBpbjU38UnbtQHX3/Q+YwWynZ+RUHYZ59dZqUfZ0g9Xd
         EPfKAmE+73H3C4YuTIOPj62AaBu5cB0Pa2wz09URn4E829A/7e/yHV/FoQ1xX2meegxB
         u4g8ueOAzqaWLUNCCpjvfDYuZRYlRgxZ7BClltkY3BytVTlymje5x8UfxclPVnyC2TAF
         mn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbBcsqGyig8XUhyEekjutChTUpott8WGc/M9C4QYgbI=;
        b=LsJe6BwvQLbDleoAAALUoX+pThmWXgYZ+sqlyARmRA6n9i5XVlTo//tmPjGWBL8e6S
         X598CjctkhIXl/7JxzzpPIO19Qj/CJclPan7DWPn0x2hdZtf5olbCPQ5OOoBqwJuhUZU
         6EuyUTM8xuceNcO+/8qTiXwMD3wywJhbycb/IxgAI9bsWFG2U1vyrghb9lXqUjWWATIb
         KQYmX4BsB4+NzdbVA/j5NPknsg6or8F7Dny+mxURX0pJlXSvO+MNa2jw/6VUZMuTAfax
         akgcN8dkwc8N3bwtMmYD7q4lOEvM62Ju7jCyf/kbhpml+xv841VQ9fB9aYNJcM1U5xfk
         HYsw==
X-Gm-Message-State: AO0yUKVb5NCbQ/IG9nfm/htDPQNjmz1fFeX/mKtRB09apT1i8cPuDcZY
        12NzUzhYig59WpfAFnscH+iN0Q==
X-Google-Smtp-Source: AK7set/2m/niQhK3negvQMAblFSyGR0dq+YbY3qcKX3j0XhNdKsrM9uc5HhoB44X2+p3PNyv2Bj0oQ==
X-Received: by 2002:a17:903:41cd:b0:19c:94ad:cbe8 with SMTP id u13-20020a17090341cd00b0019c94adcbe8mr21653378ple.36.1678276138049;
        Wed, 08 Mar 2023 03:48:58 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0019aa6bf4450sm9648656plg.188.2023.03.08.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:48:57 -0800 (PST)
Date:   Wed, 8 Mar 2023 19:48:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, al.grant@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] perf cs-etm: Avoid printing warning in
 cs_etm_is_ete() check
Message-ID: <20230308114850.GD19253@leoy-yangtze.lan>
References: <20230308094843.287093-1-james.clark@arm.com>
 <20230308094843.287093-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094843.287093-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 08, 2023 at 09:48:43AM +0000, James Clark wrote:
> When checking for the presence of ETE, a register is read that may not
> be present on older kernels or if ETE isn't available. cs_etm_get_ro()
> will print a warning if it doesn't exist, so check for the existence
> first before accessing it.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
