From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Wed, 27 May 2015 16:04:31 +0200
Message-ID: <20150527140431.GT19417@two.firstfloor.org>
References: <555F3F8A.6000204@suse.cz>
 <87mw0wc4vt.fsf@tassilo.jf.intel.com>
 <5562D33F.70706@suse.cz>
 <20150525151450.GK19417@two.firstfloor.org>
 <5564685D.1020204@suse.cz>
 <20150526170316.GO19417@two.firstfloor.org>
 <55658462.1000605@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:54754 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbE0OEc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 May 2015 10:04:32 -0400
Content-Disposition: inline
In-Reply-To: <55658462.1000605@suse.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

> If I understand correctly, is it just about division of the number of events
> related to an instruction and total number of events?

Yes that's it. The information is already displayed in the main view
(or more fine grained if you do --sort ...,srcline; unfortunately not
sorted in this case)

-Andi
