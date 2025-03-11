Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0425FA01;
	Tue, 11 Mar 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709507; cv=none; b=FTZW5sOYIyE345PMFE0rlsQ4eD2j/XCg++NeFyPsRdyHxpZ+8oxNgFJ6oULaLUcV33NOIJntZ+TTPcRWuii6M+BoJJnRcKQcF8wVxkRFZR0agBggU6GBb7oNE7izydy9ww9jjC5Q0b4Uxz72Z/1fszQVywtsDT0SxJMm6tu8EVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709507; c=relaxed/simple;
	bh=hQH7oJ6MRqrIdYzce2+AkH7d/jjxpTKGeJgZhRE7DyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JDRJl2UByk2q0QfZk9cmpusZ0K6Ldi7S7n2CzLKBVy7j4Dr3c13jTeOIa581ykLj7PDjmKDw3UBQebYm02hd5t8Rwr909YUjss6ZnDmlYN/65REIa4n/C1fOyG0xDVv/N1eKiFOMiY4kgnJvYhAcmBvlq2czfbSlPKwuLQ4DFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRtwASaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRtwASaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297F6C4CEEC;
	Tue, 11 Mar 2025 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709506;
	bh=hQH7oJ6MRqrIdYzce2+AkH7d/jjxpTKGeJgZhRE7DyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NRtwASaL9TBNZX4A0S/9cCblBPSC/6ahhIDJO1UBaaRGUgolfIHFzYkfL1a+kZvCT
	 HcZyO4xC4Or7Jk3dZbgFdQneqgSqyuL0uclJ6xvrgNhN3p23WJfYZQ/oTnT7V55Yt6
	 LWe66yf6gRt0p2p0PS1aOFFyFClH/2Ezfgn6Kj4PjSvhh8GiHa+cFRVbhBI8/QA8Ab
	 4htKnQmkxj8ogfNqIPz9NSov6WVCXrbSTrKABghjNsoK1TB/mKq4Oy69Qm3jyaVs4b
	 9YpZVk6klfldGh5KaXI4YQI5aHFGB6D3Bdo5hNSX3cF2KR321K1HOeIo34RsUrbSVc
	 k9doRF63yAxXg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Ian Rogers <irogers@google.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>
In-Reply-To: <20250213220341.3215660-1-samuel.holland@sifive.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
Message-Id: <174170950613.2288726.10364923188574435865.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 09:11:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Feb 2025 17:21:33 -0800, Samuel Holland wrote:
> This series updates the PMU event JSON files to add support for newer
> SiFive CPUs, including those used in the HiFive Premier P550 board.
> Since most changes are incremental, symbolic links are used when a set
> of events is unchanged from the previous CPU series.
> 
> I originally sent this series about a year ago[1], but received no
> feedback. The P550 board is now available (and I have tested this series
> on it), so it would be good to get perf support for it upstream.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


