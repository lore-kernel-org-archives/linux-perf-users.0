Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CD3B83E1
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960228; cv=none; b=VOSmz2K/RSiKu0LGE2VdBc6hoy+wfzbPMz+vFFt/XU2fctbNFnnZOpweKmdcK5SA5JiIgcYJBDJkyb3KFhAwIe5BExV3EPuBdc/EaXvTSRf9yWCNhHtPMmGB610vCBDgp9CFDLTLWebbVROLv2dytp7+SX3iUJLPpe2mmpEUuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960228; c=relaxed/simple;
	bh=lY3AoCRGB58zowwrqe06KJgM0cp2YdUkexur7sb4nCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NStJwOJ/s2nCkqGzKuLPvIcynkdideufcp8Z1iV/+Mvjo2KqiNAyr/X871Xwn0tmNpC+3n8vaCjOlkNcdwXQJMsj9pszFr1c+eMgMECgECm5pfWFptEs3RuMezAH4+CaSIUnVoAwCezbww7IL++OCDTrwTnUQKy7VtAK0IvbO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BySk0aAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BySk0aAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F51F000E9;
	Mon, 17 Aug 2026 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960227;
	bh=lY3AoCRGB58zowwrqe06KJgM0cp2YdUkexur7sb4nCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BySk0aAsBjMz0qXp20jSVxSLlfaOlrblU6ITmZ7IHNSNBFEU0gnFyVjuigIjudvWw
	 JFk3TDROXfxaetQl3DMH/dKl73zlLfLVxebBnABXARfHImGmeXPj2WndtovA8Wnycf
	 dfYxoYDRO3IhgLQsqeMZXXo+ONYJhuhqdMGzJZzrCneLMRFv4H/jkUaCTAMx9Hl34A
	 FG8mQF5pEW4p3i0/jLmZj9H25To3GvO2bVgUh4BzVNBrkPnqoxGJJxrBsOGgbjktfF
	 SMP4PAU7ue0/A3RDRjtw9IuLx8zxv9Kd6w44V7e0db9x7MWAcrFAdCncBJCRg4zAQi
	 8ETIFpD+ebIVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/9] perf c2c: add HPP list parsing for function view
 columns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-5-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-5-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:50:26 +0000
Message-Id: <20260817095026.C71F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the parser that builds the function view's local HPP output and
> sort lists from field strings. This includes dimension lookup, comparator
> wrappers, c2c_fmt allocation, and the initialization entry points used by
> the hierarchy builder.
>=20
> The generic perf_hpp__setup_output_field() registers formats on the global
> perf_hpp_list. Using it here would leave the function view's local list
> without output columns and modify the cacheline view's list instead. Add
> c2c_function_hists__setup_output_field() to append sort keys to the local
> output list.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D4

