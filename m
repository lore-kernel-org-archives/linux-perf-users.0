Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD3DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A116124C
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhJDMaw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 08:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhJDMaw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Oct 2021 08:30:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F6FE611F0;
        Mon,  4 Oct 2021 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633350543;
        bh=zAhR6uiVUavFmiYyPmnjpVE5FoXxpHBrJvoNQbsavHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSeO9+lnKYhO0Q42xj3QTiBl1zJu/QFZYimSgN1Yhz1IpnFF7jrjcfiWYVRdsFInn
         kf6qjLgE/WG/0YKGb1anbCCrONVOIhx9N5Z7gGUQzkQvO5Hq4+S11EX+LerrmThcJy
         2IRfN1xjznY+0OEqYTTXv3Gy5sQk+Cxj4HiBlQPJsgJvYlLq/b3KLaqAHYGNZR+PM1
         Vg/rOfIr/WeQ/LOSPIR9fJIfrEjlNvXyWRCZB0TGaFPflvDUrql80kyWXKoM1Bsmr6
         iO7dWOr+XhQ+oXTHeQTw6dyVu5ZQtMdRCZCiYT3uRB4Z7032gPcU8Qh0nx/OSk1WXV
         ImzI6OzfEipXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3901C410A1; Mon,  4 Oct 2021 09:29:00 -0300 (-03)
Date:   Mon, 4 Oct 2021 09:29:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v4] tools/perf: Use long-running addr2line per dso
Message-ID: <YVrzjCSXaO2AuYQe@kernel.org>
References: <YT+vJQFfSTE3EExF@kernel.org>
 <20210916120939.453536-1-tonyg@leastfixedpoint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916120939.453536-1-tonyg@leastfixedpoint.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 16, 2021 at 02:09:39PM +0200, Tony Garnock-Jones escreveu:
> Invoking addr2line in a separate subprocess, one for each required
> lookup, takes a terribly long time. This patch introduces a
> long-running addr2line process for each dso, *DRAMATICALLY* speeding
> up runs of perf. What used to take tens of minutes now takes tens of
> seconds.
> 
> Debian bug report about this issue:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911815
> 
> Signed-off-by: Tony Garnock-Jones <tonyg@leastfixedpoint.com>
> Tested-by: Ian Rogers <irogers@google.com>
> 
> ---
> Changes since v3:
>  - use zfree(), plus some small code compaction edits
>  - rebase against upstream master ff1ffd71d5f0612cf194f5705c671d6b64bf5f91
> 
> Changes since v2:
>  - remove redundant initializations to 0 and NULL
>  - use terminology "record" instead of "stanza" for input from addr2line
> 
> Changes since v1:
>  - use "subcmd/run-command.h" machinery instead of socketpair/fork/exec directly

Thanks, applied.

- Arnaldo

