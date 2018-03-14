From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Wed, 14 Mar 2018 17:42:36 +0100
Message-ID: <20180314164236.GB5297@linux.vnet.ibm.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
 <20180314131850.GA27335@kernel.org>
 <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
 <20180314154317.GG13724@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314154317.GG13724@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Hi,

On Wed, Mar 14, 2018 at 08:43:17AM -0700, Andi Kleen wrote:
> > S390 has no support for Elision and uses transaction begin/end/abort
> > instructions. The CPU measurement counter facility provides counters for
> > transaction end and transaction abort.
> 
> You don't need to implement the el-* events.
> 
> > I have used this table (taken from arch/x86/events/intel/core.c) as giudeline:
> > /* Haswell special events */
> > EVENT_ATTR_STR(tx-start,        tx_start,       "event=0xc9,umask=0x1");
> > EVENT_ATTR_STR(tx-commit,       tx_commit,      "event=0xc9,umask=0x2");
> > EVENT_ATTR_STR(tx-abort,        tx_abort,       "event=0xc9,umask=0x4");
> > EVENT_ATTR_STR(tx-capacity,     tx_capacity,    "event=0x54,umask=0x2");
> > EVENT_ATTR_STR(tx-conflict,     tx_conflict,    "event=0x54,umask=0x1");
> > EVENT_ATTR_STR(el-start,        el_start,       "event=0xc8,umask=0x1");
> > EVENT_ATTR_STR(el-commit,       el_commit,      "event=0xc8,umask=0x2");
> > EVENT_ATTR_STR(el-abort,        el_abort,       "event=0xc8,umask=0x4");
> > EVENT_ATTR_STR(el-capacity,     el_capacity,    "event=0x54,umask=0x2");
> > EVENT_ATTR_STR(el-conflict,     el_conflict,    "event=0x54,umask=0x1");
> > EVENT_ATTR_STR(cycles-t,        cycles_t,       "event=0x3c,in_tx=1");
> > EVENT_ATTR_STR(cycles-ct,       cycles_ct,      "event=0x3c,in_tx=1,in_tx_cp=1");
> > 
> > 
> > So s390 can only support tx_commit and tx-abort symbolic names.

In detail, for s390 we have:

cpum_cf/TX_C_TABORT_NO_SPECIAL/
cpum_cf/TX_C_TABORT_SPECIAL/
cpum_cf/TX_C_TEND/
cpum_cf/TX_NC_TABORT/
cpum_cf/TX_NC_TEND/

The mapping of the above is not that easy. As s390 have counters for
non-constraint (TC_NC_*) and contraint (TX_C_*) transaction commits (TEND)
and aborts (TABORTs).

> We could change perf stat to fall back to only tx commit and tx abort.
> We already did that for one limited case.

Displaying these different types for s390 is important from my point of
view.  Of course, I could create a mapping of TX_NC_TABORT/TX_NC_TEND
to tx-commit/tx-abort.  The remaining events would still appear to be specific
to the cpum_cf.

So I would propose to go with adding the cpum_cf/ specific ones first.
If necessary, they could go into the perf/arch/s390/ directory and included
in builtin-stat.  I put a todo on my list to provide at least a
tx-commit/abort for the nonconstraint transactions. (The other would still be
specific).

Kind regards,
  Hendrik

-- 
Hendrik Brueckner
brueckner@linux.vnet.ibm.com      | IBM Deutschland Research & Development GmbH
Linux on z Systems Development    | Schoenaicher Str. 220, 71032 Boeblingen


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
