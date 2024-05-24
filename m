Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3281AA7
	for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538188; cv=none; b=SBuBrrEvz7ll2MYBxAMTdq66Lhn2eTzKzqgTmr3lVbDW2FFA7F82yqofTzd4ykLQF8JxMSIpiqtpfwNsR1Z7phmK8UyYlvqlNbmOg8InKQADnKz+N2IsPC0dG+iTRK+D3p8/7MJHrF67jCZjw+j9rCaJOOgHaOPxm7Dh9+d4Zqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538188; c=relaxed/simple;
	bh=M9VBoq6dREqgaOs5ZCoiH/xJnCr8Qi/PvPkkfAnMqT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuNDqXBR1ya8PlCrvERDN0dYuxdpJZZVeqIBBTmwObFZ92ShLGcj6pRHahLvX/yTzeVkVfiAZAm5fAAbsaCjKJ++Xrd5N8QVonPV2HkwRD0jDLQA+v44fo7u0/n1kKRf0Ew5x07C1DLSPhyQG5hiFAodIrvSgnGDAEwVvSAmeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkNSMJbO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkNSMJbO"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so97884991fa.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716538184; x=1717142984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2lSidCsB9ehXoWQ8boWr3QTXV4fjcTGdt04EwooGBA=;
        b=vkNSMJbO7R2aGdYyZ8SCmG6zzEE6aDMrcgZAeCx3fGDh+Pz5olsDQNpoAjCbOq2xwI
         ABgQI3+SYZwBg2EM+2JlI3CTexuAWKJ3UORTDdDoHpuY3/SmEgOwJVStmWfq+HN++ZGS
         QZL1yOpATt81sV/zm/QmsUA7tmOaNcVU+JlQ+hMJf5AuJwcB3U5ymR1NfpnZLTohFjJk
         xm6O0GNlRO35TStBNwNMmljAwy2XmPAF8i7rdyfscal19BhCzzkOEk5h7QHfa3R0p/48
         H9eM6xTnXgSwjd8U5Q/xw4ybeyaiBPmHS2C4sz4W+/TwG1/A8x1SahzNvcPP4uFh2Lag
         /b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538184; x=1717142984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2lSidCsB9ehXoWQ8boWr3QTXV4fjcTGdt04EwooGBA=;
        b=d9KkrxSPTuyPOg0f4C7GAbFtyv92G8Byrm9+73yGrQ3xaylqZS6N2XzGMY9c4JoVDK
         rNJA0+WCeLY+2iqO/gR26xnUAh0GN4K08SuT5ZA1hLfQRcOhQqu31ONDJNto+AH7LW+T
         hT9ysW1uTxZN5TXmFrovhgq9/t193lohdAo1b573yyjvN8oaKludlLMZ1+2z5JKMnupR
         nyYVeiOLsdcKABpYYG3qYLkw54QZBinE1BTKbU5FJWAsnpakTKHrkF8vCK07+zzRFs+x
         D6nDHfnNv8sEbW4vKNpE/DSO0SzdQbR0nhqRLf+f+pNn0pHQckxTI46Jp6m1uy9YJldA
         NkmQ==
X-Gm-Message-State: AOJu0YzHsxNbcj5aELqRR0cFbpNTcR+StzCnAN87F7eHJUUKNTlfnVhO
	RnVFIsIBwBA0O3qGl/Y0j8XxRP4qHA0SMGgsN7Pca80QcxuS0rgt9h81EEdNJJe+r8w4l8Brk8H
	OAA==
X-Google-Smtp-Source: AGHT+IGzgQlRJ5ug3LTivhVUY93cMPG5I4SOe6hVc5ZOXCHlEHuiL4z22/IDhTQdsTn2j4oV9P3KDA==
X-Received: by 2002:a2e:a1d0:0:b0:2e2:a99a:4c4 with SMTP id 38308e7fff4ca-2e95b27b113mr11582591fa.47.1716538184250;
        Fri, 24 May 2024 01:09:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:7092:8288:69bc:29e5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc487fsm963351fa.24.2024.05.24.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:09:43 -0700 (PDT)
Date: Fri, 24 May 2024 10:09:39 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZlBLQ87edfIHiGRt@google.com>
References: <20240523092920.3355004-1-sesse@google.com>
 <Zk-MpqzRlAecrWA6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk-MpqzRlAecrWA6@x1>

On Thu, May 23, 2024 at 03:36:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Makefile.config:982: No libllvm found, slower source file resolution, please install llvm-devel/llvm-dev
> 
> ...                                    llvm: [ OFF ]
> 
> But maybe use "libllvm"?

I think I was trying to be consistent with the previous patch using LLVM
(something with Clang and eBPF, I think?), which used llvm and not
libllvm for the name here :-) And I don't think upstream actually uses
the libllvm name much (e.g. as you can see, it's llvm-devel, not
libllvm-devel). But I can change it if you think it's a better name;
I don't mind much either way.

> So mostly the above, and:
> 
> root@x1:~# perf probe -x /usr/bin/find -L find | grep fts_read
>      44        while ( (errno=0, ent=fts_read (p)) != NULL )
>                /* fts_read returned NULL; distinguish between "finished" and "error". */
> root@x1:~#

This part went a bit over my head, I'll just assume it's good. :-)

> So the libllvm is even producing a better result, showing those inlines
> not seen in the BFD based output.

I think maybe you need to give --inlines to BFD objdump to get it to
show inlines. (It can be useful in perf annotate sometimes.)
But annoyingly enough, LLVM objdump does not understand the flag.

> 100x speedup, looks like a win! 8-)

Great, thanks for testing. :-)

> Thanks a lot, the comments I made on the patch are mostly coding style,
> please consider them, but I wouldn't get in the way for this patch to
> get merged because of that albeit would be nice to try to fit in more
> nicely with the existing source code base.

Sure, I'll make a v6 with the requested changes. Just some
questions/comments below.

>> +		*inline_frames = (llvm_a2l_frame*)malloc(
>> +			sizeof(**inline_frames) * num_frames);
> Do we really need to cast here (my C++ is super rusty), and why not
> calloc()?

Yes, C++ does not have implicit cast-from-void*. The C++ way would be
new[] or use std::vector, but, that would make it impossible for the
caller to free(). I can use calloc, it won't change much either way.

> > +			dst.funcname = strdup(src.FunctionName.c_str());
> If strdup fails, users will cope?

Yes, same as dst.filename. new_inline_sym() (which is where we give this
data to) has an explicit check for if (!funcname).

> > +		Expected<DILineInfo> res_or_err =
> > +			symbolizer->symbolizeCode(dso_name, sectioned_addr);
> same line?

That takes it way over 80 characters, is that OK?

/* Steinar */
