Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC428FC;
	Mon, 14 Oct 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925180; cv=none; b=IGjOLQLQTO1Q7YknO+v0vIYIPKWqoWCB7PcU3xTTr3H641boBQpMxkwrMmjLWfOhKQpUGvBonc8UrwlPluspP5Af6hypzdqBomuXMY93aoaxxho1Gr5URwxpqHz2q4QoGU+ElQVfRjFQPKPuu1CSjj1HpxNo2k5yl5N6rkASEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925180; c=relaxed/simple;
	bh=KGXRkh3WUbNLSfQiGbWi/e7U8WWpJ38zyyEt2SSxtyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9jjhDvkV4Ho4zWvxfT1ULtDISuCzqlOEOQQPJoFc2Znrsg9W0zgVPoM2Tb2A6owZG96rmo8dLgwK19tEfbukkl6NbAPvs2UTKZc05czWSk/YCHCW+/ITHG0jWaJZJLSNCSeDUmRQdawJPD8XUsW3Vevq0L7F0CAFneexHoMcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdeq0pVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdeq0pVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1D0C4CEC3;
	Mon, 14 Oct 2024 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925179;
	bh=KGXRkh3WUbNLSfQiGbWi/e7U8WWpJ38zyyEt2SSxtyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdeq0pVdKEM/ldUOWrBXxLZ6/8ivBNzG2iWG2tLYH+gX7mrgwai2L26YdNWGxj3s1
	 HuoyIMHd72BnxignmfsfyKxykYW0oTs4+ZlXNjbNsfQn8nezwgm5RK3gxxPV/7G1Kn
	 cjCBOmY6YzGGyo37M0Pmy3ZlVd2QXBRxqmuGu5oeKUYYt9SoWMRHHH9WZcKwv6iqnR
	 cCyiOj0KnQMjrY8Uc5dEJM6k1K6kMtOb4Hu4kkfToF7p8L/ULRk1E6+5jkwXp7omcS
	 ZwczCfhZPUQPD1hO5pVSsv70IFHJatj6Ax+KDDop0VkLM6nhmaPtgXgPfWOD92TcwF
	 yGMxtzFoktRjA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	linux@treblig.org
Subject: Re: [PATCH] perf report: Display columns Predicted/Abort/Cycles in --branch-history
Date: Mon, 14 Oct 2024 09:59:37 -0700
Message-ID: <172892507794.15928.9191715089966160329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241010184046.203822-1-thomas.falcon@intel.com>
References: <Zwcg3ULyehsSODxF@google.com> <20241010184046.203822-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 10 Oct 2024 13:40:46 -0500, Thomas Falcon wrote:
> The original commit message:
> 
> "
> Use current sort mechanism but the real .se_cmp() just returns 0 so
> that new columns "Predicted", "Abort" and "Cycles" are created in display
> but actually these keys are not the sort keys.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
