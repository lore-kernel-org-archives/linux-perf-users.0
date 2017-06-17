From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf report: fix off-by-one for non-activation frames
Date: Sat, 17 Jun 2017 13:13:11 +0200
Message-ID: <1916323.ygRLzu1ryd@agathebauer>
References: <20170515150444.6841-1-milian.wolff@kdab.com> <CAM9d7cjqZpuxPmARtp_Zy_PhZ+Gpt7Px_ecsLe=dhguNsYW1Bw@mail.gmail.com> <20170617080402.GA1402@host1.jankratochvil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170617080402.GA1402@host1.jankratochvil.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kratochvil <jan.kratochvil@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Samstag, 17. Juni 2017 10:04:02 CEST Jan Kratochvil wrote:
> On Sat, 17 Jun 2017 09:56:57 +0200, Namhyung Kim wrote:
> > Not sure whether it needs be fixed or not.  If we fix it, srcline and
> > address would not match so it can give its own confusion to users.
> > Ideally it should display an addressof the instruction before the
> > address IMHO.
> 
> One can figure million ways how it can behave and each one has its pros and
> cons.  I was just describing the current behavior of GDB and LLDB which
> people are used to already.

Personally, I agree with Jan that we should mimick existing tool's behavior. I 
just fear that it's not trivial to do it with the current code base...

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
