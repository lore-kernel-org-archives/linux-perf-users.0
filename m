Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACABB667;
	Tue,  5 Nov 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765528; cv=none; b=UuHVgkehMOJEKplKrWKRTuw/fh6dQGtesu9kkWGI/gctVlBG+nNJ71TnLSml8dJpHBzpzVDLbLDPu9PSj1lYkQSFiDOhHqoGOhrI1doOGEMW8f14XIOrX2SwAih13vcdoh10WYY3yvYcAhr8NAMcqcAAKlecqm/yN+G6etM3yvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765528; c=relaxed/simple;
	bh=w7D1Hj3ipxcnW2gjAuaYHySmVpmD4euqpzkiW/spD5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6kvuB/IszKNgtZGjjl5bgkQT9XVqk3ogD6V36RdK/7kdZ/nUgKfhwQVPTg6dAkLnu3e8H1r83yg0bBFuc4egTw4+8FLESDej9006K8uqNyZzzCv4oZbJYKTNY2k70dnzjWugiwfa5TwTRGw18seJvButy1tI7+hSsJ5Rh0PBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcOM/gr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcOM/gr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41CFC4CECE;
	Tue,  5 Nov 2024 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730765527;
	bh=w7D1Hj3ipxcnW2gjAuaYHySmVpmD4euqpzkiW/spD5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcOM/gr+EwjXicV1S9H4Wjli8ALlc9StWLjoHjMzcjuDS+FPMf5wjmZno2Qpa8pnX
	 FnA5yWS7UiHQYuv0JwCckghrwx0MwZzGKnThuex3yl+eN3HTdEpWCzrgE5Xx6hMGaq
	 0qb7D8MIZ4wyG1g7YCZdLY0x1YrT0HevP6K+c5g6ifR9IscdkOTcgyksWBZjMdOs+m
	 Y0nplmIw7uIO5Tz5ELKKM0aw1CPgu+/nZwRcAjt0HfMohq2Clc2uycjF0U2WeX+HZ5
	 ETPCqbk6fdPOoIDtlCXRrAAHY8BW3lZaWtCamCi+dPOvodf3Vucxps85ABSmSZNoh5
	 yQ4vbzS5HdYAw==
Date: Mon, 4 Nov 2024 16:12:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf: Reveal PMU type in fdinfo
Message-ID: <Zyli1TWn8ZaNWSxm@google.com>
References: <20241101211757.824743-1-ctshao@google.com>
 <20241101211757.824743-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101211757.824743-2-ctshao@google.com>

On Fri, Nov 01, 2024 at 09:17:56PM +0000, Chun-Tse Shao wrote:
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add extra attributes which would be useful.
> 
> ```
> Testing cycles
> $ ./perf stat -e cycles &
> $ cat /proc/`pidof perf`/fdinfo/3
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    3081
> perf_event-attr.type:   0

Maybe 'perf_event_attr' would be appropriate as it's the name of the
struct.

> perf_event-attr.config: 0
> perf_event-attr.config1:        0
> perf_event-attr.config2:        0
> perf_event-attr.config3:        0

It's hard to pick which fields to show here but I'd say that those
config[123] are not used frequently at least for regular events.
Maybe just showing type and config is fine.

> 
> Testing L1-dcache-load-misses//
> $ ./perf stat -e L1-dcache-load-misses &
> $ cat /proc/`pidof perf`/fdinfo/3
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    1072
> perf_event-attr.type:   3
> perf_event-attr.config: 65536
> perf_event-attr.config1:        0
> perf_event-attr.config2:        0
> perf_event-attr.config3:        0
> ```
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  kernel/events/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

FYI usually the kernel changes are applied to a different tree than the
tools.

> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cdd09769e6c56..c950b6fc92cda 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -55,6 +55,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/buildid.h>
>  #include <linux/task_work.h>
> +#include <linux/seq_file.h>
> 
>  #include "internal.h"
> 
> @@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp, int on)
>  	return 0;
>  }
> 
> +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct perf_event *event = f->private_data;
> +
> +	seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
> +	seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.config);

I'm not sure if all archs are happy with treating it as %llu.

Thanks,
Namhyung


> +	seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.config1);
> +	seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.config2);
> +	seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.config3);
> +}
> +
>  static const struct file_operations perf_fops = {
>  	.release		= perf_release,
>  	.read			= perf_read,
> @@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops = {
>  	.compat_ioctl		= perf_compat_ioctl,
>  	.mmap			= perf_mmap,
>  	.fasync			= perf_fasync,
> +	.show_fdinfo		= perf_show_fdinfo,
>  };
> 
>  /*
> --
> 2.47.0.163.g1226f6d8fa-goog
> 
