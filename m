From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 18/31] perf vendor events arm64: Add
 armv8-recommended.json
Date: Tue, 13 Mar 2018 22:54:17 -0300
Message-ID: <20180314015417.GB19781@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
 <20180313182730.GA7987@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180313182730.GA7987@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Mar 13, 2018 at 03:27:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 13, 2018 at 03:26:18PM +0100, Ingo Molnar escreveu:
> > That's not a valid SOB chain, author != first-Signed-off-by.
 
> I removed that cset for now, can you please check if the
> perf-core-for-mingo-4.17-20180313-2 tag is allright?

So, since there is this problem with powerpc and jevents, Ingo, please
hold on a bit more... Hopefully tomorrow things will be in a better
shape.

- Arnaldo
