From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: perf mem: invalid or unsupported event: 'cpu/mem-loads/pp'
Date: Tue, 23 Jul 2013 11:46:49 +1000
Message-ID: <1374544009.5545.2.camel@concordia>
References: <6210395.6gJQB6qfUl@minime>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47003 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab3GWBqv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 21:46:51 -0400
In-Reply-To: <6210395.6gJQB6qfUl@minime>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

On Mon, 2013-07-22 at 19:34 +0200, Milian Wolff wrote:
> Hey there,
> 
> I just found perf mem in the output of perf help and wanted to try it:
> 
> $ perf mem record ls
> invalid or unsupported event: 'cpu/mem-loads/pp'
> Run 'perf list' for a list of valid events
> 
>  usage: perf record [<options>] [<command>]
>  ...
> 
> Am I missing a kernel configuration? Or what is going on here?

You need a kernel that has mem-loads in /sys/bus/event_source/devices/cpu/events

Assuming you're on x86 you'll need a 3.10 or later kernel.

cheers
