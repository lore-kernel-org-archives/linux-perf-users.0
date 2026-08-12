Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BE48382F;
	Wed, 12 Aug 2026 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568880; cv=none; b=bARYSurOGx+xaW0kR2h5tahxjJX6WlrIyiY2wq3nvpYvaVTqDAcixkUz65+ZBaIBGahxHwKBC7g36lh88o1DT6ExNSXY9tF7hPZEqESdEvm8jQ0fyUp8rlHhVQldrXSrqLM60Q7drYxG5lPAP58s+MyDKFq8k3T7gDgfgwcgNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568880; c=relaxed/simple;
	bh=94CJRkp3pV3/G3e+cxowrmDDiHC2U7jjFIgogpBx+hQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lF7zLRcx1xwVVinDI+jviFH+5Pvk0aGfxpEsMEkhXC9NrFiWa3mFKA4Pes1lf7fLav4QFnN+gyVz379npaPM/GU2oURx75MVL48jpwCmXvjzLS/gZi0QuEHTWlgpB0EVb7qiIlxJD9HdVa8aHvfeuE2zLSFetv0OIadwTVS0MVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEdX5xB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEdX5xB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753061F00A3D;
	Wed, 12 Aug 2026 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786568879;
	bh=44vP7YGIA5RwKewdBHJdLpIpZpeZciXxQGJRbmnKh0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kEdX5xB2aHPe58o8zOMsafvLQ16QOS87e3iPx47dvpxsPlS6hkNxPxs5httMSZQ67
	 H/Z98XvoTh9TzMTCTnv+oGHbedt9Kl/vUMb7JxRFlO+lOf0tBfHZJFH8M7gOw2+XE2
	 5l5Wv9pVgmfcq+8O9YKZuAb9AwgQ/Iho9c1JiU6QtgU8nQf9+Ukik5haFEoCUONhn4
	 c2T9PnBdXeigN+rEaV5wPidINV4a/RgQKEqXm4qUi+daKKpgbrNKKBn8WMzJ2s1LWJ
	 kmUKhKoMgXa3RbeMRjgFPKruwymMf/MkA0G6UloI8caOs8MA8ChqsFUzzYiydlQbm4
	 Fg7s6x5qmQvFQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260811182900.27063-1-acme@kernel.org>
References: <20260811182900.27063-1-acme@kernel.org>
Subject: Re: [PATCHES v9 0/7] perf build: Add target to install devel
 packages needed to build perf
Message-Id: <178656887944.4021779.12107322115375335484.b4-ty@kernel.org>
Date: Wed, 12 Aug 2026 14:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Aug 2026 15:28:53 -0300, Arnaldo Carvalho de Melo wrote:
> This series adds a 'make -C tools/perf install-build-deps' target that
> installs the development packages needed to build perf on Fedora, Ubuntu,
> Debian, and RHEL family distributions.
> 
> Building perf requires many devel packages (libelf, libdw, libunwind,
> numactl, libtraceevent, libbpf, etc.). Today users must iteratively
> install packages as each feature check fails. The new target installs the
> full set in one go.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


