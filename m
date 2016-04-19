From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: Ideas to measure kernel function execution time using perf
Date: Tue, 19 Apr 2016 09:42:49 +0800
Message-ID: <57158D19.7070307@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:25602 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751834AbcDSBm4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2016 21:42:56 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 8D5FA42B55E3
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2016 09:42:50 +0800 (CST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Is there any method to measure kernel function execution time for 
specific functions using perf?

Current ftrace events can only record the timestamp when hitting the 
trace point (along with some other info).

I'm OK adding new ftrace events into kernel, but even after adding such 
ftrace events, is it possible to use perf to calculate the function 
execution time?

Any advice is welcomed.

Thanks,
Qu
