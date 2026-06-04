Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245B4279F9;
	Thu,  4 Jun 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581339; cv=none; b=FJ0WgD5UkMTRwQJ1nCEgMI3MBymup3T7td3+0SLb0sCQfBOZNfNYVwEqp0hfAh5kxOJwy6C+uUT0OYT1TIscEQNCZ8Gp9LxVxOhFs2qOtaPc1KNSYwdvawm2vsz9iBYP+saS0MO1AbGl/03XWVcrBIAZoWPwQu+XGRAvTIeeFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581339; c=relaxed/simple;
	bh=LYHrkDvG2R9wMsU6ewK1GZ+N+Le9ot+hu1WrYehDaZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6PAjMpK5cX+XJrwiDwMkdlYUj5SOByd3Xas4r8rYilOsMsNCNFc8h1CuFv+kraXI+0CQA977XkX0mxbYO4ISdz5UYMpM/zLaL6CGP1jOufbk7UnIHQySVoCc7u7QXdTkguhuzvK6g11i2t0tOVMWywf87dxQkRTIDJTMz0+SSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bleEym4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bleEym4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2481F00893;
	Thu,  4 Jun 2026 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581338;
	bh=0mg/Hp2veFXAzGaFoznsZlcXxnTeCkh9Pks5Q7ikiDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bleEym4LYp+Z1zgbrnONj20sk/oQw36beuOS+9QCfrH0AWcT4ocRpXuVpnymG28IZ
	 5FheTJeFH+NYQ7xrGE48BzAWcjgunjNHskr5Rd5EOv4PxgscQM99AFM55WiXYBoR11
	 HkF+we99AvuzFlaQyp7g4UA1vl2EXFnMaGHqV9G8myu/fTUdNe0zo4wDxHcoO/+nal
	 oiF67pwjFdxNX1hsmAx5A4E3T7MRLsG7Bc4y2Xd1nXJ4RpT1Diz5/9F5bhg5iHcBW7
	 /f6QQnpI1Ydy4lWgIbTT2OG7tUcwfvoV/s+0Zzi9Rs8/73MquekupfI8Ll2Jkqaitf
	 FowT2/qaZOcZw==
Date: Thu, 4 Jun 2026 10:55:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Rui Qi <qirui.001@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf: Fix off-by-one stack buffer overflow in
 kallsyms__parse()
Message-ID: <aiGD1uOjeJhpjB27@x1>
References: <ahcrYd2xj1gWvl0m@google.com>
 <20260528062355.2320045-1-qirui.001@bytedance.com>
 <ahh8v0Zvh7iFz9i8@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahh8v0Zvh7iFz9i8@google.com>

On Thu, May 28, 2026 at 10:34:55AM -0700, Namhyung Kim wrote:
> On Thu, May 28, 2026 at 02:23:55PM +0800, Rui Qi wrote:
> > In kallsyms__parse(), the loop reading symbol names iterates with
> > i < sizeof(symbol_name), which allows i to reach sizeof(symbol_name)
> > upon loop exit. The subsequent symbol_name[i] = '\0' then writes one
> > byte past the end of the stack-allocated symbol_name[] array.
> > 
> > Fix this by changing the loop bound to KSYM_NAME_LEN, so
> > the null terminator always lands within the array. The overflow is
> > triggerable by a kallsyms entry with a symbol name of KSYM_NAME_LEN+1
> > or more characters (e.g., long Rust mangled names or a malicious
> > /proc/kallsyms).
> > 
> > Fixes: 53df2b934412 ("libsymbols kallsyms: Parse using io api")
> > Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
