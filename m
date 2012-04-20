From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] perf, x86: Disable sanity check
Date: Fri, 20 Apr 2012 11:18:16 -0700
Message-ID: <4F91A868.6090803@fb.com>
References: <1334791449-402-1-git-send-email-asharma@fb.com> <1334913084.2463.29.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334913084.2463.29.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

On 4/20/12 2:11 AM, Peter Zijlstra wrote:
> Makes me really nervous.. Ingo, Linus ?
>
> 'normal' usespace can suffer from this too with signal stacks. Arun's
> JIT case seems particularly weird in that his stacks don't strictly nest
> but can cross over multiple times (makes one wonder why they bother with
> multiple stacks..).

It's a tracing JIT, which dynamically chooses between interpreted mode 
and JIT mode. Translation is not necessarily a function at a time and 
has to be guarded by types inferred at runtime. Each time they switch 
between the two modes, they need to examine the non-native frames on the 
stack. With a single stack design, they'd have to unwind the stack 
looking for native frames vs JIT frames which adds complexity and cost.

Like you observed, this is needed for other less complex cases as well.

  -Arun
