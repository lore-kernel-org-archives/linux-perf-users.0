From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Include file bpf.h in directory /usr/lib/include/perf/bpf/bpf.h
Date: Tue, 24 Jul 2018 10:45:54 -0300
Message-ID: <20180724134554.GA5630@kernel.org>
References: <e6e3b74d-5a36-e6ac-a576-0c39c03cbc64@linux.ibm.com>
 <20180723141912.GA5804@kernel.org>
 <6a78dbf0-bd6a-17de-4bd4-b4b9faad94d1@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a78dbf0-bd6a-17de-4bd4-b4b9faad94d1@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Liebler <stli@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Thomas-Mich Richter <tmricht@linux.ibm.com>, Stefan Liebler <stli@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jul 24, 2018 at 12:49:43PM +0200, Stefan Liebler escreveu:
> In each case, the introduction of the subdirectory /usr/lib/include leads to
> the regression that one can't build the glibc RPM for s390 anymore as gcc
> can't find headers like stdbool.h.
 
> Should bpf.h be moved to /usr/lib/perf/include/bpf/bpf.h?

Thanks for the report, yes, I agree with your analysis, breaking the
assumptions of existing setups like that is not good, can you send a
patch, including this analysis so that this gets documented in the
project's git changeset history?

I wonder if we even shouldn't go one extra step and have it in:

/usr/lib/perf/bpf/include/bpf/bpf.h?

That extra /bpf/ is to make it sure that everything below
/usr/lib/perf/bpf/ is to be used in generating eBPF objects to be loaded
via sys_bpf(), of which the "include/bpf" subdir and bpf.h are for basic
BPF aspects such as the definition of maps, etc, while include/fmt/
(below /usr/lib/perf/bpf/) could be C inline functions to be used in .c
files to generate eBPF ELF objects, and other function "libraries" could
live in different directories in this hierarchy.

One can think about /usr/lib/perf/something-else-that-requires-c-headers/
like if we decide to create shared objects to process tracepoint events
obtained from the kernel in a pretty format by just using the tracefs
metadata, where we would transform a .c file into something other than
a eBPF ELF file.

But yeah, to fix the problem you described we have to have it all under
/usr/lib/perf/

- Arnaldo
