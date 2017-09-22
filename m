From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/4] Makes all those related functions receive the FILE
 pointer
Date: Fri, 22 Sep 2017 11:03:19 +0200
Message-ID: <20170922090319.GF15856@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:20PM +0800, yuzhoujian wrote:
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/builtin-script.c | 247 ++++++++++++++++++++++++--------------------
>  1 file changed, 136 insertions(+), 111 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 91b5225..f709f6f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -486,8 +486,8 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  	return 0;
>  }
>  
> -static void print_sample_iregs(struct perf_sample *sample,
> -			  struct perf_event_attr *attr)
> +static void fprint_sample_iregs(struct perf_sample *sample,
> +			  struct perf_event_attr *attr, FILE *fp)

please make sure the perf gets compiled after every change,
I think this will break compile because of unused *fp,
use the __maybe_unused attribute

jirka
