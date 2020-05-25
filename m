From: "Anand K. Mistry" <amistry@google.com>
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
Date: Mon, 25 May 2020 11:43:00 +1000
Message-ID: <CAATStaOY+JJ7mXWRwfXWuR_imhwsv=PecKSWiuZUetHTcz3EXg@mail.gmail.com>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid> <87a71y93lr.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a71y93lr.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sat, 23 May 2020 at 23:35, Andi Kleen <ak@linux.intel.com> wrote:
>
> Anand K Mistry <amistry@google.com> writes:
> >       }
> >
> > +     done_fd = eventfd(0, EFD_NONBLOCK);
>
> This will make perf depend on a recent glibc or other library
> that implements eventfd. Wouldn't surprise me if some kind
> of build time check is needed for this to pass all of Arnaldo's
> built tests.

Looks like Arnaldo made that change when merging:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=e9db221d37f91409040cf7f3fbed08b44e055ae9

This makes me curious. How old a kernel should modern tools support?
From the man page, eventfd was added in 2.6.22 (and eventfd2 in
2.6.27), which was 2007 (or 2008 for eventfd2) and glibc-2.8 which was
2008. I understand the kernel's policy of never breaking userspace,
but what about userspace tools?

>
>
> -Andi



-- 
Anand K. Mistry
Software Engineer
Google Australia
