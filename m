From: Rick Jones <rick.jones2@hpe.com>
Subject: Re: spin_lock cause ?
Date: Wed, 1 Jun 2016 11:53:20 -0700
Message-ID: <574F2F20.2090007@hpe.com>
References: <574F15E4.5070008@lexisnexis.com>
 <4716588.WReR5L1Wkn@milian-kdab2> <loom.20160601T194103-83@post.gmane.org>
 <20160601181153.GU2563@kernel.org> <loom.20160601T204307-459@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:31261 "EHLO
	g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcFATCE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 15:02:04 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 6C690BF5
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jun 2016 18:53:22 +0000 (UTC)
In-Reply-To: <loom.20160601T204307-459@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: M Kelly <mark.kelly@lexisnexis.com>, linux-perf-users@vger.kernel.org

On 06/01/2016 11:49 AM, M Kelly wrote:
> So that is helpful.
> I do not understand the system_call_fastpath->futex->_spin_lock part yet,
> but that is a separate issue!

Just a guess, but if your application is using threads, contention on 
the synchonrization primitives you use to keep things straight can 
end-up punting to the kernel.

rick jones
