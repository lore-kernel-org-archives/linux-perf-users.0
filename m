From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Thu, 16 Jun 2011 00:15:16 +0200
Message-ID: <20110615221513.GA18579@somewhere.redhat.com>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59660 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab1FOWPV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jun 2011 18:15:21 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sam Liao <phyomh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Thu, Jun 09, 2011 at 02:44:19PM +0800, Sam Liao wrote:
> Add "caller/callee" option to support inverted butterfly report,
> in the inverted report (with caller option), the call graph start
> from the callee's ancestor. Users can use such view to catch system's
> performance bottleneck from a sysprof like view. Using this option
> with specified sort order like pid gives us high level view of call
> graph statistics.

Sam, can you give me your "Signed-off-by:" tag otherwise I can't apply
the patch.

Thanks.
