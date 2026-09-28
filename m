Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D678C9C;
	Mon, 28 Sep 2026 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554059; cv=none; b=N3J4Zwf41n2B1PQNnXzoiIaTXjWFB8IJMYsucOHR75kj6Na+Xj/yZ0lvD1Ui52M53eDS4pKMAEI6sGrqTRY8GA6SQto11Y3KbHSuRw5LS8aJ/DD/KSZ7Yx6DOgsoN48dNLHWMdLChkW2cJGUMsQQEHcnf+AQ0Bg82EYC/35UY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554059; c=relaxed/simple;
	bh=Okr4uqYktWeZOfWRjDeSrS3WvovN+fTCf5PWu32cQPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDGnOxomm1qRtrvdsscihmHpO6fORggGcBXmdUCSGQDHyf58pPx29yR9mhNJSzXEgp6sS+nc7qLnTVDTkA893mt2DFXJ6cp8lf7lQxSLDvtLmxknJuaSmFv90xDfUGTZQzeuC+IobZUgpap0I2Wb86OMg2Ec+8El5zLQZo1C1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqWFtm10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqWFtm10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D90A1F000FF;
	Mon, 28 Sep 2026 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790554055;
	bh=Okr4uqYktWeZOfWRjDeSrS3WvovN+fTCf5PWu32cQPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqWFtm10DazuaUrLnfpG35BiyeQSUGz2InycyxIzOHOdKkOMs6bh36uS9aaaAcJPE
	 EtDWZhzuIQEhe/b3p3ypS9V3BP5ZC5ufoezqYv0CGCjMZFPG2TRsscfX07DfeGUOK+
	 b6Fl8UQRK8/VZPZqE+SmVHcDACv/POvSRrIrFUizHjvdwKGZU1e0WgmG112bK2/841
	 jV0G/8fpfMtcYtqBYQXiFUr/q+jKrK313cfs2lfP5Xwg1XX/YKl2Izzh+PRumgHdu2
	 fVrn4QJS4ya9PLszHhcFVV+7DJ2396ehcsw+mpKrozJqDYHuO1rc2eXq4Ursih1b/0
	 CdBe46YR3viIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tracing: Require tracepoint permission for perf
 function filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhengchuan Liang" <zcliangcn@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <95d3721fa8d4c7a4577ec14e9d7caec4fd0cefcc.1790553331.git.zcliangcn@gmail.com>
References: <cover.1790553331.git.zcliangcn@gmail.com>
 <95d3721fa8d4c7a4577ec14e9d7caec4fd0cefcc.1790553331.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 00:07:35 +0000
Message-Id: <20260928000735.8D90A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Count-only perf tracepoint events can be opened without tracepoint
> permission because they do not sample raw event data. Their SET_FILTER
> ioctl still parses .function predicates. Numeric operands call
> kallsyms_lookup_size_offset(), making ioctl success an oracle for
> recovering the randomized kernel text base. Symbolic operands resolve
> hidden symbol addresses and can also match user-controlled event fields
> against those addresses.
>=20
> Pass the perf origin through filter parsing and require
> perf_allow_tracepoint() before resolving either form of .function
> operand. Ordinary perf count filters and tracefs event filters retain
> their existing behavior.
>=20
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to =
function names")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790553331.gi=
t.zcliangcn@gmail.com?part=3D1

