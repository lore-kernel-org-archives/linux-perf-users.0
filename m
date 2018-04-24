From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH] perf tools: allow map files to specify DSO
Date: Tue, 24 Apr 2018 12:39:12 -0700
Message-ID: <20180424193912.GE14273@tassilo.jf.intel.com>
References: <1524595749-26688-1-git-send-email-johunt@akamai.com>
 <20180424192731.GC4427@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424192731.GC4427@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Hunt <johunt@akamai.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> Pekka, Andi, Stephane, do you guys see any problems with this?

Looks ok to me.

-Andi

> 
> If this flies, tools/perf/Documentation/jit-interface.txt needs
> updating.
