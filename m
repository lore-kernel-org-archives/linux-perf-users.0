From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf report: fix off-by-one for non-activation frames
Date: Mon, 19 Jun 2017 15:59:39 -0300
Message-ID: <20170619185939.GA2170@redhat.com>
References: <20170515150444.6841-1-milian.wolff@kdab.com>
 <CAM9d7cjqZpuxPmARtp_Zy_PhZ+Gpt7Px_ecsLe=dhguNsYW1Bw@mail.gmail.com>
 <20170617080402.GA1402@host1.jankratochvil.net>
 <1916323.ygRLzu1ryd@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1916323.ygRLzu1ryd@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Sat, Jun 17, 2017 at 01:13:11PM +0200, Milian Wolff escreveu:
> On Samstag, 17. Juni 2017 10:04:02 CEST Jan Kratochvil wrote:
> > On Sat, 17 Jun 2017 09:56:57 +0200, Namhyung Kim wrote:
> > > Not sure whether it needs be fixed or not.  If we fix it, srcline and
> > > address would not match so it can give its own confusion to users.
> > > Ideally it should display an addressof the instruction before the
> > > address IMHO.
> > 
> > One can figure million ways how it can behave and each one has its pros and
> > cons.  I was just describing the current behavior of GDB and LLDB which
> > people are used to already.
> 
> Personally, I agree with Jan that we should mimick existing tool's behavior. I 
> just fear that it's not trivial to do it with the current code base...

But we agree it is a worthwhile change (have backtraces in perf match
what gdb, etc show), right?

If you can, please try to do this, your attempt will help us understand
more the extent of the changes needed and perhaps someonw can come up
with simplifications...

- Arnaldo
