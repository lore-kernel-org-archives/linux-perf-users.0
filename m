Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEF170839;
	Fri, 10 May 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350873; cv=none; b=bQqLMbTgR2UbqbEWJ2CCu35Ch5BNHIwt7LWahXvfICKdv3ry2uKjEGv7EKDuJXN//yvr6YhUIZzD82H7se6XzJsM/ZKhdUCHGnh71YEIuRKZrBNmzrAofLnDh6/mo58bfdSDXp+cHCEPBo6d81kNHlecSTGMlN5gAsb3EGUJATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350873; c=relaxed/simple;
	bh=z8w1gqQixZgCovfhHB3pSvSB8T9+CM/mmdXFrbeLlM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkYUUt0gVIiKR+Ry5EuzSIaFeoIaYxgcMs8wZ63SoeC9NJZ6JFYlbGuC4BrWt2ZQi3pDBSyVy+sEzzmk7M4aEWAh0hRnEy99qfd/Va1iIhJM6iDOoqfGFgDlxISyKmWdunOLOTc6O0m+pnxwJ7AkM0e+6Q0hRyvoCpld8lE45Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpEJ5OGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpEJ5OGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70C2C113CC;
	Fri, 10 May 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715350872;
	bh=z8w1gqQixZgCovfhHB3pSvSB8T9+CM/mmdXFrbeLlM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpEJ5OGthkHzb0Yg0yKT0dzQQ9RWpVdZjkcn771CYuE94r+r2Lg7nPz4U5mKGObUt
	 dCXrDD1oMVT/1ULXFo1RijVpLmvR4SXVo26Ra/vzpXdAeTMktXmEpZvb/2GhPq45sM
	 CszVahHfzRmiscnkbWqE1ymPtGr20/oby7cJwNxLKmbgQC1cQXYj4/c2tb0WKMf4B8
	 lDumbB6m52sgoaAg8pzv4udw9e8wY3c6yYL2AylNyNRRViOHfJNXzL9jpTSEbChsAS
	 hENev/2ik+qSyIoJg+bd0vIpmlK6BvFuDbXUoFemDQuQwJnIyvt7Y4xIlPb9a/RKsp
	 gHZOEy2uFGSzg==
Date: Fri, 10 May 2024 11:21:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tracepoint: Don't scan all tracepoints to test
 if one exists
Message-ID: <Zj4tVDdY3CzU7KZM@x1>
References: <20240509060541.1928390-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509060541.1928390-1-irogers@google.com>

On Wed, May 08, 2024 at 11:05:41PM -0700, Ian Rogers wrote:
> In is_valid_tracepoint, rather than scanning
> "/sys/kernel/tracing/events/*/*" skipping any path where
> "/sys/kernel/tracing/events/*/*/id" doesn't exist, and then testing if
> "*:*" matches the tracepoint name, just use the given tracepoint name
> replace the ':' with '/' and see if the id file exists. This turns a
> nested directory search into a single file available test.
> 
> Rather than return 1 for valid and 0 for invalid, return true and
> false.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/tracepoint.c | 53 ++++++++++++++----------------------
>  tools/perf/util/tracepoint.h |  3 +-
>  2 files changed, 23 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
> index 92dd8b455b90..cca6808f7951 100644
> --- a/tools/perf/util/tracepoint.c
> +++ b/tools/perf/util/tracepoint.c
> @@ -4,10 +4,12 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <sys/param.h>
>  #include <unistd.h>
>  
>  #include <api/fs/tracing_path.h>
> +#include "fncache.h"
>  
>  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>  {
> @@ -26,39 +28,26 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>  /*
>   * Check whether event is in <debugfs_mount_point>/tracing/events
>   */
> -int is_valid_tracepoint(const char *event_string)
> +bool is_valid_tracepoint(const char *event_string)
>  {
> -	DIR *sys_dir, *evt_dir;
> -	struct dirent *sys_dirent, *evt_dirent;
> -	char evt_path[MAXPATHLEN];
> -	char *dir_path;
> -
> -	sys_dir = tracing_events__opendir();
> -	if (!sys_dir)
> -		return 0;
> +	char *dst, *path = malloc(strlen(event_string) + 4); /* Space for "/id\0". */
> +	const char *src;
> +	bool have_file;
>  
> -	for_each_subsystem(sys_dir, sys_dirent) {
> -		dir_path = get_events_file(sys_dirent->d_name);
> -		if (!dir_path)
> -			continue;
> -		evt_dir = opendir(dir_path);
> -		if (!evt_dir)
> -			goto next;
> -
> -		for_each_event(dir_path, evt_dir, evt_dirent) {
> -			snprintf(evt_path, MAXPATHLEN, "%s:%s",
> -				 sys_dirent->d_name, evt_dirent->d_name);
> -			if (!strcmp(evt_path, event_string)) {
> -				closedir(evt_dir);
> -				put_events_file(dir_path);
> -				closedir(sys_dir);
> -				return 1;
> -			}
> -		}
> -		closedir(evt_dir);
> -next:
> -		put_events_file(dir_path);
> +	if (!path) {
> +		/* Conservatively return false if memory allocation failed. */
> +		return false;
>  	}
> -	closedir(sys_dir);
> -	return 0;
> +	/* Copy event_string replacing the ':' with '/'. */
> +	for (src = event_string, dst = path; *src; src++, dst++)
> +		*dst = (*src == ':') ? '/' : *src;
> +	/* Add "/id\0". */
> +	memcpy(dst, "/id", 4);
> +
> +	dst = get_events_file(path);
> +	if (dst)
> +		have_file = file_available(dst);

If dst == NULL have_file isn't initialized?

> +	free(dst);
> +	free(path);
> +	return have_file;
>  }
> diff --git a/tools/perf/util/tracepoint.h b/tools/perf/util/tracepoint.h
> index c4a110fe87d7..65ccb01fc312 100644
> --- a/tools/perf/util/tracepoint.h
> +++ b/tools/perf/util/tracepoint.h
> @@ -4,6 +4,7 @@
>  
>  #include <dirent.h>
>  #include <string.h>
> +#include <stdbool.h>
>  
>  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
>  
> @@ -20,6 +21,6 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
>  		    (strcmp(sys_dirent->d_name, ".")) &&	\
>  		    (strcmp(sys_dirent->d_name, "..")))
>  
> -int is_valid_tracepoint(const char *event_string);
> +bool is_valid_tracepoint(const char *event_string);
>  
>  #endif /* __PERF_TRACEPOINT_H */
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
