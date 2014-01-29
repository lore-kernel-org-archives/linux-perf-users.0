From: Sujith Manoharan <sujith@msujith.org>
Subject: Re: perf lock usage
Date: Wed, 29 Jan 2014 19:23:57 +0530
Message-ID: <21225.2037.467035.833797@gargle.gargle.HOWL>
References: <21216.48020.60857.22056@gargle.gargle.HOWL>
	<20140128093542.GD1229@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from s72.web-hosting.com ([198.187.29.21]:36385 "EHLO
	s72.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbaA2N7W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jan 2014 08:59:22 -0500
In-Reply-To: <20140128093542.GD1229@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

Jiri Olsa wrote:
> some of the kernel lock types do not follow the:
>   acquire
>   contended
>   acuired
>   release
> 
> lock state machine, like rcu or spin locks.. and thats what
> caused most of the bad rates in my tests.
> 
> I was recently working on some changes for lock tracing,
> what stats are you interested in?

I am trying to see lock usage stats for the ath9k wireless driver.
Mainly in the transmission path, where normal spin locks
are acquired.

Sujith
