From: Arun Sharma <asharma@fb.com>
Subject: Re: Non core PMU support
Date: Wed, 20 Apr 2011 16:21:27 -0700
Message-ID: <20110420232127.GA651@radium.snc4.facebook.com>
References: <1303246041.6382.8.camel@carll-linux-laptop2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail007.snc4.facebook.com ([66.220.144.139]:41991 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752292Ab1DTXVc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Apr 2011 19:21:32 -0400
Content-Disposition: inline
In-Reply-To: <1303246041.6382.8.camel@carll-linux-laptop2.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Carl E. Love" <cel@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, Apr 19, 2011 at 01:47:21PM -0700, Carl E. Love wrote:
> 
> I have not found any recent work on adding uncore PMUs to perf.  Can
> anyone tell me what the current approach is to supporting uncore PMUs?
> Any pointers on how to add an uncore PMU would be appreciated.

If you install libpfm4 + my patch to perf posted here:

http://article.gmane.org/gmane.comp.linux.perfmon2.devel/2912/raw

You'll be able to use the uncore events by name.

 -Arun
