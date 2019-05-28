From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 05/44] perf data: Fix 'strncat may truncate' build
 failure with recent gcc
Date: Tue, 28 May 2019 14:39:41 -0300
Message-ID: <20190528173941.GC2935@redhat.com>
References: <20190527223730.11474-1-acme@kernel.org>
 <20190527223730.11474-6-acme@kernel.org>
 <CA+49okqviNfP087Z34-P4mJuMYc8_PiNJgTPz0xSAxqtp4iM0A@mail.gmail.com>
 <20190528130421.GB13830@kernel.org>
 <CA+49okqAuPrs679GWQhxjyMn4mMhVSH_71Ww6rBbUjsrm2g-dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+49okqAuPrs679GWQhxjyMn4mMhVSH_71Ww6rBbUjsrm2g-dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Landden <slandden@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, May 28, 2019 at 11:59:10AM -0500, Shawn Landden escreveu:
> On Tue, May 28, 2019 at 8:04 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, May 27, 2019 at 05:46:26PM -0500, Shawn Landden escreveu:
> > > On Mon, May 27, 2019 at 5:38 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > From: Shawn Landden <shawn@git.icu>
> > > >
> > > > This strncat() is safe because the buffer was allocated with zalloc(),
> > > > however gcc doesn't know that. Since the string always has 4 non-null
> > > > bytes, just use memcpy() here.
> > > >
> > > >     CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
> > > >   In file included from /usr/include/string.h:494,
> > > >                    from /home/shawn/linux/tools/lib/traceevent/event-parse.h:27,
> > > >                    from util/data-convert-bt.c:22:
> > > >   In function ‘strncat’,
> > > >       inlined from ‘string_set_value’ at util/data-convert-bt.c:274:4:
> > > >   /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: error: ‘__builtin_strncat’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
> > > >     136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
> > > >         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Signed-off-by: Shawn Landden <shawn@git.icu>
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Wang Nan <wangnan0@huawei.com>
> > > > LPU-Reference: 20190518183238.10954-1-shawn@git.icu
> > > > Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.org
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > ---
> > > >  tools/perf/util/data-convert-bt.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> > > > index e0311c9750ad..9097543a818b 100644
> > > > --- a/tools/perf/util/data-convert-bt.c
> > > > +++ b/tools/perf/util/data-convert-bt.c
> > > > @@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
> > > >                                 if (i > 0)
> > > >                                         strncpy(buffer, string, i);
> > > >                         }
> > > > -                       strncat(buffer + p, numstr, 4);
> > > > +                       memcpy(buffer + p, numstr, 4);
> > > I took care to have enough context in my patch that you could see what
> > > was going on. I wonder if there is a way to make that care
> > > propate when people add Signed-off-by: lines.
> >
> > I just checked and the patch is the same, the description I only changed
> > the subject line, so that when one uses:

> Functionally, yes. However look at how my version has enough context
> that you can immediately know that the patch is correct (instead of
> the default of 5 lines):

Hey, you're talking about the _patch_ context?

I haven't touched that, just applied the patch and then run 'git request-pull',
and that will not consider at all the initial, non-default context the patch
author used when sending upstream :-)

Also, with the patch applied, one can always do:

[acme@quaco perf]$ git log --oneline torvalds/master.. | grep strncat
97acec7df172 perf data: Fix 'strncat may truncate' build failure with recent gcc
[acme@quaco perf]$ git show -U10 97acec7df172
commit 97acec7df172cd1e450f81f5e293c0aa145a2797
Author: Shawn Landden <shawn@git.icu>
Date:   Sat May 18 15:32:38 2019 -0300
<SNIP>
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index e0311c9750ad..9097543a818b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -264,21 +264,21 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
 
                        if (!buffer) {
                                buffer = zalloc(i + (len - i) * 4 + 2);
                                if (!buffer) {
                                        pr_err("failed to set unprintable string '%s'\n", string);
                                        return bt_ctf_field_string_set_value(field, "UNPRINTABLE-STRING");
                                }
                                if (i > 0)
                                        strncpy(buffer, string, i);
                        }
-                       strncat(buffer + p, numstr, 4);
+                       memcpy(buffer + p, numstr, 4);
                        p += 3;
                }
        }
 
        if (!buffer)
                return bt_ctf_field_string_set_value(field, string);
        err = bt_ctf_field_string_set_value(field, buffer);
        free(buffer);
        return err;
 }
[acme@quaco perf]$

Go bumping that -U10 value till you get the whole file 8-)

- Arnaldo


> https://www.spinics.net/lists/linux-perf-users/msg08563.html
> 
> >
> >    git log --oneline
> >
> > we can know what is the component and what kind of build failure was
> > that.
> >
> > - Arnaldo
> >
> > > >                         p += 3;
> > > >                 }
> > > >         }
> > > > --
> > > > 2.20.1
> > > >
> >
> > --
> >
> > - Arnaldo
