From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH 02/12] perf auxtrace: Include missing asm/bitsperlong.h to
 get BITS_PER_LONG
Date: Tue, 9 Oct 2018 10:43:56 +0200
Message-ID: <a73e3b15-cff3-312a-8345-c5b14dce070f@nokia.com>
References: <20181009005427.6607-1-acme@kernel.org>
 <20181009005427.6607-3-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-3-acme@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Hi!

On 09/10/2018 02:54, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The auxtrace.h header references BITS_PER_LONG without including the
> header where it is defined, getting it by luck from some other header,
> fix it.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-v04ydmbh7tvpcctf3zld9j9s@git.kernel.org

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/auxtrace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 0a6ce9c4fc11..d88f6e9eb461 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -23,6 +23,7 @@
>  #include <linux/list.h>
>  #include <linux/perf_event.h>
>  #include <linux/types.h>
> +#include <asm/bitsperlong.h>
>  
>  #include "../perf.h"
>  #include "event.h"
> 

-- 
Best regards,
Alexander Sverdlin.
