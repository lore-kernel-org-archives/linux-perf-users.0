From: Andi Kleen <andi@firstfloor.org>
Subject: Introduction to Last Branch Records on perf
Date: Thu, 7 Apr 2016 07:21:57 -0700
Message-ID: <20160407142157.GD9407@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:53213 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbcDGOWA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 7 Apr 2016 10:22:00 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


Hi,

I wrote a two part article on theory and practice of Last Branch
Records using Linux perf. They were published on LWN.

This includes the background (what is a last branch record and why
branch sampling), what you can use it for in perf, like hot path
profiling, frame pointerless callgraphs, or automatic micro benchmarks,
and also other uses like continuous compiler feedback.

The articles are now freely available.

Introduction of Last Branch Records
http://lwn.net/Articles/680985/

Advanced uses of Last Branch Reocrds
http://lwn.net/Articles/680996

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
