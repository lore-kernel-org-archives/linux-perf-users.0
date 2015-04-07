From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Intel load latency facility
Date: Tue, 07 Apr 2015 14:13:19 +0200
Message-ID: <5523C9DF.6060907@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.insa-lyon.fr ([134.214.182.244]:48019 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbDGMTR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Apr 2015 08:19:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.insa-lyon.fr (smtp.insa-lyon.fr) with ESMTP id 3EC2C400C4
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2015 14:13:25 +0200 (CEST)
Received: from smtp.insa-lyon.fr ([IPv6:::ffff:127.0.0.1])
	by localhost (smtp.insa-lyon.fr [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ualK95EGGrmz for <linux-perf-users@vger.kernel.org>;
	Tue,  7 Apr 2015 14:13:25 +0200 (CEST)
Received: from [192.168.0.10] (mut38-6-88-167-68-98.fbx.proxad.net [88.167.68.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mselva)
	by smtp.insa-lyon.fr (smtp.insa-lyon.fr) with ESMTPSA id E69C9400C3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2015 14:13:24 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am using PEBS along with the load latency facility as described in the 
chapter 18.7.1.2 of the SDM. I always thought that this feature only 
allowed to sample memory loads accesses coming from data accesses and 
not code. I am today getting results that may indicate that's not true. 
Before deeging into this results, and because I am almost sure that the 
answer is no, I am asking it here: does Intel PEBS + load latency 
facility samples memory accesses coming from the instruction fetcher ?

Regards,

-----
Manuel
