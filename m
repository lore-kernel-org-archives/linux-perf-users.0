Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3F31A81A;
	Thu, 27 Nov 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277141; cv=none; b=Za3Ha0YLIpREfYkBBDBznCuD4vwFVPtb79pF9Co/mQFyLgEqgURuLj5x9YWbQYThRpkEl1ybJTBkOOQnt7wss4bvZVv4RAsxv/CIIe7A9lxb1TyQbHZh/g+mtFgzGl8WOrLCXtWzmbPQyKGvli8wCZiG4YD4VoodByfap/yeCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277141; c=relaxed/simple;
	bh=4PDvMhU46687aWFvEvNGlNCH5u1fFxn1j9vUBVE+NC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rRnUmFRk6Ni0CqsI8ZSIqt4AmI7hI0+iR73WrCx5y9xdoTzDXqRDp4ocCI8L+4M7a0pp/L6tugMOFO/p+C97iyuo7FpZ0O44aFBNQsUngSyeEz8hSPJ7WmQvLHHtYOjfAJHHvKjnO2cSwHALaOy/9cOzzMIxjeKHDa1McUkeYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlhEFGCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlhEFGCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0FDC4CEFB;
	Thu, 27 Nov 2025 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764277139;
	bh=4PDvMhU46687aWFvEvNGlNCH5u1fFxn1j9vUBVE+NC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jlhEFGClptTdZ3NyMdmCSuQmXHNKoNo1P19KZk2fSc+Zjq0dTLNeVmueTEqguIPsB
	 dVOfrjGsleYN4Py5zQSPhwwQa/EJ+jpJc9NFb9iBxj4h/OxozTITRXp8xGvPC1rJ80
	 W4GceiQrGk2FrIzktCoRq8Ezk3LiuH55dV3M3F5C3y8r5Tbc7HfTTiBE/OunuG5E0/
	 HhgdM/ra5HbIlOWS/+Ydc1371610aDVHcR4NVNcMpIVIYA323fQ4qgtT8+NMrKgZhX
	 N+iFtUnQjX9iJiZT2LJzm0Jyn5jlt4R6nXl7vmcakfSE63edIWpIY545FmnEkoQ2G+
	 rAJZlrjphcZ5A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251124-james-perf-non-block-v2-1-54cdc2f13a24@linaro.org>
References: <20251124-james-perf-non-block-v2-1-54cdc2f13a24@linaro.org>
Subject: Re: [PATCH v2] perf tools: Don't read build-ids from non-regular
 files
Message-Id: <176427713879.3725736.36576522440598924.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 12:58:58 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 24 Nov 2025 10:59:08 +0000, James Clark wrote:
> Simplify the build ID reading code by removing the non-blocking option.
> Having to pass the correct option to this function was fragile and a
> mistake would result in a hang, see the linked fix. Furthermore,
> compressed files are always opened blocking anyway, ignoring the
> non-blocking option.
> 
> We also don't expect to read build IDs from non-regular files. The only
> hits to this function that are non-regular are devices that won't be elf
> files with build IDs, for example "/dev/dri/renderD129".
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


