Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989C823B0
	for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456740; cv=none; b=NDAE9gCrfaCea2dg9lWHfzcPlMw33fppq+yUENtieCU+b8BLfGCX28ReUsI/2jQnMHFnKxSSSJFr3fZ1a4QhFQtgYPlN8qsR+czHUFKGmt0SrQklVWLwnw8zoVVbZJppqKAgV4KN0b+JaPPNEPtAyaSWqD1DNvNeXdBiGyHv4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456740; c=relaxed/simple;
	bh=Lj98U6JsOomLPuUxYnAamRHx6i8QFetonnyK1CfOu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBMdRpGjqu3wAyUoyKQAPPeREmlMTVmnZBB/uN9MAm9rEFCrH+XkuK/AFZOB5M68g1roOsmFsMTVCgAY1eYDwarBZcqeNqbpjVNeRxNYChP1NavlbtZZFti7t6LQBhDYWo4/P4u7pILo2ngLE1qi/y9K5G1CAOwpYHkZaT5U4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRsgBB/q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRsgBB/q"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-528878c258dso227329e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716456737; x=1717061537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mQDu8PodgpyJeYqrI53Wq+jk69QtdU/8gr3jtIgfVw=;
        b=oRsgBB/qYGMLA5lBkUSEco8P+2cF/JERyGB8CjU1O1jDwraU/RYjPON/xRns70qqSt
         ThVhFGW3baEKZCNFPe1a563yGL3zKZFZq6V8RaXRGFKBsxsqyQvlcD1VPG/kQEZj16zv
         wbW/I1vrmRZAi48ALara9bJSYpfJelByUj8EA0/VNHUg09L2HGzOguZC3kTEV+6WtiWB
         wxZuSLc01ET7wn3QnUJSG/vPuvkSX3jkQVot4A34pJVB90DGw3TVlxf+K9f8OKysPneV
         EQko0a4kIIDmMTi1dYo0mi9dPjYteOU9f+2UlKmilZxRcfWAxyBQaIXBQJ5TpUSIvaSU
         9XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456737; x=1717061537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mQDu8PodgpyJeYqrI53Wq+jk69QtdU/8gr3jtIgfVw=;
        b=AnUEWFgl9r2IN64b0fzKkT8Te1X7wVTrM3ntQRZv1aiFtdR85wc50dCUbYQpaZbadQ
         jDUEBTqKz5zYNsI5otXoj72OYRd6ApXjbjKZ1RMKR0CgS1zpHQhIElzjGEjVtkWTutmk
         +cqO3PsyTGCXGylfjx4nzCnNazVcwNp+VlokbgveodpIMhTM8RR3tDqW8wJKm1NqhYBR
         TwxXdCOQZW+uI0EIR8UBLDMndagRGvq1FQcR3GaTDFrUEP/uFPA/lOjVxSoK9y9+F0cS
         FIpHx/9pUmNm2JPPzUGVp6aw2fjv2z7ZW3LP/axtfklA2gL/iIQiuguNmn7XtbTLM0/N
         u14w==
X-Forwarded-Encrypted: i=1; AJvYcCXLwdC9fONtw/GA0zRoKVEPlGwVWcJmnv3fRtLL/EKx13eQfCV/zzJFPp9KsKuhQqZjtpH3IMnDhTLT2Y3Dk/yWKsv8LdyMcZmlnBxw6qRW4Q==
X-Gm-Message-State: AOJu0YyBa0XgmNhuurnH+FWXHgpXbnCr8+NnMC8m4p2V4qQVvP1PQkAa
	bwyZJZAN1bZLfBXUPPuN/ky/Olcw99C7M48dKUiTunydikBwss7qu3YxjefNtg==
X-Google-Smtp-Source: AGHT+IEk9OvR9KACg8HHVRm631KJZ77bnL1wnmhw4pprthIUd9aI9YxgnMHNvd3Rv4SBsaB2zLbhiQ==
X-Received: by 2002:a05:6512:3b11:b0:516:be0a:58b with SMTP id 2adb3069b0e04-527eed419ffmr775222e87.6.1716456736468;
        Thu, 23 May 2024 02:32:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:4571:1ce:5c15:9ee])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e6f5cada08sm22900441fa.140.2024.05.23.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:32:16 -0700 (PDT)
Date: Thu, 23 May 2024 11:32:11 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zk8NG10oHcQ0T6EQ@google.com>
References: <20240520083048.322863-1-sesse@google.com>
 <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>
 <Zk5Mi7SliDOd8uO4@google.com>
 <CAM9d7cjjH63CC8r-z33P4SCWw3x4NMxuSC1CovVHqpp-zXSf6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjjH63CC8r-z33P4SCWw3x4NMxuSC1CovVHqpp-zXSf6g@mail.gmail.com>

On Wed, May 22, 2024 at 01:46:35PM -0700, Namhyung Kim wrote:
> Great!  Personally I found libbfd is hard to read (and use).  Hope
> that libllvm is better in that pov.  I'm not sure if we all want to
> remove the libbfd dependency but at least we can select one of
> them at build time.  Maybe the same for libelf and libdw(fl) too.

I've never used either before, but I found libllvm pretty
straightforward. The C/C++ interop is a bit painful, though.
(The disassembler has a C interface, but addr2line does not,
from what I could see.)

> Having symbol enumeration and demangling with LLVM would
> be nice but not required to merge this work.  I'll take a deeper
> look next week.  Please post v5.

Posted.

/* Steinar */
