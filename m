Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F571C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 18:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCMSfv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCMSfb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 14:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F686151;
        Mon, 13 Mar 2023 11:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52838612FE;
        Mon, 13 Mar 2023 18:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEB4C4339B;
        Mon, 13 Mar 2023 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678732387;
        bh=Qvjiry3j6mDR6Vh8s4c81dINZYpikTiYdWJ60bOpkcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhHmCRiCZOyGKXJUg3UdOju2bmn60DCmAGvqNrBINb0H9m2RMvBtahzg8qzzpsSWM
         CHW7dxX/6JE9FNOvrDSmKwAmlNxzpyan2WvmCM9YriWNJYu12FzI0QeNDtpM68SkvJ
         8GDbpUdCDjJr5/f4WORw+3ExzndSMyfA90Tw+L57t7FdB8LqqnrfraqlUyED2YpLRu
         Y23n/j56lNxyAigSAQ4fYJhO5+QNRQFdU5T6n+ryNx+j9hbAW6DV28zB1Zh87ti4aH
         j6eYNMGrht2JR4n96OvvWW+pMBNavOMJcPxj3SDMEOuJlsITD31Bu+bQfyBK634IWY
         HXAlQlQjmi0Jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2EA74049F; Mon, 13 Mar 2023 15:33:04 -0300 (-03)
Date:   Mon, 13 Mar 2023 15:33:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
Message-ID: <ZA9sYL/re/aNVpo+@kernel.org>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com>
 <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Mar 13, 2023 at 08:22:44AM -0700, Ian Rogers escreveu:
> On Mon, Mar 13, 2023 at 1:30 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Add metrics for s390 z16
> > - Percentage sourced from Level 2 cache
> > - Percentage sourced from Level 3 on same chip cache
> > - Percentage sourced from Level 4 Local cache on same book
> > - Percentage sourced from Level 4 Remote cache on different book
> > - Percentage sourced from memory
> >
> > For details about the formulas see this documentation:
> > https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf
> >
> > Outpuf after:
> >  # ./perf stat -M l4rp -- dd if=/dev/zero of=/dev/null bs=10M count=10K
> >  .... dd output deleted
> >
> >  Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=10M count=10K':
> >
> >                  0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l4rp
> >            431,866      L1I_DIR_WRITES
> >              2,395      IDCW_OFF_DRAWER_IV
> >                  0      ICW_OFF_DRAWER
> >                  0      IDCW_OFF_DRAWER_DRAWER_HIT
> >              1,437      DCW_OFF_DRAWER
> >        425,960,793      L1D_DIR_WRITES
> >
> >       12.165030699 seconds time elapsed
> >
> >        0.001037000 seconds user
> >       12.162140000 seconds sys
> >
> >  #
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied the first two patches, please address the review
suggestions for patches 3-6 and resubmit only those.

The patches will be in the public perf-tools-next branch later today.

- Arnaldo

