From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 09:07:37 +0100
Message-ID: <5450A049.3040803@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.insa-lyon.fr ([134.214.182.244]:53888 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728AbaJ2IN2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 04:13:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.insa-lyon.fr (smtp.insa-lyon.fr) with ESMTP id 6B10540087
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 09:07:46 +0100 (CET)
Received: from smtp.insa-lyon.fr ([IPv6:::ffff:127.0.0.1])
	by localhost (smtp.insa-lyon.fr [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EB-fhT63dD21 for <linux-perf-users@vger.kernel.org>;
	Wed, 29 Oct 2014 09:07:38 +0100 (CET)
Received: from [134.214.61.237] (anyconnect237.insa-lyon.fr [134.214.61.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mselva)
	by smtp.insa-lyon.fr (smtp.insa-lyon.fr) with ESMTPSA id EFE993FE5B
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 09:07:37 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

I am trying to setup load latency sampling on a Sandy Bridge processor 
(Cpu familly 6, model 42, model name  Intel(R) Core(TM) i5-2520M CPU @ 
2.50GHz) running a 3.13 linux kernel.

After deep investigations made of reading of the Intel SDM, examples 
provided by the pfm library and the source code of perf, I am still not 
able to get sample. I think for now that my problem is related to the 
precise_ip parameter of the  perf_event_attr structure.

Any time I change this value from 0 to 1 or from 0 to 2 (2 is the value 
to enable PEBS isn't it ?) the perf_event_open system call failed with a 
"Not supported operation" error. Running perf mem record on this Sandy 
Bridge platform also result in the same error.

So my question is, which way should I follow to identify why I am not 
able to do load latency sampling on this hardware ?

Thanks for any advice,

----
Manu
