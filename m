From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Changing frequency rate to perf mem
Date: Wed, 23 Oct 2013 22:12:00 -0700
Message-ID: <87ppqvs15r.fsf@tassilo.jf.intel.com>
References: <5267EE8E.3020306@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26527 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab3JXFMC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Oct 2013 01:12:02 -0400
In-Reply-To: <5267EE8E.3020306@bsc.es> (Harald Servat's message of "Wed, 23
	Oct 2013 17:43:10 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

Harald Servat <harald.servat@bsc.es> writes:
>
>   BTW, I tried to change this value by adding "-F" and "200" into the
> argv that is passed to cmd_report by adding
>
>         rec_argv[i++] = strdup("-F");
>         rec_argv[i++] = strdup("200");
>
>   into line 42 of perf-mem.c - just after the
> strdup("record").

You would need to increase the array size too.

> Unfortunately, this seems to break something and
> perf segfaults often. Which is the most appropriate way to tune the
> user frequency of perf mem?

Best would be probably to fix it to pass through unknown
options, then -F/-c could be just used. I'm not sure
if this is possible easily with the git option parser.

Alternatively you can just specify the command line perf mem record
would specify directly to perf record, plus -c/-F

-andi

-- 
ak@linux.intel.com -- Speaking for myself only
