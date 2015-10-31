From: Ben Redelings <benjamin.redelings@gmail.com>
Subject: Inverted call-graph broken?
Date: Sat, 31 Oct 2015 09:25:39 -0400
Message-ID: <5634C153.8020001@gmail.com>
References: <55D20AF9.9040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34444 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbJaNZl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 31 Oct 2015 09:25:41 -0400
Received: by qgem9 with SMTP id m9so83082579qge.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2015 06:25:41 -0700 (PDT)
Received: from [192.168.11.14] (cpe-24-163-95-39.nc.res.rr.com. [24.163.95.39])
        by smtp.googlemail.com with ESMTPSA id s21sm4402386qkl.36.2015.10.31.06.25.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Oct 2015 06:25:40 -0700 (PDT)
In-Reply-To: <55D20AF9.9040705@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

     I've been using perf with '--call-graph=dwarf' -- very useful! I'd 
like to view call graphs in 'perf report' in "inverted" order. Adding 
'-G' to 'perf report' appears to have no effect, though. (Also 
'--call-graph=fractal,caller' has no effect.)  Am I missing something 
obvious?

-BenRI
