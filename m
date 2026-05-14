Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37B347505;
	Thu, 14 May 2026 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742166; cv=none; b=afwJwc+CKwqPFK7TaMBk1jnpCknm18XQm93fSY9Ohnd+qBaesWghrhx8FT8z4MRdS9VbyE5A1qsjF1qW/qI1N3fmVGHtSyv8ywxxRORCKov6HfUITuHJ2NDLZGqnU5Z4Tsf9bEtMPG+t0MyVXyCkEYRxkc3gluJ2Jzo89/NrMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742166; c=relaxed/simple;
	bh=y52kfi9WilI/tUA+FQZJuSnWSdg+0Jnv0yMNHuqxb7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2ZUk7QwiWVBkhx/dzOwVB2Nt1jysxiEbnS7yOlcl2miDQiIEcv2H3z2Qv1HiEfKeC86JAea/48pvMAUQMbrP1grLt6GLSzdWRbayXLc8t0gm2fTMg/Ixxz5Ja6X6qcUsasisSRHGOHlc1rbKI9R9/6niAMHkpucvbkV6oue9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xc5o6ZH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xc5o6ZH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EBFC2BCB7;
	Thu, 14 May 2026 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778742166;
	bh=y52kfi9WilI/tUA+FQZJuSnWSdg+0Jnv0yMNHuqxb7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xc5o6ZH+mUCmm7dG3C6tb4OaQMkPqB7FznCmUAlfkSnuJuNMf+uEjB3Qh82WQJ0lW
	 KKwNKinKmJCxLDg6bhFJqNJgh8n3T4W3tATQGqvHrFll9Jg8ezYIIr1J+ayhtw2oc1
	 w8RznansvCek7pGZrn5qxe4zeN0by8Oo5jbQghe0=
Date: Thu, 14 May 2026 09:02:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jia He <justin.he@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 0/7] Silence spurious warnings and crashes from kunit
 test suites
Message-ID: <2026051429-bauble-tarantula-1683@gregkh>
References: <20260514050455.2954509-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514050455.2954509-1-justin.he@arm.com>

On Thu, May 14, 2026 at 05:04:48AM +0000, Jia He wrote:
> Running the full kunit suite on arm64 (128-core Neoverse N2) with 7.1-rc3+
> produces a handful of backtraces that are not real kernel bugs but
> rather test-infrastructure issues: races with boot-time code, missing
> bounds checks, resource leaks, and sysfs duplicate-name splats.
> 
> This series fixes them one by one so that a clean kunit run no longer
> leaves noise in dmesg:

This series was sent to too many different people at once.  Always break
your changes up into subsystem-specific series as no one can take all of
these through their tree, and our tools, as you know, have a hard time
of just picking one patch out of a series.

thanks,

greg k-h
