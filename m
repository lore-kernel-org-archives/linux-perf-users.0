Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06F2080D9;
	Tue, 11 Mar 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709506; cv=none; b=Hd4uzM9CM2dZsi2NyjXYPPb1U3zhLlvztr3AT605xyCuN9SPX3JkFdDCRXmfSqIb6WIJCiK3D88HzqvfzpaNBs4k9qzOJIVjjxqMcRh7PrPspWqJyu1cn2jew9kLrxiAhasG5/U3igVOzcAOJlGf/cMfeoW+iFfQlyNFLy8RY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709506; c=relaxed/simple;
	bh=md9Z2+fthkBMzjolwYJB+69r/fQZ/xXxgBW9ZGzoS8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MOcD/0m4Ngvyt8YRXiL6ETIlSLq4uIQNwKx3fS3zbp5HwNQV3N6We3ZOyUlzjWLXjM80zGGu3Qhjf1bZYWuf9J5vLl1R79o4KZy3td/iK0QljtsAmFsPxSTeK09SYBJ1T7p8qVF6zMleQlZZmDWs9xow2BMb/hdCYKyJ/tr5K20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4g/o/gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4g/o/gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC95C4CEE9;
	Tue, 11 Mar 2025 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709506;
	bh=md9Z2+fthkBMzjolwYJB+69r/fQZ/xXxgBW9ZGzoS8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r4g/o/gnAWB0cb1Fcs9Zc4kIqAes73cREIkksAdKtwbVma0at/tQjJeJ72dFhihOx
	 fYYr8FvKJOvH21c8AxXFt7JHs/WUNVg2vV4hMdPjgkB9xNSw5Wx5TBVjf5NMBEZFsN
	 aeUCMdtMfAk/wqW6wl90rr0baIRmoWzNJ2NlLXVnh7N9qdsVHiLnBbGWiJrld9fUVS
	 LAdWwZpFOgzGLVl5HHNl/YqigGZQ0zq8d3V+0ktyzW2QFCBVOWBrVht/3tCGFgOfc3
	 ykoW6B61eoQ227LgevLYtM9PlJ9olv9dSyfGtO6bt3LjRqjfYHxDbd6hleTg2SN2S7
	 Vkp0E7lMLIVrw==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
References: <20250305023120.155420-1-linux@treblig.org>
Subject: Re: (subset) [PATCH 0/6] perf: Deadcode - the P's
Message-Id: <174170950561.2288726.17640709737674711638.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 09:11:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Mar 2025 02:31:14 +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is another set of perf deadcode, this is my set
> all starting with 'p'.  It was built on top of
> perf-tools-next as of a few days ago (7788ad59d1d9).
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


