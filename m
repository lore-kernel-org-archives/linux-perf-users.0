Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE449645;
	Sat, 13 Jul 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720883168; cv=none; b=O5f3G0/iE4IqUeLAXxFilU0X9HtvDT2RRdL9cUhv9+t4boWwCuLU/mfnwfubC+mJ7UtjOEY+UBCfpZQDoDjr6ABUqSsFtQFX/Dguao0FSjeatVyPQN6nx9Sl4ETSwLZC7YpHVCN8HU5m2H9b3OWub8Q7RUp7CdR72QbnvI+aXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720883168; c=relaxed/simple;
	bh=3FouymskU3xaeM1fU2etC2zdazrI+cr3OqUOIYMHamw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gD+K+UL4g8OGtYeF5VtA77lUpe0xWpjEuW0RTxrqyJ4dAnrDzKnqHOfZd3S8jYchLqaHxQJsFYOk2Fb/NKlM/WjMdYGo6DIbZXC8g3VaIuhfEPnTYxR3JihNyMCQRmZfsBzY1Er4vZUyvVs/OmpUww3oyI7f+Sd/+Ta7f2HFQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWyTkZJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWyTkZJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9B2C32781;
	Sat, 13 Jul 2024 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720883168;
	bh=3FouymskU3xaeM1fU2etC2zdazrI+cr3OqUOIYMHamw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWyTkZJev1+gwYPrfVM9m1zYrNbFLZG/+RZvYXFTRANcUsJ2rkkm1+/rigdd9ipvn
	 5/A5o8a4ioWur/euLwecT6TGyS98wi4oPshUUweKn5SQ403ry3EZWI0xkHVwU0h8bt
	 4sEGCP9S5L0NAmZkHyUIk0wwdVyxe0Z3wOVTwsbbyyJ7KC5rD0wDscf7cT611IZfUL
	 UvzjsR4PIzouaeThe0V0o8S2XW5mNZbvdG3FUr7Y/awo50KPmrctrbEqw3R51eIShp
	 FYaW54wj/uWVqn6I1ayrdRIcjtYVBzQ376tat0Fj1W5uiOy7VYDVXd13XyKY39xinB
	 p1ky6gCJ5bMWg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] perf trace: Augment enum arguments with BTF
Date: Sat, 13 Jul 2024 08:06:04 -0700
Message-ID: <172088309796.3315385.17601910633203307613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Jul 2024 21:20:50 +0800, Howard Chu wrote:

> Changes in v5:
> 
> - Use hardcoded landlock structs and macros for landlock.c workload to
> make this build in older systems.
> 
> Changes in v4:
> 
> [...]

Applied the patch 1/8 to perf-tools-next, thanks!

Best regards,
Namhyung
