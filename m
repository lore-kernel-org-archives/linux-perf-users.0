From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf smapling
Date: Mon, 30 Mar 2015 10:38:35 -0700
Message-ID: <87ego6qtb8.fsf@tassilo.jf.intel.com>
References: <loom.20150329T075320-204@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55727 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbbC3Ri4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 Mar 2015 13:38:56 -0400
In-Reply-To: <loom.20150329T075320-204@post.gmane.org> (sahil aggarwal's
	message of "Sun, 29 Mar 2015 05:54:14 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

sahil aggarwal <sahil.agg15@gmail.com> writes:

> Hi all
>
> I am beginner to the perf API. Can someone direct me to the example of 
> reading ring buffer using mmap.?

https://github.com/andikleen/pmu-tools/tree/master/addr

-Andi
