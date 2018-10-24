From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date: Wed, 24 Oct 2018 07:48:18 -0700
Message-ID: <20181024144818.GF6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <2679413.U8bCfAhSQu@agathebauer>
 <20181023040356.GA6218@tassilo.jf.intel.com>
 <2086866.px82jjA6i7@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2086866.px82jjA6i7@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> 
> Can someone at least confirm whether unwinding from a function prologue via 
> .eh_frame (but without .debug_frame) should actually be possible?

Yes it should be possible. Asynchronous unwind tables should work
from any instruction.

-Andi
