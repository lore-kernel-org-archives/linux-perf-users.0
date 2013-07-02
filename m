From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Link between Intel documentation events and perf list events
Date: Tue, 2 Jul 2013 16:41:02 +0200
Message-ID: <20130702144102.GW6123@two.firstfloor.org>
References: <51D1AA04.7060403@insa-lyon.fr>
 <8761wt62f8.fsf@tassilo.jf.intel.com>
 <51D28568.8070904@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:60669 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3GBOlF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Jul 2013 10:41:05 -0400
Content-Disposition: inline
In-Reply-To: <51D28568.8070904@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Tue, Jul 02, 2013 at 09:46:48AM +0200, Manuel Selva wrote:
> On a more general sense, how one can link perf events (as reported
> by perf list) to hardware documentation ? Is there some document
> explaining that or should I dig into the perf code source code in
> the Linux kernel ?

http://github.com/andikleen/pmu-tools has a event-rmap tool 
that can do that.

-Andi
