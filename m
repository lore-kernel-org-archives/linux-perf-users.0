Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E222580;
	Fri, 18 Sep 2026 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763148; cv=none; b=QerfR3XrIJZkeYz3e65N1q+GqQp3BNXBsVZLjKKPZg/KkE8lss0fZRgWcwB/NFfUvG/T+cGoA2de547gKBhXxluLp9yjZBQNDQ/LqZbV4P0seIghhSXwHJdIKCeUWyyLypfJQKcgyU+g2uHCNwW0QWF5/ocqWZyKY46EnOFvNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763148; c=relaxed/simple;
	bh=aTkksyFCHrBAJh/IUy70zWptJPV7UEtTa7WTDM/j7C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPR/v3DlWxUommlQsGOj45Bpf7xz5/ULkMK4ZG5rGQnM+o46/gsaP7NmIu3OqmbaB+berLVIub25WiKN+aMAo+1WkVKqhPSor2Fxk1E1naoqUYbkkkraY+q+qaWxmoAGL8eDTrdRIKMAMD2EIx4o/qgd8G16j/WhhCCemFWbreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoiyP1cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoiyP1cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24E31F000FF;
	Fri, 18 Sep 2026 20:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789763147;
	bh=HLs6wnc1t/Daa6z92qDpMvkWXFtfd9WHahD5G72w6gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LoiyP1cb0DwcWj1kowjAhqYxfAqHFWzAi5FYITmQ1nIA+8PL9tMOgdssSKVBBvBXf
	 yp+zPjY5vp+hFZuuzgP1YW3Jndt2tCJo3AZ+aV3RzKElRU+HWfKIDw2ocCg2taryWS
	 gxdYdbiEv8iW5vdgZ+YVeH4UWqN6Nzy147UwgXrXf7VZSVgdLLuJGosPy4XSqe2W7F
	 8SdQgEWMcjNXVhrGcJMTgF6gIsR4euThx499EZzWZy6lgzXL5VXCwKYV5/tZbTAcLE
	 +vjx85GyH1qgqTG34g4iWHvcPkmxDchS/Qu3E8YiU0TEt95JHPX4uRDzii0D5B58kp
	 UcGGmVNiszLdA==
Date: Fri, 18 Sep 2026 17:25:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v3 0/3] perf srcline: Fix addr2line cache and fallback
 bugs
Message-ID: <aq2eR9pezbRheQgR@x2>
References: <20260916063545.3103314-1-irogers@google.com>
 <20260916234402.437113-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916234402.437113-1-irogers@google.com>

On Wed, Sep 16, 2026 at 04:43:59PM -0700, Ian Rogers wrote:
> Three fixes to source line resolution, all on the addr2line paths.
> 
> 1) libdw is pointed at the wrong file. dso__libdw_dwfl() opens the Dwfl
>    with the name of the file the samples came from, but when the debug
>    information is in a separate file, symbol loading records that as the
>    dso's symsrc filename and the Dwfl is left referring to a file with
>    no DWARF in it.
> 
> 2) The dso addr2line cache is shared between implementations. The libbfd
>    reader caches a struct a2l_data and the command line fallback caches
>    a struct child_process through the same pointer, so once a dso has
>    fallen back from one to the other the cached object is read back as
>    the wrong type.
> 
> 3) libbfd only reports success when the caller asked for a file name.
>    addr2inlines() doesn't, so srcline.c treats a resolved address as a
>    failure and tries the next implementation, which appends its own
>    frames to the ones libbfd already appended. Every frame that isn't
>    inlined is then reported twice. This is the default when perf is
>    built with libbfd but without libdw:
> 
>      $ perf record --call-graph dwarf -- perf test -w inlineloop 1
>      $ perf script --fields +srcline
>      ...
>                  56051a99503a inlineloop+0x8a (perf)
>          inlineloop.c:47
>                  56051a99503a inlineloop+0x8a (perf)
>          inlineloop.c:47
>      ...
> 
>    With addr2line.style set to "libbfd,addr2line" so the fallback is
>    taken, the script output for that workload drops from 288 lines to
>    176, and each repeated frame goes from appearing 16 times to 8.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
