From: Ma chunhui <mch.thu@gmail.com>
Subject: Does perf suport per-thread information for java?
Date: Thu, 13 Mar 2014 16:33:28 +0800
Message-ID: <CAMTxwdugXR9GEJuoSwMB5rn=wnOeyXPzzD0QEMii87LrSGJn1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:54601 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaCMId2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Mar 2014 04:33:28 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so629094iec.10
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2014 01:33:28 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear Linux Perf Community:
In perf turtorial, it is said perf support per-thread information,
however, when doing java test, it seems doesn't work well.

Here is how I used perf:

$perf record -s java -cp . hellop    ### in perf help, it is said -s
is per-thread mode.
$perf report -T

And in result I didn't see any per-thread information, I mean, there
should be some jit threads, some vm threads, some gc theads... etc,
but what I see is jit.so, vm.so, not per-thread information.
Does anyone knows if I used perf wrongly? Is there any other ways to
gather per-thread information in perf?
Thanks.
