From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Link between Intel documentation events and perf list events
Date: Mon, 01 Jul 2013 18:10:44 +0200
Message-ID: <51D1AA04.7060403@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from criges14.insa-lyon.fr ([134.214.76.242]:53667 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab3GAQKq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Jul 2013 12:10:46 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am starting to deal with performance registers on an Intel core 
i5-2520M dual core (and hyperthreaded) processor. In this context I 
reached the CPUID x86 instruction. Playing with this instruction I am 
able to get some information about my cpu performance monitoring unit. 
According to this instruction my Last-level cache misses event is available.

My question is about the link between events reported in Intel 
documentation and events listed by perf list. Is the perf list 
cache-misses event the same than the one mentioned as Last-level cache 
missesin Intel documentation ?

Thanks,

--------
Manu
