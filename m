Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FA153BEF;
	Thu, 29 Aug 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959874; cv=none; b=c59nqqelbg3SNaSyaeRtDx0HxXU4BrqTZA+91xmcavPD5lbel2+/pYy7kFqY6iW0naaHinQBphG63CwXjC98f/IyrNsxT5c5kpBD/Ev+GhqSdt0eRszVJPLD3mFo+oNs8h81mS3JWCMrdKAnf/Zi8NE3wZb1wqqxYak0gPsSrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959874; c=relaxed/simple;
	bh=jaWM1/Q2WvERtXFvVclFMGAGVW84dcMNz5kthTljwq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jir1c4JfekOooVVW93LwISQFKtmLEkHFcVBzl0at5Jnl8iRyAwLNZPbTGqzNm2enHBNlLj8dAGlfsc8T0bza/ECnLJsOWyX+rhc933qO9JNuLgfAeKqO9ssHTZB28MBbN/jsYEtCB7NtobfcukV/aM09I1QRLquU5uGN2Mu0Zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdG3DQ8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdG3DQ8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C87C4CEC1;
	Thu, 29 Aug 2024 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959874;
	bh=jaWM1/Q2WvERtXFvVclFMGAGVW84dcMNz5kthTljwq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdG3DQ8FPsThDy8uJx+6l0ekKHn91P6FIhtGXlcGG77IQEUw26U+1q6oH3NnBJ8NI
	 WH8Ui2Cp4ZOhS7o+Jqtaxx6gXEpb+bftI2Gc585E3UR+NroRPzBpuF1htL0AP8yFQ/
	 huDXI9+QbLogvOvt9b8h2TG5er/jaOPd9Ct5RE/p96XCig2OC7BLb76uysFEV8elq3
	 I17GyLUJ3WC2WhwqmEBtv7YnVzyEOvgxghgRal6mC1QCcqiGt/ntV6t8XVN/LVS11y
	 ZY3JvHXv+y8oJcCTg5fULU4YzfnKw/0E8Ql2tAVQOSWZMWGjLkHNVvI3rpFU3Idoq3
	 JDuVN1dxVTRyA==
Date: Thu, 29 Aug 2024 16:31:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after
 data
Message-ID: <ZtDMf886_1vXWt49@x1>
References: <20240829150154.37929-1-irogers@google.com>
 <20240829150154.37929-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829150154.37929-6-irogers@google.com>

