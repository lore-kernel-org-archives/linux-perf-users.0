Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1D39E178
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899228; cv=none; b=UKMKZIYox5hhOm4KyYWLWhwot7vYVT2hFEOdqVZD7h2mW/cgDJfG18wc4xO8LFSGiTJFzZSsk2+wMiUzlIEcnrdN5LHvx3Pr0xC3mH72KU41ZdNcYLqaHdf87VSz7eq0MeICwg8GCekRYSSK38NwFlO58+iDSpZNxE85u7LwSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899228; c=relaxed/simple;
	bh=1hYHDvqOZUSNsyS/xTtyjzhj5k3/QYoKYYs5CP9PA2I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FHgg4J6ywGh27F+LzEXL5O3vsoZQ0bKaqfgmsdVsX7IzWDJ8lxO1q8XHDgzht9zEDOwYhjKeoMOPkG7x4k7sXQsXRIsOWncvCpElcVBdTfWBhMKhlnhl+dYp0r2W5/IDo+Sx1VdmpgNtLXAXRRQh8fSyQaMAf50L516bUOIe7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG3cpcLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG3cpcLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93B81F000FF;
	Tue, 13 Oct 2026 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899226;
	bh=1hYHDvqOZUSNsyS/xTtyjzhj5k3/QYoKYYs5CP9PA2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NG3cpcLJAGsNM7i+r9rPkKcY+2sYZf0OQWDz4CA7Y/ngvwjbcSKrAJa4clpb819dq
	 FqO71emOfMTqyU374ehOeb6MEdzcSHRKkT3Id+UQ+kmNIoji4fZecbENviQYUhbTLk
	 HxH8ZnXuCVS6/QhNBIzL82WcJS0rHpjOG5IJpDN2wabVUToWpWWJWrNAJTthChgHKY
	 m4VObWTe3EywgKvF/lxgyOgxjtCcUD1eMTwCwa/mbJWPOwO1uO1VVRlzXLM9jRdPEK
	 yNI2ZdPqcxwmng64gPokYHoM/sH5pNqGCujDjmNqfwZkygr2lT1DyRWZWhNInBlAiD
	 RRJxW5jHjiYRQ==
Message-ID: <sashiko-outbox-169861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] perf annotate-data: Track imm_value for stack
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <17d6b9f6545a0af1053a308db4a2b539fb93be03.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <17d6b9f6545a0af1053a308db4a2b539fb93be03.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:47:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, imm_value is tracked in registers but dropped when values
> are saved to or loaded from stack variables during type profiling.
> If a register of type TSR_KIND_CONST is stored to the stack, its value
> will be lost.
>=20
> Add an imm_value field to struct type_state_stack and update
> set_stack_state() and findnew_stack_state() to accept and preserve the
> immediate value when updating stack state.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D8

