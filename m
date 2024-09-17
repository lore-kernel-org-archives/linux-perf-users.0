Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA717A5B5;
	Tue, 17 Sep 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578043; cv=none; b=FAHRw4Fyjs/cIz1E0lG03zBdgpDRPUYjCMXANW9dMiKeWFVUM4oX62S5Sn5/1LWQ0bVefzUgoWLZPbvHsMvS1wGJ4kCpSwFKS8AO8qQGrTv0ln1rdbjk3K4sJzNN0i+Qr5uRVblr/VZK8G+nF6VgegjW+aGff3rusDtbhrccK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578043; c=relaxed/simple;
	bh=T/IyP9pgWZ80Y0k3xaS/Zgh3pLNXXlXoZNG7fPR+7wA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfTLyaSwnl3xZEam0X9mFeQcYgGf1I1GIIu9LWfbKLd7cpfWtGpFzdFnRUxEEW3ULJTGV7gQPgfLxW6Wj2FxMqv2ekYaRoYWol0H8q7CqQwXsGwNJM+RJskmWLaaaMoX5pro8d8LyTMhW/HWG0LlDjgALcU1G6F6uinnU0ZLl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1r6ZdXk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1r6ZdXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951CFC4CECD;
	Tue, 17 Sep 2024 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578043;
	bh=T/IyP9pgWZ80Y0k3xaS/Zgh3pLNXXlXoZNG7fPR+7wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1r6ZdXkNJTnOEqfd5h/3+uxFCPmIfJo7LVA5fD7RmdXH5D2PZ007IRdDE0huLZBL
	 l8OM2xdDox6JggxrSQama0UcKKPsoItWU86mNo2jivz2LSmWa6WYKoPkAgylbbgPXE
	 VdyRjiXfi5Y7dDYxMDqh2onhJta0nS4xYN15ljVUK+OzIlJm3jVoN1q+QwoSYrq8Tl
	 4R0NUtW4wkH9db/guo3Rop0L3MrTnK5s44XvJudvQtZmaSeyBQA527OG3QJHtx6JbK
	 IFhx5zHQVRaGmfdNVUzg8Cgj/YWyA99exbme6ROXRxYpNRDyGhLzvInt3qFVD8zVHy
	 NpwzYpD0qoRmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C173809A80;
	Tue, 17 Sep 2024 13:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] riscv: stacktrace: Add USER_STACKTRACE support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804401.126252.11110872057144476877.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:44 +0000
References: <20240708032847.2998158-1-ruanjinjie@huawei.com>
In-Reply-To: <20240708032847.2998158-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-riscv@lists.infradead.org, bjorn@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dev.mbstr@gmail.com, samuel.holland@sifive.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 8 Jul 2024 11:28:45 +0800 you wrote:
> Add RISC-V USER_STACKTRACE support, and fix the fp alignment bug
> in perf_callchain_user() by the way as Björn pointed out.
> 
> Changes in v3:
> - Fix the fp alignment bug in perf_callchain_user().
> - Remove the LTP message as Björn suggested.
> - Add the userstack trace test info.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: Fix fp alignment bug in perf_callchain_user()
    https://git.kernel.org/riscv/c/22ab08955ea1
  - [v3,2/2] riscv: stacktrace: Add USER_STACKTRACE support
    https://git.kernel.org/riscv/c/1a7483318274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


