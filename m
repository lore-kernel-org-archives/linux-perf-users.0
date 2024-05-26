Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AD2F46
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758688; cv=none; b=LPDIwxNLMEb2BrDpOzvZa2ErkejH7F0Hih0T5fRY0rRdwYVf3reA/GuVin6qiqkumhG6e1jB8JN40OHNDrypJi2WleYTWOoP6sPUSaWx5CfpBIvHN8bU8eEv9pTPmma6379KMF7PaYOM8Smix88SN80il7YZGK7+neVbuLjY028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758688; c=relaxed/simple;
	bh=Fc+Yxlu/eOYcBEZ15ctTkP/Gy0RI2ZGUfJkYqXamuco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av7ffxZ9Vyh+ELXC/0KzwWc49Jm07YXlRdaqARNeDjB3Hkv3PP0jFOrKn6Omi38T8yr78vmRO4CBNrA7OiaPGncK7ezP9EK4bOmJNI232tyE6x6GUzNvzMRkGHGvOj4kcDfEWVLnLn0CEmxMyvlL/WmS4AFoMLVi5Sfi4Tks8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4ZgPEhj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4ZgPEhj"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so33537271fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716758685; x=1717363485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTI9+Tooj7QXANR7xYSYhH9MioraP53ANnHXVs8kx10=;
        b=B4ZgPEhjhnjGfNDvPgf3YR3S/X0SeWg40atYpzu9KzCbAEMR+5FncL0BuTVj6Ka8KG
         Bfya9fp4OhlpO9QabpgO9JY0R8xXr+rnNVd4l/NUa2n71eMxHjGWgf3u9rKFQ34OCO77
         b9vV2I/du6thnuQu8wNd0jG0k8iZvVnOY9kqKxiYvhEhzDvVyFBpRYdFZrFnjk/5KT1o
         nZaCdsXKgrRWE+6pHc04r0OT9pBcDbS5XvtjERN5iy6IrxaT88HgzONhSno21ENi7ET+
         +keQqF9zEg5CwpaWxrEG+wSUk9W6v+4yT/RitWyIJJQ+iwSNDP6du8LG8n4bLpK4E48u
         KsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758685; x=1717363485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTI9+Tooj7QXANR7xYSYhH9MioraP53ANnHXVs8kx10=;
        b=CF430FwtM7zPDXf5dexN5FjnHEWSG1O3vfj1LwAChdOVaj/ByScinOKspfVl/K5VWl
         NyFQZSiNaOBbVCHyMoCjbL5EVGKVqzIdNhpy21dYPVaaiX8gVkUi96WPsevdQDdS/M9V
         QN4nM7L0GgDyO/0/fGJza84wHcpkYDOm1gGKA++nEv6dZHh3bhx4QdoK7/m2c5Bcs7Cu
         dMkMAZ0qp5CftqN/wU/2DMRwD9d+OiFwG5KNIRtVE1IWJFScT+NNtRvDSFV/mqaIKBtr
         wF4LKCro7LW2SAx90wcQG19yxRfD+A1Nad1cvDtoeWW+1ug36zrF2tHYsZVU87Tv0+Mt
         yYag==
X-Gm-Message-State: AOJu0YwXPpR6pyUgfSpUCV5Mjw8fSJHdejd6+u2nZvg4sqNUzS3QC48z
	Vim1PfHZyU3fnyNNuVmkVTrlVuK9kWKJHnOcG6P9+sQ+4Nw4UHuGwQ0RL59CKJaGIB8/FIhI2lL
	gE5tM
X-Google-Smtp-Source: AGHT+IGvmNaT28lfbXf8UTbZhn9cKaGxzBV4CQTw2CnqFzcDb0bv69PhDXXaD+BhFCx/DST9bxwpcw==
X-Received: by 2002:a2e:2c19:0:b0:2e9:564a:db29 with SMTP id 38308e7fff4ca-2e95b0c4da4mr66780081fa.29.1716758684437;
        Sun, 26 May 2024 14:24:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:9da6:3a1c:cab8:1718])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc48d3sm15888561fa.5.2024.05.26.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:24:43 -0700 (PDT)
Date: Sun, 26 May 2024 23:24:40 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v7 4/4] perf report: LLVM-based symbol listing
Message-ID: <ZlOomG5NacWlV_RY@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <20240526182212.544525-4-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526182212.544525-4-sesse@google.com>

On Sun, May 26, 2024 at 08:22:12PM +0200, Steinar H. Gunderson wrote:
> +
> +	symbols__fixup_end(dso__symbols(dso), false);
> +	symbols__fixup_duplicate(dso__symbols(dso));
> +	dso__set_adjust_symbols(dso, true);
> +	ret = 0;

Urgh, evidently I forgot to copy over dso->text_offset and dso->text_end
here, which I guess needs to happen.

Even after doing that, I still cannot annotate Windows symbols, though;
I get

  Couldn't annotate RtlLeaveCriticalSection:
  Internal error: Invalid -1 error code

This is true even with libbfd in a non-distro build (without any of my
LLVM patches), so there must be something else at play here.

I _can_ run a Windows binary in WINE and get the right symbols out with
perf report, though. So this leaves only demangling as the final piece
of the puzzle to make distro builds essentially equal to nondistro builds.

/* Steinar */
