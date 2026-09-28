Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9246D2AF
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582785; cv=none; b=gtEd7WC6nVr5UrN6iDF4kYvD0CtDDN+BRZhWCB8DhvamRMLda+WC78hAju85skZMsTZbI7Xh5S83RsPrvIhpmeZtZQgB5jzlwY4Odkxc3RGG9+j5PrMsYJfDDDmwLn6l4+r0gbF29Tz4stpbZVCj4FXAI+S2XoocQwXOtdd9ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582785; c=relaxed/simple;
	bh=Gb6zuA8sYN8qj4tzGv/+C0NoEXr5NUeekVbRdmdeu6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qh+0iVGCbQLqvMUwGErgdsPOHHWZVFMMCK5FvdQLFYNZRmIK5aMOuwFycPD0J/sief38DEmoEt7H4k/sMvnpRrQm64B5hOxUdX/X+9CRFHynoTVIvfS95Tj3SqY4fkuhqRdDWfTyoBz/n9h4YUDgN3fd4/F42E0IfMiAsrj37B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO+awLLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO+awLLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0901C1F000FF;
	Mon, 28 Sep 2026 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582783;
	bh=Gb6zuA8sYN8qj4tzGv/+C0NoEXr5NUeekVbRdmdeu6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OO+awLLcxpf71Kz0iNCaH3dkHBSNxuN4r8vA68+kaPcB+J2GtEaJPj3QR0sRFOkHK
	 f/yomx+oq8ui7PWVZ7Yovf5n9novBERSoZ7v3rcpAjYSjYbmECrzcPxSnN8RZ0jDTN
	 6zr+GYrlyfohMPriBdSRTKJSCe0q9a6vknfYcHAtSq7DqtFFtLiutczTy19UbRJexj
	 d+8Fep3k1BMoGmvmVMvHRz3YEw5TJDDmodpH9/8d/n1nrJaWGZBgN88J3uco6MAcML
	 3GvMvECX523p81ZAPZaFwWdcLDCE79L9bnLd+t16OwW4ZGowSkJE/8m167lW3GwoVG
	 rFWyqSPmPC6yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test code-reading: Fix duplicate kernel maps
 and machine leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928075517.3057621-1-irogers@google.com>
References: <20260928075517.3057621-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:06:22 +0000
Message-Id: <20260928080623.0901C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In do_test_code_reading(), machine__new_host(&host_env) already calls
> machine__create_kernel_maps(machine). Calling
> machine__create_kernel_maps(machine) a second time immediately
> afterwards duplicates all kernel module maps in machine->kmaps, causing
> dso__load_kcore()'s module validation (do_validate_kcore_modules()) to
> fail and fall back to /proc/kallsyms.
>=20
> Furthermore, when try_kcore is true and !have_kcore, returning
> TEST_CODE_READING_NO_KCORE directly bypasses out_err, leaking the entire
> struct machine, its kernel/module maps and DSOs, all kallsyms symbols,
> and host_env.
>=20
> Remove the redundant machine__create_kernel_maps() call, check for
> !machine after machine__new_host(), and jump to out_err when returning
> TEST_CODE_READING_NO_KCORE.
>=20
> Fixes: 0fd4008ed755 ("perf test: Use machine__new_host in mmap thread cod=
e reading test")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928075517.3057=
621-1-irogers@google.com?part=3D1

