From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: perf trace: file names, strace groups
Date: Wed, 15 Jul 2015 13:08:27 -0400
Message-ID: <y0mbnfdtkl0.fsf@fche.csb>
References: <2853551.Qtj9hFrTSc@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55450 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbbGORHn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jul 2015 13:07:43 -0400
In-Reply-To: <2853551.Qtj9hFrTSc@milian-kdab2> (Milian Wolff's message of "Wed, 15 Jul 2015 15:02:21 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Perf Users <linux-perf-users@vger.kernel.org>


mail wrote:

> [...]
> are there any plans to improve the `perf trace` utility to make it a drop-in 
> replacement for `strace`? [...]

By the way, see also systemtap's "strace.stp" script:
https://sourceware.org/systemtap/examples/#process/strace.stp

- FChE
