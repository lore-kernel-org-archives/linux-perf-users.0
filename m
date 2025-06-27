Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E01F12FB;
	Fri, 27 Jun 2025 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050388; cv=none; b=Ftl7uAO0SE+RdwB+HdrryCUtcSKzMAv9vS2sshxNx3yoGM692oBNJ+eTirA3dA76lU63ApH49Jv/o/TGvG5gGTHAoiDI3ynNpU/LUXbpcekJ4F3HC3xuoRHNv0yWD1w8CY0sVFKFNEwYO2GXyfbTyDh2/BMXFUpV54M8d4A7cwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050388; c=relaxed/simple;
	bh=RKE1+LJlv+cNfToC5oBc8LFqE3TLK0S0lYdPdFKsI9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N6W+LuglDfJUrOdVhJdojdQ2qiAcrfpN5L40/fl7o7AIQArC6C/N4KgUlE62eonfZamUs/Ekcs3ouoTfp5TKgzaz9D89yPBIt4aA656HHO0sW3WEg1NYzWhyZi/Xk00XfvTZh9IiQTT4aDyen6O44NSj6HJbncFhmjxi62QMxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhSvjfX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhSvjfX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5541EC4CEF7;
	Fri, 27 Jun 2025 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050387;
	bh=RKE1+LJlv+cNfToC5oBc8LFqE3TLK0S0lYdPdFKsI9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mhSvjfX46TfIvRiyOz0LDN3geUZB/zlNWgJhZxcN2HEzMpvHamrF73x0rjCldyfPe
	 b5MWPPWKK95MzNf4Zek8m89j9ksVUmkX/sS3RGPBr3N0DIUhP4XCPQrLsC5YTd3aD7
	 HORNRNo7dowqI9O5RJgHSABXdbm2T6UnD5zIKnBZF9yERK7POlReKwdB3ZNo6IcfI3
	 TDl7OI5265z9fqgEIR+l0sKWkmHcRyUWWQHNQe46UEvLm/213rS87KxnsvOih6weOb
	 6zf2oY5zCcTOe4E+43fsOUo59fpqObQbDysHQZkyNHHz1DtjWXEHraDRoJ1fiuL/wg
	 iALRQ01ox8dZA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250625230339.702610-1-namhyung@kernel.org>
References: <20250625230339.702610-1-namhyung@kernel.org>
Subject: Re: [PATCH v3] perf annotate: Fix source code annotate with
 objdump
Message-Id: <175105038731.2492671.12831472897891018109.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 11:53:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 25 Jun 2025 16:03:39 -0700, Namhyung Kim wrote:
> Recently it uses llvm and capstone to speed up annotation or disassembly
> of instructions.  But they don't support source code view yet.  Until it
> fixed, we can force to use objdump for source code annotation.
> 
> To prevent performance loss, it's disabled by default and turned it on
> when user requests it in TUI by pressing 's' key.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


