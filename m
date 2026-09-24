Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158923BB126;
	Thu, 24 Sep 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270565; cv=none; b=JLd64NRC3LZiCg0atuu/V+LxLyFTOuOlcEM725w4HEqnB1cqJ8Z2Ixm4H0hvYbNNY+qFk/h6eQUArrpkvjw3IfXUcxRM7xggCqoCdcgJ1Xycs1zOhuMmcP5Ba8oYHMbGPeCHpyeRDcTKU1kspQJ2twVGOizM/62iiJkmdIN+92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270565; c=relaxed/simple;
	bh=3HszbQKqT7fUrwqmgWFMSKUIG/Escv7S3cVzC5E0tgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC5s2i1bNsRs7oGI9J+LryB8BVrHoob2GWAmo9X9ZVFdOfpKFDZOI20soiRo5sHeYx4dlOIHofZsdN/9detEeobLzs4hr5jQ+b7lWfCopfGIU8hhP/USO/JXMK+BkVS+P3Ud6+7oFvqXzNSW5mVBHf0v1MhMshCVwILMrfGJCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9kEU6bm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9kEU6bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8D71F000FF;
	Thu, 24 Sep 2026 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270563;
	bh=UgCEO1FH9v/8c9tjb+bS6TXEAsn5v+LeAw7z/YDiEq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G9kEU6bmNjlU/6kmSIg7gyWU15EDatGiZA/xJSwpLNy5mIjY644AQiNeM/kyACc3B
	 ttoDF3d7RCo3ZsJDiCzVW07jjgrBL2ODb3zCpTQBF1YiCvfzuAbdQTp/GivsmLqPJW
	 sXcLOZ1eNHhwOCXzuyT3JoFBIrysjlkn1KnC9UAJUo0NiSADoeSENqNwCm71/l5zOH
	 YHsGeeF2tpAV0e0TwBvJe9jaT/LwVb38SGvU82JckcsXLkE9nIPT+FIZf5oUibUiRK
	 rE6X6EwHXaPqlQjzIvroCVoS0NVaTMnxVd0yy+bv2rDQi3E1Ww18tXmXFuTiZbw5CY
	 8h4lkxKm+TG8g==
Date: Thu, 24 Sep 2026 19:22:40 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf loongarch: Fix discarded const qualifier in
 _get_field()
Message-ID: <arVcYFo1xAXFdogt@x2>
References: <20260924021756.22433-1-yangtiezhu@loongson.cn>
 <arSzzwtLnew2t7VY@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arSzzwtLnew2t7VY@z2>

On Wed, Sep 23, 2026 at 10:23:27PM -0700, Namhyung Kim wrote:
> On Thu, Sep 24, 2026 at 10:17:56AM +0800, Tiezhu Yang wrote:
> > When building perf on LoongArch, the following compilation errors occur:
> > 
> >   CC      arch/loongarch/util/header.o
> > arch/loongarch/util/header.c: In function '_get_field':
> > arch/loongarch/util/header.c:31:15: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> >    31 |         line2 = strrchr(line, ' ');
> >       |               ^
> > arch/loongarch/util/header.c:36:12: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> >    36 |         nl = strrchr(line, '\n');
> >       |            ^
> > cc1: all warnings being treated as errors
> > 
> > Declare 'line2' and 'nl' as const char * to ensure type safety. In modern
> > glibc versions, strrchr() returns a 'const char *' if the input string is
> > const.
> > 
> > This is similar to commit 7378b6656aa4 ("perf riscv: Fix discarded const
> > qualifier in _get_field()").
> > 
> > Fixes: 492ac37fa38f ("perf kvm: Add kvm-stat for loongarch64")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
