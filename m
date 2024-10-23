Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDCE56A;
	Wed, 23 Oct 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719621; cv=none; b=UjfkubgSli+OCjMVnlJ5dFZtJqoPLiQWRi7hMInqPoETC+TuMWoEYhMfw/w2t+xl8Q1aLhKFTI07966pw5DNCghmTq0lfKdDI591NEEsqEL9pTWxW4Lxy09xawTsgsn4h4+Qlf3hDeab/291lk9Q3BEBIUz2P74TIc6k5QIOiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719621; c=relaxed/simple;
	bh=jKy5wynMTGLDO4QbtaNOIV9J+dPC4QzcKbiyxcc8OAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iqvgcmYmwmE0VFS3+BdsU/q2tuoCNSyXCTqUEQyjzZuQFjueOdoR8pYGbQm/ZzdiCozT1tkNeJ05A2pvBlLzySqHoc4grpQvIUdsa1Jwe1uUpYwFU6rOyBmdTPWKeb3Ru/4LvFxuXOTBYe82JfUXAawhU0rtTGN6+KihrhE3j6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvmneGLJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvmneGLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489CEC4CEC6;
	Wed, 23 Oct 2024 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729719620;
	bh=jKy5wynMTGLDO4QbtaNOIV9J+dPC4QzcKbiyxcc8OAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lvmneGLJaJAhIpfhm3WrgR7wSBK+DGY2fMzLotIqa8qUxvclbXNsue7Ij/RSiS6J2
	 atOSF1wEnMRs4j4CdSJTAlikj5onoe5cSRWJ4tZsc+U+iY8FhkIuN+rFMygzh9c5vN
	 zyozdl7jWwgfllWumgD//Fp80P0NGUlHnvfpAKWcWwiyG1otuiNk1vx22wkI+qg5cz
	 YrcsHn9pJkdlroq3jdgGLeNx/1Lk0HFOTQYkpLhoO4zKuft3+LXhWrb23TvO1LOXFL
	 /lfJ+FoFA/Cbf6acSeg/pMTl7EJOQkIy2fuTag5RqS09i+y84UrYVI6JyPGVX5l+Zy
	 dU2DCLkHkqn5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAE23809A8A;
	Wed, 23 Oct 2024 21:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172971962677.1732914.2511360924070038542.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 21:40:26 +0000
References: <20241023200352.3488610-1-jolsa@kernel.org>
In-Reply-To: <20241023200352.3488610-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, sean@mess.org,
 peterz@infradead.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 kafai@fb.com, songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 23 Oct 2024 22:03:52 +0200 you wrote:
> Peter reported that perf_event_detach_bpf_prog might skip to release
> the bpf program for -ENOENT error from bpf_prog_array_copy.
> 
> This can't happen because bpf program is stored in perf event and is
> detached and released only when perf event is freed.
> 
> Let's drop the -ENOENT check and make sure the bpf program is released
> in any case.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf] bpf,perf: Fix perf_event_detach_bpf_prog error handling
    https://git.kernel.org/bpf/bpf/c/0ee288e69d03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


