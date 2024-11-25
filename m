Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087A364D6;
	Mon, 25 Nov 2024 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732515282; cv=none; b=jzyE1qOQXh+idf11HBLZuznSQ0+eFU5HVwxiiKRAF7e6OZX9iVE7rEGxgHHxWL+QrCzUzD7S/rPgLNsBEYkhu41l3WWhbE4f4ZgSCyS3t5GU0p39Bjku9SGK9DAHSe5dxIsPDwKQdbybVFcPgIRfTn+LM8IypMlekcu/pJpTHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732515282; c=relaxed/simple;
	bh=ZwinL8/1U53BksoUcwrkFOscCyNv4jQRQn8e4Z7FM/c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iXApOBcmFuKIg1kiMKKUB5vH5pEg5oLDxI+tBc1YaCjSKtBjjDUr5ayg+hlcQB3ig846jdKdzE558f6G7PtzEL9DLPvmsCrTpAmU6wVWZpaJ5Okw8X+MHoanQjQopCOT9Ol0ms6fDW87XJD5UZTggOVlmYBmoQND2YuriY2ZEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPmTpsZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPmTpsZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AEEC4CECE;
	Mon, 25 Nov 2024 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732515281;
	bh=ZwinL8/1U53BksoUcwrkFOscCyNv4jQRQn8e4Z7FM/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPmTpsZz9Z/TG2HE4ihMvas4pho6Wg5xUfeiWyhwkPdStPe6cRF8QpawUX2YLE1JY
	 tMdWP8HEkVAP9Tz4D7oljmepnoSOkvuk9eQFWi7fQC4zBOr0gDtTSiVnJK52ToaoQs
	 4EqoQcNfqjAPT8ZJU8OZlI2+go6s0N+RwTNQQ7TnWzs5IRipONxCMR+9tVJRegwdJB
	 lWIk45XMod5RGPP6PwWBmsg/ZOXgOvnMLIhZijD+waH/SHESna6eS3pxtbzQ+XoIlA
	 rSnFbkh5arENyhHbJ+4UWBiGH0LxZEcc1Yv8rtaMXBhO4iCmHcIp9spkL3atgkI9+6
	 hJXbU8xTGcEzQ==
Date: Mon, 25 Nov 2024 15:14:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <namhyung@kernel.org>, <mark.rutland@arm.com>,
 <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
 <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <dima@secretsauce.net>,
 <aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf probe: Clear all structure fields in
 clear_perf_{probe, trace}_event()
Message-Id: <20241125151437.9cb726157de25cfba0a44665@kernel.org>
In-Reply-To: <20241114105451.90273-1-lihuafei1@huawei.com>
References: <20241114105451.90273-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 18:54:51 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> I added two probe events:
> 
>   # perf probe -f -a schedule+8
>   Added new event:
>     probe:schedule       (on schedule+8)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:schedule -aR sleep 1
> 
>   # perf probe -f -a schedule+20
>   Added new event:
>     probe:schedule_1     (on schedule+20)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:schedule_1 -aR sleep 1
> 
> However, 'perf probe -l' shows the same offset:
> 
>   # perf probe -l
>     probe:schedule       (on schedule+8@kernel/sched/core.c)
>     probe:schedule_1     (on schedule+8@kernel/sched/core.c)
> 
> __show_perf_probe_events() does not clean up the 'pev' content when
> parsing the rawlist. If the 'pev->offset' is not set while processing
> the next probe event string, the offset value of the previous event will
> be used.  After adding debug information, it was found that indeed there
> was line number information when processing 'probe:schedule_1', so the
> offset was not set and used the offset from 'probe:schedule'.
> 
> To fix this, clear all the fields of the structures in
> clear_perf_{probe, trace}_event(). not just the allocated fields.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
> Changes in v2:
>  - Do the cleanup in clear_perf_{probe, trace}_event().
>  - Refine the subject and the commit log.
> 
> v1: https://lore.kernel.org/lkml/20241108181909.3515716-1-lihuafei1@huawei.com/
> ---
>  tools/perf/util/probe-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a17c9b8a7a79..47903bb56fc6 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2376,8 +2376,8 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
>  			field = next;
>  		}
>  	}
> -	pev->nargs = 0;
>  	zfree(&pev->args);
> +	memset(pev, 0, sizeof(*pev));
>  }
>  
>  #define strdup_or_goto(str, label)	\
> @@ -2475,7 +2475,7 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
>  		}
>  	}
>  	zfree(&tev->args);
> -	tev->nargs = 0;
> +	memset(tev, 0, sizeof(*tev));
>  }
>  
>  struct kprobe_blacklist_node {
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
