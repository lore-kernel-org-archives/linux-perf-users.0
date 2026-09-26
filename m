Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8F38DC48
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404454; cv=none; b=qozKlddOPv0TALErt/Ysru/x56zgM8QBbLJhO+2ccNz3geI+pXlR3qoJXHGma2zd5qKJtpFNFiVwzOZsgvBsH7owC09kkFiPMMlWBFAnCovJTkVbjGu+mbKjUZcNqXUbUYa5EqQ7/LwvVLGlW04+q38vWFpTpVyzb0ooZ9wvIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404454; c=relaxed/simple;
	bh=w16o/gkTLj/EHlbkBh+pG+msiG/eiWr/7hIFsAXuSZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rAf9uQi+vZTR4fbOlYDL2cDmvBCGJDtBupaUFj552mWpFaNTQgl8EEgul/R7KWK/aOrCoKgsJrtg5W4lSiCx/3vr9kx2E044wD6fdr49Bv8wx1ojdd+SROz60QhOsyst7IHFObKU3OBBJgGkFKQK0iSC4Un3yu2L3kB9+DV3O+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWkDi5vE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWkDi5vE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE511F00893;
	Sat, 26 Sep 2026 06:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404453;
	bh=1+Iz+jjzkmT/knKe4i3jCTpDKwl+GMGlE3LvO64TJtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWkDi5vEN76BcQA2VNxM5hOcPV3PoomdQr4Gbauy2MzeztV/bUskgjk1GC5Ezd2z7
	 rny0Zi+sbu+L/ON19WGCVYlm30+AH/r2F0IIH5Q7f8Pz0FJj+WyB4lD34U6/0EUtSA
	 xFl6R5HpvShZlc+NTHf8v2VviZ0YrrGr0cak0FoeRbWou6khrxsl6JuE8Rg7londWo
	 s8IXRrnm6r3W+zh+uBqinwqQOrHcmaCbzmrsJCMPo2MIAzL5E+dyBjXw+eTgB/mPDv
	 fiJjeUGgnP/OB8tmYDZKzNINEZrubJ7rOnRb3zLBbudm+S2saEGg8q2WVj7Zw06WAl
	 cz+sExZ0Xb/fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 37/49] perf python: Port check-perf-trace to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-38-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:34:12 +0000
Message-Id: <20260926063413.2DE511F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port check-perf-trace.py to a standalone script in tools/perf/python/
> using the perf module directly.
>=20
> Improvements compared to the legacy script:
> - Access tracepoint fields directly as attributes on perf.sample_event
>   instead of per-event dictionaries and legacy Perf-Trace-Util helpers.
> - Decode symbolic flag and enum masks for irq:softirq_entry and
>   kmem:kmalloc directly in Python and add -i/--input CLI support via
>   argparse.
> - Add full type annotations and clean up Python 2 idioms.
>=20
> Add a shell test (test_check_perf_trace_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D37

