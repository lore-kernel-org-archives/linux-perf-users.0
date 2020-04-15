From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 1/2] tools api: add a lightweight buffered reading api
Date: Wed, 15 Apr 2020 11:20:32 +0900
Message-ID: <CAM9d7chvpCOdSAeRH1+1vt_m+-Ecwm7jRXrN2OAjAP5yJwc=og@mail.gmail.com>
References: <20200411064248.247530-1-irogers@google.com> <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
 <CAP-5=fW_5pPZTA3bXdT9d9Tt_d5aJw=4bf_fr9eqzGPfoVs3aQ@mail.gmail.com>
 <CAM9d7cgsR7mU_N3BaOz3i2XWY_GchOYWHvNh8g+=2VHTFGEm9Q@mail.gmail.com> <CAP-5=fU+rrpK=zNBWWDBxUMYBz6yV3FZV3uhwye7euN7m8saDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP-5=fU+rrpK=zNBWWDBxUMYBz6yV3FZV3uhwye7euN7m8saDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Apr 14, 2020 at 9:48 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Apr 13, 2020 at 5:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Apr 14, 2020 at 1:22 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Mon, Apr 13, 2020 at 12:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Sat, Apr 11, 2020 at 3:42 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > The synthesize benchmark shows the majority of execution time going to
> > > > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > > > reading library that will be used to replace these calls in a follow-up
> > > > > CL. Add tests for the library to perf test.
> > > > >
> > > > > v4 adds the test file missed in v3.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
> > > > > + * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
> > > > > + * returns the character after the hexadecimal value which may be -1 for eof.
> > > >
> > > > I'm not sure returning -1 is good when it actually reads something and
> > > > meets EOF.
> > > > Although it would have a valid value, users might consider it an error IMHO.
> > > > Why not returning 0 instead? (I'm ok with -1 for the later use of the API).
> > >
> > > Thanks for the feedback! In the code for /proc/pid/maps this is a
> > > hypothetical, but I think having the API right is important. I didn't
> > > go with 0 as you mention 0 'could' encode a character, for example,
> > > 7fffabcd\0 wouldn't be distinguishable from 7fffabcd<EOF>.
> >
> > Practically I don't think it matters in this case as long as we can
> > distinguish them in the next call (if the user wants to do).
> > What users want to do (I think) is whether the returned value
> > (in *hex) is ok to use or not.  By returning -1 on EOF, it might
> > be confusing for users..
>
> In the /proc/pid/maps case the code for reading an address like
> "00400000-00452000 " the code is:
>
> if (io__get_hex(io, start) != '-')
>   return false;
> if (io__get_hex(io, end) != ' ')
>   return false;
>
> If io__get_hex doesn't return the next character it becomes:
>
> if (io__get_hex(io, start))
>   return false;
> if (io__get_char(io) != '-')
>   return false;
> if (io__get_hex(io, end))
>   return false;
> if (io__get_char(io) != ' ')
>   return false;
>
> Which is twice as verbose and requires that io have a rewind operation
> to go backward when io__get_hex and io__get_dec have gone 1 character
> too far.

Yeah, I'm not against returning the next character - it's good.
The only concern was whether it should return -1 or 0 when
it meets EOF after parsing some digits.

But I think we can go with this version as there's no such case
when parsing /proc/pid/maps.

>
> > > The updated
> > > code distinguishes the cases as 0 meaning character \0, -1 meaning EOF
> > > and -2 meaning bad encoding. Your worry is that a hex number that's
> > > next to EOF will get a result of -1 showing the EOF came next. and
> > > code that does 'if ( .. < 0)' would trigger. While clunky, it'd be
> > > possible in those cases to change the code to 'if ( .. < -1)'.
> >
> > Yes, but it's not conventional IMHO.
> >
> >
> > > So my thoughts are:
> > > 1) being able to tell apart the 3 cases could be important - this is
> > > all hypothetical;
> > > 2) keeping EOF and error as negative numbers has a degree of consistency;
> > > 3) using -1 for EOF comes from get_char, it'd be nice to have one
> > > value mean EOF.
> > > Perhaps the issue is the name of the function? It isn't a standard API
> > > to return the next character, but it simplified things for me as I
> > > didn't need to add a 'rewind' operation. The function names could be
> > > something like io__get_hex_then_char and io__get_dec_then_char, EOF
> > > for the 'then_char' part would be more consistent. I'd tried to keep
> > > the names short and have a load bearing comment, which isn't ideal but
> > > generally I believe the style is that function names are kept short.
> > > Let me know what you think.
> >
> > I'm ok with the function name and understand your concerns.
> > And I don't want to insist it strongly but just sharing my thoughts.
> >
> > Thanks
> > Namhyung
>
> Thanks, feedback appreciated! It is useful to discuss and it is
> straightforward to change the API but I'm in two minds as to whether
> it would be better.
>
> I'd still like to land this and the next patch, as getting rid of
> fgets/sscanf saves 50us from event synthesis. Breaking out the io part
> of that change wasn't done so much with a view to replacing stdio, but
> just something minimal that serves the /proc/pid/maps case.

The performance gain looks nice!  Thanks for working on this.

Thanks
Namhyung
