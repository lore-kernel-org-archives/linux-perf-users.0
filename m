From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 02/10] perf, tools, stat: Avoid memory overrun with -r
Date: Tue, 19 Mar 2019 12:20:23 -0700
Message-ID: <20190319192023.GX24002@tassilo.jf.intel.com>
References: <20190314225002.30108-1-andi@firstfloor.org>
 <20190314225002.30108-2-andi@firstfloor.org>
 <20190319191452.GM3029@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190319191452.GM3029@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> mmap size 8192B
> perf: util/evlist.c:533: perf_evlist__id_add: Assertion `evsel->ids < evsel->sample_id->max_x * evsel->sample_id->max_y' failed.

I suspect this is a latent bug just caught by my assert.

So it was already broken.

You could of course remove the assert, but it would merely
hide it.

-Andi

> test child interrupted
> ---- end ----
> Read backward ring buffer: FAILED!
> 
> 
> I'm removing it till we go thru it to figure out what is the best way to
> go, not to get in the way of the other patches going upstream.
> 
> - Arnaldo
