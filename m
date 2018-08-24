From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf annotate: fix parsing aarch64 branch instructions
 after objdump update
Date: Fri, 24 Aug 2018 16:45:06 -0500
Message-ID: <20180824164506.aa6e54bceb1ffb7b3dc70733@arm.com>
References: <20180823191047.9260992844205984b75e6721@arm.com>
        <18abf031-f803-b8e6-129e-ed50c63e73d0@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18abf031-f803-b8e6-129e-ed50c63e73d0@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Robin Murphy <robin.murphy@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, perf group <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 24 Aug 2018 09:59:22 +0200
Thomas-Mich Richter <tmricht@linux.ibm.com> wrote:

> On 08/24/2018 02:10 AM, Kim Phillips wrote:
> > Tested no difference in output for sample x86_64, power arch perf.data files.
> 
> Tested,  no difference in output on s390. Just to let you know.

Thanks!  An official Tested-by: tag would help keep acme from guessing
whether he should convert these less-officially sounding types of
emails in the future.  I doubt your official Tested-by implies you
necessarily have had to claim you fully tested it on e.g., x86-64, esp.
if your Tested-by is in such context as provided above.

BTW, if you want to send me an s390 perf.data file and the file
resulting from 'perf archive', and a matching vmlinux in an off-list
email, I can add it to my perf-archives arsenal for future testing.

Again, thanks for testing!

Kim
