From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 06/13] perf vendor events powerpc: Remove duplicate events
Date: Mon, 4 Sep 2017 09:51:06 -0700
Message-ID: <20170904165106.GT2482@two.firstfloor.org>
References: <20170904140044.22912-1-acme@kernel.org>
 <20170904140044.22912-7-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170904140044.22912-7-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 04, 2017 at 11:00:37AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> Some POWER PMU event names have multiple/alternate event codes. These
> alternate event codes were listed in the POWER9 JSON files for
> reference.
> 
> But the perf tool does not seem to handle duplicates cleanly. 'perf
> list' shows such duplicate events only once, but 'perf stat' ends up
> counting the first event code twice, multiplexing if necessary and we
> end up with double the event counts.
> 
> Remove the duplicate event codes from the JSON files for now.

It would be better to fix it in perf. I assume it wouldn't be that hard.
Intel may get multiple versions of events at some point too,
as events get renamed, but the old names stay around for compatibility.

-Andi
