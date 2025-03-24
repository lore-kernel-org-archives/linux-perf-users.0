Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD614658D;
	Mon, 24 Mar 2025 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742860727; cv=none; b=O/2WKse9raoL+ke4X33JgG3bVyL1XbzE51VJveLCq0yRLxM1yvooOBtx5h1fvbLM7QQXz5nCJyy+t+9ugzVHHTjrDB2sJUh97z23gkqHhuIs5zwFLvWCiPhss7bH22pu3tvrPkG2K4Os+lstpAcN1jvpBNmtvDZH5/voWcuh6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742860727; c=relaxed/simple;
	bh=1OAba6xZgT26nihaaZhzNyeN6c4f+/Pf4pmZvl349LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJPiJ2Mo+sgaoaNWiXXogDIhultiU0s6NozHVafK6fhuI5l4z0SwgcMce1N8n07Grm2BqKddl+3CrzoQZAgvedarG6uxksMLuws/Yn9TtooPUfYHia3xmb1X1+LJjl3qnJ1ELU/iLuCoBUAAOzG/xGGCJiGk7gjqOCde6hIGNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAwDxLlB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAwDxLlB"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223a7065ff8so25730235ad.0;
        Mon, 24 Mar 2025 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742860724; x=1743465524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVOXMIH/0fBT/Jprf9dWY2GcvLQefs99A976BzEg7aU=;
        b=TAwDxLlB///LKlOh1MtZTSK5XnVxMmfHzkzHsRGqPQHpspX++rW1cVI6z+U7rUwDAt
         8pEFnBAWY1xiczf8kD2kcSo9oT9RO6li4V9uMd/2ljuRP+ppgS9JURjSF8ZbalFyIv6w
         lvxoT/m2zFv+v7pzWOAn6dLrI//Y8Jk+Z3haxYKuhphVlSfMifUKElDoSHSI1c42w+y6
         3IJgEbxNKNeTUi1TkA97LAIo2RKiRin1naMaWliO+RYjhJUT+rhR2QuBF2GaGDk6MB54
         9P8oBQlhedu8FnM8OMuj0TYrkO0tOPSM9PpjMzmdNiQC2CXJgK0cHaG1dY1LqxcSppnQ
         338A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742860724; x=1743465524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVOXMIH/0fBT/Jprf9dWY2GcvLQefs99A976BzEg7aU=;
        b=XyIABvdYE7Sr/Hy/5KuiQs99/6CHI1WZ0S3XZIyTDgfQMPB1JmaoXm3tpBfbttrY2X
         CTRfzbN9hcP+ziq6bsu7THt9vKFAS3u201EqMgZxbNU18hNy9vUMbbUCXtYm2nvDWPxx
         cEzzoQP/eer79CVM1ZMMBp83Uo+0H2kaSEjzVweplpLn5Mq1STvQ14Wn0QAjH3augbFT
         EcRd4mSQ81BGdFtIHiT2YI+QnBAIx7gDxvZHlTHCoT+p969bvUu766c6ieTEneocVTBz
         xzcAsWrOZZ326R8BEjyhihYraUGsmxu2SAyUUVW/CI0u1tEcUNQgeS7neM0muFJdPvqT
         5X5A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/rV1H/qUy5R9+hQ4JDfz2rxaP719VEeMZRynbF+PCYGxazdOtkc4lgsLbhtiE08ESNS25FKuN4/Sx/U=@vger.kernel.org, AJvYcCWgOctwm+rpr5rdgaS4dsvOINf4zZWRabJHhmJuhhen9tmgj2Abeu6X7tnwjsVsXslfFYD6ppCd6gF7CfXVu4kqhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRFzduVZlTrKe22TUU1qL4Ka7Pi5jv/nO/gjSa+huyJPcd6II
	wkvqAjgkRncGIIN5ZFR2mG0QQpuOBiVVzjlnvKkxBGDmv4NrqLOAkQYYuvUm
X-Gm-Gg: ASbGncsDGjPdCJOmzT43YBgbZ6CsdY9zhiXggdzTSiY4b4gQ4Eqyg/v47IYgmxeLezf
	RHLD4w1LyiKGSOWdlHI1K2FYrzRGOK1j5XpDYELldD9QmVwtTvX+X988zVdnbJRJkrAVAdKweLS
	Amhr1l+B7b78vFluIX3Z58JWSLB/rUD4w9XLkoTW16M4CCHYMcdb1ummBF7bskFUKXfeXNeN1Zv
	DX5WtNPHOhv53eneYbXY1MNEkXMh2QiZgvXv1MbGCdm5Ji88Kl4HOm2sG3oJrqgsmSOvY6Udg+F
	C+5/Bzsjz9usZfodtHa3GrFQXz3zQYmzCCq277mIS6+quLEOqd0lssESMC8PhPu3wcFSdcCLiX5
	/Mx0=
X-Google-Smtp-Source: AGHT+IHHkZk++M+VzY5yje5Z9GoISl071IMJ960KpJg4kK+PHqYrTe8NUo0qX8yRqm3pCRv6iXxlVw==
X-Received: by 2002:a17:902:e748:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22780c79ef5mr185870745ad.16.1742860724234;
        Mon, 24 Mar 2025 16:58:44 -0700 (PDT)
Received: from gmail.com (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4a670sm77288975ad.86.2025.03.24.16.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 16:58:43 -0700 (PDT)
Date: Mon, 24 Mar 2025 16:58:41 -0700
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix possible insufficient allocation of
 argument formats
Message-ID: <Z-HxsV8KyeTWeskb@gmail.com>
References: <20250324235245.613063-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324235245.613063-1-howardchu95@gmail.com>

Hello,

Forgot to add, there should be:

Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds")

Thanks,
Howard

On Mon, Mar 24, 2025 at 04:52:45PM -0700, Howard Chu wrote:
> In my previous fix of runtime error(Link:
> https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),
> I made a mistake of decrementing one unconditionally, regardless of
> whether an extra 'syscall_nr' or 'nr' field was present in
> libtraceevent's tp_format. This may cause perf trace to allocate one
> fewer arg_fmt entry than needed for the accurate representation of syscall
> arguments.
> 
> This patch corrects the mistake by checking the presence of'syscall_nr' or
> 'nr', and adjusting the length of arg_fmt[] accordingly.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a102748bd0c9..ad6dad8e2453 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2139,6 +2139,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  	char tp_name[128];
>  	const char *name;
>  	int err;
> +	bool extra_nr = false;
>  
>  	if (sc->nonexistent)
>  		return -EEXIST;
> @@ -2176,20 +2177,22 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  		return err;
>  	}
>  
> +	sc->args = sc->tp_format->format.fields;
> +	if (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc->args->name, "nr"))
> +		extra_nr = true;
>  	/*
>  	 * The tracepoint format contains __syscall_nr field, so it's one more
>  	 * than the actual number of syscall arguments.
>  	 */
> -	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
> +	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - (extra_nr ? 1 : 0)))
>  		return -ENOMEM;
>  
> -	sc->args = sc->tp_format->format.fields;
>  	/*
>  	 * We need to check and discard the first variable '__syscall_nr'
>  	 * or 'nr' that mean the syscall number. It is needless here.
>  	 * So drop '__syscall_nr' or 'nr' field but does not exist on older kernels.
>  	 */
> -	if (sc->args && (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc->args->name, "nr"))) {
> +	if (sc->args && extra_nr) {
>  		sc->args = sc->args->next;
>  		--sc->nr_args;
>  	}
> -- 
> 2.45.2
> 
