Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621E6C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 08:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiCVIZp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCVIZd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 04:25:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC1665D2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 01:24:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q8so12441049wrc.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87Bh+QidxYMpsTYJqSrvJQ/cLDGkqP1N5aKJGexsbZ8=;
        b=UntMI064I4h4ouP4KOJ7gqzkm7PmMH9vI17MKSNFgn3wq/uh0ECMIt0Wum/7pYQLIG
         CF5qBREq7d7xNCgDHi+Ssg57wHI7f9XS9l2hCZ3FPmB/Y8Z7aC4BhUPhqVjCnfoZhOLm
         CaKh/rBCwdFKiC7OokdIBLk11nGnzs+X/16vfiRfDNq7ikugOnBBSpW1pMOOlxZXFs8Z
         w1yNrULd3jjat3CWVriijurqzl6TaditTbuVlTI3zuNc80i3PcLCZw1oCUfa32DelVTa
         aFzFvd4SR41BRDH2prRLnHcPr/BoVrSe2MhkpDnMRxeEPk6Oyi5jgGA6Mz7oe+1Sbr8Y
         xbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87Bh+QidxYMpsTYJqSrvJQ/cLDGkqP1N5aKJGexsbZ8=;
        b=WBezEGaNYdEP+8SseLuyeQD5uQMc9WM7NS3rIHmIvqjZemq/5PaO1P0d3DwnOczPMX
         wy2d49RoVcz1UXAFkAHfOE7N/QC5LEjrPp0T2AXyUHMiFHnoh36LV+JP/SEgji8/AC8K
         lbwC6oHCzQrOHsS0VdTIcxpaa0k3YKgmbK8akGZ23N0mUBtW/3tLqP0066bKQYc4Gi9n
         gtrZPnOm4DhKDtSEfvf6qZ25hhzLrKyKod6jYc9cOvxzViZigwB3SZVo+C1IbWBZp2Wj
         fc/hnJTeFy7ewwhA4QIfp1Gd1c8b6l/IyLZ/YYwpiW8WGku92sY+FC9gciH8NK5c+Ihu
         GxPQ==
X-Gm-Message-State: AOAM531GYNTUIG+13rX6VPJEoDfijYy0JLz2LUFo4kiw1rERaZuD62gr
        YZUpkRHCqTwFc7BCXet8fuffpEFtVUCF+g==
X-Google-Smtp-Source: ABdhPJzjZUCCluCimIHyo0ySg/7PluFhbVLtmTWABCnNMk1Pt/Gy63nrTht/rrm7cCmzgiESIIYd2w==
X-Received: by 2002:a5d:6542:0:b0:203:da90:969f with SMTP id z2-20020a5d6542000000b00203da90969fmr20612878wrv.479.1647937443900;
        Tue, 22 Mar 2022 01:24:03 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00203f94379a4sm10515962wrd.67.2022.03.22.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:24:02 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:23:59 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf intel-pt: Synthesize cycle events
Message-ID: <YjmHn7ewyUEQBzDj@google.com>
References: <20220321181447.1323742-1-sesse@google.com>
 <e9126f11-177c-cc2f-7620-fdd7b3f363c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9126f11-177c-cc2f-7620-fdd7b3f363c0@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 22, 2022 at 09:13:42AM +0200, Adrian Hunter wrote:
> Thanks for sending the patch.  There is one variable leftover from my
> earlier suggestions - see below.

That should be easy enough to fix. :-) By the way, I updated the
documentation slightly in v2 to reflect what you said about when CYC
packets are emitted, and the possible (partial) mitigation of noretcomp.

/* Steinar */
