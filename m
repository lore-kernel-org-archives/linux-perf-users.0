From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf annotate: fix parsing aarch64 branch
 instructions after objdump update
Date: Thu, 30 Aug 2018 15:47:06 -0300
Message-ID: <20180830184706.GH6097@kernel.org>
References: <20180823191047.9260992844205984b75e6721@arm.com>
 <20180827125049.GD22309@kernel.org>
 <20180827125340.a2f7e291901d17cea05daba4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827125340.a2f7e291901d17cea05daba4@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@arm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Robin Murphy <robin.murphy@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, perf group <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Aug 27, 2018 at 12:53:40PM -0500, Kim Phillips escreveu:
> v2: address acme's comments:
>     - consolidate into a validate_comma()
>     - call from an additional couple of places necessary
>     - don't listen to checkpatch wrt reflowing jump__parse definition
>       line to less than 80 characters, just rm the __maybe_unused
>     - re-tested no diff on x86_64 and power arch, arm64 conditional
>       branches fixed.

Thanks for taking into account my comments, applied.

- Arnaldo
