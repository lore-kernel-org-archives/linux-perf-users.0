From: Chris Freehill <cfreehill@gmail.com>
Subject: simultaneous counter start
Date: Wed, 17 Apr 2013 22:37:47 -0500
Message-ID: <CANFySvfpjow=j02sb2WxCNjDKj_SZZurMEibvaoXiwOJJZOFLA@mail.gmail.com>
References: <CANFySveqm7z6wgXyNdkinwJirPSLhaSvApabbK3EP07XPzbaKA@mail.gmail.com>
	<CANFySvd-HjA0ZAOad+0M1_cQZaVr86Y0NbhpaKFHBrRrYCEEPw@mail.gmail.com>
Reply-To: cfreehill@alumni.utexas.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:50583 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965501Ab3DRDht (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Apr 2013 23:37:49 -0400
Received: by mail-wi0-f176.google.com with SMTP id hj19so625082wib.9
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Apr 2013 20:37:48 -0700 (PDT)
In-Reply-To: <CANFySvd-HjA0ZAOad+0M1_cQZaVr86Y0NbhpaKFHBrRrYCEEPw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Is perf stat supposed to start all specified counters simultaneously?

For example, in  the command:

perf stat -a -e rXXXX,rYYYY sleep 5

I would think that perf would configure for counting XXXX and YYYY,
and then start counting for both, so that the 2 events will have been
collected for the same amount of time.

However, looking at the perf code (and adding some logging) I see that
the first event counter is configured, then started before it then
configures and starts the 2nd event counter. Additionally, each time
it configures and starts, a global disable ("pmu_disable") is called.
So if you have many event specified, there would be a lot of starting
and stopping of all counters.

It seems like you would always want to start all the counters
simultaneously. Am I missing something? Or is there an option I can
specify to make that happen?

thanks,
chris
