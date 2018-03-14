From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Wed, 14 Mar 2018 10:31:28 -0700
Message-ID: <20180314173128.GH13724@tassilo.jf.intel.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
 <20180314131850.GA27335@kernel.org>
 <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
 <20180314154317.GG13724@tassilo.jf.intel.com>
 <20180314164236.GB5297@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314164236.GB5297@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

> Displaying these different types for s390 is important from my point of
> view.  Of course, I could create a mapping of TX_NC_TABORT/TX_NC_TEND
> to tx-commit/tx-abort.  The remaining events would still appear to be specific
> to the cpum_cf.

If you want more generic metrics you can just use the new json generic metrics /
metric group support in the eventlist. In fact if we did it today I wouldn't
add perf stat -T at all, but just use that.

-Andi
