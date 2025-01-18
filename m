Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126A1A2390;
	Sat, 18 Jan 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737223169; cv=none; b=riTb/kZoXwjiWq7wzXKmDAGEms0dTFhcQ+iJSKWW2nM+MwRqZWrhrJdtyTbFQb1UgSyQL3SVxER9dPSis7DAfCP989lWyU4CJGO5MRdUHqitow0Q+ZO+QxaO8BWNKUv+lBV+Ozk6BiPxf0syntJG3WAzE18sPstZwg1NJ2Xsz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737223169; c=relaxed/simple;
	bh=2a11IsQWv/eSdLpdjNNHRbme1WpGzDWCXP1PnToOayg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sw8AnUVaOWV4EbH4UQejLoZ+K/hIJqxdNY85yG/qbUkXYhBHAoLNiHZlqMCKWu/SLgFm+tkH9EYPhl+pmPp63nhvVXftZfQjIfhZ/yctAIvDQcW93teO6BS0PimiggvoVpcF6nkIEi6Ixm8d7hbpaYS6zdFvjxU8RcNDohDBalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYS0tn5K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYS0tn5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BFEC4CEE1;
	Sat, 18 Jan 2025 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737223168;
	bh=2a11IsQWv/eSdLpdjNNHRbme1WpGzDWCXP1PnToOayg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qYS0tn5KV5AwyU7L72NrSVyVxV+KeVRH31yNWiAwV4Fh0eweAyUISRw1EqMzv0Y9O
	 ipad4zPgPgo7zY+tz/xfW8N/+uLaps9mO72KLR1QqHOG3rBBTdtRi0BbG/RlJ/eail
	 /3fizohDtpE/NmUxUQmSiuTpOA/zGlKvdrUpUMZMrrZbwV+BJBH9kSHlikaVGybcs8
	 6zZctrz5gfW718fO4Ehdudm+xu3R9MPrkrXvA/L6G4Ohnb8gZVYOVP9s6YdCaBlkw5
	 BrZsJM0J5cqOC1XIwectlIGBVIcL+4xPEJa2p/Vkm1EHA27vDbv22VS1u/t6QQyTCg
	 dy66ny2ToPWRQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 nick.forrington@arm.com, linux-perf-users@vger.kernel.org
In-Reply-To: <20250116235838.2769691-1-ctshao@google.com>
References: <20250116235838.2769691-1-ctshao@google.com>
Subject: Re: [PATCH v6 1/3] perf lock: Fix parse_lock_type which only
 retrieve one lock flag
Message-Id: <173722316824.2826057.303737124351359213.b4-ty@kernel.org>
Date: Sat, 18 Jan 2025 09:59:28 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 16 Jan 2025 15:58:14 -0800, Chun-Tse Shao wrote:

> `parse_lock_type` can only add the first lock flag in `lock_type_table`
> given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> into this perf session. Another example is for `-Y mutex`, it only adds
> the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> so on.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

