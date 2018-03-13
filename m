From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Mon, 12 Mar 2018 20:23:42 -0700
Message-ID: <87tvtk64ld.fsf@linux.intel.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com> (Thomas
        Richter's message of "Mon, 12 Mar 2018 11:38:06 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Thomas Richter <tmricht@linux.vnet.ibm.com> writes:

> Right now there is only hard coded support for x86.

That's not true. There is support for generic transaction events in perf.

As far as I can tell your events would map 1:1 to the generic tx-* events.

-Andi
