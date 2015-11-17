From: Andi Kleen <ak@linux.intel.com>
Subject: Re: event group without multiplexing
Date: Mon, 16 Nov 2015 16:39:37 -0800
Message-ID: <20151117003937.GF10150@tassilo.jf.intel.com>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
 <CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
 <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
 <1447350001.15375.95.camel@Rudolf-RHEL-7>
 <alpine.DEB.2.20.1511121248050.7597@vincent-weaver-1.umelst.maine.edu>
 <alpine.DEB.2.20.1511121257380.7597@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37813 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbKQAji (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 19:39:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1511121257380.7597@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Yuanfang Chen <cyfmxc@gmail.com>

On Thu, Nov 12, 2015 at 01:00:09PM -0500, Vince Weaver wrote:
> 
> ccing Andi Kleen as he's the one who introduced the Haswell constraint 
> code in 3a632cb229bfb18b6d09822cc842451ea46c013e so maybe he knows why
> it is contraining all L1D_PEND_MISS.* events rather than just 
> L1D_PEND_MISS.PENDING on IVB and BDW.

Yes it looks like Haswell could use the more limited constraint as Broadwell
or IvyBridge. I don't remember why it ended up this way.
Please submit a patch.

-Andi
