From: Christopher Covington <cov@codeaurora.org>
Subject: Re: sampling  using perf
Date: Thu, 30 Oct 2014 17:03:26 -0400
Message-ID: <5452A79E.6000707@codeaurora.org>
References: <loom.20141029T184408-691@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:35507 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161019AbaJ3VD2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Oct 2014 17:03:28 -0400
In-Reply-To: <loom.20141029T184408-691@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnav <arnav.gupta06@live.in>
Cc: linux-perf-users@vger.kernel.org

On 10/29/2014 01:44 PM, Arnav wrote:
> i want get program counters every 100M instructions.
> how to achieve this ? please help

Based on what's described here:

https://perf.wiki.kernel.org/index.php/Tutorial#Collecting_samples

Does this work?

perf record -e instructions:u -c 100000000 workload
perf script -f ip

Chris

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
