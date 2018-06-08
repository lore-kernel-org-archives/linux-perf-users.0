From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf test: Test 6 dumps core on s390
Date: Fri, 8 Jun 2018 09:53:18 -0500
Message-ID: <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
References: <20180608131728.75084-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608131728.75084-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Fri, 8 Jun 2018 15:17:28 +0200
Thomas Richter <tmricht@linux.ibm.com> wrote:

> Perf test case 6 "Parse event definition strings"
> dumps core when executed on s390.

I reported it actually fails on any $ARCH system without
Intel Processor Trace (PT) h/w:

https://www.spinics.net/lists/linux-perf-users/msg06020.html

There was a follow-up patch sent here:

https://www.spinics.net/lists/linux-perf-users/msg06029.html

which worked for me, but I don't know what has/has-not transpired
since, other than it is still broken, as you found.

Kim
