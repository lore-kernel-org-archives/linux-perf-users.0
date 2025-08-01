Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C626CE36;
	Fri,  1 Aug 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069078; cv=none; b=hsWuiJuKzXo2KNH24Y4omFzKC07ZvQTQVbF3tZtdCwRVzaONWpYA6t6JR7ByM7SkNo5cHvV2JO1DbbfypMCz4rHc67B6N1ubxmNIQ4NPLiej34ry5KACbzn4cXjK/VgDo1X3XGOhZR7wp5b5Hl9txc0pqM3WBguX/EwUwOXARC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069078; c=relaxed/simple;
	bh=0T6BW3kqNRSL3CmcE+bvOFvSzPdP7Qn/jpwOomCpddE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mXPBH6ZjDL4nYzKH0QjEgz+fDomlnEwmppg4jKKSpdHjY8iXgI2vcgB51sB1veK6b3LKlntXapRp+W2J2EIFwFBERefGD8Zw/OHY8lSatyoLB2cqjmstP/u+Oat0/cifNQoQLV0C+2ayMA4LE0G9/Q2D5XDXBDrXkCyl+55dMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikTW9TRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikTW9TRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2622C4CEE7;
	Fri,  1 Aug 2025 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069077;
	bh=0T6BW3kqNRSL3CmcE+bvOFvSzPdP7Qn/jpwOomCpddE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ikTW9TRv1bmX2pfGveXkD/Q+8Dwu+Mu7kGuaygWO7t3bIXKyJGLyLmiL12Nk7s9NR
	 MV74Cuw68ebse13s1626MpofqrO3XJfg91bVD8dzwnO0VQ1gyAY6jZoLsmiSsb95BQ
	 Bp5g4H5TMEv11BVWdgXOm712kXBIFgBR348cR0FgC+TYwrqlKSvtgMJubGBYqSnrLs
	 e5jsXpno/6fZVTpQUUlhpfj5Wq0ZJ8GrQmR3ajByKkLLQC7NwUztqG10lPP3w2NqFh
	 f+G/1zTWEFRf9MZLs0P8q4+RRww0GCq3mT3XPyBNBULnVfzE47lCsjF9qMpBCqxss7
	 IMSdD2vzJFVAQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <aIofXNK8QLtLIaI3@x1>
References: <aIofXNK8QLtLIaI3@x1>
Subject: Re: [PATCH 1/1 v6.17] perf python: Stop using deprecated
 PyUnicode_AsString()
Message-Id: <175406907667.1475083.1184937311863486488.b4-ty@kernel.org>
Date: Fri, 01 Aug 2025 10:24:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 30 Jul 2025 10:34:20 -0300, Arnaldo Carvalho de Melo wrote:
> As noticed while building for Fedora 43:
> 
>     GEN     /tmp/build/perf/python/perf.cpython-314-x86_64-linux-gnu.so
>   /git/perf-6.16.0-rc3/tools/perf/util/python.c: In function ‘get_tracepoint_field’:
>   /git/perf-6.16.0-rc3/tools/perf/util/python.c:340:9: error: ‘_PyUnicode_AsString’ is deprecated [-Werror=deprecated-declarations]
>     340 |         const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
>         |         ^~~~~
>   In file included from /usr/include/python3.14/unicodeobject.h:1022,
>                    from /usr/include/python3.14/Python.h:89,
>                    from /git/perf-6.16.0-rc3/tools/perf/util/python.c:2:
>   /usr/include/python3.14/cpython/unicodeobject.h:648:1: note: declared here
>     648 | _PyUnicode_AsString(PyObject *unicode)
>         | ^~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   error: command '/usr/bin/gcc' failed with exit code 1
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


