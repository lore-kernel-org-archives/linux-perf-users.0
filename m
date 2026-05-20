Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42A28B7DB;
	Wed, 20 May 2026 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238590; cv=none; b=Xnri+EwuONymvXGZSgTRbjp60BNoEyBliXmHA9EhPGtL2jiQcfCrons83MNZTD3sNVz7BVGA2QX1q83AKcVBs8OXJWMMkac78U5qDWmUs01K/VYtkRtyx6LsoUV8tRgwS1jvxu768JYaH9PEhGhzSra70lAB60CSaHNU84DTUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238590; c=relaxed/simple;
	bh=cRgBmkh/62aumh1V/w5ebHAPfM0LhCEXEiNItKzgHnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOq0x5dOdIrgAbu0iP5EJIMqbHHZBT0GZyhc0vp8skvflj4+0ybOzhTVHdrvojFejMPOg3WEGQjQ9kRBn7c1R+bUSSIDHuV03OYYhxuGY3HxGYjCsHSTkmvpPb6rV5JU/1eNIZKDA3e/yCg7txCaDW8Jp2G4lryKEbYTuZBiRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg9Sdxus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg9Sdxus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CC21F000E9;
	Wed, 20 May 2026 00:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238589;
	bh=zk/IYBcFrXzuB8j1gHINrkQl3CicDB45Hbrs/13PQh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tg9Sdxusq8R9BF25qOxT/a6+hZQLE6SSIsZTMMfXa7LrnsSZkNLMgsm3MTB5wPRZx
	 nYS484EPsnmbW0uuzrrfIUSfmn+5AMVhDsTLHhvU4lpOgYN9n5wlgF07+yWUU88a5G
	 /xQ4uZa9PuYLY2niKDGtaY8V2tUbXKXATBvIh7wRSVAFoxVOHBAD9uXLLTbndPbZxl
	 gmd1LLYTz5JVX6Kdz4IFJaKRTmhUtYZ9DMuv2b52PE23uL0+Nubte+1WAxGDY6jvtc
	 GWKl9J0vwmd37m9/bTAteezSkK8z2och3r4jg5zgLAdlBptig1l1iKsGrcMfH17k81
	 OLqa9gjzVGMDA==
Date: Tue, 19 May 2026 17:56:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Fix uncore metric scaling bug across sockets
 and nodes
Message-ID: <ag0Gu1v9KOJPmaVF@google.com>
References: <20260518231150.1252420-1-ctshao@google.com>
 <20260518234452.DEAEFC2BCB7@smtp.kernel.org>
 <CAJpZYjXh2DFpnS3+_cKhJ==6n31qBU8Cnks9VXZB_qH5i7S-eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjXh2DFpnS3+_cKhJ==6n31qBU8Cnks9VXZB_qH5i7S-eQ@mail.gmail.com>

Hi CT,

On Tue, May 19, 2026 at 11:06:40AM -0700, Chun-Tse Shao wrote:
> Based on the AI review, instead of changing `source_count` behavior, I
> will expose `aggr->nr` in perf python metrics and fix per-aggregation
> metrics accordingly.

Please don't top post.

https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

Thanks,
Namhyung

> 
> On Mon, May 18, 2026 at 4:44 PM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The patch codifies a mathematical scaling error across all aggregation modes for uncore metrics by changing `source_count` to `aggr->nr` without removing `#num_packages` from the JSON formulas.
> > --
