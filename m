From: Christopher Covington <cov@codeaurora.org>
Subject: Periodic checkpointing (using perf and signals?)
Date: Wed, 17 Jul 2013 11:44:00 -0400
Message-ID: <51E6BBC0.1080102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:53098 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab3GQPoB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Jul 2013 11:44:01 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, criu@openvz.org

Hi,

I'm interested in taking checkpoints of processes from fast systems like
hardware and restoring them on really slow software models for performance
analysis. So far I've been able to save and restore checkpoints on the
different systems using CRIU. Now I'm looking for some way to trigger the
checkpointing. One basic use case might be to take a process that runs for say
100M instructions and take a checkpoint every 10M instructions to be restored
as 10 parallel runs of the model.

I'm thinking of trying to use performance counters to trigger such behavior.
Does perf already have support for triggering things like this? If not, I'm
thinking of trying to work in the ability to send a signal, like stop, to the
process of interest once the specified count, such as 10M instructions, has
been reached. CRIU or a wrapper could then wait for process of interest to
stop, take the checkpoint, let the process continue, and then wait for it to
stop again or exit. Would such an approach make sense?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
