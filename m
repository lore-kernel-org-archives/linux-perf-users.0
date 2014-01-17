From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Two questions on perf dwarf callchains
Date: Fri, 17 Jan 2014 12:11:53 -0800
Message-ID: <87d2jq1i7q.fsf@tassilo.jf.intel.com>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19081 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbaAQUQ6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jan 2014 15:16:58 -0500
In-Reply-To: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it> (Mauro
	Andreolini's message of "Fri, 17 Jan 2014 11:21:23 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: mauro.andreolini@gmail.com
Cc: linux-perf-users@vger.kernel.org

Mauro Andreolini <mauro.andreolini@gmail.com> writes:
> file to get perf report to print the function names.
> Is this expected behaviour? How do I get perf to automatically extract
> symbols from compressed files?

Someone would need to write the code to do that I guess.

>
> To which function would 0x7facc1df12a0 match? It does not even seem to
> be in the mapped address space of "ls". I am clueless.

The unwinder got confused. A common cause is incomplete or partially
broken dwarf unwind information. May be a compiler problem.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
