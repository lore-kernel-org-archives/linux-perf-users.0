Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885C239572;
	Thu,  6 Feb 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862544; cv=none; b=U2S9Vkh59YIH8cUM/Tk9QdM7bpp5Vqu0JJIej1TuiG+4ijLtBelABnz4EKJ43iD8nywahOjvxcON5zdFSPmkLRDHXrhkBJ0vh91cMh0p2SrtatWbRBxgD4Fj4qChxMM7fU62wRCyi+zAUJq0Do1o3KyuXbk0b0WuwPJZ3klo1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862544; c=relaxed/simple;
	bh=GVf6mm0Afe9Dt5bb6iT8M6BS1u9qSeYT9EIRC7GGtIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fncHOo/9trmRensZ+Dm991gZPzsCj57j2p3V6faFHa9Vn+Gmb8DYZo5ukdkqhflnirTXxc0VSuAuxNyo9YrPYDX712g7mAM8YYePcTqS7cIwDYDtTFbi+KMfxV5pEEB0vhSw2IYcpd+9yI/VnvNwIc1Ku0c+v63YR7odIpxEqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bysmj2Qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bysmj2Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE262C4CEDD;
	Thu,  6 Feb 2025 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738862543;
	bh=GVf6mm0Afe9Dt5bb6iT8M6BS1u9qSeYT9EIRC7GGtIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bysmj2QiiakkGtuOaKZo2DZ4/PEF2AfmGIc878jpKk6rRF6T7fGKJRU5JfLRmMKR2
	 FaqqNBBE+bQli7ifpplOI6ORFRJCW44EOcvYUSJh7rA5hjAs5CIYKCu19lVysjs1Zm
	 Kzjbr/wZZCwUXP76dUAImSiQGPqCmXoVNPKXzfrO0HckNnKkFVzXb5kulh83ByexHP
	 9HBo+AN8uH0TKy/I0zuuDu6AGRMB8xcqK3DxboAOH3b1MgUvaslHFS6TATTlgn/pfe
	 0qSgkaWCAgInyU5VlOMRn4VXALtSZ5NK6TXLWSLA3pgQnltufqcEV0z9MHZtPk7Kdi
	 tY8Bub6NTDwqQ==
Date: Thu, 6 Feb 2025 18:22:20 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <Z6TvzPIyV5oYwhF_@x1>
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <Z2CJW0vFT005gmIe@google.com>
 <CAH0uvogp4GB6ZkB=79wCNVtOhsGw-aofzGmW6nPc--b=g-D9OQ@mail.gmail.com>
 <CA+JHD92xXH=6K0-imdObf+dw3=B0uiGdFH16DO3ArdHv3r1Zzg@mail.gmail.com>
 <CAP-5=fXRBssmhBZDTbk0=0_qzo6R6f5Kg4BGnE9M1AA2viR3=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXRBssmhBZDTbk0=0_qzo6R6f5Kg4BGnE9M1AA2viR3=Q@mail.gmail.com>

On Tue, Feb 04, 2025 at 09:56:43AM -0800, Ian Rogers wrote:
> On Mon, Dec 16, 2024 at 12:55 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Now it's my turn.. ;-)
> 
> Perhaps this could land?

I'm going thru the series.

- Arnaldo
 
> Thanks,
> Ian
> 
> > On Mon, Dec 16, 2024, 5:49 PM Howard Chu <howardchu95@gmail.com> wrote:
> >>
> >> Hello Namhyung,
> >>
> [snip]
> >> On Mon, Dec 16, 2024 at 12:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >> > Thanks for your work and the persistence.
> >>
> >> I think you misspelled 'procrastination' :). All jokes aside, thank
> >> you for the reviews—it’s much harder on your side.
> >>
> >> >
> >> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> >> >
> >> > Thanks,
> >> > Namhyung
