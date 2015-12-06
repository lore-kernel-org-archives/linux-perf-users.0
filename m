From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] perf test: Introducing new testsuite
Date: Sun, 6 Dec 2015 16:55:52 +0100
Message-ID: <20151206155552.GC11852@krava.brq.redhat.com>
References: <1449249082.24573.185.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbbLFPzy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Dec 2015 10:55:54 -0500
Content-Disposition: inline
In-Reply-To: <1449249082.24573.185.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Fri, Dec 04, 2015 at 06:11:22PM +0100, Michael Petlan wrote:

SNIP

>  tools/perf/testsuite/common/init.sh                |  67 ++++++
>  tools/perf/testsuite/common/parametrization.sh     |  32 +++
>  tools/perf/testsuite/common/patterns.sh            | 117 +++++++++++
>  tools/perf/testsuite/common/settings.sh            |  57 +++++
>  61 files changed, 3145 insertions(+)

this is too big to review in single patch ;-)

please separate this under multiple patches, like:
  - base
  - test 1
  - test 2
  ...

ot something like that, that makes sense

jirka
