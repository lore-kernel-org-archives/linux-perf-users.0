Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DA1C9B91;
	Wed,  2 Oct 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889669; cv=none; b=YQbscXB8pTBQi57z7EDrZQx5qKJeJov+Y0/2uUcjR9xmEjacFa476bVWY5jTj/+ODVBtz7JWBexG2JJKEqPTOuTWLNbMtp5aFEOSnXINmxVmc2cYDcRbi67Cds6HD5rVlCqXoaAytzC+EHcNRmN0N8wQgYjEomyyFY7VwKRgNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889669; c=relaxed/simple;
	bh=bM2qhLqGwys6x8BzEhhj95bRuLudsDE05rSW36IND3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JewIzsve7flnGCteUbYZAsf9vQrJgp0WcKx2Jdp0z29BALAiQTEqtIaLFm4MuI7RzNlXM4/FseQidJzSlsTrw7DgYEJptWgGdSWhaRW5xvjfS1vXxDPsMtwnMl+DKv5kgcxz6EQaXJo0vhyySJoqGfzfnO/avkgwvl/+s2BuAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej0gMZwD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej0gMZwD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718816be6cbso95534b3a.1;
        Wed, 02 Oct 2024 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727889668; x=1728494468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxJDUbckvO5Hqt24MYCaWmow19TBYSDV81zaiyr9C8Y=;
        b=Ej0gMZwDaq5UoK/XGXonWg4VZzU0/6QxQR7FUSILl98b60PotYPpUhZvQIs2NiJN9e
         KyKvlmdFsLzRABxvBdg2twEoB/Vkhz54S+VSCbR4JSagdchmcffoAH2+VXgFV8Z+2Upr
         p/rLp6gMw9EUauTCXuiteHmw06EYq9lZluAzs6vz0HVAbFYnHmkjkhBjsGLLGfA6am+n
         W9v1hN+IrafOj1/X3JYCGO3+9+ixMs5sz0pnCMcGsfTy7ljzI9xByn7hW9GuRnJQsq0O
         oikC5vHDFfslaZMxa9H1VzkQ14DNdz8ZJLQW6tPioBdniffue6rcKIuE6R3Wu3DLLQJT
         ewdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727889668; x=1728494468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxJDUbckvO5Hqt24MYCaWmow19TBYSDV81zaiyr9C8Y=;
        b=veJtZHd3/L62nUFsksi+Y1rRKWRyrc0BG8+JVnwOGHUd3UO0knU6iNysEqajsvtr+h
         tRJz/gzk/O846aFdqfWL5G8P2Lml+WxLl4zqutXWD3pLt0yF0inwoaSORZwDIOfJBjXw
         sdJ7cHVlIxLDwls0anxf1AS2+yPMSj65Y2DDRnWaxmSW7VBK5w+JWR7IC8xEm0Kn+1Dx
         22wVzxRnUFhHFfdyIKI/VldFNT6bx5CHABJzlzd0nOmwLrbiXo72ovv5OCIGL79+EiOi
         pg/MJYNUL17ZT0POF6ZKENDS8EgLFBP3Ttbm5UiALPyWXU/o/TbGu6StRqTiqOWD6Q6o
         exgA==
X-Forwarded-Encrypted: i=1; AJvYcCXZVNBIUyXiyKJV2TRDWiiG/7bWNj+Fem/hs8GcHiwEFi+qFzD+rkdRpnBbHzoR3C7lDsTU+RgKQN5niBSkNEObXw==@vger.kernel.org, AJvYcCXwRxfbyrBqiAD+crtDdYNO9D/vh4Xa3esZGYGLeguK4dAvXqvEbHtwY4xsBztK4t2es16Pjopnz2xu+MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETHGUdwjrUQWyvxQhuufW2yHEryITJEMptSleTUZ2KdLxpg16
	RUW6xrprqbIJ8zdrXWIoVkYAdQDbtG16q+NKtEvWTLaESTjtQuRmHS1c3w==
X-Google-Smtp-Source: AGHT+IGngXUZpAMKDbGTj4ZyhVPdUcM9xfWOeh59QxYKsOIlhowocCZVwmUo78Ll8EF3st5c/eOqEQ==
X-Received: by 2002:a05:6a20:9f08:b0:1cf:32d1:48f with SMTP id adf61e73a8af0-1d5e2cbf20emr5202377637.36.1727889667555;
        Wed, 02 Oct 2024 10:21:07 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8c7cf5sm1845507a91.41.2024.10.02.10.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:21:06 -0700 (PDT)
Date: Thu, 3 Oct 2024 01:21:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] check_headers.sh with hunk exceptions
 (lib/list_sort.c tools/ copy)
Message-ID: <Zv2A/npbGyP2SlKV@visitorckw-System-Product-Name>
References: <20240930202136.16904-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202136.16904-1-acme@kernel.org>

On Mon, Sep 30, 2024 at 05:21:34PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	Please take a look, as per tools/include/uapi/README we carry
> copies of kernel files for various reasons and check when it drifts, in
> this case we need another way to accept diffs while checking, its all
> spelled out in the individual patches, please ack.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (2):
>   tools check_headers.sh: Add check variant that excludes some hunks
>   perf tools: Cope with differences for lib/list_sort.c copy from the kernel
>
LGTM. For the series:

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

While reviewing the patches, I noticed that there was already a
difference between lib/list_sort.c and tools/lib/list_sort.c regarding
an additional #include <linux/bug.h>. This prompted me to investigate
the reason for this discrepancy. From what I can see, both files only
seem to require only three headers:

#include <linux/compiler.h> /* for likely() macro */
#include <linux/export.h> /* for EXPORT_SYMBOL() macro */
#include <linux/list_sort.h> /* for list_sort() and linux/types.h */

I'll check the git history and run build tests to confirm. If only
these headers are needed, I'll submit a cleanup patch.

Regards,
Kuan-Wei

>  .../check-header_ignore_hunks/lib/list_sort.c | 31 +++++++++++++++++++
>  tools/perf/check-headers.sh                   | 29 ++++++++++++++++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/check-header_ignore_hunks/lib/list_sort.c
> 
> -- 
> 2.46.0
> 
