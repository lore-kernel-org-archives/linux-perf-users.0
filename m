From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Date: Wed, 23 May 2018 15:09:50 +0200
Message-ID: <20180523130950.GB12217@hirez.programming.kicks-ass.net>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
 <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
 <20180510101406.GA12217@hirez.programming.kicks-ass.net>
 <7051f72e-2570-68c8-1488-33ad1b024031@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7051f72e-2570-68c8-1488-33ad1b024031@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 23, 2018 at 01:06:58PM +0300, Alexey Budankov wrote:

> Is the patch ready to be up streamed now? 

Please post a new one where you modify the comment about the syscalls
not saving registers and ideally find the commit that made it so.

Also; I think Andy would appreciate a comment near the syscall code that
refers back to this code and states what registers we rely upon being
there (+BP for this patch).
