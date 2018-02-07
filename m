From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Annotate is broken with --symfs option
Date: Wed, 7 Feb 2018 09:43:57 -0300
Message-ID: <20180207124357.GK3451@kernel.org>
References: <30C2D590D16A5C46ADFE6521910377989261C1F5@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753763AbeBGMoH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Feb 2018 07:44:07 -0500
Content-Disposition: inline
In-Reply-To: <30C2D590D16A5C46ADFE6521910377989261C1F5@AZ-US1EXMB02.global.avaya.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Tue, Feb 06, 2018 at 06:17:43PM +0000, Vuille, Martin (Martin) escreveu:
> Since commit a706670900073d236938d539d1109338d64b47bb, when using
> "perf annotate --symfs SYMFS_PATH" or "perf report --symfs SYMFS_PATH",
> annotate no longer produces any output.
> 
> Cause is an unnecessary call to __symbol__join_symfs in dso__disassemble_filename,
> which results in looking for the .build-id directory under SYMFS_PATH/SYMFS_PATH/.debug
> instead of under SYMFS_PATH/.debug.
> 
> May be able to submit a patch, not sure where to send it.

You can send it to me, I maintain the userland bits, please CC
linux-kernel@vger.kernel.org and this list, so that others can look and
help me in reviewing it.

Thanks for working on it!

- Arnaldo
