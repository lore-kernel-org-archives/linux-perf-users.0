Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19BF1F4176
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426359; cv=none; b=PCxhtuk66uGUDA6fgI4+9Trrd1CmbmxaOfHYlA7t8rWBPyL5E9ObfmnA5l904de+MXud2XC+Hlzd6oGyye0Q4MAPhl2BAx6qy27gJCh9bEI6hQP8Dhx3LPAx4zuV+/FV9ezzMVwRZH4lSAAlmyswTGndc8UCUQUl4Ha2mR4TKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426359; c=relaxed/simple;
	bh=rx1yDtLO7NKQE9me/+5JmW6I94eIeaAnAVQ1hOJl3qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BB2Ncc58p+PF5f6LT4ncRhAUSLMkXXHj+rUgFRHkd1fBGiGgZacPq8ZSSHGcZkzv8LA62yUSo/h76W3wnw5J6qLYAUAdwhJdfNzMLOvjMKD2eixSckLcYN13ViqMGQAcuyb0m2ZqHf78wtRIJW5cWBAnRy/OVd0ZMWJQpdsSUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsDXiPy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsDXiPy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479751F000FF;
	Mon, 14 Sep 2026 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426358;
	bh=rx1yDtLO7NKQE9me/+5JmW6I94eIeaAnAVQ1hOJl3qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsDXiPy8lglmLyIIvdMfB1F2/PNGxQlGpN2M3dwM49CJSE8twquo0FLScKG4fVnbn
	 QaANBcr2ddsTSnk3MI/bXSWsuECdUQYSDir5nc+aMyg8v7ex/M0sN0LWMeb4/mCG2k
	 pMwybbHsCYp8k9z8FJFlgk0cwWF2d1MY8jCc0mB3yfBRtWP1ajSyKiYilSF+j+qQvT
	 //z/yS6SYmU6+TJQdq8nkFe0wSHyXxk+3JKa3d9So8PAQrFmeWelQuZ6hdw3eozyXO
	 XwxWyxFDYaOzYHW12tBjkBwfD5JRfLNwLZtRjPmxCi0qbV3f/G3oXLXI2HKzSRQXMy
	 I820EvE0VeiHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914224650.52982-3-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:52:37 +0000
Message-Id: <20260914225238.479751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>=20
> The L0 cache is newly added a small piece of cache which is
> the closest, lowest-latency memory cache tied directly to the
> execution pipeline.
>=20
> The table "Table 9-4. Data Source Field Encodings for Panther
> Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
> "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
> Auxiliary Field Layout"[1] indicates the code "01H" means the
> "L0 Hit - Minimal latency core cache hit. This request was
> satisfied by the L0 data cache."
>=20
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel=
-architecture-instruction-set-extensions-programming-reference.html
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914224650.5298=
2-1-thomas.falcon@intel.com?part=3D2

