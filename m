Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0561A2C04
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523064; cv=none; b=Rm3PLm6YPCcKIUwTTArdelclG6N3NBHQTL8LxhWF9xkl1me9kBr+hFmAEL7J7BOw5tuoQU8PBuWWqUomj70yw6G3dVtYEeGnM6rC88GWM03R9/FSMkYXtCaOegdy6FGldYe6PxN2tBGPSn1qPFz0OQ2GLBhuABOvsqvPx3CqvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523064; c=relaxed/simple;
	bh=WF3U/kmtnk/TT/RinqKFUh8IyoK4EXDp7yo7cfBc0wI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WqZpy0N4WjJGd2RExnDxm6yZCx/7Jzqs1XQMXtSp38rnT+7+2fjVRZoOPV+9AJi5lmlcEOEBM2SygQZiHywvR1njYWl0k+K2eqLINYKQYtlfPykvVrJ8/sIBiWwurq/UYD/FThNW5XYAbUr1QWjy7CSfi8vylhaf9DwHd8ZifPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGdychl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGdychl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9F91F000FF;
	Wed, 16 Sep 2026 01:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523051;
	bh=WF3U/kmtnk/TT/RinqKFUh8IyoK4EXDp7yo7cfBc0wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGdychl9yxW/lDjO+zpInh+C1je/OTuHrzSZt2glVb+0QHdNBIjyeaX+0rLLOVYp3
	 Z3mhyKssTWwB604B+SuzX58NlwjG+4ou/LuB9gaMWQMWMV3c3ZTjm8fF6xv2P/wgSI
	 TMRXL0RpX7jGlDyMdFDPCIK02X/89bW7Ia8hm0dQvqcdvlTBaRhjl+eLSONN9olF23
	 HwK+KzareJOvOQYxA3RbI2sQqE4hGba8b8kAPWwsmM3aYJ1J7tzc7x7siFpTF4wB2y
	 sQcfOiXQ9D8O2nV4dpepEA+Eg0dHmHXElmPWASwdtWGRIl8gST1NJrgIYqX5Lsq8SY
	 fYlsg+GjGbSlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/26] perf annotate-data: Track imm_value for stack
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8b29a11ea56bdc9973e3ab65d6f5ebdea0927bfa.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <8b29a11ea56bdc9973e3ab65d6f5ebdea0927bfa.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:44:11 +0000
Message-Id: <20260916014411.8F9F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, imm_value is tracked in registers but dropped when values
> are saved to or loaded from stack variables during type profiling.
> If a register of type TSR_KIND_CONST is stored to the stack, its value
> will be lost.
>=20
> Add an imm_value field to struct type_state_stack and update
> set_stack_state() and findnew_stack_state() to accept and preserve the
> immediate value when updating stack state.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D19

