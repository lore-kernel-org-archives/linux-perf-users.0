Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA16C07E9D
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 12:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiI0MgQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiI0MgN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Sep 2022 08:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA6147CD7
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Sep 2022 05:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B74C761932
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Sep 2022 12:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97D0C433D6;
        Tue, 27 Sep 2022 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664282166;
        bh=DX6vGsLYeJghLuQxmqN+cD4MEoymtJJBw0BGuAz+Gq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmLqYAPmci4Gh6JTGRFspm9yrxPdQ8Y9TrdNCp5KBiYpGKZfWS0ZRTTBHz/SM6FON
         ZgSLHB7quRZMKzBZUybdWBr8z4fzZduM7hWE8Zs2iiUffFpHGLBSUyL9B+cml1Lhz+
         eZdYH+kUyucoXpkFJdRBiUMQ+ur52rm+jP3H3DBDv6Eidp7O38zMfD9sFsF3vLZhCq
         gvBy+PBo/fi8OxYnwWL1Dw5Tcm7Ongd7O1GLCQqvwisw0ZiWUdOunpwRELTWxVX+gy
         QRKU0vXsU0VmrM5GAHwPAQr6n9hMeC+ZehPcSBEHrFaXB48x0Bx0gd72ijTHtNBQSz
         AT51PwC1SaT4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44C61403B0; Tue, 27 Sep 2022 13:36:03 +0100 (IST)
Date:   Tue, 27 Sep 2022 13:36:03 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/5] perf: Remove unused struct
Message-ID: <YzLuMxMccZ1vn9sm@kernel.org>
References: <20220927013931.110475-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927013931.110475-1-yuancan@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 27, 2022 at 01:39:26AM +0000, Yuan Can escreveu:
> This series contains five cleanup patches, remove unused struct.

Thanks, applied.

- Arnaldo

 
> Yuan Can (5):
>   perf machine: Remove unused struct process_args
>   perf annotate: Remove unused struct disasm_line_samples
>   perf metric: Remove unused struct metric_ref_node
>   perf jit: Remove unused struct debug_line_info
>   perf lock: Remove unused struct lock_contention_key
> 
>  tools/perf/ui/browsers/annotate.c     |  5 -----
>  tools/perf/util/bpf_lock_contention.c |  5 -----
>  tools/perf/util/jitdump.c             |  7 -------
>  tools/perf/util/machine.c             |  4 ----
>  tools/perf/util/metricgroup.c         | 11 -----------
>  5 files changed, 32 deletions(-)
> 
> -- 
> 2.17.1

-- 

- Arnaldo
