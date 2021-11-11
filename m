Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0CCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B40610F8
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKRvh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhKKRvh (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 12:51:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0272461354;
        Thu, 11 Nov 2021 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636652928;
        bh=ltvqjDtzTIJAwOvhes7tfAJ/0aY/89JlpYrin045thI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG7LgYiEhNz5GyTVNrVsKVG5Wz6xLPsqOoy9g5nsz+k/S9faYv5Ua1UtBdmGKAYSk
         ghxLbm1DdhlnX8/g3i3zy8+XHNByVxwVGumvWseiu6Ij2M16EUXisu3eYQLmaKoqYG
         imM2ndv8hzu5be7UVzFIAdntaAm5Gzr3bx7WB8xdsY6VMZfO7cjpNgy+Pj3ERDpYHz
         tYs4UGTE8mWeeyVxO5Z+uw73/hxYZUkt1FAY92ts/OizL9/LG9k50wPxpDONObiPt4
         3BdZ6vkjUi3TNVAKzVVNj8eGfU9awY6bkGJhuTjKhTJq/U9XlOYmgFC7lKXtxgGwue
         9Aq0DMvOEzb7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32B8F410A1; Thu, 11 Nov 2021 14:48:45 -0300 (-03)
Date:   Thu, 11 Nov 2021 14:48:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 0/2] arm-spe/cs-etm: Print size using consistent format
Message-ID: <YY1XfXPHqCyc84QK@kernel.org>
References: <20211109142153.56546-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109142153.56546-1-german.gomez@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 09, 2021 at 02:21:51PM +0000, German Gomez escreveu:
> Sent as a splitted re-roll of patchset [1] to keep the patches more
> semantically grouped. The patches themselves have been tested and
> reviewed in the previous submission already.
> 
> Changes since v1:
>   - Sent as a separate patchset.
>   - Added acme to the recipients list as I forgot to include him in [1].

Thanks, applied.

- Arnaldo

 
> [1] https://lore.kernel.org/all/20210916154635.1525-1-german.gomez@arm.com/
> 
> Andrew Kilroy (2):
>   perf cs-etm: Print size using consistent format
>   perf arm-spe: Print size using consistent format
> 
>  tools/perf/util/arm-spe.c | 2 +-
>  tools/perf/util/cs-etm.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
