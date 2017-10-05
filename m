From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/1] perf callchain symbol resolving fix
Date: Thu, 5 Oct 2017 20:07:52 +0200
Message-ID: <20171005180752.4rnwpo2bs2ryvwkw@gmail.com>
References: <20171005175913.16513-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54725 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdJESH5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Oct 2017 14:07:57 -0400
Content-Disposition: inline
In-Reply-To: <20171005175913.16513-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Pozdneev <pozdneyev@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Yao Jin <yao.jin@linux.intel.com>, zhangmengting@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 1addcd55bc54d669000221b41e379458ff3e6747:
> 
>   Merge tag 'perf-urgent-for-mingo-4.14-20170928' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-09-29 19:31:46 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.14-20171005
> 
> for you to fetch changes up to c1fbc0cf81f1c464f5fda322c1104d4bb1da6711:
> 
>   perf callchain: Compare dsos (as well) for CCKEY_FUNCTION (2017-10-05 10:52:54 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fix:
> 
> . Two functions from different binaries can have same start address. Thus,
>   comparing only start address in match_chain() leads to inconsistent
>   callchains. Fix this by adding a check for dsos as well (Ravi Bangoria)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Ravi Bangoria (1):
>       perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
> 
>  tools/perf/util/callchain.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Pulled, thanks a lot Arnaldo!

	Ingo
