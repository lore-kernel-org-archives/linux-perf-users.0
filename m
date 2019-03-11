From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 02/10] perf, tools, stat: Avoid memory overrun with -r
Date: Mon, 11 Mar 2019 13:28:48 -0700
Message-ID: <20190311202848.GC29294@tassilo.jf.intel.com>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-3-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-3-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:38PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When -r is used memory would get corrupted because the evsel->id array
> would get overrun. evsel->ids is a running counter of the last id.
> Normally this works fine, but with -r the same event is initialized
> multiple times, but not this counter, so it would keep growing
> beyond the array limit and corrupt random memory.
> 
> Always reinitialize ->ids, and also add an assert to catch
> such overruns in the future.
> 
> This fixes a perf segfault when running it from toplev.

This one should be Cc: stable

-Andi
