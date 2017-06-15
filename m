From: Jan Kratochvil <jan.kratochvil@redhat.com>
Subject: Re: [PATCH 1/2] perf report: ensure the perf DSO mapping matches
 what libdw sees
Date: Thu, 15 Jun 2017 22:38:24 +0200
Message-ID: <20170615203824.GA5513@host1.jankratochvil.net>
References: <20170602143753.16907-1-milian.wolff@kdab.com>
 <20170605104130.GB28871@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170605104130.GB28871@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, 05 Jun 2017 12:41:30 +0200, Jiri Olsa wrote:
> On Fri, Jun 02, 2017 at 04:37:52PM +0200, Milian Wolff wrote:
> > Debug output showed me that libdw found a module for the last frame
> > address, but it thinks it belongs to /usr/lib/ld-2.25.so.

I find your patch as a correct workaround of an elfutils bug.
I have filed it as:
	dwfl_addrmodule reports bogus modules for unmapped areas
	https://sourceware.org/bugzilla/show_bug.cgi?id=21602


Thanks,
Jan
