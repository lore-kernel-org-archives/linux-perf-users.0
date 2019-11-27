From: Ivan Babrou <ivan@cloudflare.com>
Subject: Re: perf is unable to read dward from go programs
Date: Wed, 27 Nov 2019 13:15:20 -0800
Message-ID: <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, kernel-team <kernel-team@cloudflare.com>
List-Id: linux-perf-users.vger.kernel.org

There were no response in linux-perf-users@, so I think it's fair to
ask maintainers.

On Fri, Nov 8, 2019 at 3:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> I have a simple piece of code that burns CPU for 1s:
>
> * https://gist.github.com/bobrik/cf022ff6950d09032fa13a984e2272ed
>
> I can build it just fine: go build -o /tmp/burn burn.go
>
> And I can see correct stacks if I record with fp:
>
> perf record -e cpu-clock -g -F 99 /tmp/burn
>
> But if I record with gwarf:
>
> perf record -e cpu-clock -g -F 99 --call-graph dwarf /tmp/burn
>
> Then stacks are lost with the following complaints during "perf script":
>
> BFD: Dwarf Error: found dwarf version '376', this reader only handles
> version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '31863', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '65271', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '289', this reader only handles
> version 2, 3 and 4 information.
> ...
>
> That's on Linux 5.4-rc5 with binutils 2.28. On Linux 4.19.80 with
> binutils 2.31.1 I don't see the error, but the stacks are not any
> better:
>
> burn   788  3994.230871:   10101010 cpu-clock:
>           479955 crypto/sha512.blockAVX2+0x965 (/tmp/burn)
>
> burn   786  3994.241393:   10101010 cpu-clock:
>           40b2a7 runtime.mallocgc+0x697 (/tmp/burn)
>
> burn   782  3994.248061:   10101010 cpu-clock:
>           4746f1 crypto/sha512.(*digest).Write+0x21 (/tmp/burn)
>
> Compare to an fp version:
>
> burn   762  3892.587246:   10101010 cpu-clock:
>           479b19 crypto/sha512.blockAVX2+0xb29 (/tmp/burn)
> d186b8c721c0c207 [unknown] ([unknown])
>
> burn   760  3892.597158:   10101010 cpu-clock:
>           474783 crypto/sha512.(*digest).Write+0xb3 (/tmp/burn)
>           474e52 crypto/sha512.(*digest).checkSum+0xd2 (/tmp/burn)
>           4749e3 crypto/sha512.(*digest).Sum+0xa3 (/tmp/burn)
>           4840d3 main.burn+0xe3 (/tmp/burn)
>           483fda main.main+0x2a (/tmp/burn)
>           4298ee runtime.main+0x21e (/tmp/burn)
>       c000016060 [unknown] ([unknown])
> 89481eebc0313474 [unknown] ([unknown])
>
> I can understand AVX being off, but other stacks should be in order.
>
> Interestingly, in production I can see that some binaries are not
> affected by this issue.
>
> Is this an expected outcome?
