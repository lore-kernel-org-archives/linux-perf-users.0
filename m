Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076337;
	b=HKK1ujSyQ7bBs+h0nkO1xZQVJI45T0eZECHFZ8r8/WY7EiznGz29XeCGNuVkF5bh21v0
	 e6yMRaNS9cyo1OtO4BWFz3S43jyEtd9jipkYKyo63h36kAh5AYiLgcKzGZfIwYUMxz73L
	 6ptCnwKkOM0D6Mgkd4zwRahIF4a5yuUilmmRUKNXRwnS3PMH1zF/0Df2+dzFwmkiNL0+q
	 yHyZClByR8yDaoyeck83M0qcjbLkv6GrDjUaNrM28eWd/ij7YIlvnTCjXqeExzB8lVtQe
	 uHRanjktw+7LWxuzb2hYsFBgELWFBliaNMAxB0/rzY8fT87TRmRqqtSwrwJ2rwRB11Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076337;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4cXxTBE1n6aLX5qjX8/TE1/ng5L5mp36kcbFtMPayoM=;
	b=l/LDqJ3mYfJBLVvYdKjIpH6zGyv21wTeCawTWJf/N9WwvTNdq1xngwBAZhBBRBJ+9aJK
	 ldPjn55X9u2U6ViwzYC9InDSjNKM8slYD4jFUrTVF3ZyEwF0qMsec4RIQBXt++dAaQbQC
	 kxJv1OfjdqUoCJQ9hIgppahY+6t6D9BWtTbJ+rrIMjgE3cQO+mymRoqxEunNIE2YLDI1W
	 PijnN9d1ORFNRvxnKQUAmOCXvq9X2qFkCWKEeMeRdSejjLP/cHAMtn6nBGiLIu0BCz9a7
	 aoyoDKX7VZMcoryWGbf0TL5yr0u3JO5RGRpitbeuAsY2WDkpPhcCo0E0WoOsIPiBi8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mccz34nn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A39606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mccz34nn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83261F000C4;
	Thu, 19 Nov 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795076336;
	bh=4cXxTBE1n6aLX5qjX8/TE1/ng5L5mp36kcbFtMPayoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mccz34nnhQwlMaHHkWpn2WzXWNnDF7jMTAh8z9T8AzpItD9ow/G/poX5/RGD2SgH3
	 C/a/8qD8fP5nVZByaf9s5fguPhxLv0+OaU0M5Vk043kp/CeicyZ1Xg2Xdkwbz9O+YL
	 B060p/crukfh5SC1/xrUtmi26zp+icO1v6EZ0CG1EHV8LEb4Aq2Hsy9NYc6THnZnHd
	 /w+nY9y5sPwtkA7lgK4nJH4iCNSiQrzmjCt5hqcLaK+2FOAOTE8/pasr/hxafO6ylX
	 EFQdYFoZGUasVGvPbH9ZWdRZ4GMYHkSB20TOASP5JQNUlt0CYMMfak/6GcUOxyOvLE
	 gRXA8YNzL+CjA==
Date: Thu, 19 Nov 2026 00:18:55 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: ORTOLA =?utf-8?Q?Rapha=C3=ABl?= <raphael.ortola@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC] perf docs: build only the declared manual section
Message-ID: <av6w7-WZbFp444bR@google.com>
References: <CACzNvX6qkkd-QgJzcQquHS6XiKacMqb85JeLC8LmfLTeWqu4EQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzNvX6qkkd-QgJzcQquHS6XiKacMqb85JeLC8LmfLTeWqu4EQ@mail.gmail.com>

Hello,

On Thu, Nov 12, 2026 at 02:24:29PM -0600, ORTOLA Raphaël wrote:
> Hello,
> 
> While building Ubuntu linux 7.3.0-9.9, GNU make 4.4.1 reports that the
> perf manual rules do not update their .5 and .7 peer targets. The
> implicit multi-target rules promise all three sections for each input,
> whereas XMLto and Asciidoctor emit the section declared by that input.
> 
> The proposed change uses the existing DOC_MAN1/DOC_MAN5/DOC_MAN7 lists
> with static pattern prerequisites and one recipe per backend. The
> shared asciidoc.conf prerequisite is moved after those rules so that
> $< remains the manual input rather than the configuration file.
> USE_ASCIIDOCTOR selects the two alternative backends.
> 
> Checks on this downstream source:
> - Before: the native XMLto build reports missing .5/.7 peer targets.
> - After: all 41 native XMLto manuals build without warnings.
> - Additional section 5 and 7 fixture manuals build with XMLto.
> - Asciidoctor 2.0.26 with Ruby 3.3.8 generates section 1, 5 and 7
> fixture manuals without warnings, using explicit ASCIIDOC_EXTRA
> backend flags.
> 
> This is an RFC for the documentation rules; it is not a claim of a
> completed kernel build or testing on current upstream master. Please
> review the proposed fix below.

Thanks for the patch.  I'm not familiar with this area but I guess it
removes some unnecessary steps during the manual build?  Should be ok
unless it changes any outputs.

Can you please send a formal patch with your Sign off?

Thanks,
Namhyung


> 
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -174,7 +174,6 @@
> 
>  html: $(DOC_HTML)
> 
> -$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
> 
>  man: man1 man5 man7
>  man1: $(DOC_MAN1)
> @@ -259,17 +258,26 @@
>                      --date=short --no-show-signature $<)))
> 
>  ifdef USE_ASCIIDOCTOR
> -$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
> +$(DOC_MAN1): $(OUTPUT)%.1: %.txt
> +$(DOC_MAN5): $(OUTPUT)%.5: %.txt
> +$(DOC_MAN7): $(OUTPUT)%.7: %.txt
> +$(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7):
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>  	$(ASCIIDOC) -b manpage -d manpage \
>  		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
>  		-adocdate=$(PERF_DATE) -o $@+ $< && \
>  	mv $@+ $@
> -endif
> -
> -$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
> +else
> +
> +$(DOC_MAN1): $(OUTPUT)%.1: $(OUTPUT)%.xml
> +$(DOC_MAN5): $(OUTPUT)%.5: $(OUTPUT)%.xml
> +$(DOC_MAN7): $(OUTPUT)%.7: $(OUTPUT)%.xml
> +$(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7):
>  	$(QUIET_XMLTO)$(RM) $@ && \
>  	$(XMLTO) -o $(OUTPUT). -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +endif
> +
> +$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
> 
>  $(OUTPUT)%.xml : %.txt
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
