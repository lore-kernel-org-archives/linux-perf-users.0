Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AC33F59C
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783401; cv=none; b=HoPpTonBOdSwsjsWaktB67rHeaTZZv/nAfg3nrmQkpAJsfS6IuFUP+hskatYdcSvbKVm4xRJG4gzCG7el80Mbn3eGQSa1GkYmBPCFgO+nF3Rc4wvH7xB6kxnWQ70XzZyu3fBGm8KPssWrPYucH3ve/hDTvmAvt3Z/tm0QoxGRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783401; c=relaxed/simple;
	bh=tdMFxE6pHuDG5QZwsXdqs2ig4JAoZ+xBUxktlZ2AmeU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OaHIrY7+plK7shX6J6T7xrSCOXNyrGCCdlntkVUThuiAwUUQ1awWb/ta/U10fOIcKIvJhYsjLqxexTWZ59/vHjnO0fMILP5sLDl7suEmsHcjSCUmwjBJoyu49zn2nR1j3fJtQWQvop0Q0jmY9q5xI22sdkwc8DxxaVfZEuX0//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG/ee2PZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG/ee2PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE41F1F0089B;
	Mon, 12 Oct 2026 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783399;
	bh=4XESrCD0D2XNsT8hdfI0bcnrbZtn9fk4qnnUFOmkjR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cG/ee2PZzbtYJLU/UJmEI9jlEGqfvsiCSXRS44GAXXo5cElHM7a4nC7UMqYtjNJBb
	 rYRfKMup1vPd9thJw/9YB+1f5HZSHFPDSt4Nhmx32mR+aTXBdNBL5zirHcnt6CkkkH
	 uCgq22TTv8w0g41jP8Cmq5LchBZ8xdQ1jaowEuGZOSjTk5Ci1vaWX6JBCFk4XrIXSQ
	 xW4Qkzj04V9IBHkNrfD+WL+3YE+yFoJlnoDPMuwTwiG5sCHfW09PV+5D84ofj5I9dT
	 Z0EFg3mHZd+5Q3JaZfov9Yy2stIv03Y6A45vv8q/0JlKqyl15TtgDhABtkLLCSN6mh
	 VYJeatd6Bz6aw==
Message-ID: <sashiko-outbox-167676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] perf annotate: Simplify symbol__disassemble()
 with dso binary_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-10-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-10-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:36:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now it should set the binary type of a DSO properly.  No need to figure
> out a filename suitable for disassembly.
>=20
> Just call dso__find_binary_type() and dso__get_filename() for that type.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D9

