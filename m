From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf test: Test 6 dumps core on s390
Date: Mon, 11 Jun 2018 11:07:06 +0200
Message-ID: <20180611090706.GA21328@krava>
References: <20180608131728.75084-1-tmricht@linux.ibm.com>
 <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
 <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Kim Phillips <kim.phillips@arm.com>, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jun 11, 2018 at 09:00:53AM +0200, Thomas-Mich Richter wrote:
> On 06/08/2018 04:53 PM, Kim Phillips wrote:
> > On Fri, 8 Jun 2018 15:17:28 +0200
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > 
> >> Perf test case 6 "Parse event definition strings"
> >> dumps core when executed on s390.
> > 
> > I reported it actually fails on any $ARCH system without
> > Intel Processor Trace (PT) h/w:
> > 
> > https://www.spinics.net/lists/linux-perf-users/msg06020.html
> > 
> > There was a follow-up patch sent here:
> > 
> > https://www.spinics.net/lists/linux-perf-users/msg06029.html
> > 
> > which worked for me, but I don't know what has/has-not transpired
> > since, other than it is still broken, as you found.
> > 
> > Kim
> 
> 
> Looks like this is still broken. I also can not find this patch on
> git clone -b perf/core git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> 
> We actually need 2 patches
> - one to fix the core dump
> - one to test for x86 platform

right.. I forgot about those, will rebase/repost it

jirka
