Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4AAC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D04B61BA5
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 16:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhG0QZe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QZd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jul 2021 12:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9BB61BA1;
        Tue, 27 Jul 2021 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627403133;
        bh=9B+zhmaJ1zRMWRRJsUG+h4L/F30ioCrCNbMWKo+jSzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DboOvg59yO5ATxI2gjD0RrwNyc+IARlAylqpnFoWk5moIIWwjeZcrpAwGcl+j60S8
         /OiOn5Ut07MoNBIhxWL+V1AbE++Oelg3u6VqRtaigvliZKvb1PDnUG9QDgBfnUZHg3
         zXcdXM2sSwEjhS85ZQgYGlMDxRkewPUcx8lhEdzI1taqb+uE9sFvXEQceHOBmcDu0H
         lOXhXDnJhCfV0bnIu5JiVITaiVoJmQQsmBLrI9ihxHPI0Xh5MIChJOursWlrH6SKHV
         vYcTSwBKZAsBetnt4pXlLAHjnqIgbtJNu/KqShBvN894t+wUQXTw/phRRgErNrreKI
         jvVWlGqZJIvjQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 867B1403F2; Tue, 27 Jul 2021 13:25:29 -0300 (-03)
Date:   Tue, 27 Jul 2021 13:25:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix alias matching
Message-ID: <YQAzeQ3IP4uAyv4L@kernel.org>
References: <1626793819-79090-1-git-send-email-john.garry@huawei.com>
 <0b57fa9b-fba4-8143-bef6-b7c4f2987635@linux.intel.com>
 <df5e5893-08ba-1fb5-b92a-921b32ed3b2f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5e5893-08ba-1fb5-b92a-921b32ed3b2f@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 27, 2021 at 11:32:55AM +0100, John Garry escreveu:
> On 21/07/2021 04:07, Jin, Yao wrote:
> > > 
> 
> Hi Arnaldo,
> 
> Can you kindly consider picking up this patch?
> 
> Thanks
> 
> > > Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same
> > > substring in different PMU type")
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > > ---
> > > @Jin Yao, please test for your scenarios
> > > 
> > 
> > For x86, the form uncore_pmu_{digits} or the uncore_pmu itself are
> > supported. We don't have more complex case such as the name in the form
> > aaa_bbbX_cccY. So my test didn't cover that complex form.
> > 
> > For my test, your patch works, thanks! :)
> 
> Can we take this as a tested-by?

Processed and added his Tested-by.

- Arnaldo
