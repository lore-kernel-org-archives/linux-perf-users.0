From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/2] perf evsel: add support for inlined function in
 callchains
Date: Wed, 20 Feb 2019 15:34:54 +0100
Message-ID: <20190220143454.GD25423@krava>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Feb 19, 2019 at 07:38:08PM +0100, Jonas Rabenstein wrote:
> Hi,
> sample__fprintf_callchain currently did not use the already available
> code to get the symbols of an inlined function if such information is
> available in a dso. This patchset adds the required logic to add
> appropriate lines.
> 
> As I am quite new to the code base of perf I am not sure how to test
> that changeset in a correct way. At least the codes builds and the tools
> that make use of sample__fprintf_callchain (perf-script, perf-trace and
> perf-sched as far as I can see) did not fail to run - also I did not get
> into the details of perf-trace and perf-sched as I have never used them
> before.

you could provide some examples that shows what u changed

I can see your changes change the perf script callchains,
displaying less or different callchains:

	--- old 2019-02-20 15:29:34.872312007 +0100
	+++ new 2019-02-20 15:30:47.784725456 +0100
	@@ -23,10 +23,9 @@ yes 11807 203482.590491:     246238 cycl
			      40 [unknown] ([unknown])

	 yes 11807 203482.590654:     534592 cycles:uppp:
	-           7f83e3c7fd0c _dl_addr+0x11c (/usr/lib64/libc-2.27.so)
	+           7f83e3c7fd0c __GI__dl_addr+0x11c (inlined)

	 yes 11807 203482.592371:     455976 cycles:uppp:
	-           55ddec8a3f6e [unknown] (/usr/bin/yes)
		 a790a790a790a79 [unknown] ([unknown])

	 yes 11807 203482.594176:     326514 cycles:uppp:
	@@ -38,11 +37,9 @@ yes 11807 203482.595464:     262867 cycl
		 a790a790a790a79 [unknown] ([unknown])

	 yes 11807 203482.596502:     214762 cycles:uppp:
	-           55ddec8a3f6e [unknown] (/usr/bin/yes)
		 a790a790a790a79 [unknown] ([unknown])


> 
> Another thing I am not sure how to deal with are some warnings of
> checkpatch.pl due to the 80 character line limit. Due to the long
> function names in use the current implementation already exceeded that
> limit in the same spots by even more characters as I have taken the
> inner loop and put it into a separate function.

don't worry much about the long lines warnings

> 
> I hope to expand my work to perf-report but thought it might be usefull
> to get already early feedback on those patches.

yep, good idea

thanks,
jirka
