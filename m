Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978F3B776E;
	Tue, 24 Mar 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332470; cv=none; b=PdqQHBrU+oWHbufUalaplsHjLQWNAdcFm//Cygwf7C92rDfRZDiZSO3vfeeXo6MbsA+BKxxyfRQiQtCal4XNq6ClX83M+DcHj6W0u+43AXZ4oXC9uo1pBIRUHsLGfy+DCsLPfkI9rDJHST09nai6HiwH2/0Yq+A8kM9jaHnJ9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332470; c=relaxed/simple;
	bh=Y4QMrZV4zVS/5aSDdfNfhdu9cZMEiIqeRxLv1R4adrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tC0PWLfbZRW0VDomE629G4CGw8rdq3EEeKv9Yo1hhP6pLY2GFFHqKOd3d9B2FtjmF9MV2ftowO2r8wmnGZbzY3D1zcDAJinrW9R76jChM8npitMri/SO9/IX4iVYRy0lOdhMQckXGQ86mjxrx8O/vXHw7Sncwqk88FxuUuAMQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro/3ARx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro/3ARx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C37C19424;
	Tue, 24 Mar 2026 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332470;
	bh=Y4QMrZV4zVS/5aSDdfNfhdu9cZMEiIqeRxLv1R4adrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ro/3ARx1DnKEPiQSha/t39M4WDVDC+lnHyDefwbPFBt3WF4OIG0KNwx+qRu9Ici3C
	 Vgh6wCYUjAfEL1ArOxivtsYyD9cj1Y880h/ZZesN4vNhY+je4tuDxmZsWExzuY0h6E
	 2uAeFKaIN+fBbaxqIg1sHlmlvZb4likMx3PQky0JOw3cwqa6DjWab7JP57TEVv9f+j
	 mkHK7+086lY8lw83TpsnmilHXH1B1yOdCT9vE/ms54D0mZaG2qyohvlH06bCnUgV29
	 iT+BDPOR8J6fKNsPPbTleXXPWSakrur201PwC2JgQARAX9JYkZfWWshyyNV2GIbhbi
	 WbxsmKqfZGKZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F913808200;
	Tue, 24 Mar 2026 06:07:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] perf vendor events riscv: Add CVA6 JSON file
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433245828.469836.18293790832033550028.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:38 +0000
References: <20251204163854.10318-1-manuel.hernandez@openchip.com>
In-Reply-To: <20251204163854.10318-1-manuel.hernandez@openchip.com>
To: =?utf-8?q?Manuel_Hern=C3=A1ndez_=7C_OPENCHIP_=3Cmanuel=2Ehernandez=40openchi?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?p=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, irogers@google.com, acme@kernel.org,
 acme@redhat.com, adrian.hunter@intel.com, alex@ghiti.fr,
 alexander.shishkin@linux.intel.com, aou@eecs.berkeley.edu,
 eric.lin@sifive.com, inochiama@gmail.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
 palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
 samuel.holland@sifive.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Thu, 4 Dec 2025 16:40:38 +0000 you wrote:
> From: Manuel Hernández Méndez <manuel.hernandez@openchip.com>
> 
> This patch add the CVA6 JSON file.
> 
> Signed-off-by: Manuel Hernández Méndez <manuel.hernandez@openchip.com>
> ---
> Hi Ian, thanks for the review.
> 
> [...]

Here is the summary with links:
  - [v2] perf vendor events riscv: Add CVA6 JSON file
    https://git.kernel.org/riscv/c/240156b25a39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


