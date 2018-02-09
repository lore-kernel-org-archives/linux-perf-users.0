From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf, tools, report: Fix description for --mem-mode
Date: Fri, 9 Feb 2018 15:30:06 -0300
Message-ID: <20180209183006.GM3451@kernel.org>
References: <20180209163909.9240-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbeBISaJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Feb 2018 13:30:09 -0500
Content-Disposition: inline
In-Reply-To: <20180209163909.9240-1-andi@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

Em Fri, Feb 09, 2018 at 08:39:09AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The mem-loads event only works when PEBS is enabled, so add
> /p to the examples.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied to perf/urgent.

- Arnaldo
