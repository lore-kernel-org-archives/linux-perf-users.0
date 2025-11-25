Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1D31A812;
	Tue, 25 Nov 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098986; cv=none; b=BT38NUWN3+bmH+fOFVE4HtKuWt+VOm9CNUkdiIHqO3RKNzcBNghwGvWUcD9ei2zb/5oDcvGzY9RYwmzMh0B1fPhOqcZOndyqrp7QiIzdA4GlaujzikblxImtyi5e5lT9sk/9xLUsX6MCYdaZVyWim5g2BlONTL0Tseaj9wqQa5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098986; c=relaxed/simple;
	bh=tQToklLwsVviV125nXFmiUKnBUcYNJgeyseHDoj2o74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFTpVcdOPkV3yCBm4cLmmJ9lVtRljSYqGB/W62sWZcRGMxNoor/nhSXEI3dcvhYffNXrWKuRiFvbzxy6G5b9DHurtsH46SVnuOK1/2Y1FW7/UDCUNRv3UtTGrGCkZ8ZDuQ0ey3edCkkmjGq0ly9wU2T742fKeoOz+7Mjv0Ak6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRS26iec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRS26iec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86853C4CEF1;
	Tue, 25 Nov 2025 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764098986;
	bh=tQToklLwsVviV125nXFmiUKnBUcYNJgeyseHDoj2o74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRS26iecXTiCg8WrMd/JxkIOGkLtjS3Gp7IiOAW9z1lXrTHwN2zCe7vrRX2Ci2MbZ
	 YkWFCDX4xh/uHiCvKp4kVnjJoSZH3EKf+01J6ATWmKAt4EIp4aYlEK7rVqTJEki3cf
	 gm6Y+aukrp4nSu8kDaROm/PIDcucIQ2pDAd6rsEVmehA6E6nJ+C7b0sl3OhEomEIK1
	 plvhNLRwOxRy55zXBzulKZk8GKYW6oCs8eZxGqXEsPaaPVsKU+EjaeqR/s/zm4+e+u
	 TfYzmQ4zBEUo6kUn6bBHj8OSm61DBn/x2jkI9hkwZxRh1pjSIz44BVO9NLjabEHUyU
	 Fz0Fx3fbyGt4w==
Date: Tue, 25 Nov 2025 19:29:43 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>,
	Fangrui Song <maskray@sourceware.org>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID
 generation
Message-ID: <20251125192943.GA3061247@google.com>
References: <20251125080748.461014-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125080748.461014-1-namhyung@kernel.org>

On Tue, Nov 25, 2025 at 12:07:46AM -0800, Namhyung Kim wrote:
> It was reported that python backtrace with JIT dump was broken after the
> change to built-in SHA-1 implementation.  It seems python generates the
> same JIT code for each function.  They will become separate DSOs but the
> contents are the same.  Only difference is in the symbol name.
> 
> But this caused a problem that every JIT'ed DSOs will have the same
> build-ID which makes perf confused.  And it resulted in no python
> symbols (from JIT) in the output.
> 
> Looking back at the original code before the conversion, it used the
> load_addr as well as the code section to distinguish each DSO.  But it'd
> be better to use contents of symtab and strtab instead as it aligns with
> some linker behaviors.
> 
> This patch adds a buffer to save all the contents in a single place for
> SHA-1 calculation.  Probably we need to add sha1_update() or similar to
> update the existing hash value with different contents and use it here.
> But it's out of scope for this change and I'd like something that can be
> backported to the stable trees easily.
> 
> Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Pablo Galindo <pablogsal@gmail.com>
> Cc: Fangrui Song <maskray@sourceware.org>
> Link: https://github.com/python/cpython/issues/139544
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

That commit actually preserved the behavior of the existing variant of
gen_build_id() that was under #ifdef BUILD_ID_SHA.  So I guess that code
was always broken, and it was just never noticed because the alternative
variant of gen_build_id() under #ifdef BUILD_ID_MD5 was used instead?

The MD5 variant of gen_build_id() just hashed the load_addr concatenated
with the code.  That's not what this patch does, though.  So just to
clarify, you'd actually like to go with a third approach rather than
just restoring the original hash(load_addr || code) approach?

Also, I missed that you had actually changed the hash algorithm.  I had
assumed the perf folks were were pushing SHA-1 because they were already
using it.  Given that the algorithm changed, there must not be any
backwards compatibility concerns here, and you should switch to a modern
hash algorithm such as SHA-256 instead.

I'd be glad to add an incremental API if you need it, but I'm confused
why you want SHA-1 and not a modern hash algorithm.

- Eric
