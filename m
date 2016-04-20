From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Ideas to measure kernel function execution time using perf
Date: Wed, 20 Apr 2016 06:09:25 -0700
Message-ID: <87a8kowhoa.fsf@tassilo.jf.intel.com>
References: <57158D19.7070307@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4718 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbcDTNJr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Apr 2016 09:09:47 -0400
In-Reply-To: <57158D19.7070307@cn.fujitsu.com> (Qu Wenruo's message of "Tue,
	19 Apr 2016 09:42:49 +0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-perf-users@vger.kernel.org

Qu Wenruo <quwenruo@cn.fujitsu.com> writes:

> Hi,
>
> Is there any method to measure kernel function execution time for
> specific functions using perf?

You can use processor trace on newer Intel CPUs (especially
Skylake) for this.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
