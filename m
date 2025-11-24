Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDAE571;
	Mon, 24 Nov 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015758; cv=none; b=bOtmgFSvGaoApxnalco6RSJ1eQt7u+kdr8+9UhhGvgKVQrSggHb0fbyAN+RUcV8cNV3By42bmq3jfpXPZrZrfgHZb3PI/ckA/6If9LHE1jIl1eyQDm2yu6MalzAd0hlmTXQnNmb+tqTqvxOU6O9Gotdjc2u+f/d/JhlvOY/FLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015758; c=relaxed/simple;
	bh=9cpV3hPEcSWt2nP+SqAQdVTrzwYE61khh6jlE/4yyzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmWIGSiKArlppa9C94nq9B89JfAgS5sECRuKn6OsUn02zq/8EUFu8lIwU1hcilTH1YFbIbSf6UFjEPs6ztLnrumqgMcJ+ECtY/CZaqxYKrSy7vDYXBLCvqlsGSeGQaUqic6kgQVNonURmfY8f9H/atEa4+GCXUzqAc+mXtrVvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SalgsBAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SalgsBAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06D4C4CEF1;
	Mon, 24 Nov 2025 20:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764015758;
	bh=9cpV3hPEcSWt2nP+SqAQdVTrzwYE61khh6jlE/4yyzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SalgsBACiW5P7RPLORYJOxDVrJb9AkDxWVSorKzlZFq18qq95ztJJ0veXEWLrIcV1
	 hAr3f/rJF0zah8tv8t4gZC6MjfAp+IqPScfGXB2/rRUST4UbIJqQgo5v1z2bJHe7VX
	 XWK7HiVxhJ0ucu76I7IMm+SdaD3RYSdpRNptn/lWN9s5SVKTH7B27WavFU69Ajxwwz
	 lWumUQNXmy8ZOARxpjrDRHYeeGjF8At/0VOf1wX9YlgCiCP7JsgTVTIW+D1pjVCTEu
	 MxDsyLxWr5/ByzSrKRIoFycwfLUXUBBFSjGT5V6DDaluTHWJNxQOzMeIpSjADp4bS/
	 1+W4SbDN5sHig==
Date: Mon, 24 Nov 2025 12:22:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf pmu: Add PMU kind to simplify differentiating
Message-ID: <aSS-jMEgzX30fe1p@google.com>
References: <20251114220547.496562-1-irogers@google.com>
 <20251114220547.496562-2-irogers@google.com>
 <CA+G8Dh+wLx+FvjjoEkypqvXhbzWEQVpykovzrsHi2_eQjHkzQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G8Dh+wLx+FvjjoEkypqvXhbzWEQVpykovzrsHi2_eQjHkzQA@mail.gmail.com>

Hello,

On Mon, Nov 24, 2025 at 12:34:11PM +0000, Anubhav Shelat wrote:
> On Fri, Nov 14, 2025 at 10:06 PM Ian Rogers <irogers@google.com> wrote:
> > +static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
> > +{
> > +       __u32 type;
> > +
> > +       if (!pmu)
> > +               return PERF_PMU_KIND_PE;
> > +
> > +       type = pmu->type;
> > +       if (type <= PERF_PMU_TYPE_PE_END)
> > +               return PERF_PMU_KIND_PE;
> > +       if (type <= PERF_PMU_TYPE_DRM_END)
> > +               return PERF_PMU_KIND_DRM;
> > +       if (type <= PERF_PMU_TYPE_DRM_END)
> > +               return PERF_PMU_KIND_DRM;
> > +       if (type <= PERF_PMU_TYPE_HWMON_END)
> > +               return PERF_PMU_KIND_HWMON;
> > +       if (type == PERF_PMU_TYPE_TOOL)
> > +               return PERF_PMU_KIND_TOOL;
> > +       return PERF_PMU_KIND_FAKE;
> > +}
> > +
> 
> Looks like there's a duplicate check for PERF_PMU_TYPE_DRM_END.

Right, can you please send a fix?

Thanks,
Namhyung

