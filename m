Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39027377AA6
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991202; cv=none; b=tKsVnoK769Wgdj+ishGeECqnA8zxc+g6aN004NokZvrJUhgTqxKV6Txu+QhrGdihGNyQH/O70zgraCUFW7dZQL7iRvTY5O3Y87+R0vaVpPXQoTng6nYHpdpqdEn+tFYU7+vC57PJr1mRDcZ0wFbG1X0WXQQhaHIQlic/9OBmECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991202; c=relaxed/simple;
	bh=Z7Tg9ngYFPhiqg7TXmVOfwnX8R2Ihr03P78ZNXa5lqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nri3Sig0OeOsPI9tLiUAduCZpynQCgHSGPMVUTqI0lhevRijKTofJsPUp/vFWljst9GZ/4+QLU8rQeBRxAruiw79kQ6bsg9BE0uB+0u/B9JFOAy4/3tbFK4zfpozalrEokN508N8t1IEFZ5W/rMR62/unjkLpUvNh4JureComXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhvDrwa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhvDrwa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6C81F0089B;
	Sat,  3 Oct 2026 01:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991201;
	bh=Z7Tg9ngYFPhiqg7TXmVOfwnX8R2Ihr03P78ZNXa5lqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhvDrwa8ZDTKMLNzTywImMyqYOj0VIfH/e5d8m5ejeX4FIxVecDUJ/QV6LHdmiDY+
	 JNGt5KYRvN+/tTwPf8fyA4LHATn6UevO9QHGOUg4qGq3L9nP/n/YEWEDni297caetF
	 1ZAhiaNFUy7vqriMZHjz2AoF+WSgB7gBmynfJiuIu2xFAnbbCYtvPmZjPjG+y91c0T
	 qP+zYgGPRvReuyvFDJDqTvxOt9R/14fnBhj+HRlzyfcuCGOZQUuOeoFn4flkWw7NMM
	 Xy02K0VnzwAx3ovhVu05ASYugxHx1+R2ToE4l1b03noidlkgK/JX7C9y2sSb9Kqi9v
	 jTRaC2ZOZXUBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] perf record: Add --buildid-offset option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-8-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:20 +0000
Message-Id: <20261003013320.EB6C81F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the --buildid-offset flag to perf record to natively request
> PERF_SAMPLE_BUILD_ID_OFFSET and PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
> from the kernel. This configures the evsel attributes by replacing
> the standard IP and CALLCHAIN bits with the build ID offset equivalents.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D7

