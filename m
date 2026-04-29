Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08023A6411;
	Wed, 29 Apr 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446510; cv=none; b=fiL8R+zpGk0nasVE8g4byRdFiNxJvlWPmiROz333HkDop/1qT9xEOKSYiPTOwHMW2bXPP0f7yw+yJ5GeqZInX8WzM64htz0idJ5lq/h9J3wnb0cORJfFYJA4snMiiOtLBxhyssVuN382hGwb4ZOzviEUydmP0Gk4e02aDYBtv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446510; c=relaxed/simple;
	bh=xzf3jDb9geA3dFUjFfPguBRjQRDomeV6ObB0wINZalE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7wUTbrIs5ov1t1d0lmw0xvymJTq0SfYNPuAZ+hUmSs3lS/zttSbnymPbznhAlshGiQhumAz1IiZNHagFhSzeHkaQXnL3qbsZb+7OJ6T6WfKl9Q6PXRXutABhH9YWfXUhca4R37xo9bgY3wQcqxvUKqM6g1giL23Rj+aDo2s6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrXvBnVq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrXvBnVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03515C2BCC6;
	Wed, 29 Apr 2026 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777446510;
	bh=xzf3jDb9geA3dFUjFfPguBRjQRDomeV6ObB0wINZalE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrXvBnVqhSEcru+ida6yeaq29fsRfpdCwSmfZhRUCu7paHArurk7TddV+cSRxv64X
	 7VsIVPKD51v1+BcACw1SN22fqck7/4SQiTt7bsodNtX/gRSxizO93s9YIb5U9ZZTQL
	 f2UB/WpEuO7RMvFuLKzhHwudSEfuhsYRrSi3v8zFo4llTccyYlJ4LzrkAUJkFy8Mh7
	 SZmk1AyLZGEe19jHL5ggfIAOiFsxwRMka1OGSdh7xBphutGogF6uiu0IHK14fMFh2M
	 Tf4VMX8NsRxKwAKQY249eu7PX/lJ20L0oMPVZZ++67MjYATzi4PgvfIFP+fYjQ188f
	 xcRLKi2UGliTA==
Date: Wed, 29 Apr 2026 00:08:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v8 08/58] perf data: Add open flag
Message-ID: <afGubL9LrZKEJBH6@z2>
References: <20260425224951.174663-1-irogers@google.com>
 <20260428071903.1886173-1-irogers@google.com>
 <20260428071903.1886173-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428071903.1886173-9-irogers@google.com>

On Tue, Apr 28, 2026 at 12:18:13AM -0700, Ian Rogers wrote:
> Avoid double opens and ensure only open files are closed. This
> addresses some issues with python integration where the data file
> wants to be opened before being given to a session.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changes in v2:
> 
> 1. Fixed File Rotation: In perf_data__switch() , I added data->open =
>    false; after the file is closed. This ensures that the subsequent
>    perf_data__open() call will not exit early and will successfully
>    open the new file.
> 
> 2. Fixed Memory Leak: In open_dir() , I added a call to
>    zfree(&data->file.path) if mkdir() fails, preventing the leak of
>    the path string.
> ---
>  tools/perf/util/data.c | 26 ++++++++++++++++++++++----
>  tools/perf/util/data.h |  4 +++-
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a7386..17baf71897d1 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -346,8 +346,10 @@ static int open_dir(struct perf_data *data)
>  		return -1;
>  
>  	if (perf_data__is_write(data) &&
> -	    mkdir(data->path, S_IRWXU) < 0)
> +	    mkdir(data->path, S_IRWXU) < 0) {
> +		zfree(&data->file.path);
>  		return -1;
> +	}
>  
>  	ret = open_file(data);
>  
> @@ -360,9 +362,16 @@ static int open_dir(struct perf_data *data)
>  
>  int perf_data__open(struct perf_data *data)
>  {
> -	if (check_pipe(data))
> +	int ret;
> +
> +	if (data->open)
>  		return 0;
>  
> +	if (check_pipe(data)) {
> +		data->open = true;
> +		return 0;
> +	}
> +
>  	/* currently it allows stdio for pipe only */
>  	data->file.use_stdio = false;
>  
> @@ -375,16 +384,24 @@ int perf_data__open(struct perf_data *data)
>  	if (perf_data__is_read(data))
>  		data->is_dir = is_dir(data);
>  
> -	return perf_data__is_dir(data) ?
> -	       open_dir(data) : open_file_dup(data);
> +	ret = perf_data__is_dir(data) ? open_dir(data) : open_file_dup(data);
> +
> +	if (!ret)
> +		data->open = true;
> +
> +	return ret;
>  }
>  
>  void perf_data__close(struct perf_data *data)
>  {
> +	if (!data->open)
> +		return;
> +
>  	if (perf_data__is_dir(data))
>  		perf_data__close_dir(data);
>  
>  	perf_data_file__close(&data->file);
> +	data->open = false;
>  }
>  
>  static ssize_t perf_data_file__read(struct perf_data_file *file, void *buf, size_t size)
> @@ -457,6 +474,7 @@ int perf_data__switch(struct perf_data *data,
>  
>  	if (!at_exit) {
>  		perf_data_file__close(&data->file);
> +		data->open = false;
>  		ret = perf_data__open(data);
>  		if (ret < 0)
>  			goto out;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 8299fb5fa7da..76f57f60361f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -50,6 +50,8 @@ struct perf_data {
>  	const char		*path;
>  	/** @file: Underlying file to be used. */
>  	struct perf_data_file	 file;
> +	/** @open: Has the file or directory been opened. */
> +	bool			 open;
>  	/** @is_pipe: Underlying file is a pipe. */
>  	bool			 is_pipe;
>  	/** @is_dir: Underlying file is a directory. */
> @@ -59,7 +61,7 @@ struct perf_data {
>  	/** @in_place_update: A file opened for reading but will be written to. */
>  	bool			 in_place_update;
>  	/** @mode: Read or write mode. */
> -	enum perf_data_mode	 mode;
> +	enum perf_data_mode	 mode:8;
>  
>  	struct {
>  		/** @version: perf_dir_version. */
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
