Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85920C477;
	Sat,  4 Apr 2026 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261702; cv=none; b=kr6nQSnJnLpKuzgK0nXu9/syNp92GVtKbQyDSkvL4mOyNeAD8WCBX0JsS4tBJAbt+kI3ejKBy5NRJrstgG5Ash3yu0LPhFoxRsrFGJbptZ5PiFw1NIbRzBiUxmaqspDzkH6w/211R3yubKn7nx1p9M+Pa4gZ/d7QckR99QrEC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261702; c=relaxed/simple;
	bh=sZCVJi875CGK8FBlxy09pyuoHJ9P3iz5Kh5dpjYT5iQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J0KSAbhR2JaNL7eGS8mFItCpx8F1DFRYqWbCG3/kfsVmN2pIRR8jnVutzksXEjw5ik96I3w9WD4EC15Pdp4v3rwkuZwtk8/+Oyi9a8H9UG+750gD8c2zMjk//xtLHm13zs3coOcblPOS4abpKu8f/hTqsEk9I+9mNY1JUQy7R7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fatC4gPH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fatC4gPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C909C19424;
	Sat,  4 Apr 2026 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261702;
	bh=sZCVJi875CGK8FBlxy09pyuoHJ9P3iz5Kh5dpjYT5iQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fatC4gPH7Pow8daCHcPqDs+kllZOCSTuEilfSHjwBt0Fq7id7zfdnPYZM0yNvHk5S
	 65xpHLwItGwX8YzaB2gJPGsO3vR1vHH0jMumiRhFOcF8wZ/x68OPud70w7GgJvtFX9
	 QUI0k4nyzs3sH9S4tuLd5Yygea43yv9xDlUBrh5cXP6eHYIRz/gw1kXlaQpdzSMJb9
	 mK4BDsow6/Ya9hxuVyznjBqixIR7OJ/REOdd8FP5F2rpp3rnz1On/odEw1Za8Rgt0v
	 E/XijNIJtu5hPMxCAhlwOCZXzik+ys9iFZuWaYLmpu+1UyxyEsKd7KzN14iMpx85jP
	 qxh6eyifsztzQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 ashelat@redhat.com, ctshao@google.com, derek.foreman@collabora.com, 
 howardchu95@gmail.com, hrishikesh123s@gmail.com, james.clark@linaro.org, 
 jolsa@kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
 swapnil.sapkal@amd.com, thomas.falcon@intel.com
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
References: <20260401055206.43187-1-irogers@google.com>
 <20260401161324.332356-1-irogers@google.com>
Subject: Re: [PATCH v4 0/8] perf data/pipe handling improvements
Message-Id: <177526170213.2123878.10130258955620280586.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 17:15:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 01 Apr 2026 09:13:16 -0700, Ian Rogers wrote:
> I'm looking at improving the perf data converter with files generated
> in pipe mode. In pipe mode I found the feature handling for the last
> feature marker was problematic. If a new feature was added then the
> old marker looks like the new feature. These changes do some minor
> logging and build fixes, but they also change the last feature
> handling in pipe mode so that the marker is treated as a marker and
> not a feature that is broken.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


