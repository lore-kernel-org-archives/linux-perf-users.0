Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762340DFC3;
	Tue, 14 Apr 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186718; cv=none; b=NoETmyc53/gIbiH7HF2kvMRCRGcazElSw7AWoMCarKI/opugsrQhnl7NEJwKGP2Gsqoty4cjq0hdF02mevS5N8773Q8nADL+SC6FLDWZHds3lu4lF8vJug+Pdz15Q3BTjvXfVkr9+EUG67gmZWA6EPEXcJQxFkmxre1RyKwPqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186718; c=relaxed/simple;
	bh=iZ/MSN39TjQv6Xdp5XG1qNwMwht+A/u+DT76X0aF2ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z/rxj+4wPOtj7EHsxIN34C6QLRzzMawcmXDoLPEhl2bpUYuCbBkd3YW1h0RnpJ5JyQVvANIVZU+0BE1Dly8e4I/xv/Q1/UyLZOCoZUXrgS6ZlY9BT2GbBqIymQJh6Yxs0QT8Z+8iaz6R2DYyDH9y/3W5wXeYrvXBNs/FcNBHU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr16E1Ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr16E1Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A15C19425;
	Tue, 14 Apr 2026 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186718;
	bh=iZ/MSN39TjQv6Xdp5XG1qNwMwht+A/u+DT76X0aF2ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zr16E1Eit2xl/kHbL+W5+yRdXBe0bSTuLYPEnW4oVdHsC1chQkhKYuExSAZHhJ6MT
	 7RBp3q5z+cnYkhwA+6/o7bLA74+OP6PhMPxnke6aVopxgOzcqUvVPdNkH/0B5MDAi2
	 OaMLX1azEvxzpbogI2/031pj6QNTDkVP6vmHVr7e4Ady8BW5R0KSVbwYeH4nxs/Y+u
	 x74RYbuSwQGRzfammczDCm9h4GXbIjN8uBRRE+1Vr1EALBMCaPaF+vBzAc+iImoEXs
	 eeN2BwnjhHBFmuysEJYZBZ38zg2rw/Xvaf9XLNqauzoi8AAUTjDeAlpQoAqOyOo1c5
	 LJutk00bbCjYg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Subject: Re: [PATCHES perf-tools-next v2 00/13] Sanity check perf.data
 headers
Message-Id: <177618671798.1519819.2086538629811418196.b4-ty@kernel.org>
Date: Tue, 14 Apr 2026 10:11:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Apr 2026 19:08:52 -0300, Arnaldo Carvalho de Melo wrote:
>         Sashiko recently mentioned the lack of sanity checking headers
> in perf.data files, that with a fuzzy or maliciously crafted file could
> make processing a perf.data file cause deleterious results.
> 
>         Add sanity checks and some arbitrarily generous upper limits to
> headers, if some are found to be questionable, lets tweak them in
> upcoming versions of this patchset.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


