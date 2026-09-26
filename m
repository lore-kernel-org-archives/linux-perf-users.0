Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA8387362
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404189; cv=none; b=L8sZaEQ4Ywat6JXWLFR42tBto7fNCQHiijdkJKxFA9tcrkTVl8//fBnAdF1Do7mGrRYC7ydTPThXSG0YwMMTdimMTXuM+Vk+0C2GOlCIVKjCLlx+ldgfDPK5ZXyZ3+muH+u6gsAME14o+i9kls5iYVyhn94WtzOX641Ik46rn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404189; c=relaxed/simple;
	bh=WfHtAXSWB0qhw1Vk0Z30rNhbTBLI8ItEV5QrcE4D410=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SH1SDMzVVU9PAs5+02TaF+an7hlty2W/ThpR31RFKh37S/iQFbXj1q2pe9sceNLCCMM3gf+YJ2Kjn31ue8bX7Clm/XrR8q3K53EEdsBZ/LIoMn0JyiqaigOzNksn3Ogw5XR1tV8Z3kmlB1ngkXiWt5bFtynPqrJBEDZ/v+kCBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJafzSnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJafzSnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2906B1F000FF;
	Sat, 26 Sep 2026 06:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404188;
	bh=TyUKJQTe1XH/C7r+xRWJDn/Hjx8SH9J+KErI7TcnUug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJafzSnTOnY8+tUO1tbE1Xsr2YflaAbrckagt+d9L/qZ6l+bKBaRugRYPpTygPe1M
	 CKPuogjLQOZNJInpknON4iDQO7C7mDN4HCGOBa0oEMzeV7vR0fcVoKmpMtsQjXdnyD
	 qq/lkZW99E1+Oa59w0PMvS91RWXP/eYzjEo4CpEfGoDAWCGbXkMBvAIaxqEcU/8ITM
	 xrgE0OfSP6XEPBxyKf7L6xgB6vvijvrbFfyrTrsalh3XPRWUTaKSEsAU3atri1Ogx0
	 3/pNlTslWM/YYiuJABolTX4u1zUWDrV1yfw4jLozCDUxn3sGA18YVvqtU4fG8a3Yq0
	 2RWGMrWvYK5ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/49] perf pmu-events: Clean up mypy and pylint
 issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-12-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:29:47 +0000
Message-Id: <20260926062948.2906B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint warnings across the pmu-events Python
> scripts (amd_metrics.py, intel_metrics.py, jevents.py,
> make_legacy_cache.py,
> and metric.py) in preparation for making MYPY and PYLINT build tests
> opt-out.
>=20
> In addition to type annotations and unused import/variable cleanups, fix
> three bugs in intel_metrics.py exposed by static analysis:
> - Fix references to undefined 'args.model' (instead of '_args.model')
>   inside
>   try/except blocks in IntelL2() and UncoreMemBw(), which previously threw
>   NameError and silently disabled Skylake/CascadeLake L2 silent eviction
>   adjustments and uncore memory bandwidth JSON loading.
> - Define DC_WB_U and DC_WB_D before their first use in IntelL2(), fixing
>   an UnboundLocalError that silently dropped the l2_out_rate, wbn, and isd
>   metrics.
> - Fix Event-to-string comparison and addition in IntelFp() by comparing
>   and modifying 'f_assist.name' instead of the Event object 'f_assist'.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D11

