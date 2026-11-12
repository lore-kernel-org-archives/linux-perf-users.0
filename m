Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466419;
	b=Xtz3OhTVulmRsQwEMRadNrkQp2jP5SkP+L9800mfAb3SKnhIWNLEI7NYeBjZkaacd9r3
	 QDAAoiB+RkeVefgS3tQb/uGJakEuEHg3hr0/cd+VEnz71+AAVfuhCCUzJoQ55TTdPdZfs
	 jirBCRoEKx35kgy0HOLYSnQrHt6rhp5fEiE81X5m0yTt4i6tZ34mTtKc56s3BXymX+LRA
	 TcbJnURVqegwurUeY3rXjo9Jy18jHAnWgqMRINTS40OUWXWK1S4mzM4uY2/hU4kjbgpj2
	 i5tna+d+tg25BTkqhKTs0AX/2aurn3GfS3KtyPUeFyD0xdPJQjaNMaGyrTs9MO6cCVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2C15/fxBQilv0ryUTn6SGBSxxdO9hnpv3AE8T89y6Xw=;
	b=fXSbwidFfOmA4hiCyMdAI7jXSUZswpfXiFqs5y/+NZckRTkYiSqUiM4sMZKu7mWFl4JK
	 aYlsg3NVDIK5ZKT37qnjxYUWJjiw6tZmAuRe770A437nEBqXVwYMMYN/EIqcMyypJzch0
	 x4cirHVFrfHZUgXnU+uP/0foCCZ8lxsgnx6YfaMkt8u36J5KWqNzdgWTbMfvtpC6AAxoO
	 fXPOkH/NS8tX8W59oH6UyOO0deqW7kJv76MNihKgKo/xg/Hd1DYfrpfov2ha3Ler47uPz
	 N0U6Ry9/vxVAwAgD4zdPiFg3d02nfl8JhllFwDLsyR0UCpcLe8CWJiV/7i/r88rstdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuJNAYA4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12894606A323;
	Thu, 12 Nov 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuJNAYA4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90C11F00A05;
	Thu, 12 Nov 2026 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794466418;
	bh=2C15/fxBQilv0ryUTn6SGBSxxdO9hnpv3AE8T89y6Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MuJNAYA4bgtMpP065/mgbayWF6j9x1ESPDiw4APg4kCzWYTPg0EX/HNq/WHOPgH/S
	 Ueua4Q1vbHbW2ngkWmYhSQtmLvyo5swd5sDFpks7rA7CzPU8SHkX55ZjDNZQCjV7Zd
	 vGdW8XCme6sKK0YXdOMwCGfK51V7CTo3EffioFQhAJlbKiEmwiRoTulync8yDSophv
	 kh8lSq32K/sQ8D88aiZCf6i4CD3AERwtYhy1dOV7TvIhoymTeR04wcA+p5F+HH5EbU
	 OrhKRpEwi2PJBW8L91bSVDpDJ0AKigHLJw+DaKvlTa8mYy1x5ekbzPGfXExp+Qy0uo
	 geBeca96v4QqA==
Date: Wed, 11 Nov 2026 22:53:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v12 12/20] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Message-ID: <avVicOfEPnzFYChm@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-13-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111174213.3526604-13-irogers@google.com>

On Wed, Nov 11, 2026 at 09:42:04AM -0800, Ian Rogers wrote:
> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.c  | 16 +++++++++++++++-
>  tools/perf/util/dso.h  |  1 +
>  tools/perf/util/dsos.c | 10 ++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index f0e02062c09c..4dc518f7cb7d 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1685,6 +1685,18 @@ const struct dso_id dso_id_empty = {
>  	}
>  };
>  
> +bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id)
> +{
> +	const struct dso_id *dso_id = dso__id_const(dso);
> +
> +	if (!id)
> +		return false;
> +
> +	return (id->mmap2_valid && !dso_id->mmap2_valid) ||
> +	       (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) ||
> +	       (build_id__is_defined(&id->build_id) && !build_id__is_defined(&dso_id->build_id));

Don't we prefer build-ID over inode?  I'm curious if it needs to check
existing build-ID is defined first and return true.  Any chance it'd
overwrite a build-ID with an inode?

Thanks,
Namhyung


> +}
> +
>  void __dso__improve_id(struct dso *dso, const struct dso_id *id)
>  {
>  	struct dsos *dsos = dso__dsos(dso);
> @@ -1692,6 +1704,8 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
>  	bool changed = false;
>  
>  	/* dsos write lock held by caller. */
> +	if (!id)
> +		return;
>  
>  	if (id->mmap2_valid && !dso_id->mmap2_valid) {
>  		dso_id->maj = id->maj;
> @@ -1715,7 +1729,7 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
>  
>  int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
>  {
> -	if (a == &dso_id_empty || b == &dso_id_empty) {
> +	if (!a || !b || a == &dso_id_empty || b == &dso_id_empty) {
>  		/* There is no valid data to compare so the comparison always returns identical. */
>  		return 0;
>  	}
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 9e38b3b69e9b..df1748763d95 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -802,6 +802,7 @@ void dso__delete(struct dso *dso);
>  int dso__cmp_id(struct dso *a, struct dso *b);
>  void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
>  void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
> +bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id);
>  void __dso__improve_id(struct dso *dso, const struct dso_id *id);
>  
>  int dso__name_len(const struct dso *dso);
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index fbbf98c4ccae..1b3f8b84ed30 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -349,6 +349,16 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
>  struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
>  {
>  	struct dso *dso;
> +
> +	down_read(&dsos->lock);
> +	dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/false);
> +	if (dso && !dso__needs_improve_id(dso, id)) {
> +		up_read(&dsos->lock);
> +		return dso;
> +	}
> +	up_read(&dsos->lock);
> +	dso__put(dso);
> +
>  	down_write(&dsos->lock);
>  	dso = __dsos__findnew_id(dsos, name, id);
>  	up_write(&dsos->lock);
> -- 
> 2.56.0.542.g3ef89b7020-goog
> 
