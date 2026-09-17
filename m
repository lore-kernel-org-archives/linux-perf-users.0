Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494C4A6CE6;
	Thu, 17 Sep 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687980; cv=none; b=o7OSdDlK5QTldzBPEdl9I79TmaWjJmkb62+aZ6rCQ9d4mHIGdYHMJU8U2+dHIQmVNBViBA1229u2bjiJjWPPik1YSNQnyGm6qRE/ir9gBSbqOAsU6TsPppQP/GXJwNDC1VZgx+xCo/xz29OVPIDIum5t2xZD6NwJrlUFKJeJICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687980; c=relaxed/simple;
	bh=qY1NT6tBT2cXx6Cwhf6pNPv4BwH+GbLvec/4vhHINE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bcuzUAt/IILH5EwTHq0BGlmQrU9O4Qm3pzyFSBhtM9w8bDtLpqgbidZLn0/M++UaDpc1ZmVpfs4FXAuRaSr2CJ2oQZzRrs5J6idU5tmoi8lM7P5KCqiYxPB20TFiZnKggxPcDwRFLS416XRPUlbXkz6sLA5zAooXccwJx3U2mN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5aMQFBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5aMQFBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C731F000FF;
	Thu, 17 Sep 2026 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687978;
	bh=qY1NT6tBT2cXx6Cwhf6pNPv4BwH+GbLvec/4vhHINE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5aMQFBRBDtoonDPhDNIqs5hpLRzyCLLlArGxW5/iiYCkrbDqZ99MuJB5QrwVoS1M
	 7HzpV+rqtai4gR1t5O9J2PkQsKXeYKi0w7LxSCJuawaabI+BNtgUZ0Mjr6r7uXu+Dz
	 nS+Zr8nPCE7P/I42Q8Y54WdAP3Kzq+VJeHRaU/EIBO8r/6WAZunUTYY8AfajxWVDs/
	 FgFmp0sjzNqtH+ZeQ+E9FlGza0tCFjf5kLZAjIB6Jx9jpd3HWC8+CyGIj/DJfDcEzD
	 x4s7ZIlrO/2Ijr+UKrSrTyg3N2phHZ/q5gxaBP6O3M4jw6+Qrc3vxFVHq5TU+FXPml
	 LwmJYjCa3IQgA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/11] ptwrite uprobes: Use atomic patching for
 multinop sites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-10-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-10-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:32:58 +0000
Message-Id: <20260917233258.87C731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The earlier multinop patching is not quite safe because the cross
> modified CPU could be already executing on a later nop when the
> cross patching occurs. The Intel SDM allows cross modification
> by larger stores as long as they are aligned. AMD has a similar
> guarantee.
>=20
> Support GCC function-entry patch sites is the main motivation for
> multinop, and these sites are always aligned.
>=20
> So enforce 8 bytes alignment of the multinop and use a safe RMW 8 byte st=
ore
> to overwrite the 5 byte sequence. This assumes that the code is not
> changing in parallel, but if that happens cross modification safety
> is probably the smallest of the issues.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D9

