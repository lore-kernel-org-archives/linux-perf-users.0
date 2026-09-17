Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489833A7D91;
	Thu, 17 Sep 2026 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687626; cv=none; b=F+q1lms9TefwIv8hwwbvDImacPAYF5FsQRHBJo1tYEdeHZ8+PH9eDliTjd1TKrFk6lRHGNjcv3S2CMUMhrhA8VstwSenCiqzzEvutsSd1u8cx8Y+n7eHn06ZcNv2Klw9IBaycDQ+iIb4DOMPINWkrwHsJaWCF/5hQhwxqPgGTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687626; c=relaxed/simple;
	bh=d7I+F9IVfVrk8nAFqweK5JCfNVysVJYCJbqMCDwfOOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YqH43MQfhGlRozjbBNZnCWLzmUh/ZsvSyeCWv8p+fGid5ePHSrDBKxba1mbzvsIn7dnfIj0k4AgM+ZB75gkIkfuRBcKjcIYAOnwfVOwbL1xuCLyrUsfyL/mTducS4ze1kIIza3CYctsmqN/UQsoaxnTsBa+qu9h03BoqYwLSG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om4kcrjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om4kcrjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E601F000FF;
	Thu, 17 Sep 2026 23:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687621;
	bh=d7I+F9IVfVrk8nAFqweK5JCfNVysVJYCJbqMCDwfOOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=om4kcrjkkBfaKP8ybSohPJKnmKtpHUjNXv975e8DnJI5wQVtYa/zd3g1YnzRYa31F
	 GyAHp8gdHp9DznJdSW1Uwbtt3Jh3rrIqy7GojJSCAoyUkEPBmcXA4ApjLcdcstuZsX
	 t9SAvCDQIecwB/C6kRd6AtPRDmqfJbt/9Twm8JmV7CLdBY7qbSYAL0unxERbQ/N9UZ
	 SLDG5dUNPtGM6C3Z9IXCr3VqVghe7a3LxUUurp/8rDhZNTr7de62Bo53UrRuGrggh/
	 put7Z0afL7iDy02X6nd2mAc6fTHKAW6I+CZfqmjUAhRf6LO1euxL3JxQtYJBAiGWEs
	 7KaFl9me0bsMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/11] ptwrite uprobes: Support instruction
 punning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260917230127.924985-9-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-9-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:27:00 +0000
Message-Id: <20260917232701.09E601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The previous ptwrite instrumentation only worked on 5 byte+ nops because
> it needs to patch in a 5 byte branch.
>=20
> However that is somewhat limiting because it means most code cannot
> be probed. Use a simplified variant of the instruction
> punning technique from Chamith et al. "Instruction Punning: Lightweight
> instrumentation for x86-64". Patch only the one-byte branch opcode and
> reuse the existing 4 following bytes in the code as the branch target.
>=20
> If someone branches to the remaining bytes they are still executed
> in the original way because they didn't change.
>=20
> This requires placing a target trampoline page at the right address. If
> the area is not available or points to kernel space it doesn't work.
>=20
> [ ... ]
> The punning technique could be also used with optimized
> uprobes, but this patch only applies it to ptwrite probes.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D8

