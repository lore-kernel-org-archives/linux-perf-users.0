From: Manuel Selva <selva.manuel@gmail.com>
Subject: How does perf collects per thread/process events ?
Date: Tue, 16 Jul 2013 17:29:33 +0200
Message-ID: <51E566DD.1070006@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:64065 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab3GPP3g (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Jul 2013 11:29:36 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so3778625wgg.2
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2013 08:29:35 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

My question regards a platform equipped with 2 Intel Xeon X5650.
According to the perf wiki page 
(https://perf.wiki.kernel.org/index.php/Tutorial), "by default perf stat 
counts for all threads of the process and subsequent child processes and 
threads" and "By default, perf stat counts in per-thread mode".

So a first question is what is the default: per thread or per process ?

Then, independently of the answer, I am wondering how does perf handles 
per thread or per process regarding the scheduler and migrations. I 
didn't find it explicitly in the Intel documentation but it seems 
natural that hardware performance counters located on a given core are 
only capable of counting event on this core and not on other cores. Is 
it true ?

Moreover, the wiki page says that "When a thread migrated from one 
processor to another, counters are saved on the current processor and 
are restored on the new one" (this seems to confirm the answer to my 
previous question above). It means that the scheduler is aware about 
"perf" or that perf is able to register a hook into the scheduler. So I 
guess this is done in the kernel part of perf (in the implementation of 
the perf_event_open system call) and not in the user land part, is it true ?

Thanks

-- 
Manu
