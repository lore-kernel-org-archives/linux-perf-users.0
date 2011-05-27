From: Arun Sharma <asharma@fb.com>
Subject: Re: perf, H/W counters - ESX hosted VM
Date: Fri, 27 May 2011 15:51:45 -0700
Message-ID: <20110527225145.GB847@dev1756.snc6.facebook.com>
References: <4DDFFCA2.8030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DDFFCA2.8030100@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 27, 2011 at 01:33:54PM -0600, David Ahern wrote:
> 
> Has anyone successfully used perf within an ESX VM? dmesg shows a PMU is
> discovered:

Don't know about ESX. But in general, getting this right requires 
virtualizing PMU hardware (eg: save/restore PMU state on exit/entry
from the guest just the way the scheduler does for processes).

Also, the MSR read/writes to event-{select,count} registers must
be properly virtualized. Interrupt delivery (NMIs) is important
as well.

I suspect that MSR writes from the guest to the PMU related registers
are simply ignored in most virtual environments today.

 -Arun
