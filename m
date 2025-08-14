Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352021885D;
	Thu, 14 Aug 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203463; cv=none; b=qPilpdW0JMFcfBFoUmbDKw1bR9tW36ADWkfE4oPXGAtbA8uPwL5oBJmul2FP33A/kgWi5hNum7FyX64S+LjXoJgYD4367KGkmn8IgYITIW9FKR0JpYElmcgtYK0gWkfJKaWYeKAlZscU4Vmfqkrh6ToHdh10o6WaI0p6q9aI2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203463; c=relaxed/simple;
	bh=GH+ORLO+cd0q3fcvJoAbTNAVWGAyts+GU//DlNdoQ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGDVyKSFO41Y/L8qyU48innj9VSiGT5yB6/+8qZdAFKHdZKK4u5NKPCYpbLpiClu/K6FJ5o3EZfXRGll/9/3Wm2kDqU2dff5FTDADYgfpr1Iu6wDOex3wfAgkJUvO5hdtTeSN3F/Hx9rT+MxWPgUsNdWrvODZfcfN8AizcNuXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWt/3yyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWt/3yyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A372C4CEED;
	Thu, 14 Aug 2025 20:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755203463;
	bh=GH+ORLO+cd0q3fcvJoAbTNAVWGAyts+GU//DlNdoQ+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWt/3yyAvjzJFR5iodQ8fLW2IMoO5aWcPMO/uNBW7B/7iT9QUKHr0KHKto5P7uZ6p
	 Ll3rgDl0BYrV4ugdxnA6+6P2ZQweFlSROsN770DJtRlzdpUevsjLxG5G1ONFRfThto
	 2DJP8T7dSZ6939gproOtyzXVSqIjKmyaWd5Sd/NT7oVwO6izMivbCr13z+ZPJM/m9R
	 ZI85SJ9MqTbwQIJbz4ry5+5+0DBwgSl4YrEEpQgMnwh1TIrrfK6sNaWd11Wcen/XcG
	 p1Lny4kzUIgI9n0WutHK0v9OriX6PPVa24RJLxeuGGPL1ziD8Y5r9VFHW8g8VPTIMX
	 0qLmZ/VzVOihA==
Date: Thu, 14 Aug 2025 13:31:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, colin.i.king@gmail.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf drm_pmu: Prevent resource leak in
 for_each_drm_fdinfo_in_dir()
Message-ID: <aJ5HhZsRPN-ZY_cK@google.com>
References: <20250814060614.450696-1-sperezglz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814060614.450696-1-sperezglz@gmail.com>

Hello,

On Thu, Aug 14, 2025 at 12:06:11AM -0600, Sergio Perez Gonzalez wrote:
> Close fdinfo_dir_fd and fd_dir prior to exit, in the event of
> cb() error.
> 
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Only a nitpick below.

> ---
>  tools/perf/util/drm_pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> index 988890f37ba7..416aeac7956e 100644
> --- a/tools/perf/util/drm_pmu.c
> +++ b/tools/perf/util/drm_pmu.c
> @@ -403,7 +403,7 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
>  	DIR *fd_dir;
>  	struct dirent *fd_entry;
>  	int fd_dir_fd, fdinfo_dir_fd = -1;
> -
> +	int ret = 0;
>  
>  	scnprintf(buf, sizeof(buf), "%s/fd", pid_name);
>  	fd_dir_fd = openat(proc_dir, buf, O_DIRECTORY);
> @@ -418,7 +418,6 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
>  		struct stat stat;
>  		unsigned int minor;
>  		bool is_dup = false;
> -		int ret;
>  
>  		if (fd_entry->d_type != DT_LNK)
>  			continue;
> @@ -458,12 +457,13 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
>  		}
>  		ret = cb(args, fdinfo_dir_fd, fd_entry->d_name);
>  		if (ret)
> -			return ret;
> +			goto out;

It could be just 'break'.

Thanks,
Namhyung


>  	}
> +out:
>  	if (fdinfo_dir_fd != -1)
>  		close(fdinfo_dir_fd);
>  	closedir(fd_dir);
> -	return 0;
> +	return ret;
>  }
>  
>  static int for_each_drm_fdinfo(bool skip_all_duplicates,
> -- 
> 2.43.0
> 
