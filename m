Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36136605E;
	Fri,  6 Mar 2026 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799254; cv=none; b=mEMFthXKbe1SVc7sOdvXPfBqjLNpCUgUagcgfEGq1CfUaN8S89h0vpz7D7P/8DRt6J4dnxEF3O8iz/HhDRBwJ1POeeBa+gDQO6+Kk6QRkYGQvNifLMaY5B6aQGcwDgxdIRgWNbv/iQ8mKpJwX57KX67E56ztFPE0MH461Yk72hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799254; c=relaxed/simple;
	bh=5t30S803mEvjtVilgSEzN5GxW7zIgmWcX4xvG/iYpEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4i6X5gdSuIRfyB1rxvudLqQ7yYCJ55Frj63q3NWxjyN9PpyjD7YAarZGe5bXcYSnQ48Kvi4j6+LuPZRVYDl5e5niovd3NLQAB+c9PqVBcNFq00kXmxiGtBXhjVzGDzizuILxb8KA3W9S6aU+eCirZ6IO4868VLsk17cJcaFQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tikwap/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tikwap/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9619BC4CEF7;
	Fri,  6 Mar 2026 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799254;
	bh=5t30S803mEvjtVilgSEzN5GxW7zIgmWcX4xvG/iYpEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tikwap/PqsX9qW68z0L9B8oWZgam0G9WL8rSIaX6RHMebxquMVwmvncWcFyyU1PJj
	 QM/5u6MuSO+BaITuU803peUdwK/FjZvFCSjC+6sZmGwMKZ20ybLaW5/2GDB92mA4n9
	 q28nqC6KTws3Xp0Xd0Zgi+n58yz5esdmu33xGkjdC2G4dvMFcCL/jDqegI/J7JnRDt
	 crDwbLMS4DGohguTog5JexO5yV2hnz3RVnBi2p3BYJmM++cOIPWON4a/x/5j0iIgqy
	 IzJ9YveW0SS7gwS7EZwitbjIMZ85fh4aeD1MCJdMM7/2ADDIF/XFo0TJt78RQmV8Gf
	 tXRxKn9w1vnUA==
Date: Fri, 6 Mar 2026 09:14:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>,
	linux-perf-users@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Levi Zim <i@kxxt.dev>, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v4] tools build: Fix rust cross compilation
Message-ID: <aarFEjqKs4pT48mF@x1>
References: <20260218154800.367720-1-9erthalion6@gmail.com>
 <CAP-5=fXLNybYv08dDfAqAsDBzbOPzQY4EZQvdY0WZsfrMu9Yyg@mail.gmail.com>
 <aahEEkHP5g-T_tFg@x1>
 <CANiq72mdo3TFS=t=t05Qc4RZ7a6DNayaDkXMUHBhBFixRjCVYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mdo3TFS=t=t05Qc4RZ7a6DNayaDkXMUHBhBFixRjCVYQ@mail.gmail.com>

On Fri, Mar 06, 2026 at 01:01:00AM +0100, Miguel Ojeda wrote:
> On Wed, Mar 4, 2026 at 3:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Thanks, applied to perf-tools, for v7.0.
 
> I think v5 (the latest one) was applied (to tmp.perf-tools -- not sure
> if that is the right place), but this reply was to v4 -- I mentioned
> it just in case.

Thanks, that is b4 picking the latest one, which is what we wanted,
right?
 
> I hope that helps!

Thanks!

- Arnaldo
