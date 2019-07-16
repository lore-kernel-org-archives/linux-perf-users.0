From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 2/3] perf script: Fix off by one in brstackinsn IPC
 computation
Date: Tue, 16 Jul 2019 15:44:53 -0300
Message-ID: <20190716184453.GC3624@kernel.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
 <20190711181922.18765-2-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711181922.18765-2-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Denis Bakhvalov <denis.bakhvalov@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jul 11, 2019 at 11:19:21AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When we hit the end of a program block, need to count the last instruction
> too for the IPC computation. This caused large errors for small blocks.
> 
> % perf script -b ls / > /dev/null
> 
> Before:

Thanks, applied.

- Arnaldo