On Thu, Aug 29, 2024 at 08:01:51AM -0700, Ian Rogers wrote:
> With a file, to write data an offset needs to be known. Typically data
> follows the event attributes in a file. However, if processing a pipe
> the number of event attributes may not be known. It is convenient in
> that case to write the attributes after the data. Expand
> perf_session__do_write_header to allow this when the data offset and
> size are known.
> 
> This approach may be useful for more than just taking a pipe file to
> write into a data file, `perf inject --itrace` will reserve and
> additional 8kb for attributes, which would be unnecessary if the
> attributes were written after the data.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c | 106 +++++++++++++++++++++++++--------------
>  1 file changed, 67 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 65c9086610cb..4eb39463067e 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3676,32 +3676,50 @@ int perf_header__write_pipe(int fd)
>  static int perf_session__do_write_header(struct perf_session *session,
>  					 struct evlist *evlist,
>  					 int fd, bool at_exit,
> -					 struct feat_copier *fc)
> +					 struct feat_copier *fc,
> +					 bool write_attrs_after_data)
>  {
>  	struct perf_file_header f_header;
> -	struct perf_file_attr   f_attr;
>  	struct perf_header *header = &session->header;
>  	struct evsel *evsel;
>  	struct feat_fd ff = {
>  		.fd = fd,
>  	};
> -	u64 attr_offset;
> +	u64 attr_offset = sizeof(f_header), attr_size = 0;
>  	int err;
>  
> -	lseek(fd, sizeof(f_header), SEEK_SET);
> +	if (write_attrs_after_data && at_exit) {
> +		/*
> +		 * Write features at the end of the file first so that
> +		 * attributes may come after them.
> +		 */
> +		if (!header->data_offset && header->data_size) {
> +			pr_err("File contains data but offset unknown\n");
> +			err = -1;
> +			goto err_out;
> +		}
> +		header->feat_offset = header->data_offset + header->data_size;
> +		err = perf_header__adds_write(header, evlist, fd, fc);
> +		if (err < 0)
> +			goto err_out;
> +		attr_offset = lseek(fd, 0, SEEK_CUR);
> +	} else {
> +		lseek(fd, attr_offset, SEEK_SET);
> +	}
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
> -		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
> -		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
> -		if (err < 0) {
> -			pr_debug("failed to write perf header\n");
> -			free(ff.buf);
> -			return err;
> +		evsel->id_offset = attr_offset;
> +		/* Avoid writing at the end of the file until the session is exiting. */
> +		if (!write_attrs_after_data || at_exit) {
> +			err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
> +			if (err < 0) {
> +				pr_debug("failed to write perf header\n");
> +				goto err_out;
> +			}
>  		}
> +		attr_offset += evsel->core.ids * sizeof(u64);

So in the past we were using lseek(fd, 0, SEEK_CUR) to set the
evsel->id_offset, now you're assuming that do_write will honour the size
parameter, i.e. write evsel->core.ids * sizeof(u64), but:

/* Return: 0 if succeeded, -ERR if failed. */
int do_write(struct feat_fd *ff, const void *buf, size_t size)
{
        if (!ff->buf)
                return __do_write_fd(ff, buf, size);
        return __do_write_buf(ff, buf, size);
}

And then:

static int __do_write_fd(struct feat_fd *ff, const void *buf, size_t size)
{
        ssize_t ret = writen(ff->fd, buf, size);

        if (ret != (ssize_t)size)
                return ret < 0 ? (int)ret : -1;
        return 0;
}

I see that writen calls ion that even has a BUG_ON() if it doesn't write
exactly the requested size bytes, I got distracted with __do_write_fd
extra check that ret != size returning ret if not negative...

I.e. your code _should_ be equivalent due to the check in ion(), and
taking that as an assumption you reduce the number of lseek syscalls,
which is a good thing...

I was just trying to see that the !write_attrs_after_data case was
_exactly_ the same as before, which it doesn't look like it is :-\

- Arnaldo

>  	}
>  
> -	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
> -
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
>  			/*
> @@ -3711,40 +3729,46 @@ static int perf_session__do_write_header(struct perf_session *session,
>  			 */
>  			evsel->core.attr.size = sizeof(evsel->core.attr);
>  		}
> -		f_attr = (struct perf_file_attr){
> -			.attr = evsel->core.attr,
> -			.ids  = {
> -				.offset = evsel->id_offset,
> -				.size   = evsel->core.ids * sizeof(u64),
> +		/* Avoid writing at the end of the file until the session is exiting. */
> +		if (!write_attrs_after_data || at_exit) {
> +			struct perf_file_attr f_attr = {
> +				.attr = evsel->core.attr,
> +				.ids  = {
> +					.offset = evsel->id_offset,
> +					.size   = evsel->core.ids * sizeof(u64),
> +				}
> +			};
> +			err = do_write(&ff, &f_attr, sizeof(f_attr));
> +			if (err < 0) {
> +				pr_debug("failed to write perf header attribute\n");
> +				goto err_out;
>  			}
> -		};
> -		err = do_write(&ff, &f_attr, sizeof(f_attr));
> -		if (err < 0) {
> -			pr_debug("failed to write perf header attribute\n");
> -			free(ff.buf);
> -			return err;
>  		}
> +		attr_size += sizeof(struct perf_file_attr);
>  	}
>  
> -	if (!header->data_offset)
> -		header->data_offset = lseek(fd, 0, SEEK_CUR);
> +	if (!header->data_offset) {
> +		if (write_attrs_after_data)
> +			header->data_offset = sizeof(f_header);
> +		else
> +			header->data_offset = attr_offset + attr_size;
> +	}
>  	header->feat_offset = header->data_offset + header->data_size;
>  
> -	if (at_exit) {
> +	if (!write_attrs_after_data && at_exit) {
> +		/* Write features now feat_offset is known. */
>  		err = perf_header__adds_write(header, evlist, fd, fc);
> -		if (err < 0) {
> -			free(ff.buf);
> -			return err;
> -		}
> +		if (err < 0)
> +			goto err_out;
>  	}
>  
>  	f_header = (struct perf_file_header){
>  		.magic	   = PERF_MAGIC,
>  		.size	   = sizeof(f_header),
> -		.attr_size = sizeof(f_attr),
> +		.attr_size = sizeof(struct perf_file_attr),
>  		.attrs = {
>  			.offset = attr_offset,
> -			.size   = evlist->core.nr_entries * sizeof(f_attr),
> +			.size   = attr_size,
>  		},
>  		.data = {
>  			.offset = header->data_offset,
> @@ -3757,21 +3781,24 @@ static int perf_session__do_write_header(struct perf_session *session,
>  
>  	lseek(fd, 0, SEEK_SET);
>  	err = do_write(&ff, &f_header, sizeof(f_header));
> -	free(ff.buf);
>  	if (err < 0) {
>  		pr_debug("failed to write perf header\n");
> -		return err;
> +		goto err_out;
> +	} else {
> +		lseek(fd, 0, SEEK_END);
> +		err = 0;
>  	}
> -	lseek(fd, header->data_offset + header->data_size, SEEK_SET);
> -
> -	return 0;
> +err_out:
> +	free(ff.buf);
> +	return err;
>  }
>  
>  int perf_session__write_header(struct perf_session *session,
>  			       struct evlist *evlist,
>  			       int fd, bool at_exit)
>  {
> -	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
> +	return perf_session__do_write_header(session, evlist, fd, at_exit, /*fc=*/NULL,
> +					     /*write_attrs_after_data=*/false);
>  }
>  
>  size_t perf_session__data_offset(const struct evlist *evlist)
> @@ -3793,7 +3820,8 @@ int perf_session__inject_header(struct perf_session *session,
>  				int fd,
>  				struct feat_copier *fc)
>  {
> -	return perf_session__do_write_header(session, evlist, fd, true, fc);
> +	return perf_session__do_write_header(session, evlist, fd, true, fc,
> +					     /*write_attrs_after_data=*/false);
>  }
>  
>  static int perf_header__getbuffer64(struct perf_header *header,
> -- 
> 2.46.0.295.g3b9ea8a38a-goog
