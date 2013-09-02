From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf_event: rdpmc self-monitoring overhead issue
Date: Sun, 01 Sep 2013 19:50:39 -0700
Message-ID: <87ob8cdji8.fsf@tassilo.jf.intel.com>
References: <alpine.DEB.2.10.1308301334410.19094@vincent-weaver-1.um.maine.edu>
	<CAMsRxfLSnNi_vESxYHM5w0tQrOtOPsEy3ythoViRMBbEi+XHGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44437 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889Ab3IBCul (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 1 Sep 2013 22:50:41 -0400
In-Reply-To: <CAMsRxfLSnNi_vESxYHM5w0tQrOtOPsEy3ythoViRMBbEi+XHGw@mail.gmail.com>
	(Stephane Eranian's message of "Fri, 30 Aug 2013 20:05:05 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: eranian@gmail.com
Cc: Vince Weaver <vincent.weaver@maine.edu>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

Stephane Eranian <eranian@googlemail.com> writes:

> I don't see a flag in mmap() to fault it in immediately.

MAP_PRESENT

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
