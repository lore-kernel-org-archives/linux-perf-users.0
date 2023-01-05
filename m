Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67472C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjAEQ14 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjAEQ1g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 11:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6D24C
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 08:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E667CB81ABD
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 16:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C13C433F1;
        Thu,  5 Jan 2023 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672936053;
        bh=BptZ//+zPBiJNckd27a6AFTMffS7Sb0cVmy3P7OsHpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7NcY7Jjp55HnD6DwcHIpTLjb06esSb6ggr9rNsUaQqzBR5CtxqtYxUfA3O8Px+Tj
         DOjIrREM6LFjcRWWsiADiTOiHftEkFLlZhzrcJXkgtRagXnMAc+IA+BeAKq4n9zjM5
         GQmhWWDalQ7OCBCUD3CxfQVOnzhtBPItJ4cbnNHR2WtmRAGUxuvbvxcPsu6R/Omocl
         pNNQgJiEgENCKzaqFYFbtVHyQnZSYz1Iuzjd9Tn5QeqBhdQ9YGL9so0sWr6okT62uJ
         +YcmSiDcZpZdspZFfMegxQGjqfMnGADRRFLDvAF32iFKHvYliDHg3tOCvXeWt0kvwP
         kX6l3MuICZZpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1AA3F40468; Thu,  5 Jan 2023 13:27:30 -0300 (-03)
Date:   Thu, 5 Jan 2023 13:27:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
Message-ID: <Y7b6cmRE/+5HJLCa@kernel.org>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jan 05, 2023 at 07:03:25PM +0530, Ravi Bangoria escreveu:
> Hello,
> 
> Two tracepoints, kmem:kmalloc_node and kmem:kmem_cache_alloc_node used by perf-
> kmem tool were removed from kernel by commit 11e9734bcb6a7 ("mm/slab_common:
> unify NUMA and UMA version of tracepoints"). This causes issue while running
> perf kmem on latest kernel:
> 
>   $ sudo ./perf kmem record
>   event syntax error: 'kmem:kmalloc_node'
>                        \___ unknown tracepoint
> 
>   $ sudo ./perf kmem record
>   event syntax error: 'kmem:kmem_cache_alloc_node'
>                        \___ unknown tracepoint
> 
> Haven't got a chance to debug further. Anyone aware of this?

I didn't notice this so far, would be good to have a fix soon.

Thanks,

- Arnaldo
