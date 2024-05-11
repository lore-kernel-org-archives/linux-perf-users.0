Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E881CD31
	for <linux-perf-users@vger.kernel.org>; Sat, 11 May 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457895; cv=none; b=SvnEOnG3wg5KllW1WQ8TtMW0VwktNsXSpS4hmUWrwo2GQCkUedCDsnBOo59RN2NJo1JYNelAE1sRARzmIK0sDDH2c82P4VSjrRz8kpnlTD3V5K5c7YJeZYzuPlr5iDQ8hrydy1EDOFqLVAzItbSmiYw6lSNjRJpHQTFWBwQEXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457895; c=relaxed/simple;
	bh=m0PmhIZfGfLGxB7MdP6Q++k4AXvc2nOplWPxUyw2VLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF5izX9HhDFVlzQYGF0/RlPJykfh+B5IwhSmo7ebwUXAAkORUaQTqsui5yOq0ck+WnZAhp4Bx9u2SkWaDHaGctdJLs/hwkPjTGe7zo5G9IC+1WQv245ruE0FMtQ2RIEYJJcNf1E5YGEXua6G42YHVgmbOH4IOjKaGCGZos6cUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZDgbCTEl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDgbCTEl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so2591960b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 11 May 2024 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715457892; x=1716062692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAxRPnoHPzaMqkCmlI5pbJkR9qG9/zkm1emY09MZiz8=;
        b=ZDgbCTEl5MhaSUfST1waVCnlPi8WVwFpmMJY3cuHXP+W0Q+fVNBcanSOgyrum5uVi0
         CLQ8ZrwK693xxvMu5UotmQ3baCfpZYhNFT5hRswwT88UYj5h12g+J/jRPjAitul0UqFE
         Uj2eGeJ9B/PnR3aMXb+xzCZIS9XLV4FyUxVGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715457892; x=1716062692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAxRPnoHPzaMqkCmlI5pbJkR9qG9/zkm1emY09MZiz8=;
        b=Xf2S/1i+BsUDixylJ82ndwgf/hTmEsCedAlA6Nqqixpt6pQWqnRm+69mhl4D86k5pb
         6Wj9qqRJKb/uK/LghRZZtST7lh2T9zfOfZOBeJJMcHd2ei+N92KEFdyhWwdV3TomujF5
         uQ3xqbYIJjxPgK43WFZw5pn5wocNw94jze2xX3TD8N76bmwZPnIJNOJQjgLMU08+T1uK
         EJlBgfE6nlo+PXcvJuhxlwOGazN41OdIfzLH3dvnMXIAVG/x4dMqmNubTwZqpX1ngXBB
         vBmdE48KGGFmvbCUeHgcH8CWE1oAt3QF2Cju++3iA8dgLooxRETQrISNSU2rO258S4le
         xfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQkWc5HU0UpEbnKrgLw/E2rzYqIh//BJKW/PKqzn0CqMatoayjyKsm+JW6nGkxru8GWAAZ614OfGBqFgt0hw+Mv7S4vpKAiXp1bYAoISm6rw==
X-Gm-Message-State: AOJu0Ywp6cM5IxKk4TIS5lRGY5ZR/85DFPYkSgf6yPWeI00Ac0gn2H3s
	kolzjTeelM+ZObN0PYFr8bRy7EeW6mZiXNgcD3LsIfFOWlNK3x+sizUx0sA0hg==
X-Google-Smtp-Source: AGHT+IEH64K5jd6mjFYb931Me09tBfbrb15HesgvKj7DyqJhBJRz3ZGnEZ6lTZAV58PL9Yzco/fyPA==
X-Received: by 2002:a05:6a20:da83:b0:1ad:8755:976 with SMTP id adf61e73a8af0-1afde0b5aa7mr6858922637.13.1715457892419;
        Sat, 11 May 2024 13:04:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6d0b8c887sm3496640a91.21.2024.05.11.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 13:04:51 -0700 (PDT)
Date: Sat, 11 May 2024 13:04:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: Add flex array to struct
 amd_uncore_ctx
Message-ID: <202405111304.6A390B9D@keescook>
References: <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, May 11, 2024 at 04:51:54PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> The "struct amd_uncore_ctx" can be refactored to use a flex array for
> the "events" member. This way, the allocation/freeing of the memory can
> be simplified.
> 
> Specifically, as the "curr" variable is a pointer to the amd_uncore_ctx
> structure and it now ends up in a flexible array:
> 
> struct amd_uncore_ctx {
>         [...]
>         struct perf_event *events[];
> };
> 
> the two-step allocation can be simplifief by using just one kzalloc_node
> function and the struct_size() helper to do the arithmetic calculation
> for the memory to be allocated.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> This patch can be considered v4 of this other one [1]. However, since
> the patch has completely changed due to the addition of the flex array,
> I have decided to make a new series and remove the "Reviewed-by:" tag
> by Gustavo A. R. Silva and Kees cook.
> 
> [1] https://lore.kernel.org/linux-hardening/PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com/
> 
> Thanks,
> Erick
> ---
>  arch/x86/events/amd/uncore.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

My favorite kind of patch: fewer lines, clearer code.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
