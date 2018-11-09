From: Andi Kleen <ak@linux.intel.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Thu, 8 Nov 2018 16:55:35 -0800
Message-ID: <20181109005535.GA6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <20181106202411.GU6218@tassilo.jf.intel.com>
 <1584560.aXQ729uQp3@agathebauer>
 <7105958.qy8IzDpmRc@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7105958.qy8IzDpmRc@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> Can we change this, such that perf_event_output also takes a second set of 
> registers (iregs) that get sampled for PERF_SAMPLE_REGS_INTR? I'm very new to 
> real kernel development, what kind of ABI/API stability guarantees exist for 
> something like "perf_event_output"?

Yes you can change it.

That's no API/ABI stability guarantee for kernel internal functions, 
as long as you change all callers in tree.

-Andi
