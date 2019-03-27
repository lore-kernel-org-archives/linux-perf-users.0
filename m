From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/4] perf, tools: Implement duration_time as a proper
 event
Date: Wed, 27 Mar 2019 06:54:39 -0700
Message-ID: <20190327135439.GS18020@tassilo.jf.intel.com>
References: <20190326221823.11518-1-andi@firstfloor.org>
 <20190326221823.11518-3-andi@firstfloor.org>
 <20190327085813.GB24156@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327085813.GB24156@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> 
> so now that we have time in a separate event, we could
> get rid of the isolated update_stats(&walltime_nsecs_stats) calls
> and move them to perf_stat__update_shadow_stats?

In theory yes, but it would require perf stat always setting up
the duration_time event implicitely and then special handling.

For stat it would need to be hidden to keep the same output.

It's probably simpler to keep the old way for that.

-Andi
