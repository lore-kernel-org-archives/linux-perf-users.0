Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86431D0153;
	Mon, 21 Oct 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526505; cv=none; b=L9rDkPUCFFLNrQi62Yli+VnwNCwpW3SoFdTy1og1bNM9d8Lu5kNriU1qnVMOF4JPdphOVmAT81A8VhSsV40HIgueCo5R/g9DQgQ6m0vpXIAyyQoMsMFSz/JvOi+RDvxnU6g0npbpA2Vd6JNJZBsAsaj3vNcneK7fSVilfkrytls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526505; c=relaxed/simple;
	bh=Nhxa5kOx0iAj+/T0R3ms+1J4YXNHCkA/zB+wzsAaK08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8ZzCIJmeA8AygFs1qfoMLEEBN2TfhFKlq0m6BvZVY0XDFGRUOo7PcDjceHOAprIhXpEJ1dasD7JE7bAs36snvvigKiraWoT6fP49Uopi8Lhz688ERj91Bwk4BR82z18O2NU2QgK3B+anpCOMRIcy3jrob/yIxbOXYSWjmZIzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyAG5bIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyAG5bIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDEAC4CECD;
	Mon, 21 Oct 2024 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729526504;
	bh=Nhxa5kOx0iAj+/T0R3ms+1J4YXNHCkA/zB+wzsAaK08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TyAG5bIevWrhW1h5euO8wqyzXBFF8koOqQu72txC0aGeZoVa9azi7VflfaereioYD
	 yVRpG3leV/Nu5ildgNkragTUtEuAimLzA2iqqPK83sHBDsF6sniY7aQqf1vZ4UPL6R
	 X4kFOzjBg16pcyunu9J6B/TGMDEHf7Y/xdEyqdydHzf8QrPpbBZ4ntDE3ZzzUQHM3I
	 tPIH22amRuDD/wBOV9ScbmN/3MwJYiXFfc2/5ZH2AwV0kDv3e3Q32y1N2c2M5oiHTi
	 RNem3ZjSlwG/yEw0iZOoTMhk8l8MBPGic6749rdcsKM5ATZpR3weh13XH57N4jenN+
	 L4SH4Wj+DLBiA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com
In-Reply-To: <20241018081732.1391060-1-tmricht@linux.ibm.com>
References: <20241018081732.1391060-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v2] perf test: Fix perf test case 84 on s390
Message-Id: <172952650435.3574386.7528819225898340561.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 09:01:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 18 Oct 2024 10:17:32 +0200, Thomas Richter wrote:

> Perf test case 84 'perf pipe recording and injection test'
> sometime fails on s390, especially on z/VM virtual machines.
> 
> This is caused by a very short run time of workload
> 
>   # perf test -w noploop
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

