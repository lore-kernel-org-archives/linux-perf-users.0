From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding timestamps in perf.data
Date: Wed, 02 Sep 2015 12:23:39 -0700
Message-ID: <87oahk4ock.fsf@tassilo.jf.intel.com>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
	<55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33381 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033AbbIBTXq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 15:23:46 -0400
In-Reply-To: <55E72762.6030209@gmail.com> (David Ahern's message of "Wed, 2
	Sep 2015 10:44:18 -0600")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Dennis Gnad <dennis.gnad@kit.edu>, linux-perf-users@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:
>
> The counter values are not relevant for profiling. They are programmed
> to rollover and generate an NMI which causes the sample to be taken.

Actually it's relevent if you use adaptive frequency mode
(-F or default, not using -c) because it varies then.

The count values are reported by default in perf script.

-Andi
