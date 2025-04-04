Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2BBE4A
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Apr 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792053; cv=none; b=ig31Z5PoUD24KUI6H2udq92z9v32+oEsiqlWN/pNh8Qv7dP0LzhKtGVBlkQyjJaRXZcqqyVjuafE9GI3PN1rfylqyM9kaZnhd8+Pz9eVgPgUtg+JwS5Zc+4t+DDMOLg/n5A3enTHSk4I84QHROakaHMfkFgEB89WdJvztrEKpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792053; c=relaxed/simple;
	bh=hALIUUDntsZfxCyaNPt9oH3yqoJTKft+Iu0F38ZQAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdEruYOu/iYcCeZ1015Q7Tvhz6U1MC5XIxHpWWh3CsTQo6fAVoSEZhT0qoojr6YNfWI32kAMlmlJ9A8KcckFLvu/k4WQ+k9xnlXUqOYJvTko/B2Q+ZskitKRTvhMnSgBSmlc8ClMpAzB14A7E5KqWVfbpWtyOHSl6vWuEksSFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfzX9v3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfzX9v3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF8DC4CEDD;
	Fri,  4 Apr 2025 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743792052;
	bh=hALIUUDntsZfxCyaNPt9oH3yqoJTKft+Iu0F38ZQAxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfzX9v3OjoWbBRjFV1aZbEINZV0zuLxpbA00r6uIfAEZKPvw6dNJoVWLl7r92FITC
	 qnfrrJ9T3zF/GWgnHm+oujOZH5vJTqnMOzqabHvO/JZBRNVdXphUu4ozqFnRZfdfhC
	 3TSk0lgY87BUMf3qABtvHaLo6ZmbJKlGLRic9n6vEzCq3lx9ffIXQjIe3zdIc1UPUR
	 GSxrOAQGq3BmI5Q6ma/Evh+3ZUdiNeejauzv//yH8sxSUX0rMoT5m9lB6VdigcS64O
	 gYbZ4I+gQoYOXMYxGNXUBJFX1AqYEA1NQbGm4b9czcK7GRh7X1LpVAMiIEKBkxoxWQ
	 5u5C4BQPs8AlQ==
Date: Fri, 4 Apr 2025 15:40:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_AnsW9oJzFbhIFC@x1>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <Z_AWpgne5108xqlc@google.com>
 <Z_AhOFo9mpFmT4Pd@x1>
 <Z_AkNkxLU-9eDrCm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_AkNkxLU-9eDrCm@x1>

On Fri, Apr 04, 2025 at 03:26:03PM -0300, Arnaldo Carvalho de Melo wrote:
> So this is a bug...
> 
> There are no references to libunwind tools/build/feature/test-all.c and
> it is building ok:
> 
> ⬢ [acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output 
> ⬢ [acme@toolbox perf-tools-next]$ 
> 
> and somehow libunwind devel files are being somehow detected as being present...
> 
> Investigating...

Cleaning everything and rebuilding we still end up with:

⬢ [acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output 
⬢ [acme@toolbox perf-tools-next]$ grep unwind /tmp/build/perf-tools-next/FEATURE-DUMP 
feature-libunwind=1
⬢ [acme@toolbox perf-tools-next]$

I found a couple of problems with the patches that made libunwind to be
opt-in, I'm sending a patch shortly.

- Arnaldo
