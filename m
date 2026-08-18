Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD01335064
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094328; cv=none; b=E6Ft5Vj4jpdwO1ltJjRSuRvuHMHcAq2W3a1GKSVZ0M3jH/9Utn4Z0Y4Gg6rBfRSlLoOgUar3FB1bQY186P7P3X5by9HjO7kjpeKPVme5BPSGAr98zaaBE3i9/Qos+d3jYAolUe6fGbwxiufSQ7PWNnW/5HZFXzZ9j/w7gfu3Ji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094328; c=relaxed/simple;
	bh=JCTtv8k/RBjAE8Hrd2aCx+y7ncoK54ZFVBh1Olix7Q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdtiuML7SYnBgev3g95nDX6K4Mqu1O4bTjarkRgk842ni4RPySd6TKE1sVEo5ygVROpzBzOiVkMAaFVqQLCT2zAucg8WdGC2jd7rmtSg2aLw5f186XHXyPyzYnI70R2a/gyr/Fesh6b3AQOxfMDnzi8ZtAAoQPeFZqbGsftUFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9qnaQz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9qnaQz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0DF1F000E9;
	Tue, 18 Aug 2026 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787094326;
	bh=JCTtv8k/RBjAE8Hrd2aCx+y7ncoK54ZFVBh1Olix7Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9qnaQz09J5udpdGSQhNZYZAP4l3e6k+alUJYAaKyDAjadqO11zAuFjV9Scs7kEdV
	 FbsJY4oVlPmPpfKVjJQfD/1gJu7eZcl4d5jrQK9Dpt9fIv0eBEizx+TMjAfvfzQJB6
	 bmAxjDE+kNv6WFZfOEiv5txeJCXHWaTky+TA5DK+sWpHF9Gr2uqxQRI2sExVMNCPqI
	 imGVk4aAgRKcpCuSDyPghWQq+HxlPj57fFWxT2aX7xLcDEfYpae2rZQrtNTouvjc8/
	 29GUZmy9wGKpVcWTEPmVjWp/MR7TwPocVEom4YAIAdlQT7o1TnDU1vBniVCZAOvi6K
	 P6vAieJ1eAkiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] perf tools record: Modernize -W man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818230229.1491871-2-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
 <20260818230229.1491871-2-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:05:26 +0000
Message-Id: <20260818230526.8F0DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Modernize the -W / --weight description in the manpage to cover more
> cases that are supported now.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818230229.1491=
871-1-ak@linux.intel.com?part=3D1

