From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Date: Thu, 22 Aug 2019 18:24:50 -0300
Message-ID: <20190822212450.GK3929@kernel.org>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
 <20190822212407.GJ3929@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822212407.GJ3929@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Linton <Jeremy.Linton@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Aug 22, 2019 at 06:24:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 22, 2019 at 01:55:15PM +0000, James Clark escreveu:
> > Running 'perf test' with zstd compression linked will hang at the test
> > 'Zstd perf.data compression/decompression' because /dev/random blocks
> > reads until there is enough entropy. This means that the test will
> > appear to never complete unless the mouse is continually moved while
> > running it.
> 
> message came mangled, had to do it by hand and then hook up your header
> so as to get the correct date, attribution, etc, please check
> Documentation/process/email-clients.rst,

Having said that, thanks, applied.

- Arnaldo
