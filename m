From: Andi Kleen <ak@linux.intel.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Tue, 6 Nov 2018 12:24:11 -0800
Message-ID: <20181106202411.GU6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
 <20181106083957.GB8081@krava>
 <2102566.fCj8pZGm78@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2102566.fCj8pZGm78@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> Where would I look for the source to change here? So far, I only concentrated 
> on the userspace side of perf in tools/perf.

Kind of similar to 

a405bad5ad20 perf/x86: Add Haswell specific transaction flag reporting
fdfbbd07e91f perf: Add generic transaction flags

Report the original (not overwritten) regs->ip and regs->sp

-Andi
