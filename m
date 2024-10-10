Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECD18FDAB;
	Thu, 10 Oct 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575476; cv=none; b=sSz8UOVgS36tViLY/hlUYPWhpp0Nb/tuA4zncZm9rgEfeqlbsoB+rp16hUd8+AfWCKFvT7RdX+O+WiPsA1BmnuL8+VuxTfg/cAkxP7rDwibnzoIcEQcYwjyvDmKDtlViMGbQv6uBhT9S7gOcC4EYAyiyFdxUvX5xUq1ya+PjKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575476; c=relaxed/simple;
	bh=jAKRRfR5dMsM6IPiHAHZTHNfn9lv+cHMvIkPNYqzcOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQYIk0DhUaGQpl/NpuNRQzgLTTBSOS+Kw/HhFs8bqYw5aTcH4nLdos1pJ6iBeLTPMRo8TfxYgPIbiw5VsLv4rZGsd9t5Gq793T+OQbf8Dj9nayHuzyKcpdVmIojQS+ZsZY3tOrV8BFhSwib0lX2E23eINL3VG6KIZudRBpxpYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrrTVhxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrrTVhxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1967C4CEC5;
	Thu, 10 Oct 2024 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728575474;
	bh=jAKRRfR5dMsM6IPiHAHZTHNfn9lv+cHMvIkPNYqzcOU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FrrTVhxUPy/3AShSSmh8fNL5EZo+HJirLXWX7SwIcVmPLUNIE2GkIq4+sGRDZ24jB
	 D1+ZaizFIW4OrrrdINz7OSNKOm79AdTFGT62qnafpn/6qFY2Z84ij2E0GfTNI8Wnuk
	 buQFbmXylwfB/VksO3/4KNwkxCgFJ6zBHtVVx4BpXlF78bH4lvg8iJ03pcouBcsNK6
	 S24GcixYmDYOTEgdCGQteEvz3rUdsS4+7kk8kMZ+GHuIOBdA2+EEgkTeZ9ZDuCq90K
	 kdkqNb027xEUpQMTLYAmLWbxyd090l1/r59rDf4SN5uR7uiK83mOvHV+UEow3EJ0C/
	 IDMYtFoBffVNw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Leo Yan <leo.yan@linux.dev>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
Date: Thu, 10 Oct 2024 08:50:54 -0700
Message-ID: <172857541969.1131797.2693392463657578240.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241001171950.233723-1-irogers@google.com>
References: <20241001171950.233723-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 01 Oct 2024 10:19:47 -0700, Ian Rogers wrote:
> The path detection for "Setup struct perf_event_attr" test is brittle
> and leads to the test frequently not running. Running shell tests is
> reasonably robust, so make the test a shell test. Move the test files
> to reflect this.
> 
> Ian Rogers (3):
>   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
>   perf test: Remove C test wrapper for attr.py
>   perf test: Move attr files into shell directory where they are used
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
