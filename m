From: Sylwester Arabas <sarabas@itstudio.pl>
Subject: perf kills the whole process group on error - intentional?
Date: Fri, 15 Mar 2013 23:48:58 +0100
Message-ID: <5143A55A.5060507@itstudio.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from host49.kei.pl ([94.152.8.49]:43978 "EHLO smtp.host49.kei.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406Ab3COWzm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 Mar 2013 18:55:42 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: eric.noulard@gmail.com

Hello,

Here's a description of a situation where perf kills its parent process 
on error (by sending SIFTERM to all processes of its process group): 
http://public.kitware.com/Bug/view.php?id=14015

Is this behavior intentional?

Thanks,
Sylwester
