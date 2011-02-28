From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 0/6 v3] perf events: Add realtime clock event, time-of-day
 strings to script output
Date: Sun, 27 Feb 2011 20:55:28 -0700
Message-ID: <4D6B1CB0.8020704@cisco.com>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:35693 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab1B1DzR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Feb 2011 22:55:17 -0500
In-Reply-To: <1298865151-23656-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de



On 02/27/2011 08:52 PM, David Ahern wrote:
> A request was made to modify perf-trace and perf-script. From what I can see
> perf-trace does not exist yet and perf-script requires raw data which means
> it does not work for the primary use case that motivated this feature
> (perf record -e cs -1 -ag).

Please disregard the above; it is not relevant to this version.

David
