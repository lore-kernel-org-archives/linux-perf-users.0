From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Understanding perf mem -t load results
Date: Sun, 15 Dec 2013 23:03:13 +0100
Message-ID: <52AE2721.8020501@insa-lyon.fr>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr> <877gb5vmmn.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from criges14.insa-lyon.fr ([134.214.76.242]:56894 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3LOWDS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 15 Dec 2013 17:03:18 -0500
In-Reply-To: <877gb5vmmn.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thanks for the answer Andi.

Is there any way (I couldn't find in the Intel documentation) to have an 
approximation of the "maximum" acceptable frequency ?

Manu

On 12/15/2013 10:18 PM, Andi Kleen wrote:
> Manuel Selva <manuel.selva@insa-lyon.fr> writes:
>>
>> perf mem -t load rec -c 1 make -j18
>
> With -c1 on such a frequent event you will not sample much, but just
> throttle a lot, as the PMI handler would use too much time.
> Your numbers are likely garbage.
>
> -Andi
>
