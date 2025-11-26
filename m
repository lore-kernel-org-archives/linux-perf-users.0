Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119B4207A;
	Wed, 26 Nov 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179955; cv=none; b=hGSbpdztAZADiFNQnJF4G3VFWq0j9KSW1Q5sJpXFqd+7ugdS/hAjhN/1kAo+56uXLsFFUOrnjrShfTocw6ZyU9+C27B75EVhoV75H2C3j4EpsQ9XEfFl1xEW/6TeLSbNqT+PM1k3IH94w5b+f6QyWLyDM5/0EvbnJ/kTcHEbDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179955; c=relaxed/simple;
	bh=sg7NBwz1aZkzxUCOqukiMge4OdzUmxVy6rn4f9CoMP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCEznbGkvsLgf7KjNZtUqDfsC2mjsz94ER2keDW4PmDczcQzn5g7ALkgnHkFl8+fOcC8F08C6kDuq90f8ho2N55yyWkOzQtd7MyDlQDTlmd1lj9UHoE0zhGiSbWl/hdK4snMRZbUX8PNs2GsgM4EtiEjO4OnZr760q3JA/sJWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KupS65j5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KupS65j5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF0FC4CEF7;
	Wed, 26 Nov 2025 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764179954;
	bh=sg7NBwz1aZkzxUCOqukiMge4OdzUmxVy6rn4f9CoMP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KupS65j56O+AwX7I5MA/zxdTivvpPaDSXgT6biSrkVI31Z0bqs7sFSVh+2AKTR4S7
	 Eu+csty9DcP9SdmXS94C9xM+etNHT7LNCvOuwlM6J4XFR2WZhSEd7hpdFEPVKShZnz
	 ZKqxtC+khzi6W9zeQGnejP086Dy/g5F34K5BRMP1wYsC3Ap6iTtalhotLLcpVPPhov
	 qU2qRCpedGaiWVZjwhQ9TL3mIULocec9N/0BNTAkQimLqlAGXBcJYs8k9vGNJSG99a
	 7MOdktnvZJnsXwXiFVAGbPS1fw62WiFC6fJbMIIductD5WIi9+hb9qmUJEFIZRU51R
	 x+3UrpL+c5eBA==
Date: Wed, 26 Nov 2025 09:59:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Eric Lin <eric.lin@sifive.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2] perf vendor events riscv: add T-HEAD C920V2 JSON
 support
Message-ID: <aSc_7dGgKKPzxo9K@google.com>
References: <20251014014830.613399-1-inochiama@gmail.com>
 <ac26535e-01c8-d8c4-9f25-f5716065b37f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac26535e-01c8-d8c4-9f25-f5716065b37f@kernel.org>

Hello,

On Tue, Nov 25, 2025 at 05:52:10PM -0700, Paul Walmsley wrote:
> Hello tools/perf maintainers,
> 
> On Tue, 14 Oct 2025, Inochi Amaoto wrote:
> 
> > T-HEAD C920 has a V2 iteration, which supports Sscompmf. The V2
> > iteration supports the same perf events as V1.
> > 
> > Reuse T-HEAD c900-legacy JSON file for T-HEAD C920V2.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> 
> Would you like to take this one, or would you prefer that we take it 
> through arch/riscv ?
> 
> If it's needed:
> 
> Acked-by: Paul Walmsley <pjw@kernel.org>

I'll pick it up to perf-tools-next, thanks!
Namhyung

