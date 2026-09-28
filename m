Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE463264CE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582400; cv=none; b=hDxxzVVWYrotot/es3uGDW9BwK1800qHowPVK9GWnyrXUdpwc808iOKOAMnaYX5EZalmijRdiMfLF33ATEPxTwEQVdyHnqmuameynVWHa+ZfWrikmv6nqBmM17IAjAH3yFlFMaNZmW4gTu6PpbkQUnS69+csEcoPxDujB+ORfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582400; c=relaxed/simple;
	bh=Hpjd5UQaHPt2gOfthRF7Vk0QLswUpGcGjz6XPrmwDHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sDDnY7f7BLCitR8uTiXzEnu2SBmW2BPVmzoTTTU8cPfBGBgfS+y3GgZq5Mw66/OQnOkGfXyQbcPFL1hKBQiBhs79IWV7TE52xYSuYlDP4zX7Vo8WHs3xY+LKcXZn7nXF1KslEDdQYUVkMfgfDoZgx69R2C6wJB9Y2s4bQpRH14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5YVgRvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5YVgRvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDB11F000FF;
	Mon, 28 Sep 2026 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582398;
	bh=Hpjd5UQaHPt2gOfthRF7Vk0QLswUpGcGjz6XPrmwDHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W5YVgRvcs7FH7ff/Imb3Dy74X1zl9O6s9tv199suLLExBgdJqYNXhpUm+va7MlDUK
	 srfLJ9jY8r1CLXFroX/H4UGRE2Cf/ztAI6O0/uOBBnebNfZp4NFxoAY317tEcP+ByR
	 BNKDi7uiSqt9Ujo5CpRMUxkWzwQR2PC0anuRcAc3JOR06SmBM/0370vn90XMSkYxK8
	 qhPPKYG3P5z8MLSTHhHi2X4BZfyFlPYSydjPWjsqBweh2OA9u1rhOCs44g0Av5TxtU
	 Zcx4za8AsvFtQiBzt334Y4ZuDBc/p1CwIdQlBYITtwytU6Jj60KQqbQ9xuPEkSxYAw
	 bc9LsilN1egSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] perf/x86/intel: Refactor
 intel_pmu_drain_pebs_icl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-11-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 07:59:58 +0000
Message-Id: <20260928075958.BCDB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Switch intel_pmu_drain_pebs_icl() to the common PEBS drain path provided
> by intel_pmu_handle_pebs_records(), reducing duplicated logic between
> PEBS drain implementations.
>=20
> Extend the helper layer, including get_pebs_cntr_mask(),
> get_pebs_cntr_status(), and find_next_pebs_record(), so it also handles
> the ICL adaptive PEBS record layout.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D10

