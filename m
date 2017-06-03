From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH 1/2] perf report: ensure the perf DSO mapping matches what libdw sees
Date: Sat, 03 Jun 2017 13:36:13 +0200
Message-ID: <1795475.9e16bphl78@agathebauer>
References: <20170602143753.16907-1-milian.wolff@kdab.com> <13986004.8uJxbMKobt@agathebauer> <20170602194910.GB31764@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602194910.GB31764@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Freitag, 2. Juni 2017 21:49:10 CEST Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 02, 2017 at 06:21:44PM +0200, Milian Wolff escreveu:
> > On Freitag, 2. Juni 2017 17:23:41 CEST Arnaldo Carvalho de Melo wrote:
> > > Looks ok, having both implementations matching and the callchains making
> > > sense for your workloads is a good way to verify the sanity, thanks.
> > > 
> > > I wonder if we shouldn't somehow script this, i.e. build it with one
> > > implementation, generate output from some test workload, build it with
> > > the other, second output, diff it, report when not the same.
> > 
> > That does sound like a good idea, but I'm unsure how to do it. Note that
> > many "simple" tests work just fine. Only larger complicated workloads
> > trigger this issue for me.
> > 
> > One potential way to test it would be `perf archive` - i.e. I send you the
> > binaries involved and then we can use perf script diffing to ensure it all
> > works...
> 
> Humm, I'm trying to cook up a:
> 
>   perf data filter --pid 12345 --perf-data-offset 1234567 --output
> perf.data.subset
> 
> to allow when finding some case like that to get a small subset of a
> perf.data file with just the sample we want to get the backtrace from +
> the mmaps, etc up to that point.
> 
> With that I could keep a repo of interesting perf.data files to have in
> my regression tests.

How do I find the data offset to use here? If that works, I can provide you 
with one test file. But note how we'd also need the referenced mmap files. So 
it's going to be perf.data + perf archive.

Bye

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
