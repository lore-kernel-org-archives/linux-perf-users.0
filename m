Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987824888F;
	Tue, 10 Jun 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580741; cv=none; b=a3r5Wpwt+kit8RGh6xux0lexFQj84MePG9Nz3SvFMMjIYVsxk1XAyrJKuuPi3C/xfGgkZwNHH6H8jpefp0x2+SE4LDWl7oJGhjcDZypkNs/eUcOmIeV34BIBK2yQmZESHzrlpCrBhyVACUK955Z1B4d0+ISZmD8ufoL+guuazsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580741; c=relaxed/simple;
	bh=mUTIbVpokht7OiAGSsRDnNAvm4YPRzCcgweU/XfLtVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O7BruGruCOiBBegAjfj0NvaCHwZmtoYX2sjjzfHOgta9C+WwNaZT1Z8/LFcT+FEI15ZoL3wJvsOGP30QNc8h+V5nRja3ieceD8IHdQruPKwhZQ5iaR8t/UN4vC+1kE6IxmRebhBmHmqV/W7fiZGuQIUk1eSZo1m0EAjGgUIMm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A46Kb8S0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A46Kb8S0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBC5C4CEED;
	Tue, 10 Jun 2025 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580741;
	bh=mUTIbVpokht7OiAGSsRDnNAvm4YPRzCcgweU/XfLtVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A46Kb8S0JpJY9oF1sOWceU6sIEntQajmZf5+saymSR+emESDIOcJVb87/jOgIlD+W
	 FWtoN9g4l1ONsf/8+5fL2/LPT0l0U5u2w+IE823NoRgY+hafoqB/Sj5JwXVVTF73ni
	 6ahGtWcQOXuqLMnO14hjJH3H4tbOytT6jFkOl/6uSZk0WtQOjqEiBgWU7vORdBs93M
	 OfHbDM2XfpE5/254D+VEKKiw1zoPI2nmOkXd0z+7F3mHBYwXgH53BSJYeVn8vLtttx
	 q0qvLHOUPA2nDlUUnTmoPocdVRhAWEFmBDmhFTg5xVz4qx24L9WRWe4G+0+thKuSRK
	 IE0p8RsLXsXWA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Howard Chu <howardchu95@gmail.com>
Cc: mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250601173252.717780-1-howardchu95@gmail.com>
References: <20250601173252.717780-1-howardchu95@gmail.com>
Subject: Re: [PATCH v2] perf doc trace: Remove --map-dump documentation
Message-Id: <174958074079.4039944.10522397903792984025.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:39:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 01 Jun 2025 10:32:52 -0700, Howard Chu wrote:
> The --map-dump option was removed in 5e6da6be3082 ("perf trace: Migrate
> BPF augmentation to use a skeleton"), this patch removes its remaining
> documentation.
> 
> Change in v2:
> - Correct the commit log format
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


