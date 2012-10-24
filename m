From: Vince Weaver <vincent.weaver@maine.edu>
Subject: perf and uncore events
Date: Wed, 24 Oct 2012 16:32:00 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210241627360.1411@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48398 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018Ab2JXUbH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Oct 2012 16:31:07 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so1038009vcb.19
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Oct 2012 13:31:04 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


So has anyone actually ever used perf to measure uncore events?

I have a 3.6 kernel on a Sandybridge machine and the uncore directories
definitely show up in 
  /sys/bus/event_source/devices/

But if I try
   ./perf stat -a -e "uncore_imc_0/event=0xff,umask=0x00" /bin/ls
I get:
invalid or unsupported event: 'uncore_imc_0/event=0xff,umask=0x00'
Run 'perf list' for a list of valid events
[...]

I'm not sure if I'm doing the crazy naming stuff right, but
  "perf list"
says
  cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
   (see 'perf list --help' on how to encode it)
but "perf list --help" definitely *does not* tell me how to encode it.

Vince Weaver
vincent.weaver@maine.edu
