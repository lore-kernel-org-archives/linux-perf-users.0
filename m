Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F022472AE
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183820; cv=none; b=ogzzij2O/e/FjylCXZeLrSnaSIspycEiSFdMUUrrEKtJffWzNEwO14FLkZhBJZH9Uyay+HG/1heeDmwTX5Iz8bTTAawothlkC7c90l+O93Iaeg46Za9ynLiHANv8f2Hb5lxfnp/lhelV8scaDfiOnMGcd29/tu01Z8/uz6UAokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183820; c=relaxed/simple;
	bh=sdLYEmIlqlBbO7Tqg1xyp3uN2uc8idfkcBZ7qw+xdBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOGYBCswkQ7jwLeJ26gPPvr57fRBlB7rrqfXc19Rk5Ir3qceT375MhyszvYkiYmNryp1OE4FE65IIETZsSADKkUq+3DAVYRH9o8B69QE5gTN9UV295GdgWUSr7KA0lZSGbeLdWm/5nBA+M8UJtkvLAW/meIFEqEEsRHzuMeAPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJr7caZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJr7caZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801091F000FF;
	Wed, 23 Sep 2026 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183818;
	bh=sdLYEmIlqlBbO7Tqg1xyp3uN2uc8idfkcBZ7qw+xdBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJr7caZg2Yda6x4qGKk8NHwIcqcs+f/B2MKASZPzp6O/aatrpgoMq1PUzgqUOG91U
	 n9cqaSjCbmoDxS6Gol/8XjqQyOo+eBcjjRGA9WOa3eSV5Hh8jfK8XPPCW703Gh1Uj6
	 Oo6U33abYS2MQug03equINxMpHE84Lf1c0LTsEkeX6nrPjFUPGZ1RESmLyUCabT0Ik
	 7lb3r0wit8AMt7YvpiicEGSQC8rr0VqNv9XSdQLwYyj645OVAHdlQlTOO2igYnTb9J
	 930ln2iNfxbTHJSOvyXGv6KcOT/9vjtYbwTchJ1u4gJtUcXnklk3It4sJ+0C/bw6vZ
	 7cAUTP43Yz8tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923170903.48388-3-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:16:58 +0000
Message-Id: <20260923171658.801091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>=20
> The L0 cache is newly added a small piece of cache which is
> the closest, lowest-latency memory cache tied directly to the
> execution pipeline.
>=20
> The table "Table 9-4. Data Source Field Encodings for Panther
> Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
> "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
> Auxiliary Field Layout"[1] indicates the code "01H" means the
> "L0 Hit - Minimal latency core cache hit. This request was
> satisfied by the L0 data cache."
>=20
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel=
-architecture-instruction-set-extensions-programming-reference.html
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923170903.4838=
8-1-thomas.falcon@intel.com?part=3D2

