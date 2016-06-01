From: Rick Jones <rick.jones2@hpe.com>
Subject: Re: spin_lock cause ?
Date: Wed, 1 Jun 2016 13:24:31 -0700
Message-ID: <574F447F.1000503@hpe.com>
References: <574F15E4.5070008@lexisnexis.com>
 <4716588.WReR5L1Wkn@milian-kdab2> <loom.20160601T194103-83@post.gmane.org>
 <20160601181153.GU2563@kernel.org> <loom.20160601T204307-459@post.gmane.org>
 <574F2F20.2090007@hpe.com> <loom.20160601T211807-101@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:45933 "EHLO
	g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcFAUYe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 16:24:34 -0400
Received: from g2t2355.austin.hpe.com (g2t2355.austin.hpe.com [15.233.44.28])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id C334BCAE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jun 2016 20:24:33 +0000 (UTC)
In-Reply-To: <loom.20160601T211807-101@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: M Kelly <mark.kelly@lexisnexis.com>, linux-perf-users@vger.kernel.org

On 06/01/2016 12:25 PM, M Kelly wrote:
> I think I recall you from hp, years ago when I was there :-)
> Thanks for the info.  I suspect we are too heavy on
> pthread_mutex_lock()/unlock()

HP-UX has some ways/tools to track mutex contention.  Some extensions to 
give names to mutexes and then get stats on how often one went to grab 
them and it was held etc etc.  Been ages since I used them - I'd hope 
there was something similar for Linux but I've not played with threads 
in a very long time.

happy benchmarking,

rick jones
