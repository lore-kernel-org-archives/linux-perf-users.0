From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Latency values in perf mem report
Date: Wed, 5 Aug 2015 16:02:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1508051602080.7381@vincent-weaver-1.umelst.maine.edu>
References: <loom.20150805T123916-655@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35934 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbHETzp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 15:55:45 -0400
Received: by ioeg141 with SMTP id g141so60398469ioe.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2015 12:55:44 -0700 (PDT)
In-Reply-To: <loom.20150805T123916-655@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milan Radulovic <milan.radulovic@bsc.es>
Cc: linux-perf-users@vger.kernel.org

On Wed, 5 Aug 2015, Milan Radulovic wrote:

> I measured load latency using perf mem rec and I have some doubts regarding
> the results.
> It is a 2 socket machine, with 2x Intel E5-2620 (2x 6 cores) at 2.3 GHz.

I'm not sure if it applies, but you might want to take a look at this:
	
https://software.intel.com/en-us/articles/performance-monitoring-on-intel-xeon-processor-e5-family

Vince
