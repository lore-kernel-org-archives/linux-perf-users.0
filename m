Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2E30FC36;
	Thu,  4 Dec 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837713; cv=none; b=Zs2LyL3rdqChEMNX/cYgYDq/vILc3z84is4lL2gg5KBhlDeH2a/pqQPijNqGnLtjyyvYqEt3E98UhD9UWDTi3dJk66JPAzVbP/1t5C1j403UWXA43QNQd0MIedquV89tYz4Ynj5rCXZ2r/uMa3vKvTK40Ha2ps8wbalfqKxQ5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837713; c=relaxed/simple;
	bh=nTrgZgIq43ZhpmORc8qxrW674SRVzu4GR5+FjDyjkmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9ahPTC7RTkBquXtiswTI0MKUTbQDvkS08taIwo40jHOnn6p6FIz22YEvK0deD0DQLLmtLarXvXrMcBFDxaf8Jwel6KD6VMzxzeyzHFY1zx0ff/UdG6vS0BbonC2QkiF8Cgq8udsd/ygZ2pF1o4uE4hGca64ss8lsuIokwsenRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia7MAAoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia7MAAoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD15C4CEFB;
	Thu,  4 Dec 2025 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764837712;
	bh=nTrgZgIq43ZhpmORc8qxrW674SRVzu4GR5+FjDyjkmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia7MAAoEBIZ/90lRT3Jif36onUz9UUQVOBYxG5hMcBF1WmSrK8FGxckC10aytARdS
	 j/llbfxpL3HlwfpNo2L+VF6X0r0j/3WBRIgayouq56OAMyNuZA7YJZu+mlgUZgPrNW
	 P46/yQdUHEcr3PgREaZiFl+F31nShHhiGWtqDbK7Yo8HkdjO6IrJ6TMjDs4oCVDOwN
	 qRHzrgOPWTnzF0hzebipdWqTn+OfE3FLlK27X8Q8oGL4Wnx/tCOBI1SH2EklH+khf4
	 9jWjfzuwtvHmIQpnHUL5vgZ0T9A64vcvsoafM4Wd6A8avZulV6nvAvDM6YuwdrjwTV
	 7Kx7RO7HpHG9A==
Date: Thu, 4 Dec 2025 00:41:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6.19-rc1 1/1] libperf: Compile using -std=gnu17 to deal
 with visibility attribute issues
Message-ID: <aTFJT8kQsxnxBaS8@google.com>
References: <aTCpiDG6WOzMv7ji@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTCpiDG6WOzMv7ji@x1>

On Wed, Dec 03, 2025 at 06:20:08PM -0300, Arnaldo Carvalho de Melo wrote:
> We seem to need a more invasive patch using 'extern' on all LIBPERF_API
> prefixed functions to be future proof, so use -std=gnu17 which is the
> one in gcc 14, present in the distro generation before ubuntu 25.10 (gcc
> 15).

Something like this?

Thanks,
Namhyung


diff --git a/tools/lib/perf/include/perf/core.h b/tools/lib/perf/include/perf/core.h
index a3f6d68edad76240..06cc132d88cf3436 100644
--- a/tools/lib/perf/include/perf/core.h
+++ b/tools/lib/perf/include/perf/core.h
@@ -5,7 +5,7 @@
 #include <stdarg.h>
 
 #ifndef LIBPERF_API
-#define LIBPERF_API __attribute__((visibility("default")))
+#define LIBPERF_API extern __attribute__((visibility("default")))
 #endif
 
 enum libperf_print_level {
