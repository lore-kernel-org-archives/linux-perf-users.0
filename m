From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Information regarding the perf tool
Date: Wed, 23 Oct 2013 05:47:20 -0700
Message-ID: <87y55krw6f.fsf@tassilo.jf.intel.com>
References: <5266A57F.2000201@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:9507 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab3JWMrV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 08:47:21 -0400
In-Reply-To: <5266A57F.2000201@bsc.es> (Harald Servat's message of "Tue, 22
	Oct 2013 18:19:11 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

Harald Servat <harald.servat@bsc.es> writes:

> Dear list,
>
>    I'm wondering whether it be possible to extend the "perf mem"
> (tool) to emit the TSC of the sampling event?

perf report -D reports everything, including time stamps.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
