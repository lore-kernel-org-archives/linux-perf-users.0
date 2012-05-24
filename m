From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Perf 2.6.32-220.el6.x86_64 problem when recording 2 counters
Date: Thu, 24 May 2012 10:33:15 +1000
Message-ID: <1337819595.29765.9.camel@concordia>
References: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52383 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048Ab2EXAdR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 May 2012 20:33:17 -0400
In-Reply-To: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HUMMEL Michel <michel.hummel@thalesgroup.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 2012-05-23 at 18:06 +0200, HUMMEL Michel wrote:
> Hello,
> I am testing the perf command of my new centos 6.2 server, and I don't understand something.
> 
> I wrote a simple test case which is calling two functions.
> The first one "good_perfo"  does the same as the second "bad_perfo"
> but more efficiently (lesser cache miss ...).

Does it make any difference if you rewrite your test to run bad_perfo
first, and then good_perfo?

cheers
