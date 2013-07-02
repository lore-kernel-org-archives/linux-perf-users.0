From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Link between Intel documentation events and perf list events
Date: Tue, 02 Jul 2013 09:53:04 +0200
Message-ID: <51D286E0.2070500@insa-lyon.fr>
References: <51D1AA04.7060403@insa-lyon.fr> <8761wt62f8.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from criges14.insa-lyon.fr ([134.214.76.242]:36715 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab3GBHxH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Jul 2013 03:53:07 -0400
In-Reply-To: <8761wt62f8.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thanks for the answer Andi.

On a more general sense, how one can link perf events (as reported by 
perf list) to hardware documentation ? Is there some document explaining 
that or should I dig into the perf code source code in the Linux kernel ?

Manu

On 07/02/2013 05:55 AM, Andi Kleen wrote:
> Manuel Selva<manuel.selva@insa-lyon.fr>  writes:
>
>> My question is about the link between events reported in Intel
>> documentation and events listed by perf list. Is the perf list
>> cache-misses event the same than the one mentioned as Last-level cache
>> missesin Intel documentation ?
> Yes it is
>
> (at least currently, perf events are not particularly well defined
> and have changed in the past. However this one is proably not likely
> to change)
>
> -Andi
>
