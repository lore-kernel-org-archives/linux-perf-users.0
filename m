Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5D8472;
	Thu,  9 Jul 2026 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555966; cv=none; b=orU4eng52gjcyiGcvT90epgg4BYLfO0Qdb0p0vHV1AE2tvXswPz+yEK2sZUAV9MdPPhwiiLje2jBHmPgZBA0htzOEsOHbn7JRqKIYfHtyGQsomwgwOA9bkkm4c0mdKrdqgMUN822IkBjlDmN1PNZBDpGD11UlqblP0lfqvJy6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555966; c=relaxed/simple;
	bh=2SrUnFQ+Iq4QQTlPRORTm0gea1YvEMBRSayL5FS8iM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8BYoU3TO6DTVo27dwoFgckY4fMtUcTfG0o0H051+3smnKrd63SvnMEIS3xPz64VS2Q6vOTUOBMzEY9oYc1M0CSWSNrU25H3AtcU9HriqsWgegMJQrdDYQ67bNuXiSWoX2wuJ3I821ouT7MfIaE7h21zTfksOCXkO/3nyL2plEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BowM4iRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BowM4iRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99881F000E9;
	Thu,  9 Jul 2026 00:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783555964;
	bh=mVaPWkfM3+lQKsJUn1vvSmp37AvlCC1+s+lUJmFmPIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BowM4iRG9s4l7Gq3VT2YtmCqoNDr5eMva4z9mWqWi7pG5ectMuxV1ci4LG1qm9YaF
	 apSb9sQb4lAiqZlHWv4AKSm+MIpLUPA0rTtbmAyyJGseG4iScYNsrkzpLRNVfPv5xl
	 3YG1PMr22Qu5S7LgYea+fBq7aMNJ/JYkpRVkQXMKZ8xeSQWUgSwL/KKt7f0OQibrUC
	 lYw3spRWLZXlbfzgxc/8bThsL8vOO3XBYtosuoHmsFBWddCrC3AJzox2A+/QKLYIPD
	 pgDrgzzPwo7qgj8F1cvwo+67ijYCHWs7/OujNS/kznbq6M+im7f+LCZJ4UyJ5RUgT2
	 5qqptZ+935GlQ==
Date: Wed, 8 Jul 2026 17:12:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Trevor Allison <tallison@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix LTO build of libperf-jvmti.so
Message-ID: <ak7neuxFS3ZuGL4F@google.com>
References: <20260701042145.71595-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701042145.71595-1-tallison@redhat.com>

Hello,

On Wed, Jul 01, 2026 at 12:21:45AM -0400, Trevor Allison wrote:
> Linking libperf-jvmti.so through jvmti-in.o (ld -r) breaks LTO when
> -flto is passed via LDFLAGS.  Link the JVMTI object files directly
> instead, and pass any LTO flags from LDFLAGS to the JVMTI compile step

Can you share the error message and put it in the commit message?

I think my build is fine with LDFLAGS=-flto.

Thanks,
Namhyung

> 
> Signed-off-by: Trevor Allison <tallison@redhat.com>
> ---
>  tools/perf/Makefile.perf | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 3f0544d37a7f..bc66d711fa39 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -686,10 +686,12 @@ ifndef NO_JVMTI
>  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
>  
>  $(LIBJVMTI_IN): prepare FORCE
> -	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
> +	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti \
> +		CFLAGS="$(CFLAGS) $(filter -flto% -ffat-lto-objects,$(LDFLAGS))"
>  
>  $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
> +	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ \
> +		$(addprefix $(OUTPUT)jvmti/,libjvmti.o jvmti_agent.o libstring.o libctype.o)
>  endif
>  
>  $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
> -- 
> 2.50.1 (Apple Git-155)
> 
