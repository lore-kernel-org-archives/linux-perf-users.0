Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7448665E;
	Tue,  4 Aug 2026 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863081; cv=none; b=u3ORWri8wsSh1mSS7SJpgNB0Rwy1W1DxszxkZTwDRpgPMzkh1Nmc8FF+pFZktZfoP/GJCWLd3u4fEhiiVDVu/d82Q2Ulvs+Xj3OiE7URg1kxRhMRbNvZUeWlHY5weW0NG1fIjeezy4YCLtX5TKjszcTlgNEAxQwHE49LdzVILdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863081; c=relaxed/simple;
	bh=AaDp7VLSfpGmyNR/BQ3cf189kmZyf1niAPO97E8/VME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DcE8lj+Ee+cy8CvxNg/nAyHn4ZRqf14I5NYFsxJ5Ff1K558udowyuac5hAyXyXNHFLlbHxts6aLlZCSVB0IBiEyU776UbKr/qKmdcFdvDJiQdK26vcXpSHc0rISDea6EFVx0IMsew4+PoRuOyo03BMc/kQlCTD9wKGKNuOsrEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpJiCGV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpJiCGV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5EA1F00A3F;
	Tue,  4 Aug 2026 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863068;
	bh=VtzsEwg9vbhtljwHlnzlZwQdz1B5m/bEOJqvMN6HbZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZpJiCGV/kN3zGNf11j73pLfTSxBeOepheV2X6zy0DepCJuQSjDXHDojqulglO6r/a
	 r4Bo9M9ZK1tOREztHAaQHYR26vnxwXtNHWghZUcI7c5B+gBBEW8Du8oBLfXuq7871Y
	 4X03FYeM/Rp7fbESdnngV5bPSSUd9PvH8w7HU854DPxkODlTMGPQVWOO6s6nuETdtb
	 SZJgVMSvEuzPnn6TYL/GnvYh7PMrLZV99ZXbmRb6qdwg4JK0aSqFPV6RGVYyfx2s/k
	 ll2LVt6aBYnWGIJwiC9P6jgKN0PIE7Nwc9LSIYzmHgEANhrGi/itVtXD7PBVDknFXh
	 jhN9/imstbdJQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 Michail Tatas <michail.tatas@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <anBILHWZfxku7OWq@michalis-linux>
References: <anBILHWZfxku7OWq@michalis-linux>
Subject: Re: [PATCH] perf ftrace: Fix leak in parse_filter_event
Message-Id: <178586306827.3573204.16854354598586218588.b4-ty@kernel.org>
Date: Tue, 04 Aug 2026 10:04:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 03 Aug 2026 10:50:04 +0300, Michail Tatas wrote:
> strsep() advances the pointer given to it. After the loop s is
> either NULL (on success) or points mid buffer (early exit if malloc
> fails) so the original buffer is never freed properly.
> Fix by adding a tmp pointer for use by strsep and free the original
> pointer
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


