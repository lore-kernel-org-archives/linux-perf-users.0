Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD943009D5;
	Fri, 12 Sep 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701595; cv=none; b=r+/m6S+LOl9VDzhqvTfDY/M9mATWkzWkhnb4oYflPELXubW1j5SSJT6ONANMd/ph5klgNEF/54s1qKq/MjuJbgrpjELBdPI+lTj/JiMiY37ReH2OGRMXtyPHAlCWa742OIqL0ui4BGwpOKGlI9z9fP5Gl1tMa+dLIisG3p918kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701595; c=relaxed/simple;
	bh=mKTknIgSPUqsrwIiWh/K+IeP3nmG0ppoBFpLjSD6lCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqmoSqkCBhbeL85+iWNMlLoX3XPZMw8xcViws67Dk4Q6ieysb5IdOzoyn3Y4q9uE8waPxEarBTPqKQXCXOwCR6LZIrd3pHbB6LV6nL1kJii56bSlTRK+/wmMKg7v7dYwwWbv0gh2jNdA9Iyj3HavSPdWafJnRyHGZae9ol0ryOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijjYQ2Rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijjYQ2Rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECFEC4CEF1;
	Fri, 12 Sep 2025 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757701595;
	bh=mKTknIgSPUqsrwIiWh/K+IeP3nmG0ppoBFpLjSD6lCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijjYQ2RcMC4T9u5DQ43YRyCUEsiErCnGGA/kyBIfHiBAjOW4xyzxf3z8RtsbNh2WE
	 dXpjbwqVRo/p9ecAkrnUDJzdshpN0xo3CxpsyNNwvx61tAnCXt8uYj7AUgd9MW1J/8
	 Zl0Pi3TBdSq5N6GiO15NktuCbeiMHKhctXCWCAhQG+r/sNIb/p1lv+0t2+4zGleO2+
	 SoGY8cgOCBin/HawFC/rt/XuMeQHKyAT4dInmw2zzJOQ5ipNp7tiazA5aRqegqiok+
	 OJPEpHdjv/APTJ/ntGh8fqu4BigLK11RSQsJZVnUpCsCBPAGlKlCF7tqkm5IknV+7P
	 o68+hvUjGR83A==
Date: Fri, 12 Sep 2025 15:26:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: zhaoguohan@kylinos.cn
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] perf drm_pmu: fix fd_dir leaks in
 for_each_drm_fdinfo_in_dir()
Message-ID: <aMRl2AvE3LnAYesL@x1>
References: <20250908065203.22187-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908065203.22187-1-zhaoguohan@kylinos.cn>

On Mon, Sep 08, 2025 at 02:52:03PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> Fix file descriptor leak when callback function returns error. The
> function was directly returning without closing fdinfo_dir_fd and
> fd_dir when cb() returned non-zero value.

Thanks, applying to perf-tools-next.

- Arnaldo
 
> Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM information")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
> v2 -> v3: replaced "cleanup" with "close_fdinfo"
> v1 -> v2: Added the Fixes tag in commit message
> ---
>  tools/perf/util/drm_pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> index 988890f37ba7..98d4d2b556d4 100644
> --- a/tools/perf/util/drm_pmu.c
> +++ b/tools/perf/util/drm_pmu.c
> @@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
>  		}
>  		ret = cb(args, fdinfo_dir_fd, fd_entry->d_name);
>  		if (ret)
> -			return ret;
> +			goto close_fdinfo;
>  	}
> +
> +close_fdinfo:
>  	if (fdinfo_dir_fd != -1)
>  		close(fdinfo_dir_fd);
>  	closedir(fd_dir);
> -- 
> 2.43.0
