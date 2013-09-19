From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Intel PEBS  Load Latency Measurement
Date: Thu, 19 Sep 2013 01:22:05 -0700
Message-ID: <87a9j95ihe.fsf@tassilo.jf.intel.com>
References: <52380863.4090606@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22696 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab3ISIWI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 Sep 2013 04:22:08 -0400
In-Reply-To: <52380863.4090606@insa-lyon.fr> (Manuel Selva's message of "Tue,
	17 Sep 2013 09:44:35 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Manuel Selva <selva.manuel@gmail.com> writes:

> Is the perf userland tool using it to provide the functionality to end
> users ?

It's in the standard perf

perf mem record ...
perf mem report

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
