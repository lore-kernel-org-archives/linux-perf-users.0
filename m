From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Tue, 14 Jun 2011 15:15:17 -0700
Message-ID: <20110614221517.GA20319@dev1756.snc6.facebook.com>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
 <20110609193300.GA16858@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail011.snc4.facebook.com ([66.220.144.143]:59611 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752837Ab1FNWPS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Jun 2011 18:15:18 -0400
Content-Disposition: inline
In-Reply-To: <20110609193300.GA16858@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sam Liao <phyomh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Sam,

$ perf report -g graph,0.5,caller --sort pid

is a bit hard to type. Perhaps add a simpler command line option
that has the same effect?

 -Arun
