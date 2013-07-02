From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Link between Intel documentation events and perf list events
Date: Mon, 01 Jul 2013 20:55:39 -0700
Message-ID: <8761wt62f8.fsf@tassilo.jf.intel.com>
References: <51D1AA04.7060403@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59961 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755691Ab3GBDzl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Jul 2013 23:55:41 -0400
In-Reply-To: <51D1AA04.7060403@insa-lyon.fr> (Manuel Selva's message of "Mon,
	01 Jul 2013 18:10:44 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: linux-perf-users@vger.kernel.org

Manuel Selva <manuel.selva@insa-lyon.fr> writes:

> My question is about the link between events reported in Intel
> documentation and events listed by perf list. Is the perf list
> cache-misses event the same than the one mentioned as Last-level cache
> missesin Intel documentation ?

Yes it is

(at least currently, perf events are not particularly well defined
and have changed in the past. However this one is proably not likely
to change)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
