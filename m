From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf tools: Fix object code reading for PTI entry
 trampolines
Date: Tue, 5 Jun 2018 12:31:45 -0300
Message-ID: <20180605153145.GI4899@kernel.org>
References: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
 <20180605134142.GE4899@kernel.org>
 <00606a96-4e6b-6c98-c560-db722f4cd865@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00606a96-4e6b-6c98-c560-db722f4cd865@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 05, 2018 at 05:08:35PM +0300, Adrian Hunter escreveu:
> On 05/06/18 16:41, Arnaldo Carvalho de Melo wrote:
> > And this test fails way less often, but still does, for instance:

> > # while true ; do perf test -v object 2>out.txt ; grep -i fail out.txt && break ; done
> > dso__data_read_offset failed
> > Object code reading: FAILED!
> > #
> > [root@seventh ~]# tail out.txt 
> > File is: /proc/kcore
> > On file address is: 0x7fff892300df
> > kcore map tested already - skipping
> > Reading object code for memory address: 0x4a020f
> > File is: /home/acme/bin/perf (deleted)
> > On file address is: 0xa020f
> > dso__data_read_offset failed
> > test child finished with -1
> > ---- end ----
> > Object code reading: FAILED!
> > [root@seventh ~]#

> > I start that loop and then try running 'make -C tools/perf O=/tmp/build/perf install-bin',
> > to generate some load.

> So is it related to the "deleted" in "File is: /home/acme/bin/perf (deleted)"?

Probably, Jiri? Probably it'll be difficult to sort this out, as the
original for that file probably isn't available anymore and probably we
didn't had the opportunity to have already read its build-id to lookup
it in the ~/.debug/ cache... So probably we should notice that and skip
this, not considering it as an error?

- Arnaldo
