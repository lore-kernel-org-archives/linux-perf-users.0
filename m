From: Daniel Chumak <daniel.chumak@student.HTW-Berlin.de>
Subject: Perf Script Handler Arguments
Date: Tue, 06 May 2014 11:53:13 +0200
Message-ID: <5368B109.2000206@student.HTW-Berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail0.rz.htw-berlin.de ([141.45.10.100]:18128 "EHLO
	mail0.rz.htw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934609AbaEFKNO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 May 2014 06:13:14 -0400
Received: from [188.111.54.34] (helo=[192.168.149.85])
	by mail0.rz.htw-berlin.de with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82 (FreeBSD))
	(envelope-from <daniel.chumak@student.HTW-Berlin.de>)
	id 1Whc3z-0002v1-8y
	for linux-perf-users@vger.kernel.org; Tue, 06 May 2014 11:53:27 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am currently in the process of learning perfs python script support. 
Is there a way to find out, without trial and error, how much parameter 
a handler function has and what iformation the parameters are holding ?
The first 7 (event_name,context,common_cpu,common_secs, 
common_nsecs,common_pid,common_comm ) are documented in the man-page and 
are allways the same (?) but what is with the remaining ones ?
Syscalls__sys_enter_write for example needs 4 additional parameters: 
unkown0, unkown1, unkown2 and bytesToWrite.

Regards

D.C.
