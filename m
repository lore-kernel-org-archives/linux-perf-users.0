From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v4 01/15] perf tools: Add utility function to fetch
 executable
Date: Wed, 6 Mar 2019 13:08:29 -0800
Message-ID: <20190306210828.yvhifeczc7mfloqi@two.firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-2-andi@firstfloor.org>
 <20190306205337.GK30734@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190306205337.GK30734@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

> . No need to cast around, make 'buf' be a void pointer
> 
> . Rename it to thread__memcpy() to reflect the fact it is about copying
>   a chunk of memory from a thread, i.e. from its address space.
> 
> . No need to have it in a separate object file, move it to thread.[ch]
> 
> . Check the return of map__load(), the original code didn't do it, but
>   since we're moving this around, check that as well, could be moved to
>   a separate patch tho.

Changes look good. Thanks Arnaldo.

-Andi
