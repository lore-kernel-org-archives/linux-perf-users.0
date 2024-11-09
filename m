Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB41537C9
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170240; cv=none; b=O5BIJ6vjoNomlThxxO0v8HSNwwqErDYDlVF+FaDFQz7zGmOBk7iAxvr9oy6ANfhj5mJdcAsc5TJKMBAdYZDCQOVqQ2n3tRP7nln+USCnxyJz20j+c+4AOSieRnZupJ/pGz+Fta1u708G/w/z9iln6CgGqn3qI7aik7NZl0mZu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170240; c=relaxed/simple;
	bh=trRB0NURzM3aqiuztw8lik0hA7o4p1x1FN6JAdoFYgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bdhr9MopToCP5DO2vfxqJ7+6d67rZF4vAJpZS5ItEJY4E9bNKwLclb6zkwdyeyVTqu4zGTcZvzKDtwUW3ghsfXPCeEK/n2H8eUsq8Dr7UVp4r19X7JZL2bDdczE/mlZGGzlLjOHKQRkarqJnnjUIgNeJtUX/18atnSKeahEB/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnv9l75N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnv9l75N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0CBC4CED3;
	Sat,  9 Nov 2024 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731170237;
	bh=trRB0NURzM3aqiuztw8lik0hA7o4p1x1FN6JAdoFYgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fnv9l75Nj2ag2E8B+MkVkDucjnk0hhgfxt084UbuKWOojcascavcekQ9CnWfIG5pa
	 PqwiiwpTbtOleV/ufp+MKRtcGl7wP+2vf2lBa3OQG/t5nFiAOoc2EcKSyJIfy1olJS
	 Kcis9nZQZ5hRBrpzAXrpq4NAT9WycmarEqr0e6gg5nphaGPyPVyIA2wbMHUBPvNvtY
	 qUMT5MBQN2bg95SwZg+sBP3LslEP4onMr6ClLsnRbBgE56jJ1AlRicThN+03hm69O4
	 pPAEPqUCs2envEnwlnFgdXRut0P8McfVX/gdUp+POaAc2GcLfHW09Pr9/AWyUvtJn9
	 cA+yzdQJs3OAA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
 leo.yan@arm.com, amadio@gentoo.org, linux-perf-users@vger.kernel.org, 
 Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, linuxarm@huawei.com, 
 yangyicong@hisilicon.com
In-Reply-To: <20241105105649.45399-1-yangyicong@huawei.com>
References: <20241105105649.45399-1-yangyicong@huawei.com>
Subject: Re: [PATCH] perf build: Include libtraceevent headers directly
 indicated by pkg-config
Message-Id: <173117023693.3738736.10833584224263234072.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 08:37:16 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 05 Nov 2024 18:56:49 +0800, Yicong Yang wrote:

> Currently the libtraceevent's found by pkg-config, which give the
> include path as:
> [root@localhost tmp]# pkg-config --cflags libtraceevent
> -I/usr/local/include/traceevent
> 
> So we should include the libtraceevent headers directly without
> "traceevent/" prefix. Update all the users.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

