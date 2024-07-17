Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5FEC7;
	Wed, 17 Jul 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177334; cv=none; b=N6tKEJEkelNWdzmJRIbzxEyGFDS9h/em6k3qoqW6uWXoL3mx1H7FhNmGBn9JqtUVCIKC8UBOGnlzYPl7WN95b0bzdii9MVEP0n27SNybj8PCChai0i9bkIHXHrVVsdjjoThqVS0B+YjFS8gxbXvpbJ/k98lkRfwx7gYBQUsqvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177334; c=relaxed/simple;
	bh=dUfjmT5gzinhV4lAalxDfvFgPNs2XA130d13WrzQOCw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iErtOqu0Aeib2+7CVOXceMLdzSTAvChz5GIK0UgKlyXFAU2HCDQqZvBNfhL5yBulOP6Ohm/hA+wCrafgv9i5d6mSmK2NUEFBts6OEdzJNBk78UivWeVfWh27pD21uuAwlaLu13Vduuhd7H371ML62QZ9KihGbtJDsS00lBghm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPvl4vzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPvl4vzn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA69CC116B1;
	Wed, 17 Jul 2024 00:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177333;
	bh=dUfjmT5gzinhV4lAalxDfvFgPNs2XA130d13WrzQOCw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oPvl4vznD6mF0jp2U14meQ8yrcSZ9Tc/qRxxMRiOmq8aI4xI060eoB3tQIX/qtrkU
	 Z5PYqL7GNz1hCr23eMh2NVteRSVx44rOPS0kjjCZ1MyQbTK0ws7CKDegGC65qVwx6l
	 8cne5UbdzG1+j6iNx+mPw0M/8jAbQX+x5KImoGBQK+Dj7MbCE81OASUIpGrzYd+Dwv
	 ebi7Yqcomt0TRlv6kVKga/f9hmGKu2QyJxsX+YxSlmltf1TAjoo1sfIU6JDRwSjmwo
	 6G3bLXG3sfYqBKypV1+x8czuACuDbx5u3bgA4s5H3rLx98R2OKNHHmK+TSc42Avs19
	 YnIG6b0vD2K+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC0C9C43443;
	Wed, 17 Jul 2024 00:48:53 +0000 (UTC)
Subject: Re: [GIT PULL] Performance events changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpaRBAgN9QLHJ8NZ@gmail.com>
References: <ZpaRBAgN9QLHJ8NZ@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpaRBAgN9QLHJ8NZ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-07-16
X-PR-Tracked-Commit-Id: fa0c1c9d283b37fdb7fc1dcccbb88fc8f48a4aa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 576a997c6315ee482519e7cc080f341b07638808
Message-Id: <172117733375.30434.7947607199817912599.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 00:48:53 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 17:25:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2024-07-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/576a997c6315ee482519e7cc080f341b07638808

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
