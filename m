From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Inlined functions in perf report
Date: Wed, 21 Dec 2016 11:20:35 +0100
Message-ID: <20161221102035.GA31703@sesse.net>
References: <20161220115954.GA35897@sesse.net>
 <df263fe1-e1af-881b-311e-5329bb51db0e@linux.intel.com>
 <20161221095823.GA19249@sesse.net>
 <8193556.VWj3dM7HSI@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8193556.VWj3dM7HSI@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 21, 2016 at 11:09:42AM +0100, Milian Wolff wrote:
> Just to check - did you really compile your code with frame pointers? By 
> default, that is not the case, and the above will try to do frame pointer 
> unwinding which will then fail. Put differently - do you any stack frames at 
> all? Can you try `perf record --call-graph dwarf` instead? Of course, make 
> sure you compile your code with `-g -O2` or similar.

I don't specifically use -fno-omit-frame-pointer, no. But the normal stack
unwinding works just fine with mainline perf nevertheless; is this expected?

/* Steinar */
-- 
Homepage: https://www.sesse.net/
