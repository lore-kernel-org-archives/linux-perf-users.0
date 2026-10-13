Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530F48663E;
	Tue, 13 Oct 2026 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924872; cv=none; b=LL3CKhpWrYie3W7e4CgLcGu+ve9DwXrXFICPXxQOEhJB3zZ8sMG29XRhwo1yf2KRIvgvR6bxgEvw2/OYnbZHwR+b3Aqo2AmH0sxBpI0Wr/2my43tIvcR2Ni6P7+iqxnzLqdWUa0ugfCR8BvdhtJp2rN4ndYSjeLdt8FgE6iir6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924872; c=relaxed/simple;
	bh=IKcHXCcFxThR4nCp+NafVu4xlR+L1+tGC/TV8qR5L9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1KgJz0fEgXE/qSzt1YiuZFDlNDCZtwczUNBwoX6svMlgVx156lIYMZ5FFj8CKuCe2p5lTRsJTlq+LOrLySuRq+tkfE1InJaSsDpKbrEM7F8vWgmIx8i7YBaLOt8Yr8C+pxT5GxY1KLyF/A1Qn8SsPugtwuozba1yXCBOT9xZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Qe/21M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Qe/21M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A51F000FF;
	Tue, 13 Oct 2026 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791924870;
	bh=zMRM/WhKod45UemWF4Wxm605Ay3rnq5vTX+GopH3Dh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R4Qe/21MjL35dIfWMeiMkof+Ozdmv4hhzn+ghCKpNu9QNw2xeoOVdpwSzwLmXfO9S
	 pqspuJtSjVf9cdPCb+95abNGiv0DMMyYVk0ORWtRdFFyn0MX9tXe5Din4Yw6gmwVa3
	 FN+o6WVflFKQXzFyV0HKtQOnbjHg09h9xBNXvGcyzdR1DLdD0wTWaAM0Jmimet268o
	 mtJ+bYg+XPulzvmFcRkemnEG1m4IlNgndZ06AeBC4FnqSaBKWt731L7D9WXB6O3/Lm
	 jUwfmccn1f+OcOZOpXU/zMVjZ9j29Nq6LX7N6MOy2F/xxSuGqi+SDSTILCIFGITGjM
	 cUdgvfA4wuPtQ==
Date: Tue, 13 Oct 2026 13:54:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 09/11] perf symbol: Do not set binary type from symtab
 type
Message-ID: <as6ahd8NtD5Ih66s@google.com>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-10-namhyung@kernel.org>
 <sashiko-outbox-170239@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170239@kernel.org>

On Tue, Oct 13, 2026 at 05:35:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf: guest kmodules misidentified as host system path DSOs
> --
> 
> commit 509bcd616550a20de7fa8d41090d38531f89cf60
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Do not set binary type from symtab type
> 
> The DSO binary type is used to access the binary data, while the symtab
> type is for the symbol table. This commit avoids setting the binary type
> from the symtab type when loading symbols, and instead updates the binary
> type only when opening the DSO.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 47241077ad260..1ca4cc5ec7db0 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1491,9 +1491,10 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
> >  			       bool *is_big_endian)
> >  {
> >  	uint16_t e_machine = EM_NONE;
> > +	enum dso_binary_type dbt = dso__find_binary_type(dso);
> >  	int fd;
> >  
> > -	switch (dso__binary_type(dso)) {
> > +	switch (dbt) {
> 
> [Severity: High]
> Will this change cause guest kmodules to be misidentified as host system
> path DSOs?
> 
> By executing dso__find_binary_type() first, the code evaluates the priority
> list in dso__find_binary_type_locked(), which checks
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO before falling back to dso__symtab_type(dso).
> 
> If the host filesystem happens to contain a module at the exact same absolute
> path as the guest kernel module (e.g., /lib/modules/x.y.z/...), the
> SYSTEM_PATH_DSO file check will succeed. This causes dso__find_binary_type()
> to return SYSTEM_PATH_DSO instead of DSO_BINARY_TYPE__GUEST_KMODULE.
> 
> Because dso__e_machine_endian() receives SYSTEM_PATH_DSO, it will fall
> through this fast-path switch, open the host file, and return the host's ELF
> machine architecture. Could this break cross-platform perf analysis (such as
> an x86_64 host analyzing an arm64 guest) by parsing the host's headers
> instead of the guest's?

To get a filename, it doesn't really matter if it's SYSTEM_PATH_DSO or
KMODULE (for host and guest).  Also I believe there's no good way to
retrive guest modules from the host other than symfs.

So I think this is fine for now.  Maybe we can work on improving guest
supports later.

Thanks,
Namhyung

