Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF12FDC27;
	Fri, 30 Jan 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804416; cv=none; b=Yk931eOhef8nSp5agX967nAqYYbSHRSBtkNeE1BWa5lBqePv6kAQ46zc7BYkKc7AJuhCrmuuZTWzK3z71nhv9QXhTNSOKllCTeoYOsadQnxATlE3s7GhKpu107YoY/MP4KY2nn1+oFQNSQmvjzCG/YpaemjgpFmTZ07V0em680U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804416; c=relaxed/simple;
	bh=GI0K1SyFWaUJzRajqwO+gWSLkcETu3gM/nIXMfnLFlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4fMJisg2dSGgR9MlsTxucR8Nodm0b/kPrVz1KPqR+F1GfMZmIBxp9QDviy29t/AuJE9qkmWkb6ZLd78xeknaf+kHngOh/jsqcwopvpz2zbf0FavW085EJwh9YFR2F+nM3UIzylWwZPjioWCEQu6mVgzYgasuU/LcStDxsVXdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekVLnh4a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekVLnh4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B751C4CEF7;
	Fri, 30 Jan 2026 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769804415;
	bh=GI0K1SyFWaUJzRajqwO+gWSLkcETu3gM/nIXMfnLFlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ekVLnh4aowIzbb0QZKWSJY00r1yUPkbxtN4ISqqGJlPNs5bbk5yYd0kzlsbCAwJ9Z
	 Ihh+62OObqxo13SiMU67d2D/1iE16lSMqc8gnNdpugWprVxSnLfhw066VC+rurWJmk
	 Vo+gq8Y2sw1ANX7Hv1cZfb7F/b+emHeIFjFYPETEMSXc4CkQmd1UZ1/ZTSl/tSumKi
	 ycl5r37QUHqICL10dzWWXoYSGWwMSxs9IjDnLDfAtkpvjquhDtEFGruNWJd5cwB8yG
	 nCliAWJULOYLIFnHkZIpn6SjTXFRRqUssi/3PPlGrlfNg91XgOAvcZr9WjVJyxfxWO
	 GKAszaYdPHe+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11950380CFEF;
	Fri, 30 Jan 2026 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: tail calls in sleepable programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176980440785.3880814.15917626921872259763.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 20:20:07 +0000
References: <20260130081208.1130204-1-jolsa@kernel.org>
In-Reply-To: <20260130081208.1130204-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Jan 2026 09:12:06 +0100 you wrote:
> hi,
> this patchset allows sleepable programs to use tail calls.
> 
> At the moment we need to have separate sleepable uprobe program
> to retrieve user space data and pass it to complex program with
> tail calls. It'd be great if the program with tail calls could
> be sleepable and do the data retrieval directly.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Allow sleepable programs to use tail calls
    https://git.kernel.org/bpf/bpf-next/c/0f0c332992b8
  - [bpf-next,2/2] selftests/bpf: Add test for sleepable program tailcalls
    https://git.kernel.org/bpf/bpf-next/c/15ac1adf0f84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


