From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 03/13] perf report: create real callchain entries for
 inlined frames
Date: Sun, 01 Oct 2017 10:40:37 -0700
Message-ID: <1506879637.2274.5.camel@perches.com>
References: <20170906135501.306-1-milian.wolff@kdab.com>
         <20170906135501.306-4-milian.wolff@kdab.com> <20170919122711.GA13388@krava>
         <1648232.PM1aBqIB3I@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1648232.PM1aBqIB3I@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Sun, 2017-10-01 at 14:37 +0200, Milian Wolff wrote:
> On Dienstag, 19. September 2017 14:27:11 CEST Jiri Olsa wrote:
[]
> > nit, think we prefer the /* */ comment style
> 
> I'll fix this, but note that there are more places outside this patch series 
> where this style has crept in. Some of them also from past patches of mine - 
> sorry for that.

I think c99 comments are fine.
So did Linus Torvalds.

http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html

> I looks to me as if the checkpatch.pl should catch this, but it doesn't for me 
> which is odd. Does anyone know what I need to do to enable the C99_COMMENTS 
> check?

Modify checkpatch

my $allow_c99_comments = 1;

change the 1 to 0

Add a runtime option if you want.
