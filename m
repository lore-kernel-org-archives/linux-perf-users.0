From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/4] Add the fp_selection_helper function to set the file
 pointer for the related functions
Date: Fri, 22 Sep 2017 11:03:27 +0200
Message-ID: <20170922090327.GG15856@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-4-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505714122-39141-4-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:21PM +0800, yuzhoujian wrote:
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/builtin-script.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index f709f6f..89bab68 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1527,6 +1527,13 @@ static int cleanup_scripting(void)
>  	return scripting_ops ? scripting_ops->stop_script() : 0;
>  }
>  
> +static FILE *fp_selection_helper(bool per_event_dump)
> +{
> +	if (per_event_dump == false)
> +		return stdout;
> +	else
> +		return per_event_dump_file;

when's the per_event_dump_file ever set? 

jirka
