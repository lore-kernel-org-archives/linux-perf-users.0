From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Date: Thu, 6 Jun 2019 15:15:04 -0300
Message-ID: <20190606181504.GD21245@kernel.org>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org>
 <20190606144614.GC12056@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606144614.GC12056@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: ufo19890607 <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jun 06, 2019 at 04:46:14PM +0200, Jiri Olsa escreveu:
> On Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > So that the user don't try using:

> >     pref record --user-callchains --kernel-callchains

> > expecting to get both user and kernel callchains and instead gets
> > nothing.
 
> good catch.. we should add the logic to keep both (default)
> in this case.. so do nothing ;-)

Yeah, not using both or using both should amount to the same behaviour.

Can be done with a patch on top of what I have in my tree now.

- Arnaldo
