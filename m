From: Vijay Thakkar <vijaythakkar@me.com>
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
Date: Fri, 28 Feb 2020 12:27:03 -0500
Message-ID: <20200228172703.GA34885@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
 <20200228160045.GA23708@shwetrath.localdomain>
 <f7dba82f-beac-2669-c7e7-5a85edc2798d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7dba82f-beac-2669-c7e7-5a85edc2798d@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> They're producing nonzero counts on my model 31h, so leave them in?

> I'm getting nonzero values on my model 31h for that event's
> various unit masks, too.
Okay, will do.

> Thanks, I'd veer toward making them available despite differences in PPR
> versions.

Okay, that is consistent with what I have done so far for the Zen1
counters that are not mentioned in the Zen2 PPRs. Great! I will send v3
in a bit.

Best,
Vijay
