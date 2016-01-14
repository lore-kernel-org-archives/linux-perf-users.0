From: Taeung Song <treeze.taeung@gmail.com>
Subject: perf event: what does mean node-* event [HW cache event] ?
Date: Thu, 14 Jan 2016 18:26:37 +0900
Message-ID: <569769CD.8070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33305 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbcANJ0m (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 14 Jan 2016 04:26:42 -0500
Received: by mail-pf0-f182.google.com with SMTP id e65so97171235pfe.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jan 2016 01:26:42 -0800 (PST)
Received: from [192.168.0.99] ([121.162.235.38])
        by smtp.gmail.com with ESMTPSA id a18sm7915322pfj.40.2016.01.14.01.26.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 01:26:41 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-mailing-list <linux-perf-users@vger.kernel.org>

Hi all

I've been looking into perf events.
I understood L1-*,LLC-*, iTLB-*, dTLB-*, etc in HW cache events.
But I don't know what node-* event mean very well.
In HW cache field, what does 'node' word mean ?
And Can you help me understand node-* event ?

(I found a similar mail in this mailing list,
but I didn't look for the answer for the mail.)

Thanks,
Taeung
