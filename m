From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Date: Wed, 25 Mar 2020 12:29:44 -0700
Message-ID: <20200325192944.GI27749@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de>
 <20200325191757.GG14102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200325191757.GG14102@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Mar 25, 2020 at 04:17:57PM -0300, Arnaldo Carvalho de Melo wrote:

> > As an aside, for record path, do you know where PERF_SAMPLE_CALLCHAIN
> > is actually set before being passed to kernel space?
> 
> So, I think is somewhere down from perf_evsel__config()... its in:
> 
> 	perf_evsel__set_sample_bit(evsel, CALLCHAIN);

Thanks for the pointer. I was having a hard time finding it, being too specific.

Tony
