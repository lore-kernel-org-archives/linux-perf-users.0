Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2737DA92;
	Mon, 26 Aug 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715287; cv=none; b=J6rsF/G39m+GUZSVlTQpeiGjg2GXKsHmurnZyDBm0hx0lvqYl98KTGZXKY9NynjW4tT3+l/U3qkfs70lYOaonpPFm5kXn4opMBbImtzY2Fog2L4/QaHK6hO85U+Aarx8g+Dw0JokZbVSMxoZOVlV+4kVCaWPLm1uS0B8AkWVgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715287; c=relaxed/simple;
	bh=oPJH4KLtGg8l9XraRPJikgy+VRDJF4zXcfVhPAShEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G125cZm+4mie0ipw0bTdqOQ7pA1qIkpAevuatbK9KhtvESeJag1nW+NLChBq5fvXboXyokUmp0nvkY/w0JtpRzehrXLbMh4O2jUroyX3YJp8+Tbt8+eJxENpYjYlFDjYeGhWE4QNZkwVKlaO1ErLJW+Srq4vvQ1AERVLb85Cz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxZr0/hK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxZr0/hK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5DFC8B7A2;
	Mon, 26 Aug 2024 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724715287;
	bh=oPJH4KLtGg8l9XraRPJikgy+VRDJF4zXcfVhPAShEc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxZr0/hKFsgM7uU6Re2NR0y7KNR831Ko6ln000tawk9/9QG8z+fyuirdBQokssvxr
	 ePCFiZK+j5pTHv56ivx/+tzpnx63HHpjzXxa3bEL28K6BOEE8aU30SZLzdObdCdks+
	 2dkG8KI45Qyh8UzlYmHbIjiJlwojuK4gAeZZhQH3d+P2r+wT29MT8AHAWg2NsRwhmb
	 sWl1n5A0RSzQkwO3ayDM0b+45pT+JtjWc1qE3MOq7CRN2qSH3bBS7DInkWQlhhTiKe
	 hYciYTJFO2IbykrQd18FHad/MCbB52F14fgj/s9UerllP4QLCyQzswwNt4dQag4ZnS
	 /Wshp9WGqbp+A==
Date: Mon, 26 Aug 2024 20:34:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
Message-ID: <Zs0RE60KpHyZlj8g@x1>
References: <20240813213651.1057362-1-ak@linux.intel.com>
 <Zstiry-K_v51oDC4@tassilo>
 <ZsyR4eQr8X-q2X28@x1>
 <CAP-5=fWKiN8jJ2rehG+0fw_REyYZxC3562KLBG1g9jHCyXMRvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWKiN8jJ2rehG+0fw_REyYZxC3562KLBG1g9jHCyXMRvQ@mail.gmail.com>

On Mon, Aug 26, 2024 at 08:27:43AM -0700, Ian Rogers wrote:
> On Mon, Aug 26, 2024 at 7:32 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Sun, Aug 25, 2024 at 09:58:23AM -0700, Andi Kleen wrote:
> > > Arnaldo,
> >
> > > can you please apply the patchkit? This fixes a regression.
> >
> > First one was applied, was letting the others to be out there for a
> > while, I thought there were concerns about it, but I see Namhyung's Ack,
> > so applied.
> 
> Can we not apply this? See comments on the thread. Basically we're

And what about the reported segfault?

- Arnaldo
