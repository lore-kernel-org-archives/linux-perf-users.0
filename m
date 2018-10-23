From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date: Mon, 22 Oct 2018 21:03:56 -0700
Message-ID: <20181023040356.GA6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <1775744.0RuD2nMEIt@agathebauer>
 <87o9bmrsli.fsf@linux.intel.com>
 <2679413.U8bCfAhSQu@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2679413.U8bCfAhSQu@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> So what if my libm wasn't compiled with -fasynchronous-unwind-tables? We 

It's default (64bit since always and 32bit now too) Unless someone disabled it.

However libm might be partially written in assembler and hand written assembler
often has problems with unwind tables because the programmer has to get them
correct explicitely.

-Andi
