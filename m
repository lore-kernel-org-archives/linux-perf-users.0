From: Sujith Manoharan <sujith@msujith.org>
Subject: Re: perf lock usage
Date: Thu, 23 Jan 2014 18:07:35 +0530
Message-ID: <21217.3343.506597.272876@gargle.gargle.HOWL>
References: <21216.48020.60857.22056@gargle.gargle.HOWL>
	<CAFTL4hzowjuj0E8X8trCz19iq5o-BAjj_JPe86XRnS6E8xs1VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from s72.web-hosting.com ([198.187.29.21]:49624 "EHLO
	s72.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaAWMmz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jan 2014 07:42:55 -0500
In-Reply-To: <CAFTL4hzowjuj0E8X8trCz19iq5o-BAjj_JPe86XRnS6E8xs1VQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Frederic Weisbecker wrote:
> > lockdep is enabled:
> > root@linux-test ~# zgrep -i lockdep /proc/config.gz
> > CONFIG_LOCKDEP_SUPPORT=y
> > CONFIG_LOCKDEP=y
> > # CONFIG_DEBUG_LOCKDEP is not set
> 
> Hi Sujith,
> 
> You also need CONFIG_LOCK_STAT=y

CONFIG_LOCK_STAT is enabled too.

root@linux-test ~# zgrep -i lock_stat /proc/config.gz 
CONFIG_LOCK_STAT=y

Sujith
