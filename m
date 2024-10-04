Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9011DE2C1;
	Fri,  4 Oct 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070155; cv=none; b=Ep6jb7W68KL2P+dnLzDkLbXwfSqrk6CJsvezq0bcXEsgm0iUl3OyGnPcgLkrRx31H9fWH1V103i95rGgzPCZKeohffNDaVAN7waNze2+UhQnzjCoZWUwbuiVWyfOtxJfxT24odTtBgYtO3n1rZIBr6HbxunmE8SSnYC7nQ1oFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070155; c=relaxed/simple;
	bh=JkPmcqnYmI9E2oEefcK9E5Vl7RkRYpDpmqsXOhsLhD8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BJ1jnKFVBO2PbPjuRhXaxMJnmJ6RG3Gb/tnNiT6t8jW7EESB/a+YaQlbNrDD9gJVeTnjeDnvrCD+tozP9uNJCtjNQngW6ErgF6WMgOdNfyMzT9G7yL/l1FpCG/0ZYecS7eYWBYF9MI2Kxj+hS8tAR1nqKf6Pi8fW+sfDbdsYB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/Mgkv4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Mgkv4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A9AC4CEC6;
	Fri,  4 Oct 2024 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070155;
	bh=JkPmcqnYmI9E2oEefcK9E5Vl7RkRYpDpmqsXOhsLhD8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=j/Mgkv4ijvBfv5JYZ38NFc0ww/BGJV2V+Ll7szlIrtbSzInveku2b0JQOTfOCGHb1
	 FWNQWlM3XsXviPay+VEzzX8MN+1UymTbCbmzFG2pY2pJlqrNrWtxX53lk7NdJUzzx8
	 NQmDlo3dwcrL113HJBrGdc5a9pmysEuW0m3pV4fPGjjf0huwrXrnZdgHHiShHwwkTB
	 mf7UW91GCAlS/AdwHpWo0LUumDH2zLJ2jxgs1pJlhx+kYnNPjHB/KuBuYCRyraZZ3N
	 +TxsVcioKytmjVijbJK/qffs7Hd6yQurODZOa7Ho+4oON/c5amknndsQwK6e1h4rYs
	 JSftSJ2AlcMvQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yoshihiro Furudera <fj5100bi@fujitsu.com>
In-Reply-To: <20241003002404.2592094-1-fj5100bi@fujitsu.com>
References: <20241003002404.2592094-1-fj5100bi@fujitsu.com>
Subject: Re: [PATCH] perf list: update option desc in man page
Message-Id: <172807015451.55364.15671532984152524675.b4-ty@kernel.org>
Date: Fri, 04 Oct 2024 12:29:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 03 Oct 2024 00:24:04 +0000, Yoshihiro Furudera wrote:

> There is a difference between the SYNOPSIS section of the help message
> and the man page (tools/perf/Documentation/perf-list.txt) for the perf
> list command. After checking, we found that the help message reflected
> the latest specifications. Therefore, revised the SYNOPSIS section of
> the man page to match the help message.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

