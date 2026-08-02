Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17C34252D;
	Sun,  2 Aug 2026 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785649594; cv=none; b=lKj1kKe4mXyCclcC+/k1L3bmTdatIpvFNo6c4ojpEfcSBjO0MfmPkSzBGoDNUHSYYmp6hqvFB8B11j3Ky8dJp0Wtnv0b+hRuVwMqO9+xD2xs2ZP5ILafE6TpuyXIw8alKI4soW37yCB5ePmzZiDp81Tq5lmBpkJ/9TeGF3TLA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785649594; c=relaxed/simple;
	bh=tg5RvoWmYApLfTCkTssCSgJfNFTtXJuh4wYGQD4ETA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tPDK5JdtZAGC4twHPiVoBmObRr9XrUHcbaE8fv7HC6B6txppDOGE7y+v3MoMKZQGTRKvauGffKk6wGllkX6Ssa5eWoKMLLcKr1sEcOFS27aekyxR/64bynUYLfCg1xL6ieMX0F9GAyvBDZGsm8eymALO5fDCPLgOc2UT1E+iECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV8Ybyip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV8Ybyip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D0E1F00ACF;
	Sun,  2 Aug 2026 05:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785649593;
	bh=j9hbdTdgX21CXv3Gi2di7w90jOnQwDmNw6nWgzh8i/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jV8YbyipTEdvzufftYnMsciEblz3RAGhCkac71NLFXeVExoCxodB1eEmay73zssBv
	 cPICmrm1TpCKArYNJpMOzod/ooEsopPn/Sf9/rZKI5iiD5MYfnGyDNNRs1cmotq/Ue
	 8hoo9ot4uHQ1AI0Iay/jtCzwa9gFtt2xyGMJUB4Yzw48TBgr3fGTxzYUYH6wXeFZ0d
	 Y+FItop6NednI2hD2qKX4wlrvwItNj5PBea6GJeEEMAyezskNGhbrelAtR4/TdM9yr
	 tBVFXgYvVX6SfKj1TYyxiLysiRZEs/Dp1Ssiku9Wr/OQ5vLFRILitvkRItbcOOs0OJ
	 R/EonyiuipOHg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Subject: Re: [PATCHES 0/8 v1] perf machine fixes
Message-Id: <178564959303.665203.18105792717707415852.b4-ty@kernel.org>
Date: Sat, 01 Aug 2026 22:46:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 26 Jul 2026 20:40:06 -0300, Arnaldo Carvalho de Melo wrote:
>     Here is a series of patches fixing issues with the 'struct machine'
> methods, please consider applying to perf-tools-next.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (8):
>   perf machine: Fix fd leak on bounds check in maps__set_modules_path_dir()
>   perf machine: Fix NULL parent dereference in fork event processing
>   perf machine: Guard against NULL strlist in machines__findnew()
>   perf machine: Check snprintf truncation in machines__findnew()
>   perf machine: Don't abort guest map creation on first inaccessible dir
>   perf machine: Reset errno before strtol in guest kernel map creation
>   perf machine: Free scandir entries in guest kernel map creation
>   perf machine: Check snprintf truncation for guest kallsyms path
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


