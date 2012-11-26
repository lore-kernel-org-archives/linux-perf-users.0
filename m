From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Does Perf support AMD cpu perfectly?
Date: Mon, 26 Nov 2012 15:05:58 +0100
Message-ID: <20121126140558.GD1210@krava.brq.redhat.com>
References: <50B3517A.7090505@core.kaist.ac.kr>
 <50B35D78.9090805@core.kaist.ac.kr>
 <50B3726C.8070706@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15445 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab2KZOGE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 09:06:04 -0500
Content-Disposition: inline
In-Reply-To: <50B3726C.8070706@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chulmin Kim <cmkim@core.kaist.ac.kr>
Cc: linux-perf-users@vger.kernel.org

On Mon, Nov 26, 2012 at 10:45:16PM +0900, Chulmin Kim wrote:
> Update for this issue.
> 
> I'm investigating the kernel source.
> 
> I found that Perf for AMD seems imperfect in linux 3.0 (my machine's
> linux version).
> 
> For AMD family 15h, there is a commented line as follow.
>  - /* nortbridge counters not yet implemented: */  (line 541,
> perf_event_amd.c )

there were some updates for 15h models recently,
you probably need to try latest sources

jirka
