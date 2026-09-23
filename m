Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979AF47ECF4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187965; cv=none; b=Dr+rNTBFZQ0Ioxpb3lZar97rjI+tYU/szdPNILBE1OjmDDXL1BXcM0NY5gy76D2RzZxjMlPLa/3H/Sz8OwqpTlhuuKVHaUpc5Wohzd4wvAXMNMbrQIX2Qjgbnn5ra9aCIRuPt47dcdKnsTA1wuxqEmQS3ASwk7d+ay17aUVnXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187965; c=relaxed/simple;
	bh=yN6d2U/W8m+N7k3mDf7HwGC0c5QpK/CGrg/7i9grJm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rT5zVd1298rGsOnrPeRiiwphgfNTZl4ncaHIQ3FWovhoLrGLMrzJenk28hGS5BDJh8hcoVgTm9ydUr/cF4D/K0OxcoEjRlJPbkLCvyuGIyKznCRak3E+4G7UEyxK26fJS/PEFcIal2DFbmS2dWa5ZVzezFR4xUSRzUUDQJIx8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7lTaAtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7lTaAtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3411F000FF;
	Wed, 23 Sep 2026 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187962;
	bh=yN6d2U/W8m+N7k3mDf7HwGC0c5QpK/CGrg/7i9grJm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7lTaAtQyvM2DHyM8pk7hsTrN2H52UZSfKoj6jWUqKs5DHGF/tHvipK5u3YERQwHj
	 ursx776O860Mgg05X7qpGo+VTsTJKxoXx9urjET57HPbSdLwqxmkLOs0WMMBHCJ5aO
	 i5uhPQtjul6d0ytk9HVSKqEHrGVOXc3Qdpp/qXD/8WEJTGpq1bufLi0pHxr/HJfPJZ
	 QxVrnDVnCQBApvvvX3CP2dLs4DOtQxAT89/b0hFkJrG1Qhc/QCSfm/rLPSvKlE17Yv
	 6nR4Ju1/VpUjUe5Lr/5crWAWn3vK6Lbsahklc4UYHgaUxcF9EPUOEJXKWJNiLodtJF
	 L/kb0u0ytVT3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/49] perf Makefile: Install standalone Python
 scripts during transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-16-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:26:02 +0000
Message-Id: <20260923182602.8E3411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Install the newly ported standalone Python scripts (python/*.py), type
> stubs (python/perf.pyi), and compiled perf Python extension module
> (python/perf*.so, when built) into $(perfexec_instdir_SQ)/python
> alongside the legacy scripts during the transition phase so that newly
> ported scripts can import perf directly from the installation directory
> before legacy support is removed.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D15

