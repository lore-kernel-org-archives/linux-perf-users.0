From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/3] perf vendor events amd: latest PMU events for
 zen1/zen2
Date: Tue, 7 Jan 2020 18:46:25 +0100
Message-ID: <20200107174625.GI29542@zn.tnic>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20200106221754.GB16851@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106221754.GB16851@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Vijay Thakkar <vijaythakkar@me.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 06, 2020 at 07:17:54PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 27, 2019 at 07:55:33AM -0500, Vijay Thakkar escreveu:
> > This series of patches brings the PMU events for AMD family 17h series
> > of processors up to date with the latest versions of the AMD processor
> > programming reference manuals.
> > 
> > The first patch changes the pmu events mapfile to be more selective for
> > the model number rather than blanket detecting all f17h processors to
> > have the same events directory. This is required for the later patch
> > where we add events for zen2 based processors.
> > 
> > The second patch adds the PMU events for zen2.
> 
> Borislav, can you ack these, or point to someone who can double check
> this and the other 2 patches?

Hey acme, HNY! :-)

That should be Kim who's already on the Cc list.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
