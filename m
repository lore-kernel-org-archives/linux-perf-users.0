From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: Problems initializing symbol libraries!
Date: Thu, 12 May 2016 15:10:44 -0300
Message-ID: <20160512181044.GK20258@kernel.org>
References: <2323271.hRPH2PSKxc@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36661 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbcELSKv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 May 2016 14:10:51 -0400
Content-Disposition: inline
In-Reply-To: <2323271.hRPH2PSKxc@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, May 12, 2016 at 02:05:35PM +0200, Milian Wolff escreveu:
> I'm getting the following error when trying to run `perf trace` built from 
> acme's perf/core branch on an Ubuntu 16.04 machine:
 
> $ perf trace
> Problems initializing symbol libraries!
 
> strace shows this at the end:
 
> ...
> lstat("/proc", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> lstat("/proc/kallsyms", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> write(2, "Problems initializing symbol lib"..., 40Problems initializing symbol 
> libraries!
> ) = 40
> exit_group(244) 
 
> Is something wrong with my /proc/kallsyms? Can someone tell me what the 
> problems are that are being encountered?

Does it work as root?

What is the value of /proc/sys/kernel/kptr_restrict?

Need to improve that message :-\

- Arnaldo
