Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35846349AE0;
	Thu,  4 Dec 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875446; cv=none; b=TmUVIP1mSdVp91fyS3e+0EavGr83pDrJqIhipeG7YIiFiri9+tOQ1ocLBkiuQEpqA+n21Kl5GAkLM/oZiDRE4fBgxtUVyoalKRP0u3UqcCeldq0Y+wsnxK0STGGjs0Vr+prBoiwxFaN4d4ys6KFWXfZQew492/Z7EcB7kkshc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875446; c=relaxed/simple;
	bh=ioTUMYFgvz0SorzlneVrBmxzTNx+Y5ShQzJa+09soUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rj2PGTaBXjzKweMMW6Ub3QQ9s+Uc/9VkKgJjqAQ9b59LdOqgwU6QsGYuLhhDJ1auleOepReN3y5IcfrRG/VxZ59p3TOQKdmcFJwG89gkVksapEqIr9RMXpoKzjGmqwvAlgizSdccRENSmQ+tnnJ3edPMCCrGC/t9rGZZNlG2C78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjyDkOhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjyDkOhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D96C4CEFB;
	Thu,  4 Dec 2025 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875445;
	bh=ioTUMYFgvz0SorzlneVrBmxzTNx+Y5ShQzJa+09soUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hjyDkOhm0Fb0KegVR6dC3eVqejtp7ChGxovGb4IYQz9GZ5u1VrvLsgwwT0CrPJhsF
	 q5WIPOTPNjcr5FTJVejC17qoSWC+taMJ6dP5hLCDvaTsjJoxG3oYqzx49QE5RYs3cM
	 KF2GRS2IbA4YG7a44foLI0/Qm2LkUpyl98m7qecvdvaZq8VMwjm6/8198JhOhMZY5A
	 X91pFoWNoXJ0KKy/zRN2ARPT5QTsifovfAL9pSD2heP3nPiA3UqmxhExgx78YnA4Wf
	 iW3rSfHT5176JAKIeME6vBpN5mZDC8HpFeTsGAyNK+EnxZeZsqiNGqCTAqCDRpuYnK
	 Y2y63dhqdO6VQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <aTBOG7H7OAST04iB@x1>
References: <aTBOG7H7OAST04iB@x1>
Subject: Re: [PATCH v6.19-rc1 1/1] perf auxtrace: Include sys/types.h for
 pid_t
Message-Id: <176487544485.182574.3803352851202043832.b4-ty@kernel.org>
Date: Thu, 04 Dec 2025 11:10:44 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 03 Dec 2025 11:50:03 -0300, Arnaldo Carvalho de Melo wrote:
> In 754187ad73b73bcb ("perf build: Remove NO_AUXTRACE build option")
> sys/types.h was removed, which broke the build in all Alpine Linux
> releases, as musl libc has pid_t defined via sys/types.h, add it back.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


