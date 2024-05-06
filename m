Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA42BAE5;
	Mon,  6 May 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027807; cv=none; b=azRNdAP/zajkhV2a/FBEs/BiC96Jq+Duwws+7W3uQC8d4qLujK+CUX81loahN8ZSMr0B+y4pk7+aBFya3ZayBk6vSWu0i7PTj9lC8Gks3RKRJneG9DvUJZLZtw1dGvDnnCb+mlc6jzzFpTLb4mAJeZ3GY1++mAxHD63bWorp0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027807; c=relaxed/simple;
	bh=MFDJo0eIxhiRsnVVVXF9lYzAO/U41RzeZgolMT6wza4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfTP1ChV7yfbnjOK/VB4R1B6++2TNTXwBX3G25fEoNPKHTJB4HA6kW+xw7TGY7rmpp5wD0h7/kKT1cndvDRISUruzEUU/KPSf5za80OLRufpXUHASI5I215eruVM0Q3FaoP2PEZJR22IR60xQKqrDElCvSNUSZtLUqdUp1mkELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCdu6jFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCdu6jFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32268C116B1;
	Mon,  6 May 2024 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715027806;
	bh=MFDJo0eIxhiRsnVVVXF9lYzAO/U41RzeZgolMT6wza4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCdu6jFlfU7OpB7h7GtDxgprv7pl++K1tHNGhqT6WSPomS3yJaXsJLAChBqsnOHBk
	 KAGPwSB2ZuShVcCcBUxSOfgGJltAlFX28Nvg+HCm2bYYoBKJReTiAb1moY7twPXn5r
	 7c0Jo/DvqZxKbTvQvv5qcfS26MczbwoOZJV15zUYuOIcpOjkuDhDZe/KX2uRH7uzp+
	 fWJGP+pSDTBhvwFAdcFz99yWHx3lJSJhDY0DRd/nhvsv8od2YxG5Jods0z1NIU8xja
	 tfjHXtm5ns/euLTaR2Y2Ns9CFJlB+0fU+O+2NuArfrFSU/oC7YVHf4kBgyWPLcY69Z
	 awoTi3WGnIwBg==
Date: Mon, 6 May 2024 17:36:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] dso/dsos memory savings and clean up
Message-ID: <Zjk_V1GSYJFGX2Dj@x1>
References: <20240506180104.485674-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506180104.485674-1-irogers@google.com>

On Mon, May 06, 2024 at 11:01:00AM -0700, Ian Rogers wrote:
> v7. Rebase dropping 5 merged patches. Break apart the fixes per
>     file. Tweak to the map dso logic as the else path was missing a
>     dso__get.

Thanks, applied to perf-tools-next,

- Arnaldo

- Arnaldo
