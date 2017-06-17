From: Jan Kratochvil <jan.kratochvil@redhat.com>
Subject: Re: perf report: fix off-by-one for non-activation frames
Date: Sat, 17 Jun 2017 10:04:02 +0200
Message-ID: <20170617080402.GA1402@host1.jankratochvil.net>
References: <20170515150444.6841-1-milian.wolff@kdab.com>
 <5576772.scvU8aRrkq@agathebauer>
 <20170616115744.GA14948@host1.jankratochvil.net>
 <31894796.cyPb9Arfxd@agathebauer>
 <CAM9d7cjqZpuxPmARtp_Zy_PhZ+Gpt7Px_ecsLe=dhguNsYW1Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752301AbdFQIEJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Jun 2017 04:04:09 -0400
Content-Disposition: inline
In-Reply-To: <CAM9d7cjqZpuxPmARtp_Zy_PhZ+Gpt7Px_ecsLe=dhguNsYW1Bw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>

On Sat, 17 Jun 2017 09:56:57 +0200, Namhyung Kim wrote:
> Not sure whether it needs be fixed or not.  If we fix it, srcline and
> address would not match so it can give its own confusion to users.
> Ideally it should display an addressof the instruction before the
> address IMHO.

One can figure million ways how it can behave and each one has its pros and
cons.  I was just describing the current behavior of GDB and LLDB which people
are used to already.


Jan
