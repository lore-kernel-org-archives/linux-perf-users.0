Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB491C701F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644080; cv=none; b=NAQq0Bb5DghCx8Lz6rsuRFYa25nPQ9tXLmtzDDoyI5dDNKejOJyTU4jYC9eXhzo3STJW1Un1fL3k4DkG39YUpAd1zN/r3xobmBk+b9eJt0uz8Iil1owoLaouEQ8eKYkhRo7EPDprnGM6EkPQzHy6BL9HRwQVNMLXWG3t9gFTZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644080; c=relaxed/simple;
	bh=uiwls5NrNifOfcdd0PZSE7mtM4jXM3qxBEi7/CJdMWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uVZ/hTV9fGr/82/XQxvsQ+ZcettwX8KFierHr17/Sew4yeXva/ZE+ADophTYeLjI99aagK9FFcO2eh2Isg493OgSEKLgcMpc9F2+AaXhieYq8YYqjI3X0VdO2Cflh73LOu7qXmeSQ89PteHq7egQ70bG5/X7AZcOK3R8UuXONcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGwPTUFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGwPTUFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5AE1F00A3A;
	Fri, 10 Jul 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644079;
	bh=5VzLkHlF85viHKbnz0EyQRjrR1wmiefUtKtHMcklHCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FGwPTUFxKfWwmvUsZH2I2nekEUiKCIKVpeVSpfNyMtvvaZ0n+ZmBFg8oZjnnMTwdD
	 KfPmxnmSuRU/Oo6qnsumCfsoPlHArCyYvpXNm+fOCMHydnw8FKF5CywBAEJEW/omKa
	 f0JO9/lzD5U2awuLdlt4Z+/IpX9iYbsGOA35dHxrJx8gH9loyv8J21Bn1TyWC46oBC
	 pr9YSrpnkQENJAtu6Rvq7JS9zdg6ugYjgrlOt6isGMMg1Ft6e1YLLIRV1FT6mFj4nl
	 lhX8/ZN5ed8am98F7Ok4K/lZ0/oe1ka2MipL7hdQdL7X+CDmRXrHXiJRQ34n9nCrqD
	 bXByme0aqt/hw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
 maddy@linux.ibm.com, irogers@google.com, 
 Tanushree Shah <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
In-Reply-To: <20260708112607.548304-2-tshah@linux.ibm.com>
References: <20260708112607.548304-2-tshah@linux.ibm.com>
Subject: Re: [PATCH v4] perf dso: Fix kallsyms DSO detection with fallback
 logic
Message-Id: <178364407868.1457655.7985344242070155598.b4-ty@kernel.org>
Date: Thu, 09 Jul 2026 17:41:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 16:56:08 +0530, Tanushree Shah wrote:
> The current kallsyms detection in dso__is_kallsyms() uses the
> dso_binary_type enum which fixes the issue of kallsyms being cached in
> the build-id cache for out-of-tree modules.
> 
> However, during build-id injection in perf record/inject, dso_binary_type
> has not been explicitly set yet,so dso__binary_type() returns
> DSO_BINARY_TYPE__NOT_FOUND instead of DSO_BINARY_TYPE__KALLSYMS for the
> kernel DSO. The current check then fails to identify it as kallsyms,
> causing build-id symlinks to not be created in ~/.debug/.build-id/ and
> perf archive to fail with "Cannot stat" errors.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


