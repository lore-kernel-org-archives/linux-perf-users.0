From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Information regarding the perf tool
Date: Thu, 31 Oct 2013 17:48:01 +0100
Message-ID: <20131031164801.GY29695@two.firstfloor.org>
References: <5266A57F.2000201@bsc.es>
 <87y55krw6f.fsf@tassilo.jf.intel.com>
 <52727B0C.5040402@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:42529 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab3JaQsE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 12:48:04 -0400
Content-Disposition: inline
In-Reply-To: <52727B0C.5040402@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

>   In fact, I expected that for each entry into the PEBS a handler
> would be executed, but Intel documentations points that to use PEBS
> the tool (here perf) needs to allocate space for multiple PEBS
> entries, so the when the handler is invoked there may be multiple
> entries in the buffer, which makes things a little more obscure.

perf always uses threshold 1 for the PEBS buffer.

But yes there is some delay until the handler executes, and the
time stamp is only computed in the handler.

-Andi
