From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Profiling sleep times?
Date: Fri, 07 Oct 2011 11:33:25 +0200
Message-ID: <1317980005.9813.13.camel@twins>
References: <4E8A0F53.7020408@fb.com> <1317673027.20367.41.camel@twins>
	 <4E8A2EC5.1030901@fb.com> <1317717291.25926.13.camel@twins>
	 <4E8E2417.2000903@fb.com> <1317951036.9813.12.camel@twins>
	 <4E8E9142.1030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42951 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab1JKN6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 11 Oct 2011 09:58:12 -0400
In-Reply-To: <4E8E9142.1030103@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: avagin@gmail.com
Cc: Arun Sharma <asharma@fb.com>, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, Stephane Eranian <eranian@google.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Fri, 2011-10-07 at 09:42 +0400, avagin@gmail.com wrote:
> Could you commit it? It's subject:
> [PATCH 1/4] perf: fix counter of ftrace events
> 
tip/master:

commit 92e51938f5d005026ba4bb5b1fae5a86dc195b86
Author: Andrew Vagin <avagin@openvz.org>
Date:   Mon Sep 26 19:55:32 2011 +0400

    perf: Fix counter of ftrace events
