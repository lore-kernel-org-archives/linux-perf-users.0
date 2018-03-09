From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf tools arm64: Add libdw DWARF post unwind support
 for ARM64
Date: Fri, 9 Mar 2018 12:07:20 -0600
Message-ID: <20180309120720.9358515dbff3b1d1fdf70cc8@arm.com>
References: <A5E405FE-1BA3-46FC-9A43-CF19A4B369C5@cisco.com>
        <20180226142726.cd413c792d0782f77b60a23e@arm.com>
        <20180226174040.6998bd3c0a79b2f19c491e4d@arm.com>
        <9B701F46-6AEA-48D8-9103-71D35C83776D@cisco.com>
        <20180308211030.4ee4a0d6ff6dc5cda1b567d4@arm.com>
        <20180309150627.GB8347@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309150627.GB8347@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Christian Hansen (chansen3)" <chansen3@cisco.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, "Vuille, Martin (Martin)" <vmartin@avaya.com>, Martin Vuille <jpmv27@aim.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 9 Mar 2018 12:06:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

Hi Arnaldo,

> Em Thu, Mar 08, 2018 at 09:10:30PM -0600, Kim Phillips escreveu:
> > Based on prior work:
> > 
> > https://lkml.org/lkml/2014/5/6/395
> 
> Thanks, looks good, applying.
> 
> Jean, is everything ok with you on this?

By now your email to Jean should have bounced with "The email account
that you tried to reach does not exist."  Removing Jean from Cc.

It seems like you're applying patches.  There are a couple that have
slipped through the cracks: Can you please take a look at applying them?

- "perf tools: Fixing uninitialised variable"
  https://patchwork.kernel.org/patch/10179381/

- "perf unwind: Report error from dwfl_attach_state"
  https://patchwork.kernel.org/patch/10211483/
  [Martin, I guess it would help if you replied-all that patch and
   added your signed-off-by.]

- "perf unwind: Unwind with libdw doesn't take symfs into account"
  https://patchwork.kernel.org/patch/10211599/

Thanks,

Kim
