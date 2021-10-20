Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D026C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02F86138B
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 14:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJTOdl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhJTOdl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 10:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8881360EE9;
        Wed, 20 Oct 2021 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634740286;
        bh=wG2rEzncCnp5Cz7Uk5a+cH+bEmf4SXh8+Paqd30Gcgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEko7VPBbneEC8nHYmBxS7SU8xDSJ6aLs5xRzytaI9fAw6/j0ajgxCrljMdPWBu5E
         cwZPQvF56wi2HpZo2UMu965Ss2iSsLn9jb52g/9QbC7N1jWPemWZwwv8SNVOQTKxG4
         YzWyCg0YDRVvBGVVAu/AzTL2LKmJT+o/32p2YflIH0qiaYr5bfEZtIhNVL2RUI/gS0
         wg9R+tAIpX9dbaqdZUmwB+s4r10qZC7KwSjw/Pp55jy2krTSSNBpcsvlZwCYU/k1Rr
         qY61ebw5ECKzfwCxO0CczGHbLV30okNLRfdVrpsRTZIBPQRxE4JuF5GfnjC3ADehoX
         4VFAN6UIKV9IA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00A40410A1; Wed, 20 Oct 2021 11:31:22 -0300 (-03)
Date:   Wed, 20 Oct 2021 11:31:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com
Subject: Re: [PATCH 0/2] perf jevents: Enable build warnings
Message-ID: <YXAoOgRVfkzr5vcS@kernel.org>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Oct 16, 2021 at 12:48:25AM +0800, John Garry escreveu:
> Currently jevents builds without any complier warning flags enabled. So
> use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS. I am not
> 100% confident that this is the best way, but sending out for review.
> 
> Baseline is be8ecc57f180 (HEAD, acme/perf/core) perf srcline: Use
> long-running addr2line per DSO

Thanks, applied.

- Arnaldo

