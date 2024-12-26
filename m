Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC3629;
	Thu, 26 Dec 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735226270; cv=none; b=iq8jmIDcrgkoayrJ6hXQhdYRPSVScrfMlVWqau6MxFow2tgJULLShECyYAejBQ/RuBsrg03UgEkEK9pvvwZqYP7hCS9C+sAKcmDNSNGzaUeR3Q8sV8qts5B51v8X3S31g7qWsqdIvQRxFGMo50rVjbF2BI4hEbdpmm/5c3A+T4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735226270; c=relaxed/simple;
	bh=+pcq3q/GtmMcb2/mx3f/a0T//0DP2SabjwQdYRMoZ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmGV4h3lpnF5qgo4E3geM3+Zig9C+RJD8tZirjjURfRHmkeNSz3TsAsiV/jCar0Y2pMUyR8SQYV33cZr2ajzzLpJYjPZDsSRJkNk0wpbcQAfxDiV/sDa5dOWCcfLR+pcjCyH3m/INANZwyclhzZ6RAwU/TINzBx192PG7Pxe574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSk2vU9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSk2vU9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081CAC4CED1;
	Thu, 26 Dec 2024 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735226269;
	bh=+pcq3q/GtmMcb2/mx3f/a0T//0DP2SabjwQdYRMoZ6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSk2vU9Kw9lu7lFb625FJYglxTIkXiXmz+AP/PoIiTMZlctjxZfSsLIQMrBJcCjiA
	 CUry5fOQT8jbQJkME851irwpGe10a8hcODWLMK8t2G5HMpOzzGhVx6/ssYeAN6SvO2
	 aKByKOnvaTleqlHwFvis5qbjYoOu859Y6zmZTiRsGIve7PyxM7m11JlhXaJSnO51gH
	 +Z08O+4UGPu+6QoB+iKNePNcCfrUrla9ssUXIO5/VrOHtWpTTSFPU3RuFMW6XSFCxi
	 fk8XsbHSew5TiFkyck4WQxAVBx7Sgf2yrmKds/qsH0yO/uslhoUFFa7dDb1mhr3miU
	 2gGTv1agOY2pw==
Date: Thu, 26 Dec 2024 12:17:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z21zmkbi87kybE84@x1>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com>
 <Z2mzzytPOpjF0Hxe@x1>
 <Z2m8qzyLdm1BEYuF@x1>
 <CAH0uvohvzQi_iE0q3A8jZF4P+cwu=4P1Az2guNKP3ckPon9HxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohvzQi_iE0q3A8jZF4P+cwu=4P1Az2guNKP3ckPon9HxA@mail.gmail.com>

On Mon, Dec 23, 2024 at 06:03:11PM -0800, Howard Chu wrote:
> On Mon, Dec 23, 2024 at 11:40 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > So its not just when running in paralell, anyway, its merged, we can go
> > on from what we got there.
 
> Thanks, I will resolve this issue and send v5 along with the
> documentation changes you suggested.

I got v4 merged meanwhile, we can go on from there, with further patches
polishihg those aspects.

Thanks,

- Arnaldo
