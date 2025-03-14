Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C02046B2
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974223; cv=none; b=GrmbIIOCtBby+fKIJas6eT4KfdJwrzGSeUGveltR1dE5JnSgk1QhnzOy+N9u984s/cy4dz4JdGjHeXDi97aay53IO35OtwBhW6z40yHhNrUrVUuHcLAzC6Pwfh/61akQH5jKduE9PveRwZLhPtudC+TS/Xbi6vYkR8kKrWbnsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974223; c=relaxed/simple;
	bh=sHAcyHueyNUGuHuP+HLKftEjBu8RdBOuKqfGaHIW8L4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s6TF8uF+5GzysS8Z5djHSsmil3FipsNMUOAnD7bMAtzP3nz0PhkTqEpgp2Q6m82wTyQF09i6qSYe/evHLbxllBGeE4WHx2oZuMkYtt761AsuvxYUWXC18nF7IKNBqpqzBXJldv8eIzk+u7UUSr/R3Ss+o8Stssb7bLwMkhrkKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEu+4l+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEu+4l+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC6DC4CEE3;
	Fri, 14 Mar 2025 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974222;
	bh=sHAcyHueyNUGuHuP+HLKftEjBu8RdBOuKqfGaHIW8L4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BEu+4l+WMAOVo5y79u/EpdTSMoup/Qn35nrgiKxzlT3S4MfXtBKFoocBMs54+hFhR
	 UjU0l5G3uj/idQVIJ9FiuE4BtcU0qFKkMy4G2zbCAAJLvz0Y/iPRW9MSiayVy0LS4O
	 r4wUnu1TD9CHNWgQZUPKHlAxzD2Q2Ui06LbpbRM/uSZeqwTlA9HV1hSxpoiTw77PbV
	 Yu9k4uAzLWhS5osSxf2Ax4ifBR0l62xe/XR9BvVMEutKjjSoPIlMxN5RY1pVNtuWOq
	 3g3weUTdd6z+KEUkxgsBO8vV/QWtI50eNyON475uI0FPnfLHTFF3vTIu62FBIPAU+Y
	 T0/7WOftZ/Csw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
 irogers@google.com, vmolnaro@redhat.com
Cc: mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 kan.liang@linux.intel.com, qzhao@redhat.com
In-Reply-To: <20241122231233.79509-1-vmolnaro@redhat.com>
References: <20241122231233.79509-1-vmolnaro@redhat.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat'
 result
Message-Id: <174197422213.4059945.4203258869508272700.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 10:43:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 23 Nov 2024 00:12:33 +0100, vmolnaro@redhat.com wrote:
> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' output
> due to a poor design. Firstly, having the 'set -e' option with a trap
> catching the sigexit causes the shell to exit immediately if 'perf stat' ends
> with any non-zero value, which is then caught by the trap reporting an
> unexpected signal. This causes events that should be parsed by the if-else
> statement to be caught by the trap handler and are reported as errors:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


