Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524481;
	b=rCEWwzFdfax0na2M9Bs4qG4nxHV5FsJRGbJqL/b0qhEy885ljlYqEa9kPNS6YSsFQP4a
	 wodUJV9JA7pZGkJ1SxEyIGL5KOPKTj7vN5LAZloUZsTgFjHZ9iZmrKLQcUUmwcgsWyG6n
	 nLV/gjSeu5Bw6wjjv67iPYQ3it/jOPn2P0mCNA6TW6yX8jsZFy5/BgxQOZ22PwrYXid4e
	 Mk5VJ3ZvboWslgIKLjqFLdVqYiRFhhRzzeLOBYBd9CzhUKXteeCphJ4pTYfmB9Ypwcntb
	 U+LB3ZXpTMuXFKlokbNHnjwxJ7R60HthwEuQ44ikN1Nxk+5PSbBNqxDytjGPRkyyuQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524481;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=AuDHHV5SIiUlpjAuQTXBK/FlHwXFuSjZa8VsGCc1sR8=;
	b=z+RiTNsW8Q+0TGDqjkZVmV+7QRWKfPLka8tdHSB7gYeo0IQ8NOEciOklI4LR9xHczZx6
	 ++R98FgnwW1LDXElP4Avig1kzbUDAgtwhEkWolmzTnr1UF1G80pe4tGEA9caV7nPdscoP
	 4jG4IxHWd7pPIWVCRtj5zHrUIg83og2OxT3dEqsjyWaWtUU8hAyTfjyE3p/hPPKh7OZxY
	 HAL7oJ4B9nFclJNoED3jyStosKT7upX3wv9LkTcNj4UbvkY1CasVwQllShWlq1k1KW18P
	 WO/mxPjzIl1y/rmcnoRAZNjfN1tg85dUAzon7XMjLpl3G8n9fzjn5cyi76DK3SQO+FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4imERTG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B1606A322;
	Tue, 24 Nov 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4imERTG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9E1F000CF;
	Tue, 24 Nov 2026 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524480;
	bh=AuDHHV5SIiUlpjAuQTXBK/FlHwXFuSjZa8VsGCc1sR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K4imERTG+CUU0k+/mkGtfdSII7pvHIrnfOHmfwMzMYsnIr+c3wXCnsUU+QO8WwYyW
	 ZpD5GzxKwBczBXkkx5yJr+6nL+d3dqi5Yytp22WRG56T6DaaRZ0tjO5D1Fe18RYJ6y
	 yWrXVU3QkNOv43+mlmo3RdK0agMA4Mx1DKm+JrX1GFCgzmfLpGZHkBJYsWtN3ULoqq
	 iZh/1v3lOi/lESdRVgdXUwI5+VouvJLFVlxHTDaCc1S1dz1EBmzhRHQEHqfSfB0GNx
	 Wr8tpdr1ZiJ4UOB9Cwx1oEr+AkCveZlnUqFui9tZuJgdRKR7gAQTxhlktVpvzdSGxs
	 aQ0Cn5M3b4XfA==
Date: Tue, 24 Nov 2026 13:47:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-hwmon@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, Tony Luck <tony.luck@intel.com>,
	Ashok Raj <ashok.raj.linux@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2] msr: replace rdmsr()/wrmsr() in comments
Message-ID: <awWHd9ygPFipisb3@gmail.com>
References: <20261124064108.2440277-1-jgross@suse.com>
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
In-Reply-To: <20261124064108.2440277-1-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> Replace all mentioning of rdmsr() and wrmsr() in comments with
> rdmsrq() and wrmsrq(), as the former functions are no longer
> existing.
> 
> In drivers/hwmon/coretemp.c drop mentioning rdmsr/wrmsr, as the
> comment was incorrect in this regard.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> To be applied on top of current core/msr branch of the tip tree.
> V2:
> - drop comment in drivers/hwmon/coretemp.c (Asaf Nuri Bertizlioglu)
> ---
>  Documentation/arch/x86/microcode.rst  | 2 +-
>  arch/x86/events/amd/ibs.c             | 2 +-
>  arch/x86/events/intel/core.c          | 2 +-
>  arch/x86/events/intel/lbr.c           | 6 +++---
>  arch/x86/include/asm/shared/msr.h     | 2 +-
>  arch/x86/kernel/cpu/feat_ctl.c        | 2 +-
>  drivers/hwmon/coretemp.c              | 3 +--
>  drivers/platform/x86/intel/ifs/load.c | 5 +++--
>  8 files changed, 12 insertions(+), 12 deletions(-)

Yeah, so I've already applied -v1 without the coretemp.c bits,
ie. just the mechanical renames.

Mind sending the coretemp.c part as a standalone patch, with
Asaf Nuri Bertizlioğlu's (presumed) Acked-by?

Thanks,

	Ingo
