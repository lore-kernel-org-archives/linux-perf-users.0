Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF426738C;
	Tue, 13 Jan 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337469; cv=none; b=PAJIljQx8vDY0zmA5udUxibWXRwzsDZe5XwwxKl4ux2DUyLJnxYoP8SgyVhnkNvXHSfTZxkWF6rv05qLvFKP1hTLodDWFVosjYn63yXR9ntteffnKXfQX8d7FS8Vk0wzSfhzSvFEV6drufTLYT3stV1H5uHcjsnMLMV20f+UnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337469; c=relaxed/simple;
	bh=NFwBjT4kFkm446c7jci53iP8L/+BbkTGCvjXyVA9DIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfSpTDGkIL02fADMyEH4M7d+AIzsJJqBvd9W7UpAAoPg7ecWbpqerAsXfVQDZXSR72OzYXlXJsz2cHLFrZuYLEz30KeUl9ndZIi9A1UuNcu1m+z/oc9hLvKzYvd7xZROEIYOeChuVksGBBq+8iNiDGn/aoOQhLmo88+S087IoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpGcWh0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpGcWh0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D5C19422;
	Tue, 13 Jan 2026 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768337468;
	bh=NFwBjT4kFkm446c7jci53iP8L/+BbkTGCvjXyVA9DIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpGcWh0R5DZSq4fqhi8iLVZR+rsMu+oG3PF9MwSocWq80nSppKZSoMZofp9Rm6vDn
	 fgYBwHuA+87BfEPr8dlizTCBGh6vRpv1HFHxdvp1qcmaQz3zIyQOfTL4IfB89JkYE7
	 TeepAF3e2oZ9TsTUEUkWJPwv2CU0Mt0//YIOdyuhgZf1iBJoZ5pVmbT7y1BMHDDaU2
	 E0T8TdvLaOba0U3Lt7a222wAcQnqF+uqXPCgne2uT/Ur/ZPSL4L/qYdPNdGjrbzEbR
	 2QiQnvRT6vOaUr53xhLsoefy5C2oJpA7Myw6oTL08hjyhcIVMm9MDndB+U1/rObKoT
	 TRMvH1kf7ohSA==
Date: Tue, 13 Jan 2026 17:51:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v3 00/12] perf cs-etm/arm-spe: Remove hard coded config
 fields
Message-ID: <aWawOTKpREcVTtUL@x1>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
 <CAP-5=fXrLck7XACML16hzQO-pHGXA+qAM69kDDC6Za4O5S=SmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXrLck7XACML16hzQO-pHGXA+qAM69kDDC6Za4O5S=SmA@mail.gmail.com>

On Tue, Dec 16, 2025 at 01:00:32PM -0800, Ian Rogers wrote:
> On Fri, Dec 12, 2025 at 7:32 AM James Clark <james.clark@linaro.org> wrote:
> >
> > The specific config field that an event format attribute is in is
> > consistently hard coded, even though the API is supposed to be that the
> > driver publishes the config field name. To stop this pattern from being
> > copy pasted and causing problems in the future, replace them all with
> > calls to a new helper that returns the value that a user set.
> >
> > This reveals some issues in evsel__set_config_if_unset(). It doesn't
> > work with sparse bitfields, which are an unused but documented feature.
> > And it also only writes to the attr.config field. To fix it we need to
> > start tracking user changes for all config fields and then use existing
> > helper functions that support sparse bitfields. Some other refactoring
> > was also required and a test was added.
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Outside of some nits, for the series:
> Reviewed-by: Ian Rogers <irogers@google.com>

Are you ok with v4?

- Arnaldo
