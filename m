Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E492CC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C481C60EBB
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhHJOea (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239178AbhHJOea (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 10:34:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB00460F02;
        Tue, 10 Aug 2021 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628606047;
        bh=HhRHud89RZh+9BReKwcojVNrJoWlzKRquEYxNO16hLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ic2Z4qPTN3PsuGs/jSs4b3y6mLuQRCXH/jDzoDavIClcLGszndHFXTzGQvbpJdw01
         7uQy23wqs+ldDwTPADYJkZXK8oh9sBvejZOupaME5Pf+9083ozYxAjt0xqtBbQxnrC
         OpSxrJniUCaVh8K8SJrbvQX4KCqHnPN4WKujY1PwQ5T5wP/8Ye+Ja42di4ICGyy2RZ
         6oR8V/E1rMCURKNYNVtnVHcyALvqjbc0/IK16I9cwk4L+HfMk1+rOEEt0Ndl+WJNmZ
         AIo+85giqBVlf0lPD+YjIka3xNvnjSMtG8mAlCteB0wxmuCFUDJ5sO6JImAdtX1/As
         sxQ+gd6qWbXqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 988AE403F2; Tue, 10 Aug 2021 11:34:04 -0300 (-03)
Date:   Tue, 10 Aug 2021 11:34:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, linuxarm@huawei.com
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
Message-ID: <YRKOXJ9uskRyiLQK@kernel.org>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
 <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
 <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
 <YRKGo1AtfBn85sZ7@kernel.org>
 <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 03:23:07PM +0100, John Garry escreveu:
> On 10/08/2021 15:01, Arnaldo Carvalho de Melo wrote:
> > > Shall I send this as a formal patch?
> > The question is when should I apply this patch? After this series? After
> > the patch I commented about, before?
> > 
> 
> Hi Arnaldo,
> 
> I think that you can apply it before the series. This is a pre-existing
> issue that there was no dependency checking on the test events folder for
> rebuilding pmu-event.c .

Ok, will do so, thanks for clarifying.

- Arnaldo
