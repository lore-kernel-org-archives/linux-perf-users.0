From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Fri, 12 Jan 2018 17:02:29 -0300
Message-ID: <20180112200229.GI9655@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112164706.GE9655@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jan 12, 2018 at 01:47:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> There is still room for improvement, I noticed overriding is not working
> for the probe event, investigating it now.

So, I had to fix this another way to get the possibility of overwriting
the global options (--max-stack, --call-graph) in an specific tracepoint
event:

http://git.kernel.org/acme/c/08e26396c6f2

replaced that HEAD.

This cset may take some more minutes to show up, just pushed.

- Arnaldo
