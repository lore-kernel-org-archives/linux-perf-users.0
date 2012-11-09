From: Florin <ftrofin@adobe.com>
Subject: Re: perf: generating a report from another machine doesn't show symbols for my binaries
Date: Fri, 9 Nov 2012 23:08:50 +0000 (UTC)
Message-ID: <loom.20121109T235502-314@post.gmane.org>
References: <CCC01133.6EA9%ftrofin@adobe.com> <CCC03D52.6EC0%ftrofin@adobe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47163 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2KIXe5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Nov 2012 18:34:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TWy6I-0007tl-Va
	for linux-perf-users@vger.kernel.org; Sat, 10 Nov 2012 00:35:03 +0100
Received: from vpn-sea.adobe.com ([vpn-sea.adobe.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Nov 2012 00:35:02 +0100
Received: from ftrofin by vpn-sea.adobe.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Nov 2012 00:35:02 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

For other poor souls out there searching for answers: the fix was to add
"-Wl,--build-id" to my linker flags.

If your binaries are not compiled with this option,
they will not be archived by perf archive command.

(Oh, and you should also be using the -fno-omit-frame-pointer
compile flag as well on x64).
