From: Chris Freehill <cfreehill@utexas.edu>
Subject: perf uncore behavior
Date: Fri, 1 May 2015 15:55:35 -0500
Message-ID: <CANFySvewjJTo7Cezq3e1SPAFFmRRRWADTJ50T5rubvcLrAV2xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36207 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbEAUzg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 May 2015 16:55:36 -0400
Received: by wgen6 with SMTP id n6so100376953wge.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2015 13:55:35 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to get clarification on the meaning of the results perf
gives for uncore events, depending on the options.

Here are some examples:

1. $ perf stat -a -e "uncore_cbox_0/clockticks/" sleep 1

2. $ perf stat  -e "uncore_cbox_0/clockticks/" sleep 1

3. $ perf stat -a -C0 -e "uncore_cbox_0/clockticks/" sleep 1

It appears #2 is not supported. If it was supported, I would take it
to mean the number of uncore events counted while the process was
active, regardless of which processor it was running on. Right?  Is
there any reason it's not implemented (for example it's nonsensical)
or it just has been tackled yet?

Are 1 and 3 effectively the same, since uncore events are not specific
to a core? I would think they would be the same. If not, what is the
difference?

thanks,
Chris
