From: Florin Trofin <ftrofin@adobe.com>
Subject: Multiple commands in perf 3.2.30 and 3.5.5 on Ubuntu 12 do not work
Date: Tue, 13 Nov 2012 23:01:18 +0000 (UTC)
Message-ID: <loom.20121113T224335-737@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46098 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab2KMXBe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 Nov 2012 18:01:34 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TYPUA-0000ta-SH
	for linux-perf-users@vger.kernel.org; Wed, 14 Nov 2012 00:01:39 +0100
Received: from vpn-sea.adobe.com ([vpn-sea.adobe.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Nov 2012 00:01:38 +0100
Received: from ftrofin by vpn-sea.adobe.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Nov 2012 00:01:38 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I mentioned in a previous post that "perf archive" command is not recognized on
Ubuntu 12.04 (perf version 3.2.30) although it is  listed in the --help output.
I wanted to see if the issue was fixed in a later version so I tried
Ubuntu 12.10 (perf version 3.5.5) and it has the same problems:
archive is not recognized as a valid command, and other commands fail as well:

$ perf timechart record sleep 2
invalid or unsupported event: 'power:cpu_frequency'
Run 'perf list' for a list of valid events

Another command that doesn't work:

$ perf lock record sleep 2
invalid or unsupported event: 'lock:lock_acquire'
Run 'perf list' for a list of valid events

This makes me think that either perf is mostly broken in the new versions
or something is wrong on my machine (although installation went smoothly).
I installed perf by doing:

$ sudo apt-get install linux-tools-common
$ sudo apt-get install linux-tools-3.5.0-17

Can somebody shed some light on this please?

TIA,

Florin
