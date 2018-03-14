From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Wed, 14 Mar 2018 08:43:17 -0700
Message-ID: <20180314154317.GG13724@tassilo.jf.intel.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
 <20180314131850.GA27335@kernel.org>
 <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

> S390 has no support for Elision and uses transaction begin/end/abort
> instructions. The CPU measurement counter facility provides counters for
> transaction end and transaction abort.

You don't need to implement the el-* events.

> I have used this table (taken from arch/x86/events/intel/core.c) as giudeline:
> /* Haswell special events */
> EVENT_ATTR_STR(tx-start,        tx_start,       "event=0xc9,umask=0x1");
> EVENT_ATTR_STR(tx-commit,       tx_commit,      "event=0xc9,umask=0x2");
> EVENT_ATTR_STR(tx-abort,        tx_abort,       "event=0xc9,umask=0x4");
> EVENT_ATTR_STR(tx-capacity,     tx_capacity,    "event=0x54,umask=0x2");
> EVENT_ATTR_STR(tx-conflict,     tx_conflict,    "event=0x54,umask=0x1");
> EVENT_ATTR_STR(el-start,        el_start,       "event=0xc8,umask=0x1");
> EVENT_ATTR_STR(el-commit,       el_commit,      "event=0xc8,umask=0x2");
> EVENT_ATTR_STR(el-abort,        el_abort,       "event=0xc8,umask=0x4");
> EVENT_ATTR_STR(el-capacity,     el_capacity,    "event=0x54,umask=0x2");
> EVENT_ATTR_STR(el-conflict,     el_conflict,    "event=0x54,umask=0x1");
> EVENT_ATTR_STR(cycles-t,        cycles_t,       "event=0x3c,in_tx=1");
> EVENT_ATTR_STR(cycles-ct,       cycles_ct,      "event=0x3c,in_tx=1,in_tx_cp=1");
> 
> 
> So s390 can only support tx_commit and tx-abort symbolic names.
> None of them show up in the transactions_attrs and transaction_limited_attrs
> string variables used in builtin-stat.c file.

We could change perf stat to fall back to only tx commit and tx abort.
We already did that for one limited case.

-Andi
