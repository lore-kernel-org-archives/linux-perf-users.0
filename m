Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA4145B0F;
	Wed,  7 Aug 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074777; cv=none; b=DxOPeYSygZMhbVSHhFIOLm9vpJLEVv8IwBC7KaOK7pXKJ1oRRKaT6Fl7G5YAb70iFYnrjlW4qLEd1Felr4mR+JmfNxlIoRR01XiiYi2SAVtcV5P7ToTcPTF+5xEfuRFeYTbnLBQYgo5bVIw1BZnqSlLC22I3qMXkq2qunayKpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074777; c=relaxed/simple;
	bh=uzVsJuCix+UZD2X1hZ44hFcHSZGxTwvDOwV3zE11SjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKjXVqq/kT8HVGPO/1avCUIlb/+AL5lbBmtclp3ffqeqZKWHQHiUoXx7qx465q1SEBg/0XN4MYohjUFfdLY1B8oSGfYHUKTlkv5IAC6xhpD3oUZBiOB+fPUd2Td2gQwJIbRHeIzuAQDW64IT2kiB91SQAhsYsLlAIljdJWnrUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUTzyUWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUTzyUWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FD9C32781;
	Wed,  7 Aug 2024 23:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074776;
	bh=uzVsJuCix+UZD2X1hZ44hFcHSZGxTwvDOwV3zE11SjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUTzyUWTBEf9VMmvrBNitbtpaA3Gm2DHXc1RBhITmey20FRVkGkcUyyU2je2ohvIx
	 55qsUiBjSN3tfCnaJDRUdthYtEkpJg0RwkXESJu1tKKtnO2YL6RvjdKhCqkMg1fDo7
	 uTCp/T9tSq+plY90Bd1DuKW1nE/fpK5H+JxkI0IFqdGUCdtPn2v277rEviehzGXndl
	 wSjRRbR+3r+JI88BuKwrwzuRuIWIAaWBDWSbu7o8SXAipi3HdM9ymcMYe+PqAmYxrd
	 MsMljNnqsh68XQyXvVVk0fuHXu7I3AWpyj+biX6O2sVCwda7zmAqaPQG+Gqb+MN8VU
	 acPylerBRtmqA==
Date: Wed, 7 Aug 2024 16:52:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] perf header: Add field 'embed'
Message-ID: <ZrQI1w1B3hnWbd6j@google.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-9-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807153843.3231451-9-howardchu95@gmail.com>

On Wed, Aug 07, 2024 at 11:38:42PM +0800, Howard Chu wrote:
> We have to save the embedded data's sample type for it to be consumed
> correctly by perf script or perf report.
> 
> This will approach most definitely break some perf.data convertor.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/header.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 55e9553861d0..d60e77d5c25c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -80,6 +80,7 @@ const char perf_version_string[] = PERF_VERSION;
>  
>  struct perf_file_attr {
>  	struct perf_event_attr	attr;
> +	__u64 embed;

Can we just set bpf_output.attr correctly and get rid of this?

Thanks,
Namhyung


>  	struct perf_file_section	ids;
>  };
>  
> @@ -3713,6 +3714,7 @@ static int perf_session__do_write_header(struct perf_session *session,
>  		}
>  		f_attr = (struct perf_file_attr){
>  			.attr = evsel->core.attr,
> +			.embed = evsel->sample_type_embed,
>  			.ids  = {
>  				.offset = evsel->id_offset,
>  				.size   = evsel->core.ids * sizeof(u64),
> @@ -4147,6 +4149,14 @@ static int read_attr(int fd, struct perf_header *ph,
>  
>  		ret = readn(fd, ptr, left);
>  	}
> +
> +	ret = readn(fd, &f_attr->embed, sizeof(f_attr->embed));
> +	if (ret <= 0) {
> +		pr_debug("failed to read %d bytes of embedded sample type\n",
> +			 (int)sizeof(f_attr->embed));
> +		return -1;
> +	}
> +
>  	/* read perf_file_section, ids are read in caller */
>  	ret = readn(fd, &f_attr->ids, sizeof(f_attr->ids));
>  
> @@ -4272,6 +4282,8 @@ int perf_session__read_header(struct perf_session *session, int repipe_fd)
>  		tmp = lseek(fd, 0, SEEK_CUR);
>  		evsel = evsel__new(&f_attr.attr);
>  
> +		evsel->sample_type_embed = f_attr.embed;
> +
>  		if (evsel == NULL)
>  			goto out_delete_evlist;
>  
> -- 
> 2.45.2
> 
