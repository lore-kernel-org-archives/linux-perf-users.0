From: Andi Kleen <andi@firstfloor.org>
Subject: Re: access function parameters with DWARF-less perf probing
Date: Wed, 23 Apr 2014 22:21:07 -0700
Message-ID: <87iopzb8vw.fsf@tassilo.jf.intel.com>
References: <CANHDG4btxwQxGme+TwWYhPVEKSwyHA_C3fVxNuaFJOrzGYOyCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25947 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaDXFVn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Apr 2014 01:21:43 -0400
In-Reply-To: <CANHDG4btxwQxGme+TwWYhPVEKSwyHA_C3fVxNuaFJOrzGYOyCA@mail.gmail.com>
	(Jun Wang's message of "Tue, 22 Apr 2014 10:31:34 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jun Wang <junwang123@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Jun Wang <junwang123@gmail.com> writes:

> Hi Everyone,
>
> With systemTap, in the absence of debugging information (DWARF), one
> can access function parameters using (positional) numbers. Can the
> same be done with `perf`?
> Why? I'm trying to capture variables in a kernel function but I don't
> have an good perf with DWARF support and there is are significant
> challenges to build one due to the relatively old distro.

You can specify the registers according to the ABI. 
di = 1. arg, si = 2nd arg etc.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
