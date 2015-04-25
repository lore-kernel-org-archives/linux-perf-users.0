From: Daniel Speyer <dspeyer@gmail.com>
Subject: Re: What helps with stacks?
Date: Sat, 25 Apr 2015 18:42:09 +0000 (UTC)
Message-ID: <loom.20150425T203859-304@post.gmane.org>
References: <loom.20150421T215002-474@post.gmane.org> <87sibtmek5.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46608 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbbDYSmW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 25 Apr 2015 14:42:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Ym51v-0004v4-1O
	for linux-perf-users@vger.kernel.org; Sat, 25 Apr 2015 20:42:19 +0200
Received: from dyn-160-39-229-153.dyn.columbia.edu ([160.39.229.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2015 20:42:19 +0200
Received: from dspeyer by dyn-160-39-229-153.dyn.columbia.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2015 20:42:19 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Andi Kleen <andi <at> firstfloor.org> writes:
> If you have a Haswell/Broadwell system and uptodate perf (4.0) you can also
> use --call-graph lbr
> 
> This uses a new hardware mechanism that can handle many situations
> where the old ones failed (but also has some situations where
> it has to give up)
> 
> -andi
> 

We've gotten access to a Haswell system.  How do we get perf with LBR
support?  It looks like it hasn't been merged into the main line kernel. 
Are there binaries anywhere?  Do we need to upgrade the entire kernel, or
just the perf utility?
