From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Meaning of weight and source fields in perf mem samples
Date: Wed, 02 Sep 2015 12:21:04 -0700
Message-ID: <87si6w4ogv.fsf@tassilo.jf.intel.com>
References: <ms64jg$cfo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44940 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbbIBTVI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 15:21:08 -0400
In-Reply-To: <ms64jg$cfo$1@ger.gmane.org> (Daniel Ortiz's message of "Wed, 2
	Sep 2015 06:22:40 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel Ortiz <daniel.ortiz@tum.de>
Cc: linux-perf-users@vger.kernel.org

Daniel Ortiz <daniel.ortiz@tum.de> writes:
>
> But I have not found any source that confirms whether perf is taking
> this value or not. Could anyone confirm me if these are the values
> that perf is putting on the samples

Yes the load-latency values are used for weight here.
-Andi
