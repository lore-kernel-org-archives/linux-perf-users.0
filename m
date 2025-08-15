Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD5211F;
	Fri, 15 Aug 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289052; cv=none; b=sbMPDP2WWNzTovU9M8uaVujB5mnkJpJOWTHqDSX6oq39DvBqX2f6ilOszOdR3yWVHB9+CsdWK8B2Uw5yNNkaUaobF8IFDcCIGsA2y9gA1ja5qxy5u4MUH12L99qi8+5Fu65ER7vGeNqRhvfII7GCmSVuAAZ1N9ocGUsSe6qw4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289052; c=relaxed/simple;
	bh=8VAkT1fdVJlMR9/yh9YtINjkt/+BYWKwDDnCKDrIz+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM02aiPyVzaPJy3eY3DZWTJKdk6uTiy5nsZt8+3u5ePKnVqWCWAvZOIo5K+mSbbtjnfuT/NOD8YG/Zz9ZOq6S9WTAFcLKXxCKycYd7HAiJJTGdNiX0inylzK+n4Ohkxlk7afoq/sbhyCOU/clzdDzwQ6HXU3o4/I5qYHgEo0s+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hssiF0UA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hssiF0UA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867CC4CEEB;
	Fri, 15 Aug 2025 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755289051;
	bh=8VAkT1fdVJlMR9/yh9YtINjkt/+BYWKwDDnCKDrIz+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hssiF0UAhc4FgcChBwGSfo6ur/j5WaUdoPBYlSc/8iVmOH+KCT+s5QwTKQO5Qksab
	 gbsCF/RJOqu8yP5iPDyPBGww71pgukw/LHDFeu+k53fmob2Dmo6QGtzt6TfAHgl3+x
	 /AcEM6L6xnWingS2uD+Lhs0sdkJ03Im26iChI+VS0D6jM3CBo9tLjU1yZUR8Dh3Dlw
	 9cEOKm2L6FZQqCb4a0ubjvBDDv0MpH7AcHPzyeIEaivky/Cl4TLeRsFL9SWvMFYQrF
	 Xz2Ekf1CNpFlwgZqh+QjtJaOervtz8jQRzVzJEJELlYBRUV5F69OsZNtFR8VS0cjck
	 JGeRNUZdsHxPA==
Date: Fri, 15 Aug 2025 13:17:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tamas Zsoldos <tamas.zsoldos@arm.com>
Subject: Re: [PATCH] perf session: Fix handling when buffer exceeds 2 GiB
Message-ID: <aJ-V2ZsYpN8RDQ3M@google.com>
References: <20250808-perf_fix_big_buffer_size-v1-1-45f45444a9a4@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808-perf_fix_big_buffer_size-v1-1-45f45444a9a4@arm.com>

On Fri, Aug 08, 2025 at 02:24:40PM +0100, Leo Yan wrote:
> If a user specifies an AUX buffer larger than 2 GiB, the returned size
> may exceed 0x80000000. Since the err variable is defined as a signed
> 32-bit integer, such a value overflows and becomes negative.
> 
> As a result, the perf record command reports an error:
> 
>   0x146e8 [0x30]: failed to process type: 71 [Unknown error 183711232]
> 
> Change the type of the err variable to a signed 64-bit integer to
> accommodate large buffer sizes correctly.
> 
> Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
> Fixes: d5652d865ea7 ("perf session: Add ability to skip 4GiB or more")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 26ae078278cd67fc5894c01cbb44c4b8fa81321a..09af486c83e4ff82e74f17f3da08d3bc3989768b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1402,7 +1402,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  	const struct perf_tool *tool = session->tool;
>  	struct perf_sample sample;
>  	int fd = perf_data__fd(session->data);
> -	int err;
> +	s64 err;
>  
>  	perf_sample__init(&sample, /*all=*/true);
>  	if ((event->header.type != PERF_RECORD_COMPRESSED &&
> 
> ---
> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
> change-id: 20250808-perf_fix_big_buffer_size-e28f618df61c
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
